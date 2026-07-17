<#
.SYNOPSIS
    Creates one Communication site per GOC224 student account:
    https://<tenant>.sharepoint.com/sites/user.<N>, owned by user.<N>@<TenantDomain>.

.DESCRIPTION
    Idempotent — safe to re-run. For each index in the range, the site is created only if it
    doesn't already exist (existing sites are left untouched), so the script also works to
    "top up" a partially provisioned batch.

    Requires: PnP.PowerShell (>= 2.12) and an account with the SharePoint Administrator role
    (or Global Admin) in the target tenant.

    PnP.PowerShell no longer ships a shared ClientId — you must pass the ClientId of an Entra
    app registration in the target tenant. If none exists yet, create one once with:
      Register-PnPEntraIDAppForInteractiveLogin -ApplicationName "PnP-GOC224" -Tenant <tenant>.onmicrosoft.com
    and reuse the returned ClientId for all subsequent runs.

.PARAMETER AdminUrl
    SPO admin center URL, e.g. https://ms365x17157302-admin.sharepoint.com.

.PARAMETER TenantDomain
    Login domain of the student accounts (site owners), e.g. spdemo.online.

.PARAMETER StartIndex
    First student number (inclusive), e.g. 11.

.PARAMETER EndIndex
    Last student number (inclusive), e.g. 30.

.PARAMETER ClientId
    ClientId of the Entra app registration used by PnP.PowerShell for sign-in (see DESCRIPTION).
    Never hardcode this — pass it at the command line only (same rule as tenant IDs, see
    environment.md: instructor-only identifiers stay out of this public repo).

.PARAMETER Lcid
    Locale of the new sites. Default 1033 (English); 1029 = Czech.

.EXAMPLE
    ./New-CourseStudentSites.ps1 -AdminUrl https://ms365x17157302-admin.sharepoint.com -TenantDomain spdemo.online -StartIndex 11 -EndIndex 30 -ClientId <guid> -UseDeviceCode

.EXAMPLE
    ./New-CourseStudentSites.ps1 -AdminUrl https://ms365x17157302-admin.sharepoint.com -TenantDomain spdemo.online -StartIndex 11 -EndIndex 30 -ClientId <guid> -WhatIf
#>

[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [string]$AdminUrl,

    [Parameter(Mandatory)]
    [string]$TenantDomain,

    [Parameter(Mandatory)]
    [int]$StartIndex,

    [Parameter(Mandatory)]
    [int]$EndIndex,

    [Parameter(Mandatory)]
    [string]$ClientId,

    [int]$Lcid = 1033,

    # Use device code sign-in instead of the interactive browser popup — useful when the
    # popup gets hidden behind other windows (embedded terminals) or WAM auth fails/cancels.
    [switch]$UseDeviceCode,

    # App-only auth (no sign-in prompt): thumbprint of a certificate (CurrentUser\My) registered
    # on the -ClientId app, plus -TenantId (tenant GUID). The app needs the SharePoint
    # Sites.FullControl.All APPLICATION permission — see scripts/README.md.
    [string]$CertificateThumbprint,
    [string]$TenantId
)

$pnp = Get-Module -ListAvailable -Name PnP.PowerShell | Where-Object Version -ge '2.12.0' | Sort-Object Version -Descending | Select-Object -First 1
if (-not $pnp) {
    throw "Missing module 'PnP.PowerShell' (>= 2.12.0). Install with: Install-Module PnP.PowerShell -Scope AllUsers"
}
Import-Module -ModuleInfo $pnp -Force

# Derive https://<tenant>.sharepoint.com from the admin URL — sites are created under it.
$tenantUrl = $AdminUrl -replace '-admin\.sharepoint\.com', '.sharepoint.com'
if ($tenantUrl -eq $AdminUrl) {
    throw "AdminUrl '$AdminUrl' doesn't look like an SPO admin center URL (expected https://<tenant>-admin.sharepoint.com)."
}

$connectArgs = @{
    Url      = $AdminUrl
    ClientId = $ClientId
}
if ($CertificateThumbprint) {
    if (-not $TenantId) { throw "-CertificateThumbprint requires -TenantId (tenant GUID)." }
    $connectArgs.Thumbprint = $CertificateThumbprint
    $connectArgs.Tenant = $TenantId
}
elseif ($UseDeviceCode) { $connectArgs.DeviceLogin = $true } else { $connectArgs.Interactive = $true }
Connect-PnPOnline @connectArgs

$created = 0
$skipped = 0

for ($i = $StartIndex; $i -le $EndIndex; $i++) {
    $siteUrl = "$tenantUrl/sites/user.$i"
    $owner   = "user.$i@$TenantDomain"
    $title   = "User $i"

    $existing = Get-PnPTenantSite -Identity $siteUrl -ErrorAction SilentlyContinue
    if ($existing) {
        Write-Verbose "$siteUrl already exists — skipping."
        $skipped++
        continue
    }

    if ($PSCmdlet.ShouldProcess($siteUrl, "Create Communication site (owner $owner)")) {
        # -Wait blocks until provisioning finishes, so a re-run's existence check is reliable.
        New-PnPSite -Type CommunicationSite -Title $title -Url $siteUrl -Owner $owner -Lcid $Lcid -Wait | Out-Null
        Write-Host "Created $siteUrl (owner $owner)"
        $created++
    }
}

Write-Host "`nDone: $created created, $skipped already existed."
