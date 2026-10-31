# Návod · Inventarizace nastavení Copilot in SharePoint

> Modul: powershell-spo · Odhad: 30 min · Režim: read-only (jen `Get-*`), stejný go/no-go jako lab — viz instructor-notes
> Zdroj: [Get started with Copilot in SharePoint](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started) · Prostředí: [`../../environment.md`](../../environment.md)

## Cíl

Postavit skript `copilot-inventory.ps1`, který odpoví na otázku *„kde v tenantu je Copilot in SharePoint reálně dostupný a kde je governance v nepořádku?"* — tedy přečte site-level blokaci (Restricted Content Discovery) a signál `IsAuthoritative` pro každý web a spočte sloupce `CopilotAvailable` a `GovernanceConflict`.

## Kontext (stav k 2026-10)

- Copilot in SharePoint má od **30. 9. 2026 GA rollout**: everyday funkce jsou v licenci Microsoft 365 Copilot bez opt-in kroku.
- Preview parametry **`KnowledgeAgent*`** na `Set-SPOTenant` jsou **vyřazené** — MS je ctí jen do **1. 11. 2026**. Dostupnost dnes řídí **Site AI settings** (vlastník webu, jen v UI) a **Restricted Content Discovery** (čitelné PowerShellem).
- Proto se inventarizuje RCD: je to jediná dostupnostní páka, kterou admin přečte skriptem napříč tenantem.

> [!IMPORTANT] Názvosloví / lineage
> Předchozí verze návodu počítala dostupnost z `KnowledgeAgentScope` + `KnowledgeAgentSelectedSitesList`. Skript legacy hodnotu ještě vypíše (pokud ji modul vrací), ale do výpočtu nevstupuje.

## Krok 1 — Verze modulu a import v PS7

Skript má začít fail-fast kontrolou verze modulu (Copilot-related vlastnosti existují od **16.0.26615.12013**):

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

Proč fail-fast: při konfliktu verzí modulu dostaneš nesrozumitelnou chybu až uprostřed běhu — kontrola na začátku dá srozumitelnou chybu hned. (Postup úklidu konfliktních verzí: sekce *To resolve versioning errors* ve zdrojovém článku.)

## Krok 2 — Připojení

```powershell
Connect-SPOService -Url $AdminUrl
```

Admin URL viz `environment.md`; role stejná jako v labu (SharePoint Administrator, go/no-go režim viz instructor-notes).

## Krok 3 — Tenant-level: kdo smí RCD zapínat

```powershell
$tenant = Get-SPOTenant
$tenant | Select-Object DelegateRestrictedContentDiscoverabilityManagement
```

- `$true` = vlastníci webů smí RCD zapínat sami (se zdůvodněním, auditováno v Purview); `$false` = jen admin.
- Legacy `KnowledgeAgentScope`: skript ho vypíše jen tehdy, když ho `Get-SPOTenant` ještě vrací (`$tenant.PSObject.Properties['KnowledgeAgentScope']`) — s poznámkou „bez efektu". Do výpočtu nevstupuje.
- Tento skript **jen čte**; jakýkoli `Set-SPOTenant` je tenant-wide → v kurzu výhradně instruktor.

## Krok 4 — Site-level: Restricted Content Discovery

Restricted Content Discovery (RCD) **přebíjí** všechna ostatní nastavení: na webu s RCD se Copilot in SharePoint ani AI akce neobjeví. Vlastnost na webu: `RestrictContentOrgWideSearch`.

```powershell
$sites = Get-SPOSite -Limit ALL
foreach ($s in $sites) {
    # -Limit ALL vrací defaulty vlastností (lekce z labu!) — detail nutno číst per web.
    $detail = Get-SPOSite -Identity $s.Url
    $rcd = [bool]$detail.RestrictContentOrgWideSearch
    $authoritative = [bool]$detail.IsAuthoritative   # signál "oficiální zdroj" pro Search/Copilot
    ...
}
```

Význam všech tří nastavení (Site AI settings × RCD × `IsAuthoritative`) a jejich kombinace ve scénářích: [`../configuration/explainer-copilot-controls.md`](../configuration/explainer-copilot-controls.md).

S 20 weby kurzu je smyčka rychlá; v produkci s tisíci weby by chtěla dávkování/throttling awareness.

## Krok 5 — Efektivní dostupnost

Jádro skriptu — po GA jednoduché, zajímavý je až konflikt:

```powershell
$available = -not $rcd                       # web splňuje podmínky
$conflict  = $rcd -and $authoritative        # zvyšuje váhu obsahu vyřazeného z discovery
```

`GovernanceConflict` drž jako samostatný sloupec — RCD + `IsAuthoritative` na stejném webu signalizuje chybu v governance rozhodnutí (pravidlo 2 v explaineru).

## Krok 6 — Export a interpretace

- Výsledná tabulka per web: `Url, Template, RestrictedContentDiscovery, IsAuthoritative, GovernanceConflict, CopilotAvailable`.
- `Export-Csv -Encoding utf8 -NoTypeInformation` + souhrn na konzoli (počet dostupných webů, počet blokovaných RCD, počet konfliktů).
- Odpověz nad výstupem: **(a)** smí vlastníci webů RCD spravovat sami, **(b)** na kolika webech je Copilot in SharePoint efektivně dostupný, **(c)** je někde konflikt RCD + `IsAuthoritative` a co s ním?

## Omezení skriptu

- **Licence Microsoft 365 Copilot** skript neověří — licence se čtou přes Graph/Entra, mimo rozsah SPO modulu. Dostupnost = „web splňuje podmínky", ne „uživatel to uvidí".
- **Site AI settings** (panel vlastníka webu — volba agenta, skrytí Copilot tlačítka pro visitors) nejsou přes SPO cmdlety čitelné; po GA je to druhá dostupnostní páka, kterou skript nevidí.
- Multigeo tenant by vyžadoval běh per geo — kurzovní tenant je single-geo.

## Ověření

- [ ] Skript má: kontrolu verze modulu + `Import-Module` + connect + tenant-level čtení + per-site smyčku + CSV export.
- [ ] Skript nepočítá dostupnost z `KnowledgeAgentScope` (vyřazeno).
- [ ] Ve skriptu není žádný `Set-*` cmdlet.
- [ ] Student odpoví na 3 otázky z kroku 6 (ze svého nebo promítnutého běhu).

## Referenční řešení

[`solution/copilot-inventory.ps1`](solution/copilot-inventory.ps1)
