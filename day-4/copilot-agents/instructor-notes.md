# Instructor notes — Copilot Agents

## Timing

> [!NOTE] Struktura (D4, tento běh)
> Agentní část rozdělená na **úvod (tento blok) + dva nástrojové bloky**: [`agent-builder`](../agent-builder/), [`agents-toolkit`](../agents-toolkit/); volitelně [`opt-sharepoint-agents`](../opt-sharepoint-agents/) na konci dne. Před agenty běží [`cowork`](../cowork/), [`code`](../code/) a [`ai-app-access`](../ai-app-access/). **Skills jsou v D3, Copilot Studio v D5.**

- Tento blok (úvod): deklarativní základ + mapa cest + srovnání (`comparison-agent-paths.md`) ~15–20 min + návrhový lab (`lab-agent-design.md`).
- Nástrojové bloky mají vlastní laby a go/no-go (jejich instructor-notes). Orientační časy: Agent Builder ~45 min, Toolkit ~35 min (+ connected agents 25–30 min), volitelně SharePoint agents ~20 min.
- Most na D5: „dnes jste viděli strop no-code cest (analytika) — zítra ho Studio prorazí; a agenty, co postavíte, ráno spravujete v `copilot-admin`."

## Go/no-go — otestovat před během

- Tool-specific go/no-go je v instructor-notes jednotlivých bloků: [agent-builder](../agent-builder/instructor-notes.md), [sharepoint-agents](../opt-sharepoint-agents/instructor-notes.md), [agents-toolkit](../agents-toolkit/instructor-notes.md).
- Napříč: studenti mají od běhu 2026-11 **Copilot licenci** → Agent Builder hands-on; **SharePoint agents** tvorba = Copilot licence (legacy, volitelný blok); **Toolkit** (tvorba/nasazení) bez licence je od 2026-09 dokumentovaný (prerequisites); **Skills** po GA license-only, na PAYG nejedou (T1, ověřeno 2026-11). Skills už byly v D3.
- Knowledge Email / People / Teams messages / Teams meetings je jen pro licencované — s licencí ho studenti vyzkoušet můžou; u zákazníků s PAYG uživateli na to upozornit.

## Tripwires

- Callback na D2: tabulku vrstev instrukcí ukázat znovu — „teď píšete Agent Instructions doopravdy".
- **Instrukce ≠ knowledge** (XPIA) — kontrolovat v labu, studenti rádi nacpou směrnici do instrukcí.
- Negativní test v evaluačním plánu je povinný — bez něj se agent „vždycky povede".
- Researcher/Analyst nejsou „agenti k tvorbě" — D4 už to říkal, nenechat zamotat. Jsou součást Copilot licence; admin je umí blokovat.
- Demo agenta stavět nad instruktorským webem, ne nad studentskými (práva, překvapení).
- Srovnávací matici (`comparison-agent-paths.md`) promítnout u mapy cest — nosné rozdíly: listy (Studio 10 + analytika / Builder 1 / SharePoint agent 1 a nic jiného / Toolkit nic), akce (Studio konektory+MCP+triggery vs. Toolkit OpenAPI), ALM (jen Toolkit = git). U SharePoint agents zmínit docs lag k listům (MC1255409 GA ~05/2026, get-started to neuvádí) a že limit „1 zdroj" je empirický, MS ho nedokumentuje. Avizovat: od pol. 11/2026 jde tvorba SharePoint agenta přes Agent Builder, `.agent` končí po 03/2027.

## HR Asistent — running example (příprava dat)

