<#
.SYNOPSIS
    Grants or revokes Entra admin roles (default: Global Reader + SharePoint Administrator)
    for the GOC224 student accounts user.<N>@<TenantDomain>.

.DESCRIPTION
    Idempotent — safe to re-run. Grant skips users who already hold the role; Revoke skips
    users who don't. Designed for the D2 SPO PowerShell lab go/no-go plan (instructor-notes):
    grant roles for the duration of the block, revoke immediately after.

    Requires: Microsoft Graph PowerShell SDK (>= 2.38.0, AllUsers scope — see
    New-CourseStudents.ps1 for why) — Microsoft.Graph.Authentication, Microsoft.Graph.Users,
    Microsoft.Graph.Identity.Governance — plus an account with Privileged Role Administrator
    (or Global Admin) in the target tenant.

.PARAMETER Mode
    Grant or Revoke.

.PARAMETER TenantDomain
    Login domain of the student accounts, e.g. spdemo.online.

.PARAMETER StartIndex
    First student number (inclusive), e.g. 11.

.PARAMETER EndIndex
    Last student number (inclusive), e.g. 30.

.PARAMETER RoleNames
    Display names of the directory roles to grant/revoke.
    Default: 'Global Reader', 'SharePoint Administrator'.

.EXAMPLE
    ./Set-CourseStudentRoles.ps1 -Mode Grant -TenantDomain spdemo.online -StartIndex 11 -EndIndex 30 -UseDeviceCode

.EXAMPLE
    ./Set-CourseStudentRoles.ps1 -Mode Revoke -TenantDomain spdemo.online -StartIndex 11 -EndIndex 30 -UseDeviceCode

.EXAMPLE
    ./Set-CourseStudentRoles.ps1 -Mode Grant -TenantDomain spdemo.online -StartIndex 11 -EndIndex 30 -WhatIf
#>

[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [ValidateSet('Grant', 'Revoke')]
    [string]$Mode,

    [Parameter(Mandatory)]
    [string]$TenantDomain,

    [Parameter(Mandatory)]
    [int]$StartIndex,

    [Parameter(Mandatory)]
    [int]$EndIndex,

    [string[]]$RoleNames = @('Global Reader', 'SharePoint Administrator'),

    # Sign-in tenant for Connect-MgGraph. Defaults to TenantDomain; override with the tenant GUID
    # if needed. Never hardcode — pass at the command line only (see environment.md).
    [string]$TenantId = $TenantDomain,

    [switch]$UseDeviceCode,

    # App-only auth (no sign-in prompt): ClientId of the app registration holding the certificate
    # plus the thumbprint of that certificate (CurrentUser\My). Pass -TenantId as the tenant GUID
    # in this mode. Required application permissions: see scripts/README.md. NOTE: app-only role
    # management needs RoleManagement.ReadWrite.Directory — grant deliberately, it's high privilege.
    [string]$ClientId,
    [string]$CertificateThumbprint
)

$requiredModules = 'Microsoft.Graph.Authentication', 'Microsoft.Graph.Users', 'Microsoft.Graph.Identity.Governance'
foreach ($m in $requiredModules) {
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
        Scopes    = 'RoleManagement.ReadWrite.Directory', 'User.Read.All'
        TenantId  = $TenantId
        NoWelcome = $true
    }
    if ($UseDeviceCode) { $connectArgs.UseDeviceCode = $true }
    Connect-MgGraph @connectArgs
}

# Resolve role definitions up front — fail fast on a typo in RoleNames.
$roles = foreach ($name in $RoleNames) {
    $def = Get-MgRoleManagementDirectoryRoleDefinition -Filter "displayName eq '$name'"
    if (-not $def) { throw "Role definition '$name' not found in this tenant." }
    $def
}

$changed = 0
$skipped = 0

for ($i = $StartIndex; $i -le $EndIndex; $i++) {
    $upn = "user.$i@$TenantDomain"
    $user = Get-MgUser -Filter "userPrincipalName eq '$upn'" -Property Id, UserPrincipalName -ErrorAction SilentlyContinue
    if (-not $user) {
        Write-Warning "$upn not found — skipping."
        continue
    }

    foreach ($role in $roles) {
        $existing = Get-MgRoleManagementDirectoryRoleAssignment -Filter "principalId eq '$($user.Id)' and roleDefinitionId eq '$($role.Id)'"

        if ($Mode -eq 'Grant') {
            if ($existing) {
                Write-Verbose "$upn already has '$($role.DisplayName)' — skipping."
                $skipped++
                continue
            }
            if ($PSCmdlet.ShouldProcess($upn, "Grant '$($role.DisplayName)'")) {
                New-MgRoleManagementDirectoryRoleAssignment -PrincipalId $user.Id -RoleDefinitionId $role.Id -DirectoryScopeId '/' | Out-Null
                Write-Host "Granted '$($role.DisplayName)' to $upn"
                $changed++
            }
        }
        else {
            if (-not $existing) {
                Write-Verbose "$upn doesn't have '$($role.DisplayName)' — skipping."
                $skipped++
                continue
            }
            if ($PSCmdlet.ShouldProcess($upn, "Revoke '$($role.DisplayName)'")) {
                foreach ($assignment in $existing) {
                    Remove-MgRoleManagementDirectoryRoleAssignment -UnifiedRoleAssignmentId $assignment.Id
                }
                Write-Host "Revoked '$($role.DisplayName)' from $upn"
                $changed++
            }
        }
    }
}

Write-Host "`nDone ($Mode): $changed changed, $skipped already in desired state."
