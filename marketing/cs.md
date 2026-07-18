# GOC224 — obsah pro web (gopas.cz)

> [!NOTE] Pro editora
> Každý nadpis „##" níže odpovídá jednomu poli na stránce kurzu; text pod ním vlož do daného pole. Bloky „Pro editora" samotné nejsou obsah stránky — nekopírovat na web.

Oproti aktuálně živé stránce se mění: titulek nově obsahuje „agentů" a neobsahuje „SharePoint Premium" (značka byla Microsoftem rozdělena na samostatné produkty — Document processing, SharePoint Advanced Management, Microsoft 365 Backup/Archive, Copilot in SharePoint...); osnova doplňuje moduly, které na současné stránce chybí — Agent Builder, SharePoint agents, Microsoft 365 Agents Toolkit, Skills a Copilot Studio jako samostatnou položku.

## URL

`microsoft-365-sprava-sharepoint-copilotu-agentu-a-obsahovych-sluzeb_goc224`

> [!NOTE] Pro editora
> Nový slug (bez „sharepoint-premium"). Nastavit 301 redirect ze stávajícího `microsoft-365-sprava-sharepoint-copilot-a-sharepoint-premium_goc224`.

## Titulek kurzu

Microsoft 365: správa SharePoint Copilotu, agentů a obsahových služeb

## Krátký popis (meta description / teaser)

Praktický pětidenní kurz nasazení a správy SharePoint Copilotu, AI agentů a obsahových služeb Microsoft 365 — od licencování přes konfiguraci a governance až po provozní monitoring a rollout blueprint.

## Popis kurzu

Kurz provede administrátory a architekty celým cyklem nasazení Microsoft 365 Copilotu nad SharePointem: od orientace v AI landscape a licenčních modelech, přes krok-za-krokem konfiguraci tenantu, až po obsahové služby (eSignature, zálohování, archivaci) a governance vrstvu (SharePoint Advanced Management). Samostatný blok patří automatizaci — Power Automate a volba mezi pro-code a low-code rozšířením. Těžištěm je tvorba AI agentů: účastníci projdou všechny cesty tvorby (mapa cest, Agent Builder, SharePoint agents, Microsoft 365 Agents Toolkit) i jejich následnou správu (Copilot Control System, Agent 365, provozní monitoring). Kurz končí stavbou agenta v Copilot Studiu a vlastním rollout blueprintem pro nasazení v organizaci účastníka.

## Pro koho je kurz určen

- SharePoint / Microsoft 365 administrátoři a solution architekti
- Vlastníci governance, compliance a platformy
- Specialisté na automatizaci (low-code i pro-code)

## Formát a délka

- 5 dní, instruktorem vedený kurz s praktickými laby v testovacím tenantu
- úroveň: pokročilí

> [!NOTE] Pro editora
> Cena záměrně vynechána — doplní ji obchodní oddělení GOPAS přímo v CMS/ceníku.

## Osnova kurzu

### Den 1 — Foundation

- **Onboarding & pravidla práce** — úvod do prostředí kurzu a pravidel spolupráce.
- **Formáty: JSON, MD, YAML** — gramotnost ve formátech používaných napříč kurzem (konfigurace, dokumentace, Skills).
- **SharePoint technologický úvod** — architektura SharePointu Online jako platformy pro obsah a AI.
- **AI landscape a pozicování Copilotu** — historie AI/LLM, zásady zodpovědné AI, web-grounded vs. tenant-grounded, kam zapadá Copilot in SharePoint.
- **Licenční modely a řízení nákladů** — vrstvy licencí Copilotu, dva PAYG modely, princip licence vs. permissions.

> Volitelně dle času skupiny: Informační architektura SharePoint Online.

### Den 2 — Prompting, scripting & konfigurace

- **Základy promptování a agentní anatomie** — struktura promptu, role Orchestratoru, Prompt/Context/custom instructions/Memory/Agent Instructions.
- **SharePoint PowerShell (SPO module)** — instalace a připojení SPO Management Shell, čtení stavu tenantu, reportovací skripty.
- **Konfigurace krok za krokem** — pořadí zapnutí Copilot in SharePoint (PAYG billing → zapnutí → rozsah → ověření), `KnowledgeAgentScope`.
- **Document processing for Microsoft 365 (základy)** — rodina služeb (OCR, autofill columns, image tagging aj.) a jejich PAYG licencování; živá konfigurace a demo.

### Den 3 — Obsahové služby, governance & automatizace

- **Scénáře eSignature** — SharePoint eSignature v rodině Document processing, úrovně podpisu dle eIDAS, schvalovací flow.
- **SharePoint Advanced Management (SAM)** — tři pilíře SAM, výběr politiky pro governance, licencování jako příprava tenantu na Copilot.
- **Power Automate — příchozí faktury** — end-to-end flow (příjem → vytěžení → schválení → uložení), tři cesty vytěžování vč. Azure AI Document Intelligence.
- **Pro-code vs. low-code agenti a vzory rozšíření** — volba vrstvy rozšíření (konektor / Power Automate / SPFx / Graph), aktuální dev nástroje.

### Den 4 — Data protection & tvorba agentů

- **Microsoft 365 Backup** — rozsah (SharePoint, OneDrive, Exchange), RPO/RTO, plán obnovy.
- **Microsoft 365 Archive** — strategie studených dat, souhra s retencí, eDiscovery a Copilotem.
- **Agenti — mapa cest tvorby** — přehled všech cest tvorby agentů, deklarativní agent, návrh s plánem vyhodnocení.
- **Agent Builder** — lightweight tvorba deklarativního agenta přímo v aplikaci M365 Copilot (hands-on).
- **SharePoint agents** — agent stavěný vlastníkem obsahu přímo na webu, dědí jeho permissions a lifecycle.
- **Microsoft 365 Agents Toolkit** — agent jako spravovaná konfigurace, repo-as-code (manifest, verzování, provisioning).

### Den 5 — Správa, stavba & rollout

- **Nástroje pro správu Copilotu a agentů** — Copilot Control System, sekce Agents v M365 admin centru, Agent 365.
- **Provozní monitoring a compliance** — auditní stopa v Purview, zdroje provozního signálu, incident runbook.
- **Skills — rozšíření Copilot in SharePoint** — anatomie `SKILL.md`, návrh a review Skill, governance bez admin vypínače.
- **Copilot Studio — stavba nad SharePointem** — agent se SharePoint knowledge, generative vs. classic orchestrace, DLP.
- **Závěrečný projekt a další kroky** — rollout blueprint: design dokument nasazení Copilotu a obsahových služeb, roadmapa adopce.

> Volitelně dle času skupiny: Orchestry — governance a provisioning třetí strany.

## Výstup kurzu

Účastník odchází s vlastním rollout blueprintem — návrhem nasazení Microsoft 365 Copilotu, agentů a obsahových služeb pro svou organizaci, včetně konfigurace, automatizace, governance, rizik a plánu adopce.

## Před publikací — kontrolní seznam pro editora

- [ ] Nastavit 301 redirect ze stávajícího `microsoft-365-sprava-sharepoint-copilot-a-sharepoint-premium_goc224` na nové URL uvedené výše.
- [ ] Doplnit cenu kurzu (obchodní oddělení GOPAS).
- [ ] Ověřit aktuálnost názvů produktů a PAYG sazeb — Microsoft mění licenční balíčky a ceny v řádu měsíců.
- [ ] Zkontrolovat, že žádný blok „Pro editora" nezůstal zkopírovaný do publikovaného textu.
