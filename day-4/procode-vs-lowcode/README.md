# Pro-code vs. low-code agenti a vzory rozšíření

> Typ: povinný · Den: 4 · Odhad: AM blok (po Power Automate)
> Prostředí: viz [`../../environment.md`](../../environment.md) · Názvosloví: [`../../GLOSSARY.md`](../../GLOSSARY.md)

## Cíle

- Student umí vybrat vrstvu rozšíření: konektor / Power Automate / SPFx / Graph — podle limitů, bezpečnosti a udržovatelnosti.
- Student zná aktuální dev nástroje (Agents Toolkit, Agents SDK) a ví, co je deprecated.
- Student navrhne rozšíření existujícího flow o vlastní akci (lab).

## Výklad

### Mapa možností

```mermaid
flowchart TB
  Need[Potřeba rozšíření] --> LC{Stačí hotový<br>konektor?}
  LC -->|ano| PA[Power Automate<br>+ 1000+ konektorů]
  LC -->|ne| CC[Custom connector<br>OpenAPI + Entra ID auth]
  Need --> UI{Jde o UI<br>v SharePointu?}
  UI -->|ano| SPFx[SPFx web part /<br>extension]
  Need --> Data{Přímý přístup<br>k M365 datům?}
  Data -->|ano| Graph[Microsoft Graph<br>graph.microsoft.com]
  Need --> CUI{UI agenta<br>přímo v Copilotu?}
  CUI -->|ano| CUX[SPFx Copilot UX<br>components]
```

- **SPFx** — client-side model pro SharePoint/Teams/Viva Connections (tam jediná cesta); **SharePoint add-in model v SharePoint Online skončil 2. 4. 2026, SPFx je náhrada** ([SPFx overview](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/sharepoint-framework-overview), [SPFx roadmap](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/roadmap)).
- **SPFx 1.24** (GA 28. 10. 2026) — **Copilot UX components** jsou GA: SPFx balíček může dodat deklarativního agenta i s interaktivním UI přímo do Microsoft 365 Copilotu a Copilotu v Teams. Vyžaduje Copilot licenci uživatele, spotřební (PAYG) účtování nepodporuje ([Release 1.24](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/release-1.24.0), [Copilot UX components](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/copilot/overview-copilot-apps)).
- **Microsoft Graph** — jeden endpoint `graph.microsoft.com` pro M365 data; SharePoint zdroje site/list/listItem/driveItem, weby jen read (list/item read-write) ([Graph overview](https://learn.microsoft.com/en-us/graph/overview), [SharePoint API](https://learn.microsoft.com/en-us/graph/api/resources/sharepoint)). Pozor rename: Graph connectors = **Microsoft 365 Copilot connectors**.
- **Custom connectors** — obal nad REST API (OpenAPI definice; auth doporučeně Entra ID); sdílené mezi Power Automate, Power Apps **a Copilot Studio** (ne Logic Apps) ([Custom connectors](https://learn.microsoft.com/en-us/connectors/custom-connectors/)).
- **Microsoft 365 Agents Toolkit** — nástupce Teams Toolkitu (VS Code, JS/TS/Python); staví deklarativní i custom engine agenty. **TeamsFx SDK je vyřazený** — community support skončil v září 2026, dokumentace je archivovaná ([TeamsFx SDK — archiv](https://learn.microsoft.com/en-us/previous-versions/microsoftteams/platform/toolkit/teamsfx-sdk)); nová práce jede na **Microsoft 365 Agents SDK** ([Agents Toolkit](https://learn.microsoft.com/en-us/microsoftteams/platform/toolkit/agents-toolkit-fundamentals)).

### Rozhodovací osa (limity · bezpečnost · udržovatelnost)

| Kritérium | Low-code (flow + konektory) | Pro-code (SPFx / Graph / Agents SDK) |
|---|---|---|
| Rychlost dodání | hodiny–dny | dny–týdny |
| Limity | throttling konektorů, AI Builder kredity, licence per-user | limity API (Graph throttling), jinak volné |
| Bezpečnost | DLP politiky konektorů, Entra ID auth | plná kontrola (app registration, scopes, cert auth) |
| Udržovatelnost | flow žije v prostředí, ALM přes solutions | **kód v repu, code review, CI/CD** |
| Kdo udrží | power user / IT | vývojář |

## Klíčové rozlišení

- **Kupovat konektor vs. psát kód**: custom connector je nejmenší pro-code krok — API kontrakt bez vlastní aplikace. SPFx/Graph až když potřebuješ UI nebo přístup mimo možnosti konektorů. UI agenta uvnitř Copilotu (SPFx Copilot UX components) = jen pro uživatele s Copilot licencí.
- **Deklarativní agent vs. custom engine**: deklarativní = instrukce + knowledge na orchestrátoru Copilotu (repo-as-code, D5); custom engine = vlastní hosting a modely. Pro 90 % scénářů kurzu stačí deklarativní.
- **Vyřazené vrstvy neučit**: SharePoint add-in model (v SPO skončil 4/2026), TeamsFx SDK (support skončil 9/2026), staré „in a folder" triggery (deprecated).

## Naše prostředí

- Lab je **simulace** — návrh rozšíření demo flow z bloku 3, bez psaní kódu. Dev nástroje se ukazují, neinstalují.

## Lab

Viz [`lab-flow-extension.md`](lab-flow-extension.md) — rozšíření flow o vlastní akci (simulace).

## Zdroje (Microsoft)

[SharePoint Framework overview](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/sharepoint-framework-overview) · [SPFx roadmap](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/roadmap) · [SPFx 1.24](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/release-1.24.0) · [Copilot UX components](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/copilot/overview-copilot-apps) · [TeamsFx SDK (archiv)](https://learn.microsoft.com/en-us/previous-versions/microsoftteams/platform/toolkit/teamsfx-sdk) · [Microsoft Graph overview](https://learn.microsoft.com/en-us/graph/overview) · [SharePoint API v Graphu](https://learn.microsoft.com/en-us/graph/api/resources/sharepoint) · [Microsoft 365 Agents Toolkit](https://learn.microsoft.com/en-us/microsoftteams/platform/toolkit/agents-toolkit-fundamentals) · [Custom connectors](https://learn.microsoft.com/en-us/connectors/custom-connectors/)

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu — stav k 2026-10.
> TeamsFx SDK: community support skončil 9/2026 — jen jako historie. SharePoint add-iny v SPO skončily 2. 4. 2026. SPFx 1.24 GA (2026-10-28) s Copilot UX components; SPFx 1.25 plánované na 12/2026–1/2027 (SPFx CLI místo Yeomana) — do výkladu nepatří, jen tripwire na dotazy. Agents Toolkit v GCC: alpha; GCC High/DoD roadmap. Copilot connectors (ex-Graph connectors) — hlídat další posuny názvů; po Ignite (17.–20. 11. 2026) projet.
