# Návod · Inventarizace nastavení Copilot in SharePoint

> Modul: powershell-spo · Odhad: 30 min · Režim: read-only (jen `Get-*`), stejný go/no-go jako lab — viz instructor-notes
> Zdroj: [Get started with Copilot in SharePoint](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started) · Prostředí: [`../../environment.md`](../../environment.md)

## Cíl

Postavit skript `copilot-inventory.ps1`, který odpoví na otázku *„kde v tenantu je Copilot in SharePoint reálně dostupný?"* — tedy zkombinuje tenant-level scope, seznam vybraných webů a site-level blokaci (Restricted Content Discovery) do jednoho sloupce `CopilotAvailable` pro každý web.

## Kontext (stav k 2026-07)

- Copilot in SharePoint je od poloviny června 2026 **opt-out preview**: zapíná se automaticky uživatelům s licencí Microsoft 365 Copilot, bez akce admina. Dřívější opt-out (tenant i site) zůstává respektován.
- Dostupnost se řídí parametry **`KnowledgeAgent*`** na `Set-SPOTenant` — názvy zůstávají z preview období, i když se funkce už jmenuje Copilot in SharePoint.
- Dokumentovaná výchozí hodnota parametru `KnowledgeAgentScope` je `NoSites`, ale opt-out rollout ji v tenantech mění — **právě proto se inventarizuje**: skutečný stav tenantu zjistíš jen čtením, ne z dokumentace.

## Krok 1 — Verze modulu a import v PS7

Parametry `KnowledgeAgent*` existují až od verze **16.0.26615.12013** — skript má začít fail-fast kontrolou:

```powershell
$minVersion = [version]"16.0.26615.12013"
$module = Get-Module -Name Microsoft.Online.SharePoint.PowerShell -ListAvailable |
    Sort-Object Version -Descending | Select-Object -First 1
if (-not $module -or $module.Version -lt $minVersion) {
    throw "Potřeba modul $minVersion+, nalezeno: $($module.Version). Spusť: Update-Module Microsoft.Online.SharePoint.PowerShell -Force"
}

# POVINNÝ krok — bez něj skript spadne hned na Connect-SPOService.
Import-Module Microsoft.Online.SharePoint.PowerShell
# Jen u starých verzí (< ~16.0.24810) byl nutný -UseWindowsPowerShell — ty ale
# neprojdou kontrolou verze výše, takže do skriptu nepatří.
```

**`Import-Module` je povinný, ne kosmetický.** Manifest modulu exportuje cmdlety wildcardem (`CmdletsToExport = *`) a PowerShell autoloading funguje jen s explicitně vyjmenovanými exporty — takže `Connect-SPOService` bez explicitního importu skončí na *„not recognized as a name of a cmdlet"* na každém stroji, i s aktuální verzí modulu.

Proč fail-fast: při konfliktu verzí modulu dostaneš `A parameter cannot be found that matches parameter name 'KnowledgeAgentScope'` až u `Set-*`/výpisu — kontrola na začátku dá srozumitelnou chybu hned. (Postup úklidu konfliktních verzí: sekce *To resolve versioning errors* ve zdrojovém článku.)

## Krok 2 — Připojení

```powershell
Connect-SPOService -Url $AdminUrl
```

Admin URL viz `environment.md`; role stejná jako v labu (SharePoint Administrator, go/no-go režim viz instructor-notes).

## Krok 3 — Tenant-level: scope a seznam webů

```powershell
$tenant = Get-SPOTenant
$tenant | Select-Object KnowledgeAgentScope, KnowledgeAgentSelectedSitesList
```

| `KnowledgeAgentScope` | Význam |
| --- | --- |
| `AllSites` | dostupný na všech webech |
| `IncludeSelectedSites` | **jen** weby v `KnowledgeAgentSelectedSitesList` (opt-in list) |
| `ExcludeSelectedSites` | všechny weby **kromě** listu (opt-out list) |
| `NoSites` | nikde (dokumentovaný default parametru) |

- `KnowledgeAgentSelectedSitesList` má význam jen u `Include`/`ExcludeSelectedSites` a je omezen na **100 URL**.
- Zápis (vč. `KnowledgeAgentSelectedSitesListOperation Overwrite/Append/Remove`) je `Set-SPOTenant` = tenant-wide → v kurzu výhradně instruktor. Tento skript **jen čte**.

## Krok 4 — Site-level: Restricted Content Discovery

Restricted Content Discovery (RCD) **přebíjí** availability nastavení: web s RCD Copilot in SharePoint nezobrazí, ať je scope jakýkoli. Vlastnost na webu: `RestrictContentOrgWideSearch`.

```powershell
$sites = Get-SPOSite -Limit ALL
foreach ($s in $sites) {
    # -Limit ALL vrací defaulty vlastností (lekce z labu!) — detail nutno číst per web.
    $detail = Get-SPOSite -Identity $s.Url
    $rcd = [bool]$detail.RestrictContentOrgWideSearch
    ...
}
```

S 20 weby kurzu je smyčka rychlá; v produkci s tisíci weby by chtěla dávkování/throttling awareness.

## Krok 5 — Efektivní dostupnost

Jádro skriptu — logika z článku přepsaná do `switch`:

```powershell
$inList = $normalizedList -contains $normalizedUrl   # URL normalizovat (case, koncové lomítko)!
$inScope = switch ($scope) {
    'AllSites'             { $true }
    'IncludeSelectedSites' { $inList }
    'ExcludeSelectedSites' { -not $inList }
    default                { $false }   # NoSites i neznámá budoucí hodnota
}
$available = $inScope -and -not $rcd
```

`$inScope` drž jako samostatný sloupec — v souhrnu pak odlišíš „blokuje scope" od „blokuje RCD".

Tripwire: URL v `KnowledgeAgentSelectedSitesList` porovnávej **normalizovaně** (malá písmena, bez koncového `/`) — `-contains` je sice case-insensitive pro stringy, ale koncové lomítko porovnání rozbije.

## Krok 6 — Export a interpretace

- Výsledná tabulka per web: `Url, Template, RestrictedContentDiscovery, InSelectedSitesList, InScope, CopilotAvailable`.
- `Export-Csv -Encoding utf8 -NoTypeInformation` + souhrn na konzoli (scope, počet dostupných webů, počet blokovaných RCD).
- Odpověz nad výstupem: **(a)** jaká je hodnota `KnowledgeAgentScope`, **(b)** na kolika webech je Copilot efektivně dostupný, **(c)** blokuje někde RCD web, který by jinak dostupný byl?

## Omezení skriptu

- **Licence Microsoft 365 Copilot** skript neověří — licence se čtou přes Graph/Entra, mimo rozsah SPO modulu. Dostupnost = „web splňuje podmínky", ne „uživatel to uvidí".
- **Site AI settings** (panel vlastníka webu — volba agenta, skrytí Copilot tlačítka pro visitors) nejsou přes SPO cmdlety čitelné.
- Multigeo tenant by vyžadoval běh per geo — kurzovní tenant je single-geo.

## Ověření

- [ ] Skript má: kontrolu verze modulu + `Import-Module` + connect + tenant-level čtení + per-site smyčku + CSV export.
- [ ] Ve skriptu není žádný `Set-*` cmdlet.
- [ ] Student odpoví na 3 otázky z kroku 6 (ze svého nebo promítnutého běhu).

## Referenční řešení

[`solution/copilot-inventory.ps1`](solution/copilot-inventory.ps1)
