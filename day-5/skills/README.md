# M · Skills — rozšíření Copilot in SharePoint

> Typ: povinný · Den: 5 (otvírák) · Odhad: AM blok — vč. **živého dema na instruktorském účtu**
> Prostředí: viz [`../../environment.md`](../../environment.md) · Názvosloví: [`../../GLOSSARY.md`](../../GLOSSARY.md)

## Cíle

- Student ví, co Skill **je a není** (vs. agent, vs. jednorázový prompt) a kdy ho použít.
- Student zná anatomii `SKILL.md`, umí Skill navrhnout a zreviduje cizí návrh.
- Student viděl **živě** celý cyklus: tvorba v chatu → review draftu → uložení → běh se skill indicator kartou → soubor v Agent Assets.
- Student rozumí governance Skills (žádný admin vypínač; řídí se právy na souborech) a licenční bráně.

## Výklad

### Co je Skill

**Skill** = opakovatelný vícekrokový postup uložený jako **reusable asset** na webu — Copilot in SharePoint ho načte automaticky podle dotazu, nebo explicitně jménem ([Skills](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-skills)). Zachycuje org-specifická pravidla (standardy dokumentů, review checklisty), takže Copilot pracuje **konzistentně**, ne podle nálady jednorázového promptu.

- Tvorba: **přirozeným jazykem v chatu** — popíšeš workflow, agent vrátí draft definice, zreviduješ, uložíš.
- Běh: dotaz odpovídající účelu Skillu (auto-load), nebo „Run *název* on the selected documents"; načtení potvrzuje **skill indicator card** v chatu.

### Co Skill umí a neumí

- **Umí**: řetězit vestavěné schopnosti Copilot in SharePoint — sumarizace/porozumění obsahu, organizace souborů a složek, práce se seznamy (např. „zvaliduj smlouvy a nevalidní zapiš do listu Invalid Contracts").
- **Neumí**: externí systémy, vlastní kód. **Nepřekročí práva uživatele** — nerozšiřuje přístup ani schopnosti nad rámec Copilot in SharePoint. (Na akce a integrace jsou agenti — hned další blok.)

### Kde Skill žije — SKILL.md

Úložiště: knihovna **Agent Assets** na webu, cesta `/Agent Assets/Skills/<název>/SKILL.md`. Je to obyčejný **Markdown** (callback na D1 formáty!) — jde editovat i přímo, jen držet strukturu, ať ho Copilot dál umí interpretovat.

### Governance a práva

- **Žádný admin vypínač** — Skills jsou nativní schopnost Copilot in SharePoint, samostatně se nevypínají. Knihovnu Agent Assets vytváří produkt a **nejde smazat**.
- Řízení = **standardní file governance**: permissions, retention, sensitivity labels, audit — jako u každého obsahu. Default: **Edit** na webu = tvorba Skillu, **View** = spuštění; přísnější model = break inheritance na Agent Assets.
- **Licenční brána (první!)**: Skills běží jen tam, kde je dostupný **Copilot in SharePoint = M365 Copilot licence**. PAYG je neodemyká (ověřeno živě v tomto tenantu 2026-07) — Edit/View práva jsou až druhá brána.

### Živé demo (instruktor)

Celý cyklus na instruktorském webu: prompt na tvorbu Skillu (review smluv → zápis nevalidních do listu) → review draftu → uložení → výběr souborů v knihovně → běh → skill indicator card → prohlídka `SKILL.md` v Agent Assets.

## Klíčové rozlišení

- **Skill vs. agent**: Skill = uložený *postup* uvnitř Copilot in SharePoint (bez vlastní persony, knowledge a akcí); agent = samostatná *persona* s instrukcemi, knowledge a případně akcemi. Mapa cest tvorby agentů: [`../../day-4/copilot-agents/`](../../day-4/copilot-agents/).
- **Skill vs. prompt**: prompt je jednorázový a osobní; Skill je uložený, sdílený (View stačí) a konzistentní. „Dobrý prompt, který píšeš potřetí" = kandidát na Skill (D2 prompt anatomie se recykluje).
- **Licence vs. permissions** (D1 vzor): licence otvírá funkci (Copilot in SharePoint), permissions řídí tvorbu/běh (Edit/View) — tady jsou brány **dvě za sebou**.

## Naše prostředí

- **Studenti Skills spustit nemohou** (Business Basic + PAYG — license-only funkce). Živé demo běží na **instruktorském účtu s M365 Copilot licencí**; studenti v labu Skill **navrhují a revidují** (`SKILL.md` je jen Markdown — psát umí od D1) a vybrané návrhy instruktor spustí živě.

## Lab

Viz [`lab-skill-design.md`](lab-skill-design.md) — návrh a review SKILL.md + živé spuštění vybraných návrhů.

## Zdroje (Microsoft)

[Extend Copilot in SharePoint with skills](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-skills) · [Get started with Copilot in SharePoint](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started)

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu — stav k 2026-07.
> Skills = součást **preview** Copilot in SharePoint — chování (auto-load, indicator card, formát SKILL.md) se může měnit; před během projít docs (ms.date 2026-06-23). Licenční brána (license-only, PAYG neodemyká) ověřena živě 2026-07 — při GA se může změnit enablement celého Copilot in SharePoint. Skills jsou zatím dostupné jen v first-party Copilot in SharePoint experience.
