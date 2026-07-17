<#
.SYNOPSIS
    Wipes GOC224 student-created content and artefacts at the end of a course run:
    owned groups/Teams, owned app registrations, MFA registrations, student sites, OneDrive content.

.DESCRIPTION
    Companion to Disable-CourseStudents.ps1 — run THIS script first (it needs the accounts still
    licensed and enabled for OneDrive access), then Disable-CourseStudents.ps1 to disable sign-in
    and free the licence seats.

    Idempotent — safe to re-run. For each user.<N>@<TenantDomain> in the given range that exists:
      1. Deletes M365 groups/Teams the student owns (deduped across students; deleting a
         team-connected group also removes its team and site; soft-deleted for 30 days).
      2. Deletes Entra app registrations the student owns (declarative agents deployed via
         Agents Toolkit create these). The PnP sign-in app passed via -ClientId is never deleted.
      3. Deletes all non-password authentication methods (Authenticator, phone, FIDO2, …) so the
         accounts aren't locked to this run's students' devices on the next course run.
      4. Deletes the student Communication site /sites/user.<N> (permanently — skips recycle bin).
      5. Wipes OneDrive content (adds the signed-in admin as site admin first) and empties the
         OneDrive recycle bin.
    Finally prints a report of org-uploaded Teams apps and guest accounts, plus the manual
    checklist (Power Platform flows/environments, Copilot Studio agents, PAYG spending policy).

    Mailboxes are intentionally NOT wiped here: delegated Graph permissions can't read other
    users' mail, and removing the licence (Disable-CourseStudents.ps1) disconnects the mailbox —
    it is auto-deleted after 30 days, so the next course run starts with a fresh one.

    Requires: Microsoft.Graph.Authentication (>= 2.38.0, AllUsers scope — see
    New-CourseStudents.ps1 header) and PnP.PowerShell (>= 2.12.0). The signed-in account needs
    Global Administrator (group/app deletion, auth methods, SPO admin).

.PARAMETER AdminUrl
    SPO admin center URL, e.g. https://ms365x17157302-admin.sharepoint.com.

.PARAMETER TenantDomain
    Login domain of the student accounts, e.g. spdemo.online.

.PARAMETER StartIndex
    First student number (inclusive), e.g. 11.

.PARAMETER EndIndex
    Last student number (inclusive), e.g. 30.

.PARAMETER ClientId
    ClientId of the Entra app registration used for sign-in. Delegated mode: the PnP interactive
    app (PnP-GOC224). App-only mode (-CertificateThumbprint): the app that carries the certificate
    and application permissions. Never hardcode either — pass at the command line only (see
    environment.md: instructor-only identifiers stay out of this public repo).

.PARAMETER TenantId
    Sign-in tenant. Defaults to TenantDomain. With -CertificateThumbprint pass the tenant GUID.

.PARAMETER UseDeviceCode
    Use device code sign-in instead of the interactive browser/WAM popup (for both Graph and PnP).
    Prefer this over the default interactive popup when the default browser runs under a different
    identity than the tenant admin. Ignored when -CertificateThumbprint is set.

.PARAMETER CertificateThumbprint
    Runs everything app-only with certificate auth — zero sign-in prompts. The -ClientId app must
    have these APPLICATION permissions admin-consented in the COURSE tenant:
      Microsoft Graph: User.Read.All, Directory.Read.All, Group.ReadWrite.All,
                       Application.ReadWrite.All, UserAuthenticationMethod.ReadWrite.All,
                       AppCatalog.Read.All
      SharePoint:      Sites.FullControl.All
    For a multitenant app registered elsewhere, create+consent its service principal in the course
    tenant first: https://login.microsoftonline.com/<courseTenantId>/adminconsent?client_id=<ClientId>
    (re-run that URL after adding any new permission to the app).

.EXAMPLE
    # App-only (recommended — no prompts). ClientId = the certificate-bearing app.
    ./Remove-CourseStudentData.ps1 -AdminUrl https://ms365x17157302-admin.sharepoint.com -TenantDomain spdemo.online -StartIndex 11 -EndIndex 30 -ClientId <app guid> -TenantId <tenant guid> -CertificateThumbprint <thumbprint> -WhatIf

