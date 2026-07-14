<#
.SYNOPSIS
    Referenční řešení návodu "Inventarizace nastavení Copilot in SharePoint"
    (den 2, powershell-spo). Read-only: tenant scope + site-level RCD
    -> efektivní dostupnost Copilotu per web.

.NOTES
    Vyžaduje roli SharePoint Administrator (viz guide-copilot-inventory.md).
    Modul Microsoft.Online.SharePoint.PowerShell 16.0.26615.12013+
    (parametry KnowledgeAgent* existují až od této verze).
    Zdroj logiky: https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started
#>
param(
    # Admin URL tenantu, viz environment.md
    [Parameter(Mandatory)]
    [string]$AdminUrl,

    [string]$OutputCsv = "copilot-inventory.csv"
)

# Krok 1: fail-fast na verzi — starší modul KnowledgeAgent* vlastnosti nezná
# a selhal by až uprostřed běhu nesrozumitelnou chybou.
$minVersion = [version]"16.0.26615.12013"
$module = Get-Module -Name Microsoft.Online.SharePoint.PowerShell -ListAvailable |
    Sort-Object Version -Descending | Select-Object -First 1
if (-not $module -or $module.Version -lt $minVersion) {
    throw "Potřeba modul Microsoft.Online.SharePoint.PowerShell $minVersion+, nalezeno: $($module.Version). Spusť: Update-Module Microsoft.Online.SharePoint.PowerShell -Force"
}

# POVINNÝ krok: manifest modulu exportuje wildcardem, autoloading nefunguje —
# bez explicitního importu není Connect-SPOService k nalezení. PS7: aktuální
# verze běží nativně (bez -UseWindowsPowerShell).
Import-Module Microsoft.Online.SharePoint.PowerShell

# Krok 2: připojení k SPO admin endpointu.
Connect-SPOService -Url $AdminUrl

# Krok 3: tenant-level nastavení — scope říká, kde je Copilot in SharePoint
# povolen; selected-sites list má význam jen u Include/ExcludeSelectedSites.
$tenant = Get-SPOTenant
$scope = $tenant.KnowledgeAgentScope

# URL v listu normalizovat (malá písmena, bez koncového lomítka) — koncové
# lomítko by rozbilo porovnání s Url webu.
$selectedSites = @($tenant.KnowledgeAgentSelectedSitesList) |
    Where-Object { $_ } | ForEach-Object { $_.TrimEnd('/').ToLowerInvariant() }

[PSCustomObject]@{
    KnowledgeAgentScope = $scope
    SelectedSitesCount  = $selectedSites.Count
} | Format-List

# Krok 4 + 5: per-site inventura. -Limit ALL vrací jen defaultní sadu
# vlastností, proto detail (RCD) čteme per web přes -Identity.
$report = foreach ($s in Get-SPOSite -Limit ALL) {
    $detail = Get-SPOSite -Identity $s.Url

    # Restricted Content Discovery přebíjí availability nastavení:
    # web s RCD Copilot nezobrazí, ať je scope jakýkoli.
    $rcd = [bool]$detail.RestrictContentOrgWideSearch

    # IsAuthoritative = pozitivní signál "oficiální zdroj" pro Search/Copilot
    # (nic neomezuje) — viz ../../configuration/explainer-copilot-controls.md.
    $authoritative = [bool]$detail.IsAuthoritative
    $inList = $selectedSites -contains $s.Url.TrimEnd('/').ToLowerInvariant()

    # Dostupnost podle scope (bez RCD) — zvlášť, ať jde v souhrnu odlišit
    # "blokuje RCD" od "blokuje scope".
    $inScope = switch ($scope) {
        'AllSites'             { $true }
        'IncludeSelectedSites' { $inList }
        'ExcludeSelectedSites' { -not $inList }
        default                { $false }   # NoSites i neznámá budoucí hodnota
    }
    $available = $inScope -and -not $rcd

    [PSCustomObject]@{
        Url                        = $s.Url
        Template                   = $s.Template
        RestrictedContentDiscovery = $rcd
        IsAuthoritative            = $authoritative
        InSelectedSitesList        = $inList
        InScope                    = $inScope
        CopilotAvailable           = $available
    }
}

$report | Format-Table -AutoSize

# Krok 6: CSV pro navazující práci (D2 configuration) — utf8 kvůli diakritice.
$report | Export-Csv -Path $OutputCsv -Encoding utf8 -NoTypeInformation

$availableCount = @($report | Where-Object CopilotAvailable).Count
# RCD blokuje = web by podle scope dostupný byl, ale RCD ho vyřadilo.
$rcdBlocked = @($report | Where-Object { $_.InScope -and $_.RestrictedContentDiscovery }).Count
Write-Host "Export: $OutputCsv | Scope: $scope | Copilot dostupný: $availableCount/$($report.Count) webů | RCD blokuje: $rcdBlocked"
