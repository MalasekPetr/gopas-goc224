# Skills — rozšíření Copilot in SharePoint

> Typ: povinný · Den: 3 (závěr) · Odhad: PM blok — vč. **živého dema na instruktorském účtu**
> Prostředí: viz [`../../environment.md`](../../environment.md) · Názvosloví: [`../../GLOSSARY.md`](../../GLOSSARY.md)

## Cíle

- Student ví, co Skill **je a není** (vs. agent, vs. jednorázový prompt) a kdy ho použít.
- Student zná anatomii `SKILL.md`, umí Skill navrhnout a zreviduje cizí návrh.
- Student viděl **živě** celý cyklus: tvorba v chatu → review draftu → uložení → běh se skill indicator kartou → soubor v Agent Assets.
- Student rozumí governance Skills (žádný admin vypínač; řídí se právy na souborech) a licenční bráně.

## Výklad

### Co je Skill

**Skill** = opakovatelný vícekrokový postup uložený jako **reusable asset** na webu — Copilot in SharePoint ho načte automaticky podle dotazu, nebo explicitně jménem ([Skills](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-skills)). Zachycuje org-specifická pravidla (standardy dokumentů, review checklisty), takže Copilot pracuje **konzistentně**, ne podle nálady jednorázového promptu.

- Tvorba: **přirozeným jazykem v chatu** — popíšeš workflow, vestavěná schopnost **Create skill** vrátí draft definice, zreviduješ, uložíš.
- Běh: dotaz odpovídající účelu Skillu (auto-load), nebo „Run *název* on the selected documents"; načtení potvrzuje **skill indicator card** v chatu.

Tři druhy Skills ([Skills](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-skills)):

| | **Site skill** | **Personal skill** | **Built-in skill** |
|---|---|---|---|
| Vlastník | admin webu | uživatel | Microsoft |
| Úložiště | knihovna **Agent Assets** webu | **OneDrive** uživatele | součást produktu (needitovatelné) |
| Dostupnost | jen na daném webu | vlastníkovi napříč weby | všem; seznam přes `/skills` v chatu |

Personal skill je přenosný, ale **nepřenáší práva** — běží jen nad obsahem, ke kterému má uživatel přístup.

> [!NOTE] Jeden formát, víc hostitelů
> Stejný princip `SKILL.md` dnes používá i Copilot v Excelu/Wordu, Agent Builder (až 8 skills na agenta, preview), manifest deklarativního agenta 1.9 (`agent_skills`) a Cowork (až 50 vlastních skills). Chování a limity se liší podle hostitele — tady učíme Copilot in SharePoint.

### Co Skill umí a neumí