.EXAMPLE
    # Delegated with device code (pick the identity yourself in any browser). ClientId = PnP-GOC224.
    ./Remove-CourseStudentData.ps1 -AdminUrl https://ms365x17157302-admin.sharepoint.com -TenantDomain spdemo.online -StartIndex 11 -EndIndex 30 -ClientId <guid> -UseDeviceCode
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

    [string]$TenantId = $TenantDomain,

    [switch]$UseDeviceCode,

    # Thumbprint of a certificate (CurrentUser\My) registered on the -ClientId app. When set, the
    # whole script runs app-only (no sign-in prompts at all) — see NOTES for required application
    # permissions and the admin-consent step. Pass -TenantId as the tenant GUID in this mode.
    [string]$CertificateThumbprint
)

$graphModule = Get-Module -ListAvailable -Name Microsoft.Graph.Authentication | Where-Object Version -ge '2.38.0' | Sort-Object Version -Descending | Select-Object -First 1
if (-not $graphModule) {
    throw "Missing module 'Microsoft.Graph.Authentication' (>= 2.38.0). Install with: Install-Module Microsoft.Graph.Authentication -Scope AllUsers"
}
Import-Module -ModuleInfo $graphModule -Force

$pnp = Get-Module -ListAvailable -Name PnP.PowerShell | Where-Object Version -ge '2.12.0' | Sort-Object Version -Descending | Select-Object -First 1
if (-not $pnp) {
    throw "Missing module 'PnP.PowerShell' (>= 2.12.0). Install with: Install-Module PnP.PowerShell -Scope AllUsers"
}
Import-Module -ModuleInfo $pnp -Force

$tenantUrl = $AdminUrl -replace '-admin\.sharepoint\.com', '.sharepoint.com'
if ($tenantUrl -eq $AdminUrl) {
    throw "AdminUrl '$AdminUrl' doesn't look like an SPO admin center URL (expected https://<tenant>-admin.sharepoint.com)."
}
$myUrlBase = $AdminUrl -replace '-admin\.sharepoint\.com', '-my.sharepoint.com'

$appOnly = [bool]$CertificateThumbprint

if ($appOnly) {
    Connect-MgGraph -ClientId $ClientId -TenantId $TenantId -CertificateThumbprint $CertificateThumbprint -NoWelcome
    # Fail fast if the app's service principal in the course tenant lacks the Graph app roles —
    # without this, every user lookup 403s and misleadingly reads as "user not found".
    try {
        Invoke-MgGraphRequest -Method GET -Uri "/v1.0/users?`$top=1&`$select=id" -ErrorAction Stop | Out-Null
    }
    catch {
        throw ("App-only Graph call was denied. The app '$ClientId' is missing admin-consented APPLICATION " +
               "permissions in tenant '$TenantId' (needs User.Read.All, Directory.Read.All, Group.ReadWrite.All, " +
               "Application.ReadWrite.All, UserAuthenticationMethod.ReadWrite.All, AppCatalog.Read.All). " +
               "Add them on the app registration, then re-run the adminconsent URL — see the script header. " +
               "Original error: $($_.Exception.Message)")
    }
}
else {
    $connectArgs = @{
        Scopes    = 'User.ReadWrite.All', 'Directory.Read.All', 'Group.ReadWrite.All', 'Application.ReadWrite.All',
                    'UserAuthenticationMethod.ReadWrite.All', 'AppCatalog.Read.All'
        TenantId  = $TenantId
        NoWelcome = $true
    }
    if ($UseDeviceCode) { $connectArgs.UseDeviceCode = $true }
    Connect-MgGraph @connectArgs
}
# $null under app-only — only used to grant OneDrive access in delegated mode, where it's set.
$adminUpn = (Get-MgContext).Account

function New-PnPConnectionArgs([string]$Url) {
    $connArgs = @{ Url = $Url; ClientId = $ClientId; ReturnConnection = $true }
    if ($appOnly) { $connArgs.Thumbprint = $CertificateThumbprint; $connArgs.Tenant = $TenantId }
    elseif ($UseDeviceCode) { $connArgs.DeviceLogin = $true }
    else { $connArgs.Interactive = $true }
    return $connArgs
}

$pnpConnectArgs = New-PnPConnectionArgs -Url $AdminUrl
$adminConn = Connect-PnPOnline @pnpConnectArgs

