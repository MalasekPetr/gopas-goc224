# AI landscape a pozicování Copilotu

> Typ: povinný · Den: 1 · Odhad: PM blok
> Názvosloví: [`../../GLOSSARY.md`](../../GLOSSARY.md) · Zdroje ozdrojované odkazy na Microsoft (viz [Zdroje](#zdroje-microsoft)).

## Cíle

- Student umí zasadit Microsoft Copilot mezi ostatní AI nástroje.
- Student vysvětlí rozdíl web-grounded vs. tenant-grounded a co znamenají datové hranice.
- Student zná 6 principů zodpovědné AI Microsoftu.
- Student ví, kam v rodině Copilotů zapadá Copilot in SharePoint a Document processing.

## 1. Stručně: AI, LLM, generativní AI

Krátký koncepční úvod (bez produktových detailů):
- **AI → strojové učení → generativní AI**: modely, které generují text/obraz na základě vzorů z tréninkových dat.
- **LLM (large language model)**: predikuje pravděpodobný následující token; „nezná pravdu", jen vzory → nutná lidská kontrola a grounding.
- **Grounding / RAG**: doplnění promptu o relevantní data (web nebo tenant), aby odpověď byla konkrétní a aktuální. Tohle je klíč k pochopení rozdílu mezi nástroji dál.

Microsoft učební zdroje: [AI learning hub](https://learn.microsoft.com/en-us/training/), [Responsible AI training](https://learn.microsoft.com/en-us/training/modules/embrace-responsible-ai-principles-practices/).

## 2. Zásady zodpovědné AI (Microsoft)

Microsoft staví na **Responsible AI Standard** a šesti principech: **fairness, reliability & safety, privacy & security, inclusiveness, transparency, accountability** ([Principles & approach](https://www.microsoft.com/en-us/ai/principles-and-approach), [What is Responsible AI](https://learn.microsoft.com/en-us/azure/machine-learning/concept-responsible-ai), [Service assurance](https://learn.microsoft.com/en-us/compliance/assurance/assurance-artificial-intelligence)). Standard je rozdělený do 6 domén a 14 cílů s konkrétními požadavky; RAI safety checks běží i za běhu Copilota (viz data flow níže).

## 3. ChatGPT-styl vs. Microsoft Copilot — grounding a datové hranice

Nosné rozlišení celého kurzu.

| | Veřejný chat (ChatGPT-styl) / Copilot Chat (Basic) | Microsoft 365 Copilot (add-on) |
|---|---|---|
| Grounding | web (u Copilot Chat přes Bing); výjimka Outlook — viz níže | **tenant** přes Microsoft Graph, Work IQ + Semantic Index (+ volitelně web) |
| Přístup k org obsahu | ne (jen co vložíš do promptu) | ano, ale **jen co uživatel smí vidět** |
| Datová hranice | — | Microsoft 365 service boundary, EDP |
| Trénink na tvých datech | u veřejných nástrojů záleží na podmínkách | **ne** — prompty/odpovědi netrénují foundation modely |

Klíčová fakta (Microsoft):

- Copilot i Copilot Chat běží v **Microsoft 365 service boundary** s **enterprise data protection (EDP)**; prompty a odpovědi **netrénují** foundation modely ([Enterprise data protection](https://learn.microsoft.com/en-us/microsoft-365/copilot/enterprise-data-protection), [Privacy & protections](https://learn.microsoft.com/en-us/copilot/privacy-and-protections)).
- **Permission-trimming**: Copilot zobrazí jen data, na která má uživatel oprávnění; Graph/Semantic Index ctí identity-based access boundary; ctí i Purview sensitivity labels a šifrování ([Data, privacy & security](https://learn.microsoft.com/en-us/microsoft-365/copilot/microsoft-365-copilot-privacy), [Data protection architecture](https://learn.microsoft.com/en-us/microsoft-365/copilot/microsoft-365-copilot-architecture-data-protection-auditing)).
- **Copilot Chat (Basic)** je grounded na webu (Bing), ne na org obsahu, dokud ho uživatel nevloží — **s výjimkou Outlooku**: Copilot Chat v Outlooku grounduje i bez licence na poštu, kalendář, schůzky, chaty a omezenou sadu souvisejícího obsahu ([Copilot overview](https://learn.microsoft.com/en-us/copilot/overview)).

> [!IMPORTANT] EU datové hranice — přímo pro CZ/EU zákazníky
> Microsoft se hlásí ke GDPR, **EU Data Boundary** a ISO/IEC 27018. Ale: **web search dotazy** (přes Bing) a **modely Anthropic** jsou z EU Data Boundary aktuálně **vyňaty** ([Enterprise data protection](https://learn.microsoft.com/en-us/microsoft-365/copilot/enterprise-data-protection), [Anthropic models](https://learn.microsoft.com/en-us/microsoft-365/copilot/connect-to-ai-subprocessor)). **OpenAI** jako subprocesor (od 07/2026) je naopak **uvnitř** EU Data Boundary ([OpenAI subprocessor](https://learn.microsoft.com/en-us/microsoft-365/copilot/openai-subprocessor)). V tenantu uvnitř EU Data Boundary nabízí **Cowork jen GPT modely** ([Cowork models](https://learn.microsoft.com/en-us/copilot/cowork/cowork-models)). To je ta governance nit z `../onboarding/ways-of-working.md` — konkrétní, doložitelný bod pro EU tenanty.

## 4. Rodina Copilotů a kam zapadá SharePoint

Microsoft nabízí Copilot napříč produkty (Word/Excel/PowerPoint/Outlook/Teams, Copilot Chat, agenti) ([Copilot overview](https://learn.microsoft.com/en-us/copilot/overview)). Od 25. 9. 2026 je to **„nový Copilot"** — jedna aplikace se třemi vstupy ([Introducing the new Copilot](https://blogs.microsoft.com/blog/2026/09/25/introducing-the-new-copilot-with-home-code-and-autopilot/)):

- **Home** = **Chat** (rychlé dotazy) + **Cowork** (delegovaný úkol do hotového výsledku: pošle e-mail, naplánuje schůzku, vytvoří dokument — každou akci uživatel schvaluje; GA, [Cowork](https://learn.microsoft.com/en-us/copilot/cowork/)) + Office (Word/Excel/PowerPoint přímo v aplikaci Copilot).
- **Code** = popíšeš aplikaci/dashboard/skript, Copilot ho postaví a hostuje v tenantu (Frontier preview, [Copilot Code](https://learn.microsoft.com/en-us/copilot/code/)).
- **Autopilot** (dříve Scout) = trvalý proaktivní agent s vlastní identitou (Frontier).
- **Researcher / Analyst** = vestavění agenti pro hloubkovou rešerši a analýzu dat (součást Copilot licence).

```mermaid
flowchart LR
  C[Nový Copilot] --> H[Home]
  C --> K[Code]
  C --> A[Autopilot]
  H --> Ch[Chat - Basic zdarma, work-grounded = licence]
  H --> Cw[Cowork - licence + Credits]
  H --> Of[Office v Copilotu]
  K --> Cr[Licence + Credits, Frontier]
  A --> Cr2[Credits, Frontier]
  C -.-> SP[Copilot in SharePoint - surface kurzu]
```

Licenční dopad (licence vs. Copilot Credits) → `../licensing/`.

- **Copilot in SharePoint** = Copilot zážitek nad weby a knihovnami (vč. Skills a agentů) — surface, kde probíhá většina kurzu. GA rollout od 30. 9. 2026 — v tenantu se může objevit postupně ([Get started](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started)).
- **Document processing for Microsoft 365** není „Copilot", ale **dodává Copilotu strukturovaná metadata** (vytěžování dokumentů) → lepší grounding. Vztah: Document processing vytěžuje → Copilot se ptá nad vytěženým (viz `../licensing/`).

## Data flow (jak Copilot zpracuje dotaz)

```mermaid
flowchart LR
  U[Uživatel: prompt] --> O[Copilot orchestrator]
  O --> R1[RAI safety checks]
  R1 --> G[Grounding: Graph/Semantic Index + volitelně web/Bing]
  G --> P[Permission-trim: jen co uživatel smí]
  P --> L[LLM generuje odpověď]
  L --> R2[RAI safety checks]
  R2 --> Log[Log do Exchange pro audit/eDiscovery]
  Log --> A[Odpověď uživateli]
```

## Klíčové rozlišení

- **Web-grounded vs. tenant-grounded** — hlavní osa; určuje, co Copilot „ví".
- **Copilot ≠ Document processing** — Copilot se ptá, Document processing připravuje data.
- **EDP ≠ EU Data Boundary pro všechno** — web queries a Anthropic modely jsou vyňaty.
- **Chat ≠ Cowork** — Chat odpovídá, Cowork koná (a čerpá Copilot Credits navíc k licenci).

## 5. Naše prostředí (kurz)

Studenti mají od běhu 2026-11 **Microsoft 365 Copilot licenci** + Copilot Credits (viz `../licensing/`) — PAYG bez licence by odemkl jen Copilot Chat nad tenant daty a agenty, ne Copilot in SharePoint, Skills, Cowork ani Code. **Cowork a Code** si studenti vyzkouší hands-on v D4 ([`../../day-4/cowork-code/`](../../day-4/cowork-code/README.md)); Autopilot (Frontier) jen zmínit. Pro EU governance demo je vyňetí Anthropic modelů z EU Data Boundary konkrétní bod k ukázání.

## Lab

Viz [`lab-readiness-checklist.md`](lab-readiness-checklist.md).

## Zdroje (Microsoft)

Responsible AI: [Principles & approach](https://www.microsoft.com/en-us/ai/principles-and-approach) · [What is Responsible AI](https://learn.microsoft.com/en-us/azure/machine-learning/concept-responsible-ai) · [Service assurance](https://learn.microsoft.com/en-us/compliance/assurance/assurance-artificial-intelligence) · [Training](https://learn.microsoft.com/en-us/training/modules/embrace-responsible-ai-principles-practices/)
Grounding & data protection: [Enterprise data protection](https://learn.microsoft.com/en-us/microsoft-365/copilot/enterprise-data-protection) · [Privacy & protections](https://learn.microsoft.com/en-us/copilot/privacy-and-protections) · [Data, privacy & security](https://learn.microsoft.com/en-us/microsoft-365/copilot/microsoft-365-copilot-privacy) · [Architecture](https://learn.microsoft.com/en-us/microsoft-365/copilot/microsoft-365-copilot-architecture) · [Data protection architecture](https://learn.microsoft.com/en-us/microsoft-365/copilot/microsoft-365-copilot-architecture-data-protection-auditing) · [Web search data](https://learn.microsoft.com/en-us/microsoft-365/copilot/manage-public-web-access)
Copilot family: [Copilot overview](https://learn.microsoft.com/en-us/copilot/overview) · [Introducing the new Copilot](https://blogs.microsoft.com/blog/2026/09/25/introducing-the-new-copilot-with-home-code-and-autopilot/) · [Cowork](https://learn.microsoft.com/en-us/copilot/cowork/) · [Cowork models](https://learn.microsoft.com/en-us/copilot/cowork/cowork-models) · [Copilot Code](https://learn.microsoft.com/en-us/copilot/code/) · [Copilot in SharePoint](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started)
AI subprocesoři: [Anthropic models](https://learn.microsoft.com/en-us/microsoft-365/copilot/connect-to-ai-subprocessor) · [OpenAI subprocessor](https://learn.microsoft.com/en-us/microsoft-365/copilot/openai-subprocessor)

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu
> - Vyňetí Anthropic modelů z EU Data Boundary se může měnit — ověřit v Enterprise data protection dokumentu.
> - Modely za Copilotem se mění (router Auto; GPT, Anthropic, v Cowork i xAI); model updates nemění bezpečnostní/compliance nastavení.
> - Copilot in SharePoint GA od 30. 9. 2026 (rollout).
> - Nový Copilot (Home/Cowork/Code/Autopilot) — stav k 2026-10; Code a Autopilot ve Frontier. Po Ignite (17.–20. 11. 2026) projet znovu.
