<#
.SYNOPSIS
    Referenční řešení návodu "Inventarizace nastavení Copilot in SharePoint"
    (den 2, powershell-spo). Read-only: site-level RCD + IsAuthoritative
    -> efektivní dostupnost Copilotu per web.

.NOTES
    Vyžaduje roli SharePoint Administrator (viz guide-copilot-inventory.md).
    Modul Microsoft.Online.SharePoint.PowerShell 16.0.26615.12013+.
    Od GA (rollout 30. 9. 2026) je KnowledgeAgentScope vyřazený (MS ho ctí jen
    do 1. 11. 2026); dostupnost řídí Site AI settings (UI, PowerShellem
    nečitelné) + Restricted Content Discovery. Legacy hodnotu skript jen vypíše.
    Zdroj logiky: https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started
#>
param(
    # Admin URL tenantu, viz environment.md
    [Parameter(Mandatory)]
    [string]$AdminUrl,

    [string]$OutputCsv = "copilot-inventory.csv"
)

# Krok 1: fail-fast na verzi — starší modul Copilot-related vlastnosti nezná
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

# Krok 3: tenant-level nastavení. Delegace RCD říká, kdo smí web z Copilota
# vyřadit (jen admin, nebo i vlastník webu).
$tenant = Get-SPOTenant

# Legacy: KnowledgeAgentScope MS po 1. 11. 2026 nectí. Vypisujeme ho jen,
# pokud ho modul ještě vrací — jako historii, do výpočtu nevstupuje.
$legacyScope = if ($tenant.PSObject.Properties['KnowledgeAgentScope']) {
    "$($tenant.KnowledgeAgentScope) (vyřazeno, bez efektu)"
} else {
    "n/a (vlastnost už modul nevrací)"
}

[PSCustomObject]@{
    RcdDelegatedToSiteAdmins   = $tenant.DelegateRestrictedContentDiscoverabilityManagement
    LegacyKnowledgeAgentScope  = $legacyScope
} | Format-List

# Krok 4 + 5: per-site inventura. -Limit ALL vrací jen defaultní sadu
# vlastností, proto detail (RCD) čteme per web přes -Identity.
$report = foreach ($s in Get-SPOSite -Limit ALL) {
    $detail = Get-SPOSite -Identity $s.Url

    # Restricted Content Discovery: web s RCD Copilot in SharePoint ani AI
    # akce nezobrazí, bez ohledu na ostatní nastavení.
    $rcd = [bool]$detail.RestrictContentOrgWideSearch

    # IsAuthoritative = pozitivní signál "oficiální zdroj" pro Search/Copilot
    # (nic neomezuje) — viz ../../configuration/explainer-copilot-controls.md.
    $authoritative = [bool]$detail.IsAuthoritative

    # Po GA: web splňuje podmínky, pokud nemá RCD. Site AI settings (skryté
    # tlačítko pro návštěvníky) a licence uživatele skript nevidí.
    $available = -not $rcd

    [PSCustomObject]@{
        Url                        = $s.Url
        Template                   = $s.Template
        RestrictedContentDiscovery = $rcd
        IsAuthoritative            = $authoritative
        # RCD + IsAuthoritative zároveň = chyba v governance rozhodnutí
        # (zvyšuje váhu obsahu, který je z discovery vyřazen).
        GovernanceConflict         = $rcd -and $authoritative
        CopilotAvailable           = $available
    }
}

$report | Format-Table -AutoSize

# Krok 6: CSV pro navazující práci (D2 configuration) — utf8 kvůli diakritice.
$report | Export-Csv -Path $OutputCsv -Encoding utf8 -NoTypeInformation

$availableCount = @($report | Where-Object CopilotAvailable).Count
$rcdBlocked = @($report | Where-Object RestrictedContentDiscovery).Count
$conflicts = @($report | Where-Object GovernanceConflict).Count
Write-Host "Export: $OutputCsv | Copilot dostupný: $availableCount/$($report.Count) webů | RCD blokuje: $rcdBlocked | Konflikt RCD+IsAuthoritative: $conflicts"
