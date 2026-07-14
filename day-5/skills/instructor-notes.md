# Instructor notes — Skills

## Timing

- 35 min výklad + živé demo, 35 min lab (25 návrh/review + 10 živé běhy). Otvírák pátku — energie je, ale kredity a pozornost šetřit na Copilot Studio (další blok); Skills demo kredity nečerpá jinak než přes instruktorskou licenci.

## Go/no-go — otestovat před během

- **Instruktorský účet má M365 Copilot licenci** (potvrzeno 2026-07) a na demo webu se otvírá Copilot in SharePoint panel — ověřit ráno, je to preview.
- **Demo web je v `KnowledgeAgentScope`** (D2 konfigurace!) a nemá RCD — obojí by panel vypnulo.
- Připravit: knihovna s 3–4 dokumenty pro demo Skill (review smluv / kontrola metadat), jeden dokument záměrně „nevalidní".
- Vyzkoušet celý demo cyklus den předem — tvorba Skillu je preview, draft může vypadat jinak než na screenshotech.

## Tripwires

- **Studenti si Skills nespustí** — říct hned na začátku a proč (license-only, PAYG neodemyká — ověřeno v našem tenantu; licenční lekce z D1 v praxi). Lab je návrhový záměrně, ne z nouze: psaní SKILL.md je přenositelná dovednost.
- **Skills ≠ automatizace**: žádné externí systémy, žádný kód, žádné triggery — na to jsou agenti (odpoledne) a Power Automate (D3). Studenti budou chtít „skill, co pošle e-mail" — zastavit u kroku 3 labu.
- **Žádný admin vypínač** — governance dotazy směřovat na file permissions na Agent Assets (break inheritance), ne do admin centra.
- Agent Assets nejde smazat — nepanikat při demu, je to by design.
- Nezabřednout do formátu SKILL.md jako „specifikace" — je to preview, struktura se může měnit; učíme princip (postup jako reusable MD asset), ne syntax.

## Vazby

- Zpět: MD formát (D1 `formats`), prompt anatomie (D2 — nejednoznačné instrukce), agent vs. skill (D4 `copilot-agents`), KnowledgeAgentScope/RCD (D2 konfigurace + explainer).
- Dopředu: Copilot Studio (hned potom) — „skill = postup uvnitř Copilotu; když potřebujete akce, kanály nebo vlastní knowledge, stavíte agenta"; topics v Studiu ≠ Skills (jiný mechanismus, stejná disciplína popisů).