- **Umí**: řetězit vestavěné schopnosti Copilot in SharePoint — sumarizace/porozumění obsahu, organizace souborů a složek, práce se seznamy (např. „zvaliduj smlouvy a nevalidní zapiš do listu Invalid Contracts").
- **Neumí**: externí systémy, vlastní kód. **Nepřekročí práva uživatele** — nerozšiřuje přístup ani schopnosti nad rámec Copilot in SharePoint. (Na akce a integrace jsou agenti — D4.)

### Kde Skill žije — SKILL.md

Úložiště site skillu: knihovna **Agent Assets** na webu, cesta `/Agent Assets/Skills/<název>/SKILL.md` (knihovna vznikne automaticky s prvním site skillem). Je to obyčejný **Markdown** (callback na D1 formáty!) — jde editovat i přímo, jen držet strukturu, ať ho Copilot dál umí interpretovat.

### Governance a práva

- **Žádný admin vypínač** — Skills jsou nativní schopnost Copilot in SharePoint, samostatně se nevypínají. Knihovnu Agent Assets vytváří produkt a **nejde smazat**.
- Řízení = **standardní file governance**: permissions, retention, sensitivity labels, audit — jako u každého obsahu. Default: **Edit** na webu = tvorba Skillu, **View** = spuštění; přísnější model = break inheritance na Agent Assets.
- **Licenční brána**: Skills běží tam, kde je dostupný **Copilot in SharePoint** — od GA (rollout 30. 9. 2026) MS výslovně uvádí Copilot licenci jako prerekvizitu. **Tvorba a správa skills je v ceně licence**; skills v **plánovaných AI automatizacích** a práce ve velkém jsou „Advanced work" a čerpají Copilot Credits přes spending policy ([Get started](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started)). V preview (2026-07-17) Skills fungovaly i na PAYG bez licence; **po GA ne — ověřeno v tenantu 2026-11**. Copilot Credits PAYG licenci nenahradí. Druhá brána = **Edit** (tvorba site skillu) / **View** (spuštění).

### Jak se Skills aktivují

Skills se samostatně nezapínají — jedou tam, kde je dostupný **Copilot in SharePoint**. Dvě brány:

1. **Licence:** M365 Copilot licence (po GA license-only, ověřeno 2026-11; PAYG nestačí).
2. **Dostupnost na webu:** **Site AI settings** (vlastník webu: který agent se otevře z ikony v hlavičce, skrytí Copilot tlačítka pro visitory, zapnutí advanced document processing) a **Restricted Content Discovery** (RCD web z Copilotu vyřadí — přebíjí ostatní nastavení). Inventura RCD skriptem je v D2 [`../../day-2/powershell-spo/guide-copilot-inventory.md`](../../day-2/powershell-spo/guide-copilot-inventory.md).

Na úrovni webu **není žádná „site collection feature" k aktivaci** — Agent Assets se aktivuje sám s prvním site skillem. Skills jsou nativní schopnost — žádný další vypínač.

> [!IMPORTANT] Názvosloví / lineage
> Do 1. 11. 2026 se dostupnost Copilot in SharePoint (a tedy Skills) řídila tenant-wide parametrem `Set-SPOTenant -KnowledgeAgentScope`. Při GA ho Microsoft vyřadil; dnes Site AI settings + RCD ([Get started](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started)).

### Na jakém modelu Skills běží (a co Anthropic)

Copilot in SharePoint — a tedy Skills — běží na **Microsoft-managed reasoning modelu od OpenAI**; model se nekonfiguruje. Skills proto **na Anthropicu nezávisí** (Claude se v této cestě aktuálně nepoužívá). AI subprocesoři, Anthropic a EU Data Boundary: [`../../day-5/copilot-admin/explainer-ai-subprocessors.md`](../../day-5/copilot-admin/explainer-ai-subprocessors.md).

### Kontext webu — SHAREPOINT.md (doporučení)

**Doporučená praxe:** jeden `SHAREPOINT.md` v **kořeni knihovny Agent Assets** dá Copilotu trvalý kontext o webu (účel, mapa knihoven, konvence pojmenování, pravidla pro AI, glosář) — načítá se do každého chatu na webu a Skills ho dědí. Konzistentní kontext napříč tenanty = levná páka na kvalitu odpovědí (obdoba `AGENTS.md`/`CLAUDE.md` pro repo).

> [!IMPORTANT] Zatím neoficiální
> **`SHAREPOINT.md` není k 2026-10 dokumentován na Microsoft Learn** (oficiálně jen `SKILL.md`) — komunitní pattern, chování před produkčním spoléháním ověřit. Detail, šablona, kam patří a na co dát pozor: [`explainer-sharepoint-md.md`](explainer-sharepoint-md.md).

### Tip: `--agenttools` — co agent na webu umí

V chatu Copilot in SharePoint vypíše `--agenttools` **view-only seznam všech tools**, které má agent na daném místě, seskupené do kategorií (docAssist, Creation, Deletion, Automation & Rules…) — např. `create_file`, `create_folder`, `create_form`, `delete_field`, `delete_list`. Rychlá **discoverability**: co může Skill na tomto webu/knihovně řetězit.

> [!IMPORTANT] Zatím neoficiální
> `--agenttools` (a další `--` příkazy) **nejsou dokumentované na MS Learn** — in-product preview pomůcka; hláška v UI sama říká, že se tools v čase mění. Brát jako tip, ne stabilní API.

Nejblíž oficiálnímu **katalogu schopností** je [Work IQ SharePoint reference (preview)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/mcp-sharepoint-work-iq) — MCP server „Work IQ SharePoint" pro Copilot Studio (`findSite`, `createSmallTextFile`, `createFolder`, `createList`, `createColumn`, `shareFileOrFolder`, `setSensitivityLabelOnFile`…). Pozor: **jiná plocha** (Copilot Studio MCP) a **jiné názvy** než `--agenttools` — reference schopností, ne 1:1 dokumentace toho příkazu. Preview: názvy se můžou měnit.

### Živé demo (instruktor)

Celý cyklus na instruktorském webu: prompt na tvorbu Skillu (review smluv → zápis nevalidních do listu) → review draftu → uložení → výběr souborů v knihovně → běh → skill indicator card → prohlídka `SKILL.md` v Agent Assets.

## Klíčové rozlišení

- **Skill vs. agent**: Skill = uložený *postup* uvnitř Copilot in SharePoint (bez vlastní persony, knowledge a akcí); agent = samostatná *persona* s instrukcemi, knowledge a případně akcemi. Mapa cest tvorby agentů: [`../../day-4/copilot-agents/`](../../day-4/copilot-agents/).
- **Skill vs. prompt**: prompt je jednorázový a osobní; Skill je uložený, sdílený (View stačí) a konzistentní. „Dobrý prompt, který píšeš potřetí" = kandidát na Skill (D2 prompt anatomie se recykluje).
- **Licence vs. permissions** (D1 vzor): licence otvírá funkci (Copilot in SharePoint), permissions řídí tvorbu/běh (Edit/View) — tady jsou brány **dvě za sebou**.

## Naše prostředí

- Studenti mají od běhu 2026-11 **Copilot licenci** → Skill **navrhnou, vytvoří i spustí sami** (`SKILL.md` je jen Markdown — psát umí od D1).
- Bez licence (PAYG) Skills po GA nejedou (T1, ověřeno 2026-11; v preview 2026-07-17 ještě fungovaly). Fallback, kdyby se licence nepropsala: studenti navrhnou a zrevidují `SKILL.md`, tvorbu a běh předvede instruktor.
- **Plánované skills** (scheduled AI automations) = Advanced work → Copilot Credits přes spending policy. V labu nezakládat.

## Lab

Viz [`lab-skill-design.md`](lab-skill-design.md) — návrh a review SKILL.md + živé spuštění vybraných návrhů.

## Zdroje (Microsoft)

[Extend Copilot in SharePoint with skills](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-skills) · [Get started with Copilot in SharePoint](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started)

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu — stav k 2026-10.
> Copilot in SharePoint (vč. Skills) má GA rollout od 30. 9. 2026; přibyly personal a built-in skills (`/skills`), skills v plánovaných automatizacích čerpají Copilot Credits. Chování (auto-load, indicator card, formát SKILL.md) se může měnit; před během projít docs (ms.date 2026-09-28). **Licence: po GA license-only — preview nález „PAYG funguje" (2026-07-17) po GA neplatí, ověřeno v tenantu 2026-11 (T1).** `KnowledgeAgentScope` vyřazen k 1. 11. 2026. Skills jsou v SharePointu dostupné jen v first-party Copilot in SharePoint experience.
