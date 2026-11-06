# Výklad · Srovnání schopností agentů podle cesty tvorby

> Modul: copilot-agents · Doplněk k „Mapa cest tvorby" v README · Stav ověřen k 2026-10
> Prostředí: viz [`../../environment.md`](../../environment.md) · Názvosloví: [`../../GLOSSARY.md`](../../GLOSSARY.md)

Agent Builder, SharePoint agents a Agents Toolkit vedou k deklarativnímu agentovi na orchestrátoru M365 Copilot; Copilot Studio staví hlavně agenty na vlastních harnessech (pozn. ¹) a Agents Toolkit vede i na custom engine (viz níže). **Schopnosti se ale liší víc, než mapa cest naznačuje**. Tohle je rozdílová tabulka pro rozhodnutí „čím stavět".

## Srovnávací matice

| Schopnost | **Agent Builder** | **Copilot Studio** (new exp.)¹ | **Agents Toolkit** (VS Code) | **SharePoint agents** |
| --- | --- | --- | --- | --- |
| **SharePoint soubory/weby** | ✅ až 100 souborů/složek/webů | ✅ weby real-time nebo upload se sync | ✅ URL / SharePoint IDs (site, knihovna, složka, soubor) | ✅ zdroje z webu |
| **SharePoint listy** | ✅ **1 list** (20k položek / 50 MB; přílohy se neindexují) | ✅ **až 10 listů**, ~120k řádků celkem; **analytické/agregační dotazy** | ❌ list jako tabulku manifest nezná (`list_id` = **knihovna**, ne list — i ve schema 1.9); tabulková data jen přes `Dataverse`/konektor/akci | ✅ **1 list — a nic jiného** (přidání listu odstranilo ostatní zdroje; MC1255409 — MS dokumentace limit neuvádí, empiricky 2026-07, ověřit) |
| **Dataverse** | ❌ | ✅ nativní | ✅ capability `Dataverse` (tabulky v manifestu) | ❌ |
| **Copilot konektory** | ✅ vč. scopování atributem | ✅ | ✅ + **KQL filtr** (`additional_search_terms`), scoping per item/container | ❌ |
| **Teams / e-mail / People / schůzky**² | ✅ (Teams 5 chatů, e-mail bez scopování) | částečně (přes konektory/tools) | ✅ nejjemnější: e-mail per složka + **shared/group mailboxy**, schůzky per ID, People s related content | ❌ |
| **Web search** | ✅ 4 URL | ✅ | ✅ 4 sites | ❌ |
| **Akce / tools** | ❌ akce do externích služeb neumí → „copy to Copilot Studio" ([Agent Builder](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/agent-builder)); umí připojit **skills** (preview, max 8) | ✅ **nejsilnější**: Power Platform konektory, HTTP, **MCP**, agent flows, triggery (autonomní scénáře) | ✅ API pluginy (OpenAPI manifest), MCP; 1–10 akcí | ❌ (jen Q&A nad obsahem) |
| **Orchestrace / model** | orchestrátor M365 Copilot | **vlastní orchestrace** (generative vs. classic), volba modelu, potlačení obecných znalostí modelu | orchestrátor M365 Copilot + manifest overrides (viz níže) | orchestrátor M365 Copilot |
| **ALM / source control** | ❌ (osobní nástroj) | částečně (solutions, environmenty) | ✅ **repo-as-code**: manifest v gitu, CI/CD, provisioning | ❌ (.agent soubor na webu) |
| **Multi-agent** | ❌ | ✅ (connected agents, worker koncepty) | ✅ `worker_agents` v manifestu (preview) | ❌ |
| **Publikace** | sdílení + org katalog (ne marketplace) | org katalog, marketplace, **kanály mimo M365** (web, custom app) | org katalog, marketplace | jen web (+ sdílení do Teams chatu) |
| **Licence tvorba/použití** | Copilot licence nebo PAYG tenant | Copilot Studio přístup (Copilot Credits / PAYG) | tvorba zdarma; použití licence/kredity | tvorba: Copilot licence; použití: licence **nebo PAYG meter** |
| **Governance páky** | admin approval do katalogu | **DLP v Power Platform admin centru** (enforcement povinný), kanály, auth | RAI validace balíčku, admin approval, audit v repu | RCD/RSS na webu, SAM reporty (D3/D4) |

