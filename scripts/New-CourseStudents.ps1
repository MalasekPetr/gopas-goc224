<#
.SYNOPSIS
    Ensures GOC224 student accounts exist in the course tenant, are enabled, licensed, and are
    members of the students group. Also doubles as the reactivation script for a new course run
    against accounts a previous run left disabled — see Disable-CourseStudents.ps1.

.DESCRIPTION
    Idempotent — safe to re-run. For each user.<N>@<TenantDomain> in the given range:
      - creates the account if missing (random password, forced change at first sign-in)
      - re-enables sign-in if the account exists but was disabled (e.g. by a prior offboarding run)
      - assigns the given licence SKU if not already assigned (skipped entirely if -LicenseSkuPartNumber
        is omitted — e.g. licences haven't been procured/assigned to the tenant yet)
      - adds the account to the target group if not already a member
    Existing accounts are left alone otherwise, so this also works to "top up" a partially
    provisioned batch, to reactivate a batch for a new course run without recreating anyone, and
    to backfill licensing later by re-running with -LicenseSkuPartNumber once licences exist.

    Requires: Microsoft Graph PowerShell SDK, installed to AllUsers scope (>= 2.38.0) —
    Microsoft.Graph.Authentication, Microsoft.Graph.Users, Microsoft.Graph.Groups,
    Microsoft.Graph.Users.Actions, Microsoft.Graph.Identity.DirectoryManagement — plus an account
    with User Administrator + License Administrator + Groups Administrator (or Global Admin) in
    the target tenant.

    Install (in an elevated PowerShell):
      Install-Module Microsoft.Graph.Authentication, Microsoft.Graph.Users, Microsoft.Graph.Groups, `
        Microsoft.Graph.Users.Actions, Microsoft.Graph.Identity.DirectoryManagement -Scope AllUsers -Force
    AllUsers scope matters here, not just convenience: if a CurrentUser-scope copy already exists
    under a OneDrive-redirected Documents folder, mixed/stale module versions across the two
    locations can cause "Assembly with same name is already loaded" errors from Connect-MgGraph.

.PARAMETER TenantDomain
    Login domain for the student accounts, e.g. spdemo.online.

.PARAMETER StartIndex
    First student number (inclusive), e.g. 11.

.PARAMETER EndIndex
    Last student number (inclusive), e.g. 30.

.PARAMETER GroupName
    Display name of the existing group students are added to. The group must already exist.

.PARAMETER LicenseSkuPartNumber
    skuPartNumber of the licence to assign, e.g. O365_BUSINESS_ESSENTIALS (Microsoft 365 Business Basic).
    Omit to skip licensing entirely (e.g. licences aren't available yet) — re-run later with this
    set to backfill licences on the accounts created now.

.PARAMETER UsageLocation
    Two-letter usage location required before licence assignment.

.PARAMETER OutputCsvPath
    Where to write newly generated credentials (UPN + password). Never commit this file —
    the default path (scripts/student-credentials.csv) is explicitly gitignored; keep it that
    way if you change the path. Hand out passwords and delete the file once distributed.

.EXAMPLE
    ./New-CourseStudents.ps1 -TenantDomain spdemo.online -StartIndex 11 -EndIndex 30 -GroupName Students -LicenseSkuPartNumber O365_BUSINESS_ESSENTIALS

.EXAMPLE
    ./New-CourseStudents.ps1 -TenantDomain spdemo.online -StartIndex 11 -EndIndex 30 -GroupName Students -LicenseSkuPartNumber O365_BUSINESS_ESSENTIALS -WhatIf

.EXAMPLE
    # No licences yet — create accounts and fill the group, skip licensing.
    ./New-CourseStudents.ps1 -TenantDomain spdemo.online -StartIndex 11 -EndIndex 30 -GroupName Students
#>

[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [string]$TenantDomain,

    [Parameter(Mandatory)]
    [int]$StartIndex,

    [Parameter(Mandatory)]
    [int]$EndIndex,

    [Parameter(Mandatory)]
    [string]$GroupName,

    [string]$LicenseSkuPartNumber,

    [string]$UsageLocation = "CZ",

    # Sign-in tenant for Connect-MgGraph. Defaults to TenantDomain; override with the tenant GUID
    # if the verified-domain name doesn't resolve for auth. Never hardcode this — pass it at the
    # command line only (see environment.md: tenant IDs are instructor-only, kept out of this
    # public repo).
    [string]$TenantId = $TenantDomain,

    [string]$OutputCsvPath = (Join-Path $PSScriptRoot "student-credentials.csv"),

    # Use device code sign-in instead of the interactive browser/WAM popup — useful when the
    # popup gets hidden behind other windows (embedded terminals) or WAM auth fails/cancels.
    [switch]$UseDeviceCode,

    # App-only auth (no sign-in prompt): ClientId of the app registration holding the certificate
    # plus the thumbprint of that certificate (CurrentUser\My). Pass -TenantId as the tenant GUID
    # in this mode. Required application permissions: see scripts/README.md.
    [string]$ClientId,
    [string]$CertificateThumbprint
)

function New-RandomPassword {
    param([int]$Length = 16)

    $upper   = 'ABCDEFGHJKLMNPQRSTUVWXYZ'
    $lower   = 'abcdefghijkmnpqrstuvwxyz'
    $digits  = '23456789'
    $symbols = '!@#$%^&*-_+='
    $all     = $upper + $lower + $digits + $symbols

    $bytes = [byte[]]::new($Length)
    [System.Security.Cryptography.RandomNumberGenerator]::Fill($bytes)

    # Guarantee at least one char from each class, fill the rest from the combined pool.
    $chars = @(
        $upper[$bytes[0] % $upper.Length]
        $lower[$bytes[1] % $lower.Length]
        $digits[$bytes[2] % $digits.Length]
        $symbols[$bytes[3] % $symbols.Length]
    )
    for ($i = 4; $i -lt $Length; $i++) {
        $chars += $all[$bytes[$i] % $all.Length]
    }

    # Shuffle so the guaranteed classes aren't always in the first four positions.
    $shuffled = $chars | Sort-Object { [System.Security.Cryptography.RandomNumberGenerator]::GetInt32(0, 1000000) }
    -join $shuffled
}

$requiredModules = 'Microsoft.Graph.Authentication', 'Microsoft.Graph.Users', 'Microsoft.Graph.Groups', 'Microsoft.Graph.Users.Actions', 'Microsoft.Graph.Identity.DirectoryManagement'
foreach ($m in $requiredModules) {
    # Pin to the AllUsers-scope install (>= 2.38.0). Older 2.30.0 copies can linger in a
    # OneDrive-redirected CurrentUser module path and fail to load (broken/partially hydrated DLL) —
    # letting PowerShell auto-pick a version risks grabbing that broken one.
    $available = Get-Module -ListAvailable -Name $m | Where-Object Version -ge '2.38.0' | Sort-Object Version -Descending | Select-Object -First 1
    if (-not $available) {
        throw "Missing module '$m' (>= 2.38.0). Install with: Install-Module $m -Scope AllUsers"
    }
    Import-Module -ModuleInfo $available -Force
}

if ($CertificateThumbprint) {
    if (-not $ClientId) { throw "-CertificateThumbprint requires -ClientId." }
    Connect-MgGraph -ClientId $ClientId -TenantId $TenantId -CertificateThumbprint $CertificateThumbprint -NoWelcome
}
else {
    $connectArgs = @{
        Scopes    = 'User.ReadWrite.All', 'Group.ReadWrite.All', 'Organization.Read.All'
        TenantId  = $TenantId
        NoWelcome = $true
    }
    if ($UseDeviceCode) { $connectArgs.UseDeviceCode = $true }
    Connect-MgGraph @connectArgs
}

$sku = $null
if ($LicenseSkuPartNumber) {
    $allSkus = Get-MgSubscribedSku -All
    $sku = $allSkus | Where-Object SkuPartNumber -eq $LicenseSkuPartNumber
    if (-not $sku) {
        $available = ($allSkus | Select-Object -ExpandProperty SkuPartNumber) -join ', '
        throw "Licence SKU '$LicenseSkuPartNumber' not found in this tenant. Available SKUs: $available"
    }
    if ($sku.PrepaidUnits.Enabled - $sku.ConsumedUnits -lt ($EndIndex - $StartIndex + 1)) {
        Write-Warning "Only $($sku.PrepaidUnits.Enabled - $sku.ConsumedUnits) '$LicenseSkuPartNumber' seats free — may not cover the full range."
    }
}
else {
    Write-Warning "No -LicenseSkuPartNumber given — licensing skipped for this run. Re-run with it set once licences are available."
}

$group = Get-MgGroup -Filter "displayName eq '$GroupName'"
if (-not $group) {
    throw "Group '$GroupName' not found. Create it first (this script only fills an existing group)."
}
if (@($group).Count -gt 1) {
    throw "Multiple groups named '$GroupName' found — disambiguate."
}

$newCredentials = [System.Collections.Generic.List[pscustomobject]]::new()

for ($i = $StartIndex; $i -le $EndIndex; $i++) {
    $upn = "user.$i@$TenantDomain"
    $displayName = "User $i"
    $mailNickname = "user.$i"

    $user = Get-MgUser -Filter "userPrincipalName eq '$upn'" -Property Id, UserPrincipalName, AccountEnabled -ErrorAction SilentlyContinue

    if (-not $user) {
        if ($PSCmdlet.ShouldProcess($upn, "Create user")) {
            $password = New-RandomPassword
            $user = New-MgUser -UserPrincipalName $upn `
                -DisplayName $displayName `
                -MailNickname $mailNickname `
                -AccountEnabled `
                -UsageLocation $UsageLocation `
                -PasswordProfile @{
                    Password                      = $password
                    ForceChangePasswordNextSignIn = $true
                }
            $newCredentials.Add([pscustomobject]@{
                UserPrincipalName = $upn
                DisplayName       = $displayName
                Password          = $password
            })
            Write-Host "Created $upn"
        }
    }
    elseif ($user.AccountEnabled -eq $false) {
        if ($PSCmdlet.ShouldProcess($upn, "Re-enable sign-in")) {
            Update-MgUser -UserId $user.Id -AccountEnabled
            Write-Host "Re-enabled $upn"
        }
    }
    else {
        Write-Verbose "$upn already exists and is enabled — skipping creation."
    }

    if (-not $user) { continue }  # -WhatIf run: nothing to license/group below

    if ($sku) {
        $alreadyLicensed = (Get-MgUserLicenseDetail -UserId $user.Id) | Where-Object SkuId -eq $sku.SkuId
        if (-not $alreadyLicensed) {
            if ($PSCmdlet.ShouldProcess($upn, "Assign licence $LicenseSkuPartNumber")) {
                Set-MgUserLicense -UserId $user.Id -AddLicenses @{SkuId = $sku.SkuId} -RemoveLicenses @() | Out-Null
                Write-Host "Licensed $upn"
            }
        }
    }

    $isMember = Get-MgGroupMember -GroupId $group.Id -All | Where-Object Id -eq $user.Id
    if (-not $isMember) {
        if ($PSCmdlet.ShouldProcess($upn, "Add to group '$GroupName'")) {
            New-MgGroupMember -GroupId $group.Id -DirectoryObjectId $user.Id
            Write-Host "Added $upn to $GroupName"
        }
    }
}

if ($newCredentials.Count -gt 0) {
    $newCredentials | Export-Csv -Path $OutputCsvPath -NoTypeInformation -Encoding UTF8
    Write-Host "`n$($newCredentials.Count) new account(s) — credentials written to $OutputCsvPath"
    Write-Host "Do not commit this file. Hand out passwords and delete it once distributed."
}
else {
    Write-Host "`nNo new accounts created — all users in range already existed."
}
