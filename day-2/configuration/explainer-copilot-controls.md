# Výklad · KnowledgeAgentScope × RCD × IsAuthoritative

> Modul: configuration · Vazba: ranní [powershell-spo](../powershell-spo/) (čtení hodnot skriptem) · D3 SAM (RCD je SAM feature)
> Prostředí: viz [`../../environment.md`](../../environment.md)

## Tři nastavení, tři různé otázky

Všechna tři se týkají „Copilotu a obsahu", ale každé odpovídá na jinou otázku — proto se **nevylučují, ale kombinují**:

| Nastavení | Úroveň | Otázka | Směr působení | Licence |
| --- | --- | --- | --- | --- |
| `KnowledgeAgentScope` | tenant (`Set-SPOTenant`) | **Kde** běží funkce Copilot in SharePoint (UI na webech)? | zapíná/vypíná funkci | M365 Copilot |
| RCD (`RestrictContentOrgWideSearch`) | web (`Set-SPOSite`) | **Co** smí org-wide search a Copilot vůbec najít? | skrývá obsah | M365 Copilot + **SAM** |
| `IsAuthoritative` | web (`Set-SPOSite`) | **Čemu** má Search/Copilot věřit jako oficiálnímu zdroji? | zvyšuje váhu obsahu | M365 Copilot |

Mnemotechnika: **scope = kde je tlačítko · RCD = co AI vidí · IsAuthoritative = čemu AI věří.**

## KnowledgeAgentScope — kde je tlačítko

- Tenant-wide rozsah funkce **Copilot in SharePoint** (Copilot panel, AI actions, tvorba webů/stránek promptem). Hodnoty: `AllSites` / `IncludeSelectedSites` / `ExcludeSelectedSites` / `NoSites` + `KnowledgeAgentSelectedSitesList` (max 100 URL).
- **Neřídí grounding.** `NoSites` vypne funkci na webech, ale obsah SharePointu dál groundí M365 Copilot Chat (Teams/Office/M365.cloud) — grounding jde přes Graph/search a řídí ho permissions a RCD, ne scope. Kdo tohle zamění, myslí si, že „vypnul AI nad obsahem", a nevypnul.

## RCD — co AI vidí

- Site-level. Obsah webu zmizí z **org-wide** discovery: SharePoint home, Office.com, Bing i Copilot experiences. Na webu samotném zmizí AI entry pointy (Copilot tlačítko, AI actions, Create pages with AI) — proto RCD **přebíjí** jakýkoli scope.
- Co RCD **nedělá**:
  - **Nemění permissions.** Kdo má přístup, přistoupí dál (přímý link, nedávno otevřený dokument, vlastní obsah). RCD = řízení nálezitelnosti, **ne** bezpečnostní hranice — „security by obscurity" argument u zkoušky neobstojí.
  - Nemaže z indexu — Purview (eDiscovery, auto-labeling) funguje dál.
  - Neplatí pro OneDrive (jen SharePoint weby).
- Provozní vlastnosti: propagace přes indexy trvá (web s 500k+ položkami i přes týden); je to **dočasný** governance nástroj na dobu revize přístupů; nadužívání zužuje korpus a zhoršuje kvalitu search i Copilot odpovědí (Microsoft explicitně varuje).
- Správa: admin centrum (Active sites → Settings → *Restrict content from Microsoft 365 Copilot*) nebo `Set-SPOSite -RestrictContentOrgWideSearch $true`; delegace na site adminy `Set-SPOTenant -DelegateRestrictedContentDiscoverabilityManagement $true` (se zdůvodněním, auditované v Purview); tenant report `Start-/Get-SPORestrictedContentDiscoverabilityReport`.

## IsAuthoritative — čemu AI věří

- Site-level, `Set-SPOSite -IsAuthoritative $true` (admin s Copilot licencí). Signál pro Microsoft Search, M365 Copilot a agenty: obsah webu je **oficiální, důvěryhodný, ověřený** → lepší discoverabilita a vyšší důvěra v AI odpovědi.
- Čistě **pozitivní** signál — nic nezakazuje, nikoho neomezuje. Typicky HR politiky, oficiální směrnice, produktová dokumentace: weby, kde chceš, aby Copilot citoval *tuhle* verzi pravdy, ne pět zastaralých kopií z týmových webů.

