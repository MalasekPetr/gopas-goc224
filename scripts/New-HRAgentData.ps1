<#
.SYNOPSIS
    Provisions the GOC224 "HR Asistent" agent scenario data on a SharePoint site:
      - list  "Zaměstnanci"  (employee master, keyed by Osobní číslo / personnel number)
      - library "Certifikáty" (certificate scans, linked by Osobní číslo)
      - library "Smlouvy"     (contracts/addenda to sign, linked by Osobní číslo)
      - library "Runbooky"    (Markdown runbooks — knowledge for the Support/Ops agent scenario)
    and seeds them from hr-employees-seed.csv (employees) and scripts/runbooks/*.md (runbooks),
    generating one placeholder document per contract / certificate so the agent has real files
    to ground on.

.DESCRIPTION
    Idempotent — safe to re-run. Lists/libraries/fields are created only if missing.
    Seeding is skipped when the list already has items unless -Reseed is passed
    (-Reseed clears the list + libraries first, then re-seeds).

    Date-sensitive facts in the CSV are stored as OFFSETS in days relative to -ReferenceDate
    (default: today), so the demo always has "certificate expiring within 30 days" and
    "probation ending soon" cases no matter when the course runs. Historical facts
    (hire date) are stored as "days ago".

    Requires PnP.PowerShell (>= 2.12) and an account that can create lists/upload files on
    the target site (site owner is enough; site creation with -CreateSite needs SharePoint
    Administrator). PnP no longer ships a shared ClientId — pass the "PnP-GOC224" app's
    ClientId (see New-CourseStudentSites.ps1). Never hardcode it (public repo).

    DEMO DATA ONLY — all names/numbers are fictional. Do not load real personnel data
    (GDPR / ISO 27001): this is a training tenant.

.PARAMETER SiteUrl
    Target site, e.g. https://ms365x17157302.sharepoint.com/sites/hr-demo.

.PARAMETER ClientId
    ClientId of the Entra app registration used by PnP for sign-in. Pass at the command line
    only (instructor-only identifier, stays out of this public repo — see environment.md).

.PARAMETER CsvPath
    Path to the employee seed CSV. Default: hr-employees-seed.csv next to this script.

.PARAMETER ReferenceDate
    "Today" for the demo. All relative dates (cert expiry, probation, signed, contract end)
    are computed from this. Default: current date. Pin it to get reproducible demo results.

.PARAMETER TenantDomain
    Login domain used to derive each employee UPN from UserIndex (user.<idx>@<domain>).
    Default: spdemo.online.

.PARAMETER CreateSite
    Create a Communication site at -SiteUrl if it doesn't exist (needs SharePoint Admin and
    -SiteOwner). Omit if the site already exists.

.PARAMETER SiteOwner
    Owner UPN for -CreateSite (the account that will own the new site).

.PARAMETER Reseed
    Clear list + libraries and re-seed even if data already exists.

.PARAMETER UseDeviceCode
    Device-code sign-in instead of the interactive browser popup (embedded terminals / WAM).

.EXAMPLE
    ./New-HRAgentData.ps1 -SiteUrl https://ms365x17157302.sharepoint.com/sites/hr-demo -ClientId <guid> -UseDeviceCode

.EXAMPLE
    ./New-HRAgentData.ps1 -SiteUrl https://ms365x17157302.sharepoint.com/sites/hr-demo -ClientId <guid> -ReferenceDate 2026-09-01 -Reseed
#>

[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [string]$SiteUrl,

    [Parameter(Mandatory)]
    [string]$ClientId,

    [string]$CsvPath = (Join-Path $PSScriptRoot 'hr-employees-seed.csv'),

    [datetime]$ReferenceDate = (Get-Date).Date,

    [string]$TenantDomain = 'spdemo.online',

    [switch]$CreateSite,

    [string]$SiteOwner,

    [switch]$Reseed,

    [switch]$UseDeviceCode,

    # App-only auth (no sign-in prompt): thumbprint of a certificate (CurrentUser\My) registered
    # on the -ClientId app, plus -TenantId (tenant GUID). The app needs the SharePoint
    # Sites.FullControl.All APPLICATION permission — see scripts/README.md.
    [string]$CertificateThumbprint,
    [string]$TenantId
)

function New-HRPnPConnectArgs([string]$Url) {
    $connArgs = @{ Url = $Url; ClientId = $ClientId }
    if ($CertificateThumbprint) {
        if (-not $TenantId) { throw "-CertificateThumbprint requires -TenantId (tenant GUID)." }
        $connArgs.Thumbprint = $CertificateThumbprint
        $connArgs.Tenant = $TenantId
    }
    elseif ($UseDeviceCode) { $connArgs.DeviceLogin = $true } else { $connArgs.Interactive = $true }
    return $connArgs
}

$ErrorActionPreference = 'Stop'

$pnp = Get-Module -ListAvailable -Name PnP.PowerShell | Where-Object Version -ge '2.12.0' |
    Sort-Object Version -Descending | Select-Object -First 1
if (-not $pnp) {
    throw "Missing module 'PnP.PowerShell' (>= 2.12.0). Install with: Install-Module PnP.PowerShell -Scope AllUsers"
}
Import-Module -ModuleInfo $pnp -Force

if (-not (Test-Path $CsvPath)) { throw "Seed CSV not found: $CsvPath" }

# --- optional site creation (needs admin) -----------------------------------------------
if ($CreateSite) {
    if (-not $SiteOwner) { throw "-CreateSite requires -SiteOwner (UPN of the future site owner)." }
    $adminUrl = ($SiteUrl -replace '(https://[^.]+)\.sharepoint\.com.*', '$1-admin.sharepoint.com')
    $adminArgs = New-HRPnPConnectArgs -Url $adminUrl
    Connect-PnPOnline @adminArgs
    if (-not (Get-PnPTenantSite -Identity $SiteUrl -ErrorAction SilentlyContinue)) {
        if ($PSCmdlet.ShouldProcess($SiteUrl, "Create Communication site (owner $SiteOwner)")) {
            New-PnPSite -Type CommunicationSite -Title 'HR Demo' -Url $SiteUrl -Owner $SiteOwner -Lcid 1029 -Wait | Out-Null
            Write-Host "Created $SiteUrl"
        }
    } else {
        Write-Host "$SiteUrl already exists — skipping creation."
    }
}

# --- connect to the target site ----------------------------------------------------------
# Reuse a live connection if this session already has one to the same site, so repeated runs
# (e.g. -Reseed while iterating) don't force another device-code sign-in. A fresh PowerShell
# process has no shared token cache, so the first run in a new window always signs in.
$conn = Get-PnPConnection -ErrorAction SilentlyContinue
if ($conn -and $conn.Url.TrimEnd('/') -eq $SiteUrl.TrimEnd('/')) {
    Write-Host "Reusing existing PnP connection to $SiteUrl (no re-login)."
} else {
    $connectArgs = New-HRPnPConnectArgs -Url $SiteUrl
    Connect-PnPOnline @connectArgs
}

# --- helpers -----------------------------------------------------------------------------
function Initialize-List {
    param([string]$Title, [string]$Template)
    $list = Get-PnPList -Identity $Title -ErrorAction SilentlyContinue
    if (-not $list) {
        $list = New-PnPList -Title $Title -Template $Template -OnQuickLaunch
        Write-Host "Created $Template '$Title'"
    }
    return $list
}

function Initialize-Field {
    param(
        [string]$List, [string]$InternalName, [string]$DisplayName, [string]$Type,
        [string[]]$Choices
    )
    if (Get-PnPField -List $List -Identity $InternalName -ErrorAction SilentlyContinue) { return }
    $fieldArgs = @{ List = $List; InternalName = $InternalName; DisplayName = $DisplayName; Type = $Type; AddToDefaultView = $true }
    if ($Choices) { $fieldArgs.Choices = $Choices }
    Add-PnPField @fieldArgs | Out-Null
    Write-Verbose "  + field $DisplayName ($Type)"
}

# Compute a date from a signed day-offset relative to ReferenceDate; blank -> $null.
function Get-OffsetDate { param($offset) if ($null -eq $offset -or "$offset".Trim() -eq '') { return $null } return $ReferenceDate.AddDays([int]$offset) }
function Get-PastDate    { param($days)   if ($null -eq $days   -or "$days".Trim()   -eq '') { return $null } return $ReferenceDate.AddDays(-[int]$days) }

# --- schema: list "Zaměstnanci" ----------------------------------------------------------
$empList = 'Zaměstnanci'
Initialize-List -Title $empList -Template GenericList | Out-Null
Set-PnPField -List $empList -Identity 'Title' -Values @{ Title = 'Zaměstnanec' } -ErrorAction SilentlyContinue | Out-Null

Initialize-Field $empList 'OsobniCislo'           'Osobní číslo'            Number
Initialize-Field $empList 'Jmeno'                 'Jméno'                   Text
Initialize-Field $empList 'Prijmeni'              'Příjmení'                Text
Initialize-Field $empList 'UPN'                   'UPN / e-mail'            Text
Initialize-Field $empList 'Utvar'                 'Útvar'                   Choice      @('HR','IT','Finance','Obchod','Výroba','Marketing')
Initialize-Field $empList 'Pozice'                'Pozice'                  Text
Initialize-Field $empList 'Manazer'               'Manažer'                 Text
Initialize-Field $empList 'Lokalita'              'Lokalita'                Choice      @('Praha','Brno','Ostrava','Remote')
Initialize-Field $empList 'TypUvazku'             'Typ úvazku'              Choice      @('HPP','DPP','DPČ','OSVČ')
Initialize-Field $empList 'Nastup'                'Nástup'                  DateTime
Initialize-Field $empList 'KonecPP'               'Konec PP'                DateTime
Initialize-Field $empList 'UcetAktivni'           'Účet aktivní'            Boolean
Initialize-Field $empList 'ZkusebniDobaDo'        'Zkušební doba do'        DateTime
Initialize-Field $empList 'VyzadovaneCertifikace' 'Vyžadované certifikace'  MultiChoice @('BOZP','Řidičák B','Svářečský průkaz','ISO auditor','First Aid')
Initialize-Field $empList 'CertifikacePlatiDo'    'Certifikace platí do'    DateTime
Initialize-Field $empList 'TypSmlouvy'            'Typ smlouvy'             Choice      @('Na dobu neurčitou','Na dobu určitou','Dohoda')
Initialize-Field $empList 'DokumentKPodpisu'      'Dokument k podpisu'      Boolean
Initialize-Field $empList 'PodepsanoDne'          'Podepsáno dne'           DateTime
Initialize-Field $empList 'Stav'                  'Stav'                    Choice      @('Onboarding','Aktivní','Výpověď','Offboarding')

# --- schema: libraries -------------------------------------------------------------------
$certLib = 'Certifikáty'
Initialize-List -Title $certLib -Template DocumentLibrary | Out-Null
Initialize-Field $certLib 'OsobniCislo'      'Osobní číslo'      Number
Initialize-Field $certLib 'NazevCertifikace' 'Název certifikace' Text
Initialize-Field $certLib 'Vydano'           'Vydáno'            DateTime
Initialize-Field $certLib 'PlatiDo'          'Platí do'          DateTime
Initialize-Field $certLib 'Vydavatel'        'Vydavatel'         Text

$contractLib = 'Smlouvy'
Initialize-List -Title $contractLib -Template DocumentLibrary | Out-Null
Initialize-Field $contractLib 'OsobniCislo'  'Osobní číslo'  Number
Initialize-Field $contractLib 'TypDokumentu' 'Typ dokumentu' Choice @('PP smlouva','Dodatek','NDA','GDPR souhlas','Mzdový výměr')
Initialize-Field $contractLib 'PlatiOd'      'Platí od'      DateTime
Initialize-Field $contractLib 'PlatiDo'      'Platí do'      DateTime
Initialize-Field $contractLib 'StavPodpisu'  'Stav podpisu'  Choice @('K podpisu','Podepsáno','Expirováno')
Initialize-Field $contractLib 'PodepsanoDne' 'Podepsáno dne' DateTime

# Runbooky library — knowledge source for the Support/Ops agent scenario (Agents Toolkit demo).
# Seeded from Markdown files in scripts/runbooks/. See day-4/copilot-agents/scenario-support-agent.md.
$runbookLib = 'Runbooky'
Initialize-List -Title $runbookLib -Template DocumentLibrary | Out-Null
Initialize-Field $runbookLib 'Kategorie' 'Kategorie' Choice @('Incident','Postup','FAQ')

# Resolve the ACTUAL library folder URLs — a Czech (diacritics) title produces a URL that
# differs from the display title, so -Folder must use the real server-relative URL, not the
# title. (Add-PnPListItem addresses lists by title, hence the list worked but uploads didn't.)
$certFolderUrl     = (Get-PnPProperty -ClientObject (Get-PnPList -Identity $certLib)     -Property RootFolder).ServerRelativeUrl
$contractFolderUrl = (Get-PnPProperty -ClientObject (Get-PnPList -Identity $contractLib) -Property RootFolder).ServerRelativeUrl
$runbookFolderUrl  = (Get-PnPProperty -ClientObject (Get-PnPList -Identity $runbookLib)  -Property RootFolder).ServerRelativeUrl
if ([string]::IsNullOrEmpty($certFolderUrl) -or [string]::IsNullOrEmpty($contractFolderUrl) -or [string]::IsNullOrEmpty($runbookFolderUrl)) {
    throw "Could not resolve library folder URLs (cert='$certFolderUrl', contract='$contractFolderUrl', runbook='$runbookFolderUrl')."
}

# --- seed --------------------------------------------------------------------------------
$existing = Get-PnPListItem -List $empList -PageSize 1 -ErrorAction SilentlyContinue
if ($existing -and -not $Reseed) {
    Write-Host "'$empList' already has items — seeding skipped (pass -Reseed to rebuild)."
    return
}
if ($Reseed) {
    foreach ($l in @($empList, $certLib, $contractLib, $runbookLib)) {
        Get-PnPListItem -List $l -PageSize 500 | ForEach-Object {
            Remove-PnPListItem -List $l -Identity $_.Id -Force -ErrorAction SilentlyContinue | Out-Null
        }
    }
    Write-Host "Cleared existing items (-Reseed)."
}

$rows = Import-Csv -Path $CsvPath
$tmp  = Join-Path ([IO.Path]::GetTempPath()) ("hr-agent-docs-" + [Guid]::NewGuid().ToString('N').Substring(0,8))
New-Item -ItemType Directory -Path $tmp | Out-Null

function New-PlaceholderFile {
    param([string]$Name, [string]$Body)
    $path = Join-Path $tmp $Name
    Set-Content -Path $path -Value $Body -Encoding UTF8
    return $path
}

$empCount = 0; $certCount = 0; $docCount = 0
foreach ($r in $rows) {
    $upn      = "user.$($r.UserIndex)@$TenantDomain"
    $certExp  = Get-OffsetDate $r.CertExpiryOffset
    $signed   = Get-OffsetDate $r.SignedOffset
    $probEnd  = if ("$($r.ProbationOffset)".Trim()) { Get-OffsetDate $r.ProbationOffset } else { $null }
    $konecPP  = if ("$($r.KonecPPOffset)".Trim())   { Get-OffsetDate $r.KonecPPOffset }   else { $null }
    $nastup   = Get-PastDate $r.NastupDaysAgo
    $certs    = if ("$($r.VyzadovaneCertifikace)".Trim()) { $r.VyzadovaneCertifikace -split '\|' } else { @() }
    $pending  = ("$($r.DokumentKPodpisu)".Trim().ToLower() -eq 'true')

    $vals = @{
        Title                 = "$($r.Jmeno) $($r.Prijmeni)"
        OsobniCislo           = [int]$r.OsobniCislo
        Jmeno                 = $r.Jmeno
        Prijmeni              = $r.Prijmeni
        UPN                   = $upn
        Utvar                 = $r.Utvar
        Pozice                = $r.Pozice
        Manazer               = $r.Manazer
        Lokalita              = $r.Lokalita
        TypUvazku             = $r.TypUvazku
        UcetAktivni           = ("$($r.UcetAktivni)".Trim().ToLower() -eq 'true')
        TypSmlouvy            = $r.TypSmlouvy
        DokumentKPodpisu      = $pending
        Stav                  = $r.Stav
    }
    if ($nastup)  { $vals.Nastup = $nastup }
    if ($konecPP) { $vals.KonecPP = $konecPP }
    if ($probEnd) { $vals.ZkusebniDobaDo = $probEnd }
    if ($certs.Count) { $vals.VyzadovaneCertifikace = $certs }
    if ($certExp) { $vals.CertifikacePlatiDo = $certExp }
    if ($signed -and -not $pending) { $vals.PodepsanoDne = $signed }

    if ($PSCmdlet.ShouldProcess("$($r.Jmeno) $($r.Prijmeni) ($($r.OsobniCislo))", "Add employee")) {
        Add-PnPListItem -List $empList -Values $vals | Out-Null
        $empCount++
    }

    # certificate file (one per required certification with a known expiry)
    if ($certs.Count -and $certExp) {
        foreach ($c in $certs) {
            $safe = ($c -replace '[^\w]', '_')
            $file = New-PlaceholderFile "$($r.OsobniCislo)_cert_$safe.md" @"
# Certifikát — $c

> Demo data — fiktivní.

- **Osobní číslo:** $($r.OsobniCislo)
- **Zaměstnanec:** $($r.Jmeno) $($r.Prijmeni)
- **Certifikace:** $c
- **Platí do:** $($certExp.ToString('yyyy-MM-dd'))
"@
            if ($PSCmdlet.ShouldProcess($file, "Upload certificate")) {
                Add-PnPFile -Path $file -Folder $certFolderUrl -Values @{
                    OsobniCislo = [int]$r.OsobniCislo; NazevCertifikace = $c
                    Vydano = $certExp.AddYears(-2); PlatiDo = $certExp; Vydavatel = 'Akreditovaný orgán'
                } | Out-Null
                $certCount++
            }
        }
    }

    # signed employment contract (everyone) + a pending addendum where flagged
    $file = New-PlaceholderFile "$($r.OsobniCislo)_PP_smlouva.md" @"
# Pracovní smlouva

> Demo data — fiktivní.

- **Osobní číslo:** $($r.OsobniCislo)
- **Zaměstnanec:** $($r.Jmeno) $($r.Prijmeni)
- **Typ:** $($r.TypSmlouvy)
"@
    if ($PSCmdlet.ShouldProcess($file, "Upload contract")) {
        $cv = @{ OsobniCislo = [int]$r.OsobniCislo; TypDokumentu = 'PP smlouva'; StavPodpisu = 'Podepsáno' }
        if ($nastup) { $cv.PlatiOd = $nastup }
        if ($signed) { $cv.PodepsanoDne = $signed }
        Add-PnPFile -Path $file -Folder $contractFolderUrl -Values $cv | Out-Null
        $docCount++
    }
    if ($pending) {
        $file = New-PlaceholderFile "$($r.OsobniCislo)_dodatek_k_podpisu.md" @"
# Dodatek ke smlouvě — k podpisu

> Demo data — fiktivní.

- **Osobní číslo:** $($r.OsobniCislo)
- **Zaměstnanec:** $($r.Jmeno) $($r.Prijmeni)
- **Stav:** K podpisu
"@
        if ($PSCmdlet.ShouldProcess($file, "Upload pending addendum")) {
            Add-PnPFile -Path $file -Folder $contractFolderUrl -Values @{
                OsobniCislo = [int]$r.OsobniCislo; TypDokumentu = 'Dodatek'; StavPodpisu = 'K podpisu'
                PlatiOd = $ReferenceDate
            } | Out-Null
            $docCount++
        }
    }
}

# Upload runbooks (knowledge for the Support/Ops agent scenario) from scripts/runbooks/*.md.
$runbookSrc = Join-Path $PSScriptRoot 'runbooks'
$rbCount = 0
if (Test-Path $runbookSrc) {
    foreach ($f in Get-ChildItem -Path $runbookSrc -Filter *.md) {
        $kat = switch -Regex ($f.Name) {
            '\b(sla|faq)\b'                 { 'FAQ'; break }
            '\b(incident|vypadek|denied)\b' { 'Incident'; break }
            default                         { 'Postup' }
        }
        if ($PSCmdlet.ShouldProcess($f.Name, "Upload runbook")) {
            Add-PnPFile -Path $f.FullName -Folder $runbookFolderUrl -Values @{ Kategorie = $kat } | Out-Null
            $rbCount++
        }
    }
} else {
    Write-Host "No runbooks folder ($runbookSrc) — skipping Runbooky seed."
}

Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "`nDone: $empCount employees, $certCount certificates, $docCount contract docs, $rbCount runbooks."
Write-Host "Reference date: $($ReferenceDate.ToString('yyyy-MM-dd'))  |  Site: $SiteUrl"
# Connection intentionally left open so repeat runs in this session skip the sign-in.
# Close it manually with Disconnect-PnPOnline when done, or just close the window.
