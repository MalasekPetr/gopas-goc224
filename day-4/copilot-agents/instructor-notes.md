# Instructor notes — Copilot Agents

## Timing

- 45 min výklad + demo, 40 min lab, 10 min sdílení. Demo Agent Builderu držet pod 15 min — celý flow (popis → instrukce → knowledge → test → publikace), ne ladění.
- **Závěr D4** (přesun z D5): energie nízká — demo dát doprostřed bloku jako oživení; lab část A je psací, funguje i unaveně. Most: „dnes jste agenty spravovali (copilot-admin), teď víte, jak vznikají — zítra je stavíte."

## Go/no-go — otestovat před během

- **Agent Builder v našem tenantu**: docs říkají „M365 Copilot licence NEBO tenant s PAYG pro Copilot Studio" — ověřit, že PAYG cesta u nás reálně Agent Builder zpřístupňuje (i pro studenty). Určuje část B labu (krok 6 vs. 7).
- **SharePoint agents**: tvorba vyžaduje Copilot licenci — studenti s PAYG mohou agenty *používat*, ne tvořit. Nezakládat na tom lab; zmínit jako licenční teaching point.
- **Skills NEJSOU studentský fallback** — vyžadují Copilot in SharePoint (license-only; PAYG neodemyká, ověřeno živě 2026-07). Fallback labu = návrhová část A + instruktor staví vybrané návrhy v demu.

## Tripwires

- Callback na D2: tabulku vrstev instrukcí ukázat znovu — „teď píšete Agent Instructions doopravdy".
- **Instrukce ≠ knowledge** (XPIA) — kontrolovat v labu, studenti rádi nacpou směrnici do instrukcí.
- Negativní test v evaluačním plánu je povinný — bez něj se agent „vždycky povede".
- Researcher/Analyst nejsou „agenti k tvorbě" — D4 už to říkal, nenechat zamotat.
- Demo agenta stavět nad instruktorským webem, ne nad studentskými (práva, překvapení).
- Srovnávací matici (`comparison-agent-paths.md`) promítnout u mapy cest — nosné rozdíly: listy (Studio 10 + analytika / Builder 1 / SharePoint agent 1 a nic jiného / Toolkit nic), akce (Studio konektory+MCP+triggery vs. Toolkit OpenAPI), ALM (jen Toolkit = git). U SharePoint agents zmínit docs lag k listům (MC1255409 GA ~05/2026, get-started to k 06/2026 neuvádí).

## Vazby

- Zpět: Agent Instructions/orchestrator (D2), publikační flow a registry (dnešní `copilot-admin`).
- Dopředu: Skills a Copilot Studio (zítra, D5) = „stejný návrh, silnější nástroj" — návrhy z části A se v Copilot Studiu dají rovnou stavět; evaluační plán se recykluje v capstone.