¹ Copilot Studio staví agenty hlavně na dvou harnessech: **standard** (klasický — generative/classic orchestrace, topics) a **GitHub Copilot harness** (GA od 8/2026 — orchestrace nekonfigurovatelná, skills, kredity od první stavby). Sloupec popisuje hlavně standard harness; detail v D5 ([Harnesses](https://learn.microsoft.com/en-us/microsoft-copilot-studio/harnesses-overview)).
² Na PAYG (bez Copilot licence) jsou Email, People, Teams messages a Teams meetings jako knowledge **jen pro licencované** uživatele ([Prerequisites](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/prerequisites)) — studenti mají od 2026-11 Copilot licenci, takže tyto zdroje vyzkoušet můžou.

Průřezově pro všechny: **permission trimming** (agent nikdy nepřekročí práva uživatele), sensitivity labels respektovány, **Restricted SharePoint Search blokuje SharePoint knowledge úplně** a RCD vyřazuje web z groundingu (D2 explainer).

## Co má každá cesta exkluzivně

- **Copilot Studio**: analytika nad listy (jediná cesta na agregační dotazy „průměr/počet/max"), plná kontrola orchestrace vč. blokace obecných znalostí modelu (Agent Builder umí jen *prioritizovat* — „Only use specified sources" negarantuje), DLP integrace, autonomní triggery, kanály mimo M365.
- **Agents Toolkit**: manifest-only funkce, které v žádném UI nejsou — `editorial_answers` (až 300 předdefinovaných Q&A párů), `behavior_overrides.special_instructions.discourage_model_knowledge`, `default_response_mode` (Quick/Think deeper), `user_overrides` (uživatelské vypínače capabilities), scoping e-mailu na sdílené mailboxy a schůzek per ID. A je pro-code cestou i na **custom engine agenta** (vlastní orchestrátor/model/hosting — mimo deklarativní model) s Microsoft 365 Agents SDK nebo agentem z Microsoft Foundry; low-code custom engine agenty staví i Copilot Studio ([Custom engine agents](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/overview-custom-engine-agent)). Dráhy viz README, *Dvě dráhy, jeden ekosystém*.
- **Agent Builder**: nulová bariéra — agent za minuty přímo v Copilot appce, embedded files z disku (pozor: sdílením agenta sdílíš obsah souborů), automatická tvorba z popisu, skills (preview).
- **SharePoint agents**: jediná cesta, kde agenta staví **vlastník obsahu bez opuštění webu**; agent žije s webem (permissions, lifecycle) a použití jde přes PAYG i pro nelicencované. **Od pol. 11/2026** „Create agent" na webu otevře Agent Builder a `.agent` soubor už nevznikne; `.agent` soubory přestanou odpovídat po 03/2027 ([Upgrade SharePoint agents](https://learn.microsoft.com/en-us/sharepoint/upgrade-sharepoint-agents)).

> [!NOTE] Další cesty mimo tabulku
> MS mapa nástrojů ([Choose development tools](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/choose-plugin-development-tools)) dnes uvádí i **Cowork plugins** (skills + konektory pro Cowork) a **Work IQ Dev Tools** (preview) a jako jednotku balení „plugin" (agent + skills + konektory + MCP). **Copilot Code** staví aplikace, ne agenty. Skills (`SKILL.md`) nejsou jen v Copilot in SharePoint — připojí je i Agent Builder, manifest (`agent_skills`, schema 1.9) a Cowork. Stav po Ignite (17.–20. 11. 2026) ověřit.

## Rozhodovací osa (rozšíření tabulky z README)

1. **Potřebuješ data z listů?** analytika → Copilot Studio (10 listů) · lookup → Agent Builder (1 list + jiné zdroje) · „agent nad jedním listem a ničím jiným" → SharePoint agent · Toolkit → ne (ani schema 1.9 list jako tabulku nezná — `list_id` je stále knihovna; sledovat [manifest 1.9](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/declarative-agent-manifest-1.9)).
2. **Potřebuješ akce/automatizaci?** konektory/MCP/triggery → Copilot Studio (i jako „copy to Copilot Studio" z Builderu) · vlastní API s OpenAPI → Toolkit · žádné akce → Builder/SharePoint agent.
3. **Potřebuješ source control a CI/CD?** → Toolkit, bez diskuze (repo-as-code přístup kurzu).
4. **Kdo staví?** koncový uživatel → Builder · vlastník webu → SharePoint agent · maker → Studio · vývojář → Toolkit.
5. **Kdo platí?** S Copilot licencí (náš případ od 2026-11) jsou agenti v Copilotu bez metrování; bez licence vše jede na Copilot Credits / PAYG — každý testovací dotaz stojí kredity, proto evaluační plán z labu. Pozor na GitHub Copilot harness ve Studiu: kredity čerpá už stavba a testování.

## Zdroje (Microsoft)

[Agent Builder — knowledge](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/agent-builder-add-knowledge) · [Copilot Studio — SharePoint lists (preview)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/knowledge-sharepoint-lists) · [Declarative agent manifest 1.9](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/declarative-agent-manifest-1.9) · [Agent Builder](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/agent-builder) · [Agent capabilities & licensing](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/prerequisites) · [SharePoint agents](https://learn.microsoft.com/en-us/sharepoint/get-started-sharepoint-agents) · [MC1255409 — Lists as knowledge source](https://mc.merill.net/message/MC1255409) · [Generative orchestration](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-generative-actions) · [DLP for Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/admin-data-loss-prevention)

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu — stav k 2026-10.
> Nejrychleji se hýbe podpora listů: SharePoint agents ji dostaly GA ~05/2026 (MC1255409), ale admin dokumentace ji nereflektuje — ukázat studentům jako příklad docs lag. Copilot Studio listy = production-ready preview. Manifest: existují **schema 1.8** (EmailActions, MeetingActions) i **1.9** (2026-09: `agent_skills` max 8, capability `Fabric`); `list_id` je i v 1.9 knihovna — listy pro Toolkit stále nikde. `EmbeddedKnowledge` už není označené „not yet available". `worker_agents` — stav preview ověřit.
> SharePoint agents: od pol. 11/2026 tvorba přes Agent Builder, `.agent` končí po 03/2027. Copilot Studio harnesses, Cowork plugins a Work IQ Dev Tools — po Ignite (17.–20. 11. 2026) projet znovu.