# Resolve the student accounts once up front.
$students = @()
for ($i = $StartIndex; $i -le $EndIndex; $i++) {
    $upn = "user.$i@$TenantDomain"
    $result = Invoke-MgGraphRequest -Method GET -Uri "/v1.0/users?`$filter=userPrincipalName eq '$upn'&`$select=id,userPrincipalName"
    if ($result.value.Count -eq 0) {
        Write-Warning "$upn not found — skipping."
        continue
    }
    $students += [pscustomobject]@{ Index = $i; Upn = $upn; Id = $result.value[0].id }
}

# --- Phase 1+2: student-owned groups and app registrations -----------------------------------

Write-Host "`n=== Phase 1+2: owned groups/Teams and app registrations ==="
$deletedGroupIds = [System.Collections.Generic.HashSet[string]]::new()

foreach ($s in $students) {
    $groups = (Invoke-MgGraphRequest -Method GET -Uri "/v1.0/users/$($s.Id)/ownedObjects/microsoft.graph.group?`$select=id,displayName").value
    foreach ($g in $groups) {
        if (-not $deletedGroupIds.Add($g.id)) { continue }  # already deleted via a co-owner
        if ($PSCmdlet.ShouldProcess("$($g.displayName) ($($g.id))", "Delete group/Team owned by $($s.Upn)")) {
            Invoke-MgGraphRequest -Method DELETE -Uri "/v1.0/groups/$($g.id)"
            Write-Host "Deleted group '$($g.displayName)' (owner $($s.Upn))"
        }
    }

    $apps = (Invoke-MgGraphRequest -Method GET -Uri "/v1.0/users/$($s.Id)/ownedObjects/microsoft.graph.application?`$select=id,appId,displayName").value
    foreach ($a in $apps) {
        if ($a.appId -eq $ClientId) {
            Write-Warning "Skipping app registration '$($a.displayName)' — it's the PnP sign-in app this script uses."
            continue
        }
        if ($PSCmdlet.ShouldProcess("$($a.displayName) ($($a.appId))", "Delete app registration owned by $($s.Upn)")) {
            Invoke-MgGraphRequest -Method DELETE -Uri "/v1.0/applications/$($a.id)"
            Write-Host "Deleted app registration '$($a.displayName)' (owner $($s.Upn))"
        }
    }
}

# --- Phase 3: authentication methods ---------------------------------------------------------

Write-Host "`n=== Phase 3: registered authentication methods ==="
# @odata.type → URL segment for DELETE; password can't be deleted and is intentionally absent.
$methodSegments = @{
    '#microsoft.graph.microsoftAuthenticatorAuthenticationMethod'    = 'microsoftAuthenticatorMethods'
    '#microsoft.graph.phoneAuthenticationMethod'                     = 'phoneMethods'
    '#microsoft.graph.fido2AuthenticationMethod'                     = 'fido2Methods'
    '#microsoft.graph.emailAuthenticationMethod'                     = 'emailMethods'
    '#microsoft.graph.softwareOathAuthenticationMethod'              = 'softwareOathMethods'
    '#microsoft.graph.windowsHelloForBusinessAuthenticationMethod'   = 'windowsHelloForBusinessMethods'
    '#microsoft.graph.temporaryAccessPassAuthenticationMethod'       = 'temporaryAccessPassMethods'
    '#microsoft.graph.platformCredentialAuthenticationMethod'        = 'platformCredentialMethods'
}

foreach ($s in $students) {
    $methods = (Invoke-MgGraphRequest -Method GET -Uri "/v1.0/users/$($s.Id)/authentication/methods").value
    foreach ($m in $methods) {
        $segment = $methodSegments[$m.'@odata.type']
        if (-not $segment) { continue }  # password method or a type we don't handle
        if ($PSCmdlet.ShouldProcess($s.Upn, "Delete auth method $($m.'@odata.type' -replace '#microsoft.graph.','')")) {
            Invoke-MgGraphRequest -Method DELETE -Uri "/v1.0/users/$($s.Id)/authentication/$segment/$($m.id)"
            Write-Host "Removed $($m.'@odata.type' -replace '#microsoft.graph.','') from $($s.Upn)"
        }
    }
}

# --- Phase 4: student sites -------------------------------------------------------------------

