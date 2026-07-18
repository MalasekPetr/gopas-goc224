# GOC224 — obsah pre web (gopas.sk)

> [!NOTE] Poznámka pre editora
> Každý nadpis „##" nižšie zodpovedá jednému poľu na stránke kurzu; text pod ním vlož do daného poľa. Bloky „Poznámka pre editora" samotné nie sú obsah stránky — nekopírovať na web.

Oproti aktuálne živej stránke sa mení: titulok teraz obsahuje „agentov" a neobsahuje „SharePoint Premium" (značka bola Microsoftom rozdelená na samostatné produkty — Document processing, SharePoint Advanced Management, Microsoft 365 Backup/Archive, Copilot in SharePoint...); osnova dopĺňa moduly, ktoré na súčasnej stránke chýbajú — Agent Builder, SharePoint agents, Microsoft 365 Agents Toolkit, Skills a Copilot Studio ako samostatnú položku.

## URL

`microsoft-365-sprava-sharepoint-copilotu-agentov-a-obsahovych-sluzieb_goc224`

> [!NOTE] Poznámka pre editora
> Nový slug (bez „sharepoint-premium"). Nastaviť 301 presmerovanie z aktuálneho `microsoft-365-sprava-sharepoint-copilot-a-sharepoint-premium_goc224`.

## Titulok kurzu

Microsoft 365: správa SharePoint Copilotu, agentov a obsahových služieb

## Krátky popis (meta description / teaser)

Praktický päťdňový kurz nasadenia a správy SharePoint Copilotu, AI agentov a obsahových služieb Microsoft 365 — od licencovania cez konfiguráciu a governance až po prevádzkový monitoring a rollout blueprint.

## Popis kurzu

Kurz prevedie administrátorov a architektov celým cyklom nasadenia Microsoft 365 Copilotu nad SharePointom: od orientácie v AI landscape a licenčných modeloch, cez krok-za-krokom konfiguráciu tenantu, až po obsahové služby (eSignature, zálohovanie, archiváciu) a governance vrstvu (SharePoint Advanced Management). Samostatný blok patrí automatizácii — Power Automate a voľba medzi pro-code a low-code rozšírením. Ťažiskom je tvorba AI agentov: účastníci prejdú všetky cesty tvorby (mapa ciest, Agent Builder, SharePoint agents, Microsoft 365 Agents Toolkit) aj ich následnú správu (Copilot Control System, Agent 365, prevádzkový monitoring). Kurz končí stavbou agenta v Copilot Studiu a vlastným rollout blueprintom pre nasadenie v organizácii účastníka.

## Pre koho je kurz určený

- SharePoint / Microsoft 365 administrátori a solution architekti
- Vlastníci governance, compliance a platformy
- Špecialisti na automatizáciu (low-code aj pro-code)

## Formát a dĺžka

- 5 dní, kurz vedený lektorom s praktickými labmi v testovacom tenante
- úroveň: pokročilí

> [!NOTE] Poznámka pre editora
> Cena zámerne vynechaná — doplní ju obchodné oddelenie GOPAS priamo v CMS/cenníku.

## Osnova kurzu

### Deň 1 — Foundation

- **Onboarding & pravidlá práce** — úvod do prostredia kurzu a pravidiel spolupráce.
- **Formáty: JSON, MD, YAML** — gramotnosť vo formátoch používaných naprieč kurzom (konfigurácia, dokumentácia, Skills).
- **SharePoint technologický úvod** — architektúra SharePointu Online ako platformy pre obsah a AI.
- **AI landscape a pozicovanie Copilotu** — história AI/LLM, zásady zodpovednej AI, web-grounded vs. tenant-grounded, kam zapadá Copilot in SharePoint.
- **Licenčné modely a riadenie nákladov** — vrstvy licencií Copilotu, dva PAYG modely, princíp licencia vs. permissions.

> Voliteľne podľa času skupiny: Informačná architektúra SharePoint Online.

### Deň 2 — Prompting, scripting a konfigurácia

- **Základy promptovania a agentná anatómia** — štruktúra promptu, rola Orchestrátora, Prompt/Context/custom instructions/Memory/Agent Instructions.
- **SharePoint PowerShell (SPO module)** — inštalácia a pripojenie SPO Management Shell, čítanie stavu tenantu, reportovacie skripty.
- **Konfigurácia krok za krokom** — poradie zapnutia Copilot in SharePoint (PAYG billing → zapnutie → rozsah → overenie), `KnowledgeAgentScope`.
- **Document processing for Microsoft 365 (základy)** — rodina služieb (OCR, autofill columns, image tagging a i.) a ich PAYG licencovanie; živá konfigurácia a demo.

### Deň 3 — Obsahové služby, governance a automatizácia

- **Scenáre eSignature** — SharePoint eSignature v rodine Document processing, úrovne podpisu podľa eIDAS, schvaľovací flow.
- **SharePoint Advanced Management (SAM)** — tri piliere SAM, výber politiky pre governance problém, licencovanie ako príprava tenantu na Copilot.
- **Power Automate — prichádzajúce faktúry** — end-to-end flow (príjem → vyťaženie → schválenie → uloženie), tri cesty vyťaženia vrátane Azure AI Document Intelligence.
- **Pro-code vs. low-code agenti a vzory rozšírenia** — voľba vrstvy rozšírenia (konektor / Power Automate / SPFx / Graph), aktuálne dev nástroje.

### Deň 4 — Ochrana dát a tvorba agentov

- **Microsoft 365 Backup** — rozsah (SharePoint, OneDrive, Exchange), RPO/RTO, plán obnovy.
- **Microsoft 365 Archive** — stratégia studených dát, súhra s retenciou, eDiscovery a Copilotom.
- **Agenti — mapa ciest tvorby** — prehľad všetkých ciest tvorby agentov, deklaratívny agent, návrh s plánom vyhodnotenia.
- **Agent Builder** — lightweight tvorba deklaratívneho agenta priamo v aplikácii M365 Copilot (hands-on).
- **SharePoint agents** — agent stavaný vlastníkom obsahu priamo na webe, dedí jeho permissions a lifecycle.
- **Microsoft 365 Agents Toolkit** — agent ako spravovaná konfigurácia, repo-as-code (manifest, verzovanie, provisioning).

### Deň 5 — Správa, tvorba a rollout

- **Nástroje na správu Copilotu a agentov** — Copilot Control System, sekcia Agents v M365 admin centre, Agent 365.
- **Prevádzkový monitoring a compliance** — auditná stopa v Purview, zdroje prevádzkového signálu, incident runbook.
- **Skills — rozšírenie Copilot in SharePoint** — anatómia `SKILL.md`, návrh a review Skill, governance bez admin vypínača.
- **Copilot Studio — stavba nad SharePointom** — agent so SharePoint knowledge, generative vs. classic orchestrácia, DLP.
- **Capstone & next steps** — rollout blueprint: dizajnový dokument nasadenia Copilotu a obsahových služieb, roadmapa adopcie.

> Voliteľne podľa času skupiny: Orchestry — governance a provisioning tretej strany.

## Výstup kurzu

Účastník odchádza s vlastným rollout blueprintom — návrhom nasadenia Microsoft 365 Copilotu, agentov a obsahových služieb pre svoju organizáciu, vrátane konfigurácie, automatizácie, governance, rizík a plánu adopcie.

## Pred publikáciou — kontrolný zoznam pre editora

- [ ] Nastaviť 301 presmerovanie z aktuálneho `microsoft-365-sprava-sharepoint-copilot-a-sharepoint-premium_goc224` na nové URL uvedené vyššie.
- [ ] Doplniť cenu kurzu (obchodné oddelenie GOPAS).
- [ ] Overiť aktuálnosť názvov produktov a PAYG sadzieb — Microsoft mení licenčné balíky a ceny v rádoch mesiacov.
- [ ] Skontrolovať, že žiadny blok „Poznámka pre editora" nezostal skopírovaný do publikovaného textu.
