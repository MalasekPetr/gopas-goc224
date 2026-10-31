# Instructor notes — Skills

## Timing

- 35 min výklad + živé demo, 35 min lab (25 návrh/review + 10 živé běhy). Otvírák pátku — energie je, ale kredity a pozornost šetřit na Copilot Studio (další blok); Skills demo kredity nečerpá jinak než přes instruktorskou licenci.

## Go/no-go — otestovat před během

- **Instruktorský účet má M365 Copilot licenci** (potvrzeno 2026-07) a na demo webu se otvírá Copilot in SharePoint panel — ověřit ráno (GA rollout, UI se může měnit).
- **Demo web nemá RCD** a v **Site AI settings** není Copilot tlačítko skryté ani nahrazené vlastním agentem — obojí by demo rozbilo. (`KnowledgeAgentScope` je od 1. 11. 2026 vyřazený, neřešit.)
- **T1 (go/no-go pro hands-on lab)**: výsledek testu z D1 (`../../day-1/licensing/instructor-notes.md`) — otevře studentský účet (Business Basic + PAYG, bez licence) Copilot in SharePoint a vytvoří/spustí site i personal skill?
  - **Ano** → lab plně hands-on (část B studenti sami).
  - **Ne** → část A (návrh + review) všichni; část B = instruktor vytvoří a spustí 2–3 vybrané návrhy na licencovaném účtu.
- Připravit: knihovna s 3–4 dokumenty pro demo Skill (review smluv / kontrola metadat), jeden dokument záměrně „nevalidní".
- Vyzkoušet celý demo cyklus den předem — tvorba Skillu je preview, draft může vypadat jinak než na screenshotech.

## Tripwires

- **Licence po GA**: MS dokumentuje Copilot in SharePoint (vč. Skills) jako license-only; v preview (2026-07-17) na PAYG fungovalo. Podle T1 to říct jako „docs vs. realita" (funguje) nebo „GA uzavřel preview cestu" (nefunguje). Psaní SKILL.md zůstává přenositelná dovednost v obou případech — stejný formát používá Excel/Word, Agent Builder i Cowork.
- **Skills ≠ automatizace**: žádné externí systémy, žádný kód — na to jsou agenti (odpoledne) a Power Automate (D3). Plánované spouštění skills existuje, ale jako „Advanced work" za Copilot Credits (vyžaduje licenci). Studenti budou chtít „skill, co pošle e-mail" — zastavit u kroku 3 labu.
- **Personal vs. site skill**: Copilot se při tvorbě zeptá — pro lab chceme **site skill** (Agent Assets, sdílený), personal skill skončí v OneDrive.
- **Žádný admin vypínač** — governance dotazy směřovat na file permissions na Agent Assets (break inheritance), ne do admin centra.
- Agent Assets nejde smazat — nepanikat při demu, je to by design.
- Nezabřednout do formátu SKILL.md jako „specifikace" — je to preview, struktura se může měnit; učíme princip (postup jako reusable MD asset), ne syntax.

## Vazby

- Zpět: MD formát (D1 `formats`), prompt anatomie (D2 — nejednoznačné instrukce), agent vs. skill (D4 `copilot-agents`), Site AI settings/RCD (D2 konfigurace + explainer).
- Dopředu: Copilot Studio (hned potom) — „skill = postup uvnitř Copilotu; když potřebujete akce, kanály nebo vlastní knowledge, stavíte agenta"; topics v Studiu ≠ Skills (jiný mechanismus, stejná disciplína popisů).