## Pravidla kombinování

1. **RCD vítězí.** Web s RCD Copilot nevidí a AI funkce na něm nejsou — ať je scope `AllSites` a web v include listu.
2. **IsAuthoritative na RCD webu nedává smysl** — nelze zvyšovat váhu obsahu, který je z discovery vyřazen. Kombinace signalizuje chybu v governance rozhodnutí.
3. **`NoSites` není „AI stop".** Vypne funkci na webech; grounding do M365 Copilot Chat běží dál. Content-level páky jsou RCD a permissions.
4. **Permissions jsou jediná skutečná hranice.** Všechna tři nastavení řídí viditelnost/váhu, žádné přístup. Oversharing řeší revize přístupů (DAG reporty, D3 SAM), RCD jen kupuje čas.

## Scénáře

| Scénář | KnowledgeAgentScope | RCD | IsAuthoritative |
| --- | --- | --- | --- |
| **Pilot** (10 webů, zbytek tenantu neuklizený) | `IncludeSelectedSites` + pilotní weby | zapnout na rizikových webech (HR, Finance) po dobu revize | intranet s politikami |
| **Plný provoz s governance** | `AllSites` | dočasně jen na webech v aktivní revizi přístupů | oficiální knowledge base, směrnice |
| **Oversharing nález** (DAG report ukázal únik) | beze změny — problém není funkce | okamžitě na dotčené weby (pozor: propagace není instantní!) | beze změny |
| **„Ještě nejsme ready"** | `NoSites` | přesto na citlivé weby — kvůli M365 Copilot Chat groundingu (viz pravidlo 3) | zatím neřešit |

Pořadí úvahy v praxi: nejdřív **co AI nesmí vidět** (RCD + revize permissions), pak **kde funkci pustit** (scope), nakonec **co zvýraznit** (IsAuthoritative).

## Časté omyly

| Omyl | Realita |
| --- | --- |
| „RCD web je zabezpečený." | RCD nemění permissions — kdo má přístup, čte dál. Jen ho nenajde search/Copilot. |
| „`NoSites` = obsah není v Copilotu." | Vypnutá je funkce Copilot in SharePoint; M365 Copilot Chat obsah dál groundí. |
| „RCD zapnu plošně, jistota je jistota." | Zúžený korpus = horší odpovědi pro všechny; Microsoft explicitně varuje před nadužíváním. Dočasný nástroj. |
| „IsAuthoritative omezí ostatní weby." | Nic neomezuje — jen zvyšuje váhu označeného obsahu. |
| „RCD se projeví hned." | Propagace přes indexy; velké weby i přes týden. |

## Jak stav přečíst (read-only)

```powershell
Get-SPOTenant | Select-Object KnowledgeAgentScope, KnowledgeAgentSelectedSitesList, DelegateRestrictedContentDiscoverabilityManagement
Get-SPOSite -Identity <url> | Select-Object RestrictContentOrgWideSearch, IsAuthoritative
```

Kompletní inventura všech tří nastavení per web: [`../powershell-spo/guide-copilot-inventory.md`](../powershell-spo/guide-copilot-inventory.md) (+ `solution/copilot-inventory.ps1`).

## Zdroje (Microsoft)

[Get started with Copilot in SharePoint](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started) · [Restricted Content Discovery](https://learn.microsoft.com/en-us/sharepoint/restricted-content-discovery) · [Set-SPOSite](https://learn.microsoft.com/en-us/powershell/module/microsoft.online.sharepoint.powershell/set-sposite?view=sharepoint-ps)

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu — stav k 2026-07.
> `Set-SPOSite` má nově i `RestrictedContentDiscoveryforCopilotAndAgents` (RCD pro hostování agentů, **private preview**) — do kurzu nepatří, ale studenti na parametr v nápovědě narazí; nezaměňovat s `RestrictContentOrgWideSearch`. `IsAuthoritative` je nový parametr — chování rankingu ověřit v tenantu před během.
