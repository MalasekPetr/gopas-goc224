# Pro-code vs. low-code agenti a vzory rozšíření

> Typ: povinný · Den: 4 · Odhad: AM blok (po Power Automate)
> Prostředí: viz [`../../environment.md`](../../environment.md) · Názvosloví: [`../../GLOSSARY.md`](../../GLOSSARY.md)

## Cíle

- Vyberete vrstvu rozšíření — konektor, Power Automate, SPFx, nebo Microsoft Graph — a volbu zdůvodníte limity, bezpečností a udržovatelností.
- Znáte aktuální vývojářské nástroje (Microsoft 365 Agents Toolkit, Microsoft 365 Agents SDK) a víte, které vrstvy jsou vyřazené.
- Navrhnete rozšíření existujícího flow o vlastní akci (lab).

## Proč řešit vrstvu rozšíření

V předchozím modulu [`power-automate-invoices`](../power-automate-invoices/README.md) jste viděli demo flow nad fakturami: nová faktura v knihovně → vytěžení přes AI Builder → schválení → zápis metadat. Dříve nebo později přijde požadavek, který hotový flow neumí: ověřit dodavatele v externím registru, poslat data do interního ERP, nebo zobrazit výsledek uživatelům jinak než seznamem v knihovně.

Každý takový požadavek jde splnit na několika vrstvách — od hotového konektoru po vlastní kód. Volba vrstvy přitom rozhoduje o tom, kdo řešení postaví, kdo ho bude za rok opravovat, jaké bezpečnostní kontroly na něj dopadnou a kdo bude platit jeho provoz. Jako správce nemusíte umět psát SPFx ani volat Graph, ale měli byste umět říct, *která* vrstva je pro daný požadavek přiměřená, a odmítnout zbytečně těžké řešení.

## Výklad

### Mapa možností

Diagram čtěte jako sadu otázek, které si nad požadavkem položíte. Nejsou to alternativy jedna vedle druhé — jeden požadavek může projít víc větvemi (např. flow s custom connectorem, jehož výsledek zobrazí SPFx web part).

```mermaid
flowchart TB
  Need[Potřeba rozšíření] --> LC{Stačí hotový<br>konektor?}
  LC -->|ano| PA[Power Automate<br>+ hotové konektory]
  LC -->|ne| CC[Custom connector<br>OpenAPI + Entra ID auth]
  Need --> UI{Jde o UI<br>v SharePointu?}
  UI -->|ano| SPFx[SPFx web part /<br>extension]
  Need --> Data{Přímý přístup<br>k M365 datům?}
  Data -->|ano| Graph[Microsoft Graph<br>graph.microsoft.com]
  Need --> CUI{UI agenta<br>přímo v Copilotu?}
  CUI -->|ano| CUX[SPFx Copilot UX<br>components]
```

Další sekce vysvětlují jednotlivé uzly mapy — co která vrstva je, proč existuje a kdy po ní sáhnout.

### Custom connectors — nejmenší pro-code krok

Když pro službu, kterou potřebujete volat, neexistuje hotový konektor, nemusíte hned psát aplikaci. **Custom connector** je obal nad existujícím REST API: popíšete ho definicí OpenAPI (jaké operace API má, jaké parametry bere a co vrací) a nastavíte autentizaci, doporučeně přes Microsoft Entra ID. Výsledek se v Power Automate chová jako kterýkoli jiný konektor — akce se objeví v návrháři a power user ji použije bez znalosti HTTP.

