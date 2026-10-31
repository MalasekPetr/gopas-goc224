# Výklad · Site AI settings × RCD × IsAuthoritative

> [!IMPORTANT] Názvosloví / lineage
> Do 1. 11. 2026 řídil „kde je tlačítko" tenant-wide parametr `Set-SPOTenant -KnowledgeAgentScope` (preview). Při GA Copilot in SharePoint ho Microsoft vyřadil; roli převzaly **Site AI settings** (vlastník webu) a RCD ([Get started](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started)). Ve starších návodech a skriptech na `KnowledgeAgent*` studenti narazí — je to historie.

> Modul: configuration · Vazba: ranní [powershell-spo](../powershell-spo/) (čtení hodnot skriptem) · D3 SAM (RCD je SAM feature)
> Prostředí: viz [`../../environment.md`](../../environment.md)

## Tři nastavení, tři různé otázky

Všechna tři se týkají „Copilotu a obsahu", ale každé odpovídá na jinou otázku — proto se **nevylučují, ale kombinují**:

| Nastavení | Úroveň | Otázka | Směr působení | Licence |
| --- | --- | --- | --- | --- |
| **Site AI settings** | web (*Settings → Site AI*, vlastník webu) | **Kde a komu** se Copilot in SharePoint ukáže (UI na webu)? | volí agenta v hlavičce, skryje tlačítko návštěvníkům | M365 Copilot |
| RCD (`RestrictContentOrgWideSearch`) | web (`Set-SPOSite`) | **Co** smí org-wide search a Copilot vůbec najít? | skrývá obsah | M365 Copilot + **SAM** |
| `IsAuthoritative` | web (`Set-SPOSite`) | **Čemu** má Search/Copilot věřit jako oficiálnímu zdroji? | zvyšuje váhu obsahu | M365 Copilot |

Mnemotechnika: **Site AI = kde je tlačítko · RCD = co AI vidí · IsAuthoritative = čemu AI věří.**

## Site AI settings — kde je tlačítko

- Site-level panel pro vlastníka webu (*Settings → Site AI*). Umí: (1) zvolit, který agent se otevře z ikony v globální hlavičce — Copilot in SharePoint, nebo vlastní agent; (2) **skrýt Copilot tlačítko na stránkách pro návštěvníky** webu; (3) zapnout advanced document processing pro web ([Get started](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started)).
- Na rozdíl od vyřazeného `KnowledgeAgentScope` **není tenant-wide** a neumí funkci vypnout všem — rozhoduje vlastník webu, ne admin centrálně.
- **Neřídí grounding.** Skryté tlačítko neznamená, že obsah webu nevidí M365 Copilot Chat (Teams/Office/M365.cloud) — grounding jde přes Graph/search a řídí ho permissions a RCD. Kdo tohle zamění, myslí si, že „vypnul AI nad obsahem", a nevypnul.

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

1. **RCD vítězí.** Web s RCD Copilot nevidí a AI funkce na něm nejsou — bez ohledu na Site AI settings („This rule applies regardless of your other availability settings").
2. **IsAuthoritative na RCD webu nedává smysl** — nelze zvyšovat váhu obsahu, který je z discovery vyřazen. Kombinace signalizuje chybu v governance rozhodnutí.
3. **Skryté tlačítko není „AI stop".** Site AI settings mění UI na webu; grounding do M365 Copilot Chat běží dál. Content-level páky jsou RCD a permissions.
4. **Permissions jsou jediná skutečná hranice.** Všechna tři nastavení řídí viditelnost/váhu, žádné přístup. Oversharing řeší revize přístupů (DAG reporty, D3 SAM), RCD jen kupuje čas.

## Scénáře

| Scénář | Kdo / kde (licence + Site AI settings) | RCD | IsAuthoritative |
| --- | --- | --- | --- |
| **Pilot** (malá skupina, zbytek tenantu neuklizený) | Copilot licence jen pilotní skupině; vlastníci ostatních webů mohou skrýt tlačítko návštěvníkům | zapnout na rizikových webech (HR, Finance) po dobu revize | intranet s politikami |
| **Plný provoz s governance** | licence dle rolloutu; Site AI settings default | dočasně jen na webech v aktivní revizi přístupů | oficiální knowledge base, směrnice |
| **Oversharing nález** (DAG report ukázal únik) | beze změny — problém není funkce | okamžitě na dotčené weby (pozor: propagace není instantní!) | beze změny |
| **„Ještě nejsme ready"** | licence nepřidělovat (tenant-wide vypínač po GA neexistuje) | přesto na citlivé weby — kvůli M365 Copilot Chat groundingu (viz pravidlo 3) | zatím neřešit |

Pořadí úvahy v praxi: nejdřív **co AI nesmí vidět** (RCD + revize permissions), pak **komu a kde funkci pustit** (licence, Site AI settings), nakonec **co zvýraznit** (IsAuthoritative).

## Časté omyly

| Omyl | Realita |
| --- | --- |
| „RCD web je zabezpečený." | RCD nemění permissions — kdo má přístup, čte dál. Jen ho nenajde search/Copilot. |
| „Skryl jsem Copilot tlačítko = obsah není v Copilotu." | Skryté je UI na webu; M365 Copilot Chat obsah dál groundí. |
| „`KnowledgeAgentScope NoSites` Copilot vypne." | Parametr je od 1. 11. 2026 vyřazený — MS ho už nectí. |
| „RCD zapnu plošně, jistota je jistota." | Zúžený korpus = horší odpovědi pro všechny; Microsoft explicitně varuje před nadužíváním. Dočasný nástroj. |
| „IsAuthoritative omezí ostatní weby." | Nic neomezuje — jen zvyšuje váhu označeného obsahu. |
| „RCD se projeví hned." | Propagace přes indexy; velké weby i přes týden. |

## Jak stav přečíst (read-only)

```powershell
Get-SPOTenant | Select-Object DelegateRestrictedContentDiscoverabilityManagement
Get-SPOSite -Identity <url> | Select-Object RestrictContentOrgWideSearch, IsAuthoritative
```

Site AI settings se čtou v UI webu (*Settings → Site AI*); PowerShell ekvivalent MS nedokumentuje.

Kompletní inventura všech tří nastavení per web: [`../powershell-spo/guide-copilot-inventory.md`](../powershell-spo/guide-copilot-inventory.md) (+ `solution/copilot-inventory.ps1`).

## Zdroje (Microsoft)

[Get started with Copilot in SharePoint](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started) · [Restricted Content Discovery](https://learn.microsoft.com/en-us/sharepoint/restricted-content-discovery) · [Set-SPOSite](https://learn.microsoft.com/en-us/powershell/module/microsoft.online.sharepoint.powershell/set-sposite?view=sharepoint-ps)

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu — stav k 2026-10.
> `KnowledgeAgentScope` vyřazen (ctěn do 1. 11. 2026); Site AI settings jsou site-level a UI-only — po Ignite (17.–20. 11. 2026) ověřit, zda MS nepřidá tenant-wide ovládání nebo PowerShell.
> `Set-SPOSite` má nově i `RestrictedContentDiscoveryforCopilotAndAgents` (RCD pro hostování agentů, **private preview**) — do kurzu nepatří, ale studenti na parametr v nápovědě narazí; nezaměňovat s `RestrictContentOrgWideSearch`. `IsAuthoritative` je nový parametr — chování rankingu ověřit v tenantu před během.