- Scénář [`scenario-hr-agent.md`](scenario-hr-agent.md) + laby [`../agent-builder/lab-agent-builder.md`](../agent-builder/lab-agent-builder.md) a [`../opt-sharepoint-agents/lab-sharepoint-agent.md`](../opt-sharepoint-agents/lab-sharepoint-agent.md) táhnou jeden agent D4 → D5. Data nasadit **před během**: `scripts/New-HRAgentData.ps1 -SiteUrl .../sites/hr-demo -ClientId <PnP-GOC224> -CreateSite -SiteOwner <admin-účet — viz instruktorský soubor> -UseDeviceCode` (ClientId nikdy do repa; skript je gitignored). `-ReferenceDate` pinnout pro reprodukovatelné „do 30 dnů".
- **Před každým během přenasadit s `-Reseed -ReferenceDate <datum D4>`** — expirace certifikátů jsou offsety (10018/10022/10027 = +7/+21/+28 dní). Se starými daty z 2026-07-16 by „do 30 dnů" vracelo jiné osoby a laby Agent Builder, Code a Copilot Studio by hodnotily správné odpovědi jako chybné. Laby proto berou jako zdroj pravdy filtr v listu. Data nasazená poprvé 2026-07-16. Fresh tenant: přidat `-CreateSite -SiteOwner <admin-účet — viz instruktorský soubor>`. Přidání knihovny `Runbooky` (pro Toolkit lab) i přegenerování dat: `-Reseed`. Reuse spojení = jeden device login na okno.
- Nosná pointa HR labu: **tentýž požadavek** narazí na jinou hranu — Agent Builder jen prioritizuje (neagreguje), SharePoint agent má **1 zdroj a nic jiného**. Analytiku („komu propadá certifikát") **v D4 nezvládne žádný agent** — schválně visí jako most na **Copilot Studio v D5**. Dopolední dashboard v Code (`code`) ji zvládl jako **aplikace** — rozlišovat: aplikace = přehled, agent = konverzační odpověď v kontextu. JOIN list × knihovna = Power Automate, ne agent.
- **Toolkit do HR nepatří** (list nescopuje) — má vlastní lab [`../agents-toolkit/lab-toolkit-agent.md`](../agents-toolkit/lab-toolkit-agent.md) na scénáři Support (runbooky, agent jako spravovaná konfigurace, bez akce).
- Stavět nad instruktorským HR webem, ne studentskými. U SP agenta studenti jen sledují (legacy cesta, volitelný blok).

## Dva scénáře — každý nástroj na své (playbook)

- **Publikum = správci, ne vývojáři. Kurz zůstává v M365.** Proto Toolkit učíme jako **„agent jako spravovaná konfigurace"** (manifest v gitu, provisioning, publikace přes schválení — governance/ALM), **ne jako vývoj**. **Akce / API plugin / Azure jsou mimo rozsah** — v labu jen pojmenovat slot `actions` a odkázat „udělej něco v tenantu → Power Automate (D4 dopoledne)".
- Demo playbook [`guide-agent-build-demo.md`](guide-agent-build-demo.md) staví **dva** scénáře: **HR Asistent** (data/knowledge → Agent Builder + SharePoint agent; analytika = Copilot Studio až **D5**) a **Support Asistent** ([`scenario-support-agent.md`](scenario-support-agent.md), **čte runbooky, bez akce** → Agents Toolkit jako řízená konfigurace). Support běží nad knihovnou `Runbooky`. Meta-lekce pro správce: **tentýž agent, jiná disciplína stavby** (klikačka vs. governed kód).
- **Proč Toolkit nedostal HR:** ověřeno ve schématu manifestu 1.7 a znovu v 1.9 (2026-09) — SharePoint knowledge = weby/knihovny/složky/soubory, `list_id` = **knihovna** (ne list), `unique_id` = soubor/složka. Strukturovaný list manifest jako knowledge nezná; tabulková data jen přes `Dataverse`/konektor/akci. Když se student zeptá „proč zrovna Toolkit vychází špatně", tohle je odpověď se zdrojem ([manifest 1.9](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/declarative-agent-manifest-1.9), [Toolkit add knowledge](https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/build-declarative-agents-add-knowledge)) — ne „Toolkit je slabý", ale „špatný nástroj na tuhle práci".

## Vazby

- Zpět: Agent Instructions/orchestrator (D2).
- Dopředu: **správa agentů** (registr, blokace, Agent 365) hned zítra ráno v `copilot-admin` (D5); pak Copilot Studio = „stejný návrh, silnější nástroj" — návrhy z návrhového labu se ve Studiu dají rovnou stavět, **HR Asistent** se dostaví k analytickým dotazům nad listem; evaluační plán se recykluje v capstone.