Write-Host "`n=== Phase 4: student sites /sites/user.<N> ==="
foreach ($s in $students) {
    $siteUrl = "$tenantUrl/sites/user.$($s.Index)"
    $existing = Get-PnPTenantSite -Identity $siteUrl -Connection $adminConn -ErrorAction SilentlyContinue
    if (-not $existing) {
        Write-Verbose "$siteUrl doesn't exist — skipping."
        continue
    }
    if ($PSCmdlet.ShouldProcess($siteUrl, "Delete site permanently (skip recycle bin)")) {
        Remove-PnPTenantSite -Url $siteUrl -Force -SkipRecycleBin -Connection $adminConn
        Write-Host "Deleted $siteUrl"
    }
}

# --- Phase 5: OneDrive content ----------------------------------------------------------------

Write-Host "`n=== Phase 5: OneDrive content ==="
foreach ($s in $students) {
    $odUrl = "$myUrlBase/personal/$($s.Upn -replace '[.@]', '_')"
    $odSite = Get-PnPTenantSite -Identity $odUrl -Connection $adminConn -ErrorAction SilentlyContinue
    if (-not $odSite) {
        Write-Verbose "No OneDrive provisioned for $($s.Upn) — skipping."
        continue
    }
    if (-not $PSCmdlet.ShouldProcess($odUrl, "Wipe OneDrive content and empty recycle bin")) { continue }

    if (-not $appOnly) {
        # Delegated mode: the admin needs explicit site-admin rights on each OneDrive.
        # App-only with Sites.FullControl.All already has access — no ownership change needed.
        Set-PnPTenantSite -Identity $odUrl -Owners $adminUpn -Connection $adminConn
    }
    $odConnectArgs = New-PnPConnectionArgs -Url $odUrl
    $odConn = Connect-PnPOnline @odConnectArgs

    $items = Get-PnPFolderItem -FolderSiteRelativeUrl 'Documents' -Connection $odConn
    foreach ($item in $items) {
        if ($item.Name -eq 'Forms') { continue }  # hidden system folder — deleting it breaks the library
        if ($item -is [Microsoft.SharePoint.Client.Folder]) {
            Remove-PnPFolder -Name $item.Name -Folder 'Documents' -Force -Connection $odConn
        }
        else {
            Remove-PnPFile -ServerRelativeUrl $item.ServerRelativeUrl -Force -Connection $odConn
        }
    }
    Clear-PnPRecycleBinItem -All -Force -Connection $odConn -ErrorAction SilentlyContinue
    Write-Host "Wiped OneDrive of $($s.Upn) ($($items.Count) top-level items)"
}

# --- Report: things this script can't delete for you -----------------------------------------

Write-Host "`n=== Report: org-uploaded Teams apps (agents from Agents Toolkit land here) ==="
$teamsApps = (Invoke-MgGraphRequest -Method GET -Uri "/v1.0/appCatalogs/teamsApps?`$filter=distributionMethod eq 'organization'").value
if ($teamsApps) {
    $teamsApps | ForEach-Object { Write-Host "  $($_.displayName) (id $($_.id))" }
    Write-Host "Review in Teams admin center > Manage apps — Graph doesn't expose who uploaded them."
}
else {
    Write-Host "  none"
}

Write-Host "`n=== Report: guest accounts (from sharing labs) ==="
$guests = (Invoke-MgGraphRequest -Method GET -Uri "/v1.0/users?`$filter=userType eq 'Guest'&`$count=true&`$select=id,displayName,mail" -Headers @{ ConsistencyLevel = 'eventual' }).value
if ($guests) {
    $guests | ForEach-Object { Write-Host "  $($_.displayName) <$($_.mail)>" }
}
else {
    Write-Host "  none"
}

Write-Host @"

=== Manual checklist (no API — admin center only) ===
 1. PAYG: Copilot > Cost Management > Configuration — remove students from spending policies;
    check the Consumption tab in ~1 week to confirm usage dropped to zero.
 2. Copilot Studio agents + Power Automate flows + per-student developer environments:
    Power Platform admin center (https://admin.powerplatform.microsoft.com) > Environments.
 3. Teams apps flagged above: Teams admin center > Manage apps > delete student uploads.
 4. Mailboxes: nothing to do — removing the licence (Disable-CourseStudents.ps1) disconnects
    them; auto-deleted after 30 days.

Next step: run Disable-CourseStudents.ps1 to revoke sessions, disable sign-in and free licences.
"@
