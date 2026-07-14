<#
.SYNOPSIS
    Referenční řešení labu "Inventura tenantu skriptem" (den 2, powershell-spo).
    AI-governance inventura: weby + nastavení tenantu relevantní pro Copilot.

.NOTES
    Vyžaduje roli SharePoint Administrator (viz lab-spo-scripting.md, Předpoklady).
    Modul Microsoft.Online.SharePoint.PowerShell 16.0.26615.12013+ (kvůli KnowledgeAgentScope).
#>
param(
    # Admin URL tenantu, viz environment.md
    [Parameter(Mandatory)]
    [string]$AdminUrl,

    # Rozšíření (krok 3): filtr šablony webu, např. "SITEPAGEPUBLISHING#0" (Communication site)
    [string]$TemplateFilter,

    [string]$OutputCsv = "tenant-inventory.csv"
)

# Připojení k SPO admin endpointu — všechny další cmdlety běží v jeho kontextu.
Connect-SPOService -Url $AdminUrl

# Nastavení tenantu: KnowledgeAgentScope říká, nad kterými weby smí pracovat
# Knowledge Agent — přímý vstup pro rozhodnutí, co Copilot "vidí".
# Storage kvóta dává kontext k velikostem webů níže (kolik obsahu AI reálně indexuje).
$tenant = Get-SPOTenant
[PSCustomObject]@{
    KnowledgeAgentScope = $tenant.KnowledgeAgentScope
    StorageQuotaMB      = $tenant.StorageQuota
    StorageQuotaUsedMB  = $tenant.StorageQuotaAllocated
} | Format-List

# Inventura webů: URL + Owner = kdo za obsah odpovídá (governance kontakt),
# StorageUsageCurrent = kolik obsahu web nese (váha v AI indexu),
# Template = typ webu (team vs. communication — jiný publikační režim, jiné riziko).
# POZOR: Get-SPOSite -Limit ALL vrací jen defaultní sadu vlastností — pro
# detailní vlastnosti konkrétního webu je nutné Get-SPOSite -Identity <url>.
$sites = Get-SPOSite -Limit ALL

# Rozšíření (krok 3): parametrizovaný filtr šablony.
if ($TemplateFilter) {
    $sites = $sites | Where-Object Template -eq $TemplateFilter
}

$report = $sites | Select-Object Url, Owner, StorageUsageCurrent, Template

# Rozšíření (krok 3): IsAuthoritative — jen pokud ji verze modulu/tenant vrací.
if ($sites.Count -gt 0 -and $null -ne ($sites[0].PSObject.Properties['IsAuthoritative'])) {
    $report = $sites | Select-Object Url, Owner, StorageUsageCurrent, Template, IsAuthoritative
}

$report | Format-Table -AutoSize

# CSV pro navazující práci (D2 configuration, D3 SAM) — utf8 kvůli diakritice.
$report | Export-Csv -Path $OutputCsv -Encoding utf8 -NoTypeInformation
Write-Host "Export: $OutputCsv ($($report.Count) webů)"
