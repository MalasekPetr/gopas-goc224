<#
.SYNOPSIS
    Offboards GOC224 student accounts at the end of a course run: disables sign-in and frees the
    licence seat, but keeps the user object and group membership intact for the next run.

.DESCRIPTION
    Idempotent — safe to re-run. For each user.<N>@<TenantDomain> in the given range that exists:
      - revokes existing sign-in sessions (disabling alone doesn't invalidate already-issued tokens)
      - disables sign-in (AccountEnabled = $false)
      - removes the given licence SKU if currently assigned (frees the seat for the next course)
    Group membership is left untouched — re-adding for the next run would be redundant work for
    no benefit, and keeping it makes reactivation (New-CourseStudents.ps1) a pure no-op on that step.
    Accounts that don't exist in the range are skipped with a warning, not created.

    Requires: same Microsoft Graph PowerShell SDK modules/setup as New-CourseStudents.ps1 — see
    that script's header for the AllUsers-scope install command and why it matters.

.PARAMETER TenantDomain
    Login domain for the student accounts, e.g. spdemo.online.

.PARAMETER StartIndex
    First student number (inclusive), e.g. 11.

.PARAMETER EndIndex
    Last student number (inclusive), e.g. 30.

.PARAMETER LicenseSkuPartNumber
    skuPartNumber of the licence to remove, e.g. O365_BUSINESS_ESSENTIALS (Microsoft 365 Business Basic).

.PARAMETER TenantId
    Sign-in tenant for Connect-MgGraph. Defaults to TenantDomain; override with the tenant GUID if
    the verified-domain name doesn't resolve for auth. Never hardcode this — pass at the command
    line only (see environment.md: tenant IDs are instructor-only, kept out of this public repo).

.PARAMETER UseDeviceCode
    Use device code sign-in instead of the interactive browser/WAM popup.

.EXAMPLE
    ./Disable-CourseStudents.ps1 -TenantDomain spdemo.online -StartIndex 11 -EndIndex 30 -LicenseSkuPartNumber O365_BUSINESS_ESSENTIALS -WhatIf
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
    [string]$LicenseSkuPartNumber,

    [string]$TenantId = $TenantDomain,

    [switch]$UseDeviceCode,

    # App-only auth (no sign-in prompt): ClientId of the app registration holding the certificate
    # plus the thumbprint of that certificate (CurrentUser\My). Pass -TenantId as the tenant GUID
    # in this mode. Required application permissions: see scripts/README.md.
    [string]$ClientId,
    [string]$CertificateThumbprint
)

$requiredModules = 'Microsoft.Graph.Authentication', 'Microsoft.Graph.Users', 'Microsoft.Graph.Users.Actions', 'Microsoft.Graph.Identity.DirectoryManagement'
foreach ($m in $requiredModules) {
    # Pin to the AllUsers-scope install (>= 2.38.0) — see New-CourseStudents.ps1 header for why.
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
        Scopes    = 'User.ReadWrite.All', 'Organization.Read.All'
        TenantId  = $TenantId
        NoWelcome = $true
    }
    if ($UseDeviceCode) { $connectArgs.UseDeviceCode = $true }
    Connect-MgGraph @connectArgs
}

$allSkus = Get-MgSubscribedSku -All
$sku = $allSkus | Where-Object SkuPartNumber -eq $LicenseSkuPartNumber
if (-not $sku) {
    $available = ($allSkus | Select-Object -ExpandProperty SkuPartNumber) -join ', '
    throw "Licence SKU '$LicenseSkuPartNumber' not found in this tenant. Available SKUs: $available"
}

for ($i = $StartIndex; $i -le $EndIndex; $i++) {
    $upn = "user.$i@$TenantDomain"

    $user = Get-MgUser -Filter "userPrincipalName eq '$upn'" -Property Id, UserPrincipalName, AccountEnabled -ErrorAction SilentlyContinue
    if (-not $user) {
        Write-Warning "$upn not found — skipping (this script never creates accounts)."
        continue
    }

    if ($user.AccountEnabled -ne $false) {
        if ($PSCmdlet.ShouldProcess($upn, "Revoke sign-in sessions and disable sign-in")) {
            Revoke-MgUserSignInSession -UserId $user.Id | Out-Null
            Update-MgUser -UserId $user.Id -AccountEnabled:$false
            Write-Host "Disabled $upn"
        }
    }
    else {
        Write-Verbose "$upn already disabled."
    }

    $assigned = (Get-MgUserLicenseDetail -UserId $user.Id) | Where-Object SkuId -eq $sku.SkuId
    if ($assigned) {
        if ($PSCmdlet.ShouldProcess($upn, "Remove licence $LicenseSkuPartNumber")) {
            Set-MgUserLicense -UserId $user.Id -AddLicenses @() -RemoveLicenses @($sku.SkuId) | Out-Null
            Write-Host "Removed licence from $upn"
        }
    }
}

Write-Host "`nDone. Accounts and group membership were left intact — re-run New-CourseStudents.ps1 next course start to reactivate."
