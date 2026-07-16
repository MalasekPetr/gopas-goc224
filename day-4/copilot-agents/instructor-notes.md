# Instructor notes — Copilot Agents

## Timing

> [!NOTE] Změna programu (D4, tento běh)
> copilot-agents rozšířen z „mapa cest + Agent Builder demo" na **tři laby**. Studenti staví hands-on v **Agent Builderu** a **Toolkitu**; **SharePoint agent instruktor jen ukáže** (tvorba = license-only). **Copilot Studio a jeho analytický payoff jde celý do D5** — dnes ho jen slíbíme jako most. Skills taky D5.

- Mapa cest + srovnání (`comparison-agent-paths.md`) ~15–20 min; demo Agent Builderu pod 10 min (flow, ne ladění).
- HR lab [`lab-hr-agent-build.md`](lab-hr-agent-build.md) ~45 min — studenti Agent Builder + instruktor SP agent demo.
- Toolkit lab [`lab-toolkit-agent.md`](lab-toolkit-agent.md) ~40 min — společná stavba, `Provision`/běh vede instruktor.
- Velký blok (~2 h). Když čas tlačí: Toolkit lab zkrátit na část A+B (scaffold + manifest), běh nechat jako jeden instruktorský run. Most: „dnes jste viděli strop no-code cest — zítra ho Studio prorazí."

## Go/no-go — otestovat před během

- **Agent Builder v našem tenantu**: docs říkají „M365 Copilot licence NEBO tenant s PAYG pro Copilot Studio" — ověřit, že PAYG cesta u nás reálně Agent Builder zpřístupňuje (i pro studenty). Určuje, jestli v HR labu staví studenti sami (část B), nebo to jede jen jako instruktorské demo (fallback).
- **SharePoint agents**: tvorba vyžaduje Copilot licenci — studenti s PAYG mohou agenty *používat*, ne tvořit. Nezakládat na tom lab; zmínit jako licenční teaching point.
- **Skills NEJSOU studentský fallback** — vyžadují Copilot in SharePoint (license-only; PAYG neodemyká, ověřeno živě 2026-07). Fallback labu = návrhová část A + instruktor staví vybrané návrhy v demu.

## Tripwires

- Callback na D2: tabulku vrstev instrukcí ukázat znovu — „teď píšete Agent Instructions doopravdy".
- **Instrukce ≠ knowledge** (XPIA) — kontrolovat v labu, studenti rádi nacpou směrnici do instrukcí.
- Negativní test v evaluačním plánu je povinný — bez něj se agent „vždycky povede".
- Researcher/Analyst nejsou „agenti k tvorbě" — D4 už to říkal, nenechat zamotat.
- Demo agenta stavět nad instruktorským webem, ne nad studentskými (práva, překvapení).
- Srovnávací matici (`comparison-agent-paths.md`) promítnout u mapy cest — nosné rozdíly: listy (Studio 10 + analytika / Builder 1 / SharePoint agent 1 a nic jiného / Toolkit nic), akce (Studio konektory+MCP+triggery vs. Toolkit OpenAPI), ALM (jen Toolkit = git). U SharePoint agents zmínit docs lag k listům (MC1255409 GA ~05/2026, get-started to k 06/2026 neuvádí).

## HR Asistent — running example (příprava dat)

- Scénář [`scenario-hr-agent.md`](scenario-hr-agent.md) + lab [`lab-hr-agent-build.md`](lab-hr-agent-build.md) táhnou jeden agent D4 → D5. Data nasadit **před během**: `scripts/New-HRAgentData.ps1 -SiteUrl .../sites/hr-demo -ClientId <PnP-GOC224> -CreateSite -SiteOwner admin@spdemo.online -UseDeviceCode` (ClientId nikdy do repa; skript je gitignored). `-ReferenceDate` pinnout pro reprodukovatelné „do 30 dnů".
- Data nasazená (2026-07-16). Fresh tenant: přidat `-CreateSite -SiteOwner admin@spdemo.online`. Přidání knihovny `Runbooky` (pro Toolkit lab) i přegenerování dat: `-Reseed`. Reuse spojení = jeden device login na okno.
- Nosná pointa HR labu: **tentýž požadavek** narazí na jinou hranu — Agent Builder jen prioritizuje (neagreguje), SharePoint agent má **1 zdroj a nic jiného**. Analytiku („komu propadá certifikát") **v D4 nezvládne nikdo** — schválně visí jako most na **Copilot Studio v D5**. JOIN list × knihovna = Power Automate, ne agent.
- **Toolkit do HR nepatří** (list nescopuje) — má vlastní lab [`lab-toolkit-agent.md`](lab-toolkit-agent.md) na scénáři Support (runbooky, agent jako spravovaná konfigurace, bez akce).
- Stavět nad instruktorským HR webem, ne studentskými. U SP agenta studenti jen sledují (license-only).

## Dva scénáře — každý nástroj na své (playbook)

- **Publikum = správci, ne vývojáři. Kurz zůstává v M365.** Proto Toolkit učíme jako **„agent jako spravovaná konfigurace"** (manifest v gitu, provisioning, publikace přes schválení — governance/ALM), **ne jako vývoj**. **Akce / API plugin / Azure jsou mimo rozsah** — v labu jen pojmenovat slot `actions` a odkázat „udělej něco v tenantu → Power Automate (D3)".
- Demo playbook [`guide-agent-build-demo.md`](guide-agent-build-demo.md) staví **dva** scénáře: **HR Asistent** (data/knowledge → Agent Builder + SharePoint agent; analytika = Copilot Studio až **D5**) a **Support Asistent** ([`scenario-support-agent.md`](scenario-support-agent.md), **čte runbooky, bez akce** → Agents Toolkit jako řízená konfigurace). Support běží nad knihovnou `Runbooky`. Meta-lekce pro správce: **tentýž agent, jiná disciplína stavby** (klikačka vs. governed kód).
- **Proč Toolkit nedostal HR:** ověřeno ve schématu manifestu 1.7 — SharePoint knowledge = weby/knihovny/složky/soubory, `list_id` = **knihovna** (ne list), `unique_id` = soubor/složka. Strukturovaný list manifest jako knowledge nezná; tabulková data jen přes `Dataverse`/konektor/akci. Když se student zeptá „proč zrovna Toolkit vychází špatně", tohle je odpověď se zdrojem ([manifest 1.7](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/declarative-agent-manifest-1.7), [Toolkit add knowledge](https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/build-declarative-agents-add-knowledge)) — ne „Toolkit je slabý", ale „špatný nástroj na tuhle práci".

## Vazby

- Zpět: Agent Instructions/orchestrator (D2), publikační flow a registry (dnešní `copilot-admin`).
- Dopředu: Skills a Copilot Studio (zítra, D5) = „stejný návrh, silnější nástroj" — návrhy z části A se v Copilot Studiu dají rovnou stavět; **HR Asistent** se v D5 dostaví k analytickým dotazům nad listem; evaluační plán se recykluje v capstone.
