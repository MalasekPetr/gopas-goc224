# Instructor notes — Skills

## Timing

- 35 min výklad + živé demo, 35 min lab (25 návrh/review + 10 živé běhy). Závěr D3 — most k zítřejším agentům (D4) a Cowork skills; Skills demo kredity nečerpá jinak než přes instruktorskou licenci.

## Go/no-go — otestovat před během

- **Instruktorský účet má M365 Copilot licenci** (potvrzeno 2026-07) a na demo webu se otvírá Copilot in SharePoint panel — ověřit ráno (GA rollout, UI se může měnit).
- **Demo web nemá RCD** a v **Site AI settings** není Copilot tlačítko skryté ani nahrazené vlastním agentem — obojí by demo rozbilo. (`KnowledgeAgentScope` je od 1. 11. 2026 vyřazený, neřešit.)
- **Go/no-go pro hands-on lab**: studentský účet má propsanou **Copilot licenci** (od 2026-11) — otevře Copilot in SharePoint a vytvoří/spustí site i personal skill? (T1 z D1 `../../day-1/licensing/instructor-notes.md`: PAYG bez licence po GA nestačí.)
  - **Ano** → lab plně hands-on (části C–D, tvorba a běh, studenti sami).
  - **Ne** → části A–B (návrh + review) všichni; části C–D = instruktor vytvoří a spustí 2–3 vybrané návrhy na licencovaném účtu.
- Připravit: knihovna s 3–4 dokumenty pro demo Skill (review smluv / kontrola metadat), jeden dokument záměrně „nevalidní".
- Vyzkoušet celý demo cyklus den předem — tvorba Skillu je preview, draft může vypadat jinak než na screenshotech.

## Tripwires

- **Licence po GA**: Copilot in SharePoint (vč. Skills) je license-only; v preview (2026-07-17) na PAYG fungovalo, po GA ne (ověřeno 2026-11). Říct jako „GA uzavřel preview cestu" — proto mají studenti licenci. Psaní SKILL.md zůstává přenositelná dovednost v obou případech — stejný formát používá Agent Builder i Cowork.
- **Skills ≠ automatizace**: žádné externí systémy, žádný kód — na to jsou agenti a Power Automate (obojí D4). Plánované spouštění skills existuje, ale jako „Advanced work" za Copilot Credits (vyžaduje licenci). Studenti budou chtít „skill, co pošle e-mail" — zastavit u kroku 2 labu (kontrola omezení).
- **Personal vs. site skill**: Copilot se při tvorbě zeptá — pro lab chceme **site skill** (Agent Assets, sdílený), personal skill skončí v OneDrive.
- **Žádný admin vypínač** — governance dotazy směřovat na file permissions na Agent Assets (break inheritance), ne do admin centra.
- Agent Assets nejde smazat — nepanikat při demu, je to by design.
- Nezabřednout do formátu SKILL.md jako „specifikace" — je to preview, struktura se může měnit; učíme princip (postup jako reusable MD asset), ne syntax.

## Vazby

- Zpět: MD formát (D1 `formats`), prompt anatomie (D2 — nejednoznačné instrukce), agent vs. skill (D4 `copilot-agents`), Site AI settings/RCD (D2 konfigurace + explainer).
- Dopředu: Cowork skills a agenti (D4), Copilot Studio (D5) — „skill = postup uvnitř Copilotu; když potřebujete akce, kanály nebo vlastní knowledge, stavíte agenta"; topics v Studiu ≠ Skills (jiný mechanismus, stejná disciplína popisů).

## Přesunuto z README (2026-11)

- Odhad bloku: PM blok vč. **živého dema na instruktorském účtu**.
- Živé demo — celý cyklus na instruktorském webu: prompt na tvorbu Skillu (review smluv → zápis nevalidních do listu) → review draftu → uložení → výběr souborů v knihovně → běh → skill indicator card → prohlídka `SKILL.md` v Agent Assets.
- Fallback při nepropsané licenci: studenti navrhnou a zrevidují `SKILL.md`, tvorbu a běh předvede instruktor (viz Go/no-go výše).
- Tvrzení „stejný formát `SKILL.md` používá i Copilot v Excelu/Wordu" bylo z README vypuštěno — chybí MS zdroj; před zmínkou ve výkladu ověřit.