Custom connector je sdílený mezi **Power Automate, Power Apps a Copilot Studio**, takže jednou popsané API pak může volat flow, aplikace i agent. Logic Apps tento konektor nesdílí ([Custom connectors](https://learn.microsoft.com/en-us/connectors/custom-connectors/)).

V labu na custom connector narazíte u scénářů s registrem ARES a s interním ERP — pro ani jedno hotový konektor neexistuje.

### SPFx — UI v SharePointu, Teams a Viva Connections

**SharePoint Framework (SPFx)** je client-side model pro vývoj rozšíření SharePointu, Teams a Viva Connections: web party na stránkách a extensions. Kód běží na straně klienta, v prohlížeči uživatele. Pro vlastní UI ve Viva Connections je SPFx jediná cesta.

Proč na tom dnes záleží: **SharePoint add-in model v SharePoint Online skončil 2. 4. 2026** a SPFx je jeho náhrada. Pokud v organizaci narazíte na starší add-in, v SharePoint Online už nefunguje a náhradu je potřeba postavit v SPFx ([SPFx overview](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/sharepoint-framework-overview), [SPFx roadmap](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/roadmap)).

SPFx balíček (`.sppkg`) se nasazuje přes tenant **App Catalog**; tam také správce schvaluje, ke kterým API smí řešení přistupovat (API access).

### SPFx 1.24 — Copilot UX components

**SPFx 1.24** (GA 28. 10. 2026) přidal do mapy novou hranu: **Copilot UX components** jsou GA. SPFx balíček tak může dodat deklarativního agenta i s interaktivním UI, které se zobrazí přímo v Microsoft 365 Copilotu a v Copilotu v Teams. Uživatel tedy nedostane jen textovou odpověď agenta, ale i interaktivní UI uvnitř konverzace. Funkce vyžaduje **Copilot licenci uživatele** a spotřební (PAYG) účtování nepodporuje ([Release 1.24](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/release-1.24.0), [Copilot UX components](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/copilot/overview-copilot-apps)).

Tři vlastnosti, které jsou pro správce podstatné:

- **Hosting v tenantu.** Komponenty implementují model **MCP Apps**, ale **hostují se automaticky v Microsoft 365 tenantu** — žádný vlastní hosting, routing ani externí aplikace s vlastním service principalem. Data tak neopouštějí hranici tenantu a odpadá správa další aplikační identity (srov. [`ai-app-access`](../ai-app-access/README.md)).
- **Distribuce jako běžné SPFx.** `.sppkg` obsahuje deklarativního agenta i komponenty; nasazuje se přes tenant **App Catalog** (*Add to Teams*) nebo **SharePoint Store**.
- **Omezení u GA.** Komponenty fungují jen v Copilotu a v Copilotu v Teams v prohlížeči a desktopové aplikaci; **ne na iOS/Android** (ani v Teams mobile) a **ne v Cowork**. Aktuální opravná verze je **1.24.1** (2. 11. 2026).

### Microsoft Graph — přímý přístup k datům Microsoft 365

**Microsoft Graph** je jednotné API pro data Microsoft 365: jeden endpoint `graph.microsoft.com` pro uživatele, poštu, kalendáře, Teams i SharePoint. Pro SharePoint nabízí zdroje site, list, listItem a driveItem. Weby jde přes Graph jen číst, seznamy a položky číst i zapisovat ([Graph overview](https://learn.microsoft.com/en-us/graph/overview), [SharePoint API](https://learn.microsoft.com/en-us/graph/api/resources/sharepoint)).

Po Graphu sáhnete, když potřebujete s daty pracovat způsobem, který konektory nenabízejí — typicky z vlastní služby (např. Azure Function), která běží bez uživatele. Taková služba potřebuje aplikační registraci a oprávnění, což je téma modulu [`ai-app-access`](../ai-app-access/README.md).

Pozor na podobné jméno: dřívější **Graph connectors** se dnes jmenují **Microsoft 365 Copilot connectors**. Jde o jiný pojem než Graph API popsané výše — nezaměňujte je.

### Microsoft 365 Agents Toolkit a Agents SDK

**Microsoft 365 Agents Toolkit** je nástupce Teams Toolkitu — rozšíření pro VS Code s podporou JavaScriptu, TypeScriptu a Pythonu. Staví deklarativní agenty (instrukce a znalosti nad orchestrátorem Copilotu) i custom engine agenty (vlastní hosting a modely). Projekt agenta je kód v repozitáři, takže na něj jde uplatnit code review a CI/CD ([Agents Toolkit](https://learn.microsoft.com/en-us/microsoftteams/platform/toolkit/agents-toolkit-fundamentals)).

Starší knihovna **TeamsFx SDK je vyřazená**: community support skončil v září 2026 a dokumentace je archivovaná. Nová práce jede na **Microsoft 365 Agents SDK** ([TeamsFx SDK — archiv](https://learn.microsoft.com/en-us/previous-versions/microsoftteams/platform/toolkit/teamsfx-sdk)). Když v návodech z internetu narazíte na TeamsFx, berte je jako historii.

Prakticky s Agents Toolkitem pracujete v modulu [`agents-toolkit`](../agents-toolkit/README.md).

### Rozhodovací osa (limity · bezpečnost · udržovatelnost)

Mapa říká, *které* vrstvy připadají v úvahu. O volbě mezi nimi rozhodují tři kritéria: **limity** (kde řešení narazí na strop), **bezpečnost** (jaké kontroly na něj dopadnou) a **udržovatelnost** (kdo ho za rok opraví).

| Kritérium | Low-code (flow + konektory) | Pro-code (SPFx / Graph / Agents SDK) |
|---|---|---|
| Rychlost dodání | hodiny–dny | dny–týdny |
| Limity | throttling konektorů, AI Builder kredity, licence per-user | limity API (Graph throttling), jinak volné |
| Bezpečnost | DLP politiky konektorů, Entra ID auth | plná kontrola (app registration, scopes, cert auth) |
| Udržovatelnost | flow žije v prostředí, ALM přes solutions | **kód v repu, code review, CI/CD** |
| Kdo udrží | power user / IT | vývojář |

Jak tabulku používat:

- **Limity** se u low-code projeví jako throttling konektorů a spotřeba AI Builder kreditů; u pro-code jsou hlavním stropem limity API.- **Bezpečnost** u low-code řídí správce Power Platform přes DLP politiky konektorů — centrálně, bez zásahu do flow. U pro-code máte plnou kontrolu, ale i plnou odpovědnost: aplikační registraci, rozsah oprávnění a certifikátovou autentizaci musí někdo navrhnout a hlídat.
- **Udržovatelnost** je kritérium, které se nejčastěji podcení. Flow žije v prostředí Power Platform a jeho životní cyklus (ALM) se řeší přes solutions. Kód žije v repozitáři s historií a review, ale potřebuje vývojáře. Pokud v organizaci vývojář není, i elegantní pro-code řešení se za rok stane neudržovatelným.

### Aplikace pro uživatele — kde žije a kdo platí

Stejný požadavek („přehled nad HR listem pro tým") jde dnes dodat čtyřmi cestami. Rozhoduje, kde výsledek žije, jakou licenci potřebuje čtenář a kdo platí běh.

| Cesta | Kde žije | Licence uživatele | Kdo platí běh | Správa |
|---|---|---|---|---|
| **Code / Cowork → Copilot Managed Runtime** (D4 [`code`](../code/README.md)) | Microsoft-hosted, `managedapps.cloud.microsoft` | Copilot Credits nebo Power Apps Premium (Copilot licence ne) | **každý uživatel, který aplikaci otevře** (Copilot Credits) | M365 AC → Apps, PPAC |
| **HTML page v SharePointu** | knihovna Site Pages webu | žádná (Copilot jen pro tvorbu s Copilotem) | nikdo navíc | per web: *Allow HTML files*, HTML Field Security; tenantový vypínač není |
| **SPFx web part / extension** | SharePoint stránka, Teams, Viva Connections | žádná | nikdo navíc (volaná API mohou mít vlastní poplatky) | App Catalog, API access |
| **SPFx Copilot UX components** | v tenantu, UI přímo v Copilotu | **Copilot licence** (USL nad E3/E5/E7) | bez spotřebních poplatků | App Catalog (*Add to Teams*) / SharePoint Store |

Všimněte si sloupce *Kdo platí běh*. U aplikace v **Copilot Managed Runtime** neplatí jen autor — Copilot Credits čerpá každý uživatel, který aplikaci otevře, a Copilot licence to nepokrývá. Aplikace, kterou si někdo vygeneruje v Code a nasdílí celému oddělení, tak má průběžné náklady. Naopak HTML page a SPFx žijí v SharePointu a čtenáři nestojí nic navíc. Copilot UX components jsou bez spotřebních poplatků, ale jen pro uživatele s Copilot licencí.

**HTML page je jen pro čtení.** Stránka běží v sandboxovaném iframe: JavaScript smí být jen ve stejném souboru, z knihoven jsou dostupné jen Chart.js, Mermaid, React, Fluent UI a Babylon z CDN Microsoftu a **žádná libovolná volání `fetch` ani API** nejsou povolená. Živá data umí načíst ze SharePoint listů, Excelu a CSV. Velikost stránky je omezená na 10 MB ([HTML pages v SharePointu](https://support.microsoft.com/en-us/sharepoint/create-edit-publish-html-pages), [SharePoint Blog](https://techcommunity.microsoft.com/blog/spblog/publish-rich-and-interactive-content-with-html-pages-in-sharepoint/4565918)). Pro přehled nad HR listem to stačí; pro formulář, který do listu zapisuje, ne.

Z toho plyne jednoduché pravidlo volby:

- **interaktivní aplikace se zápisem** → Copilot Managed Runtime,
- **UI agenta v Copilotu** → Copilot UX components,
- **plná kontrola nad UI v SharePointu** → SPFx,
- **přehled jen pro čtení nad daty webu** → HTML page.

Aplikaci z Managed Runtime do HTML page ani do Embed web partu jako iframe **nevkládejte**. Brání tomu Content Security Policy na obou stranách (`frame-ancestors` aplikace a sandbox stránky) a Microsoft tento scénář nedokumentuje. Odkaz na aplikaci vložit můžete; doména `managedapps.cloud.microsoft` pak musí být v HTML Field Security webu ([CSP v Managed Runtime](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/apps/governance#content-security-policy)).

## Klíčové rozlišení

- **Kupovat konektor vs. psát kód.** Custom connector je nejmenší pro-code krok — API kontrakt bez vlastní aplikace. Po SPFx nebo Graphu sáhněte až tehdy, když potřebujete vlastní UI nebo přístup, který konektory nenabízejí. UI agenta uvnitř Copilotu (SPFx Copilot UX components) je jen pro uživatele s Copilot licencí.
- **Deklarativní agent vs. custom engine.** Deklarativní agent = instrukce a znalosti nad orchestrátorem Copilotu, verzovatelné jako kód (repo-as-code, D5). Custom engine agent = vlastní hosting a vlastní modely, tedy i vlastní provoz. Pro většinu scénářů kurzu stačí deklarativní agent.
- **Vyřazené vrstvy nepoužívejte.** SharePoint add-in model (v SharePoint Online skončil 4/2026), TeamsFx SDK (support skončil 9/2026) a staré triggery „in a folder" (deprecated).
- **Licence ≠ kdo platí běh.** Copilot licence pokrývá Copilot UX components, ale ne aplikace v Copilot Managed Runtime — ty čerpají Copilot Credits za každého uživatele.

## Naše prostředí

Lab je **simulace**: navrhnete rozšíření demo flow z modulu [`power-automate-invoices`](../power-automate-invoices/README.md), bez psaní kódu. Vývojářské nástroje v tomto modulu neinstalujete.

## Shrnutí

- Vrstvu rozšíření volte podle mapy otázek: hotový konektor → custom connector → SPFx (UI v SharePointu) → Graph (přímý přístup k datům) → Copilot UX components (UI agenta v Copilotu).
- O volbě rozhodují limity, bezpečnost a hlavně udržovatelnost — kdo řešení za rok opraví.
- U aplikací pro uživatele sledujte, kde výsledek žije a kdo platí běh: Managed Runtime čerpá Copilot Credits za každého uživatele, HTML page a SPFx ne.
- Add-in model a TeamsFx SDK jsou vyřazené; náhradou jsou SPFx a Microsoft 365 Agents SDK s Agents Toolkitem.

## Lab

Viz [`lab-flow-extension.md`](lab-flow-extension.md) — rozšíření flow o vlastní akci (simulace).

## Zdroje (Microsoft)

- **SPFx:** [SharePoint Framework overview](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/sharepoint-framework-overview) · [SPFx roadmap](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/roadmap) · [SPFx 1.24](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/release-1.24.0) · [Copilot UX components](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/copilot/overview-copilot-apps)
- **Graph a konektory:** [Microsoft Graph overview](https://learn.microsoft.com/en-us/graph/overview) · [SharePoint API v Graphu](https://learn.microsoft.com/en-us/graph/api/resources/sharepoint) · [Custom connectors](https://learn.microsoft.com/en-us/connectors/custom-connectors/)
- **Agenti a vývojářské nástroje:** [Microsoft 365 Agents Toolkit](https://learn.microsoft.com/en-us/microsoftteams/platform/toolkit/agents-toolkit-fundamentals) · [TeamsFx SDK (archiv)](https://learn.microsoft.com/en-us/previous-versions/microsoftteams/platform/toolkit/teamsfx-sdk)
- **Aplikace pro uživatele:** [HTML pages v SharePointu](https://support.microsoft.com/en-us/sharepoint/create-edit-publish-html-pages) · [SharePoint Blog — HTML pages](https://techcommunity.microsoft.com/blog/spblog/publish-rich-and-interactive-content-with-html-pages-in-sharepoint/4565918) · [Copilot Managed Runtime — governance](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/apps/governance)

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu — stav k 2026-11.
>
> - **SPFx:** 1.24 GA (2026-10-28), opravná 1.24.1 (2026-11-02). Copilot UX components pro mobilní klienty a Cowork jsou „fast follow" bez data. SPFx 1.25 je plánované na 12/2026–1/2027 (SPFx CLI místo Yeomana).
> - **HTML pages v SharePointu:** public preview 10/2026, GA rollout od poloviny 11/2026 do konce 12/2026 (MC1479517). U nahraného HTML ověřte napojení živých dat z listu.
> - **Agents Toolkit** v GCC je v alpha, GCC High/DoD na roadmapě. U Copilot connectors (ex-Graph connectors) hlídejte další posuny názvů.
> - Po Ignite (17.–20. 11. 2026) modul projděte znovu.
