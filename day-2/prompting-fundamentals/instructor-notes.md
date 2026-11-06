# Instructor notes — Prompting fundamentals

## Timing

- 45 min výklad + 30 min lab. Podsekce harness (+3 min, 2026-11) jde z Memory — detail eDiscovery/Graph Explorer jen zmínit, plně až D5 monitoring. Otvírák dne — svěží energie, držet tempo; tabulka vrstev instrukcí je jádro, nekrátit.

## Tripwires

- Pojmy držet přesně dle README tabulky — studenti si jinak spojí Memory s context window. Kreslit vrstvy na tabuli.
- Memory/personalizace = **preview** — neslibovat chování; zmínit, že Purview retence/audit na paměť nesahá (governance dotek pro D5).
- **Harness = orchestrator** (podsekce v kap. 2, ~3 min): nakreslit tři vrstvy agent → harness → model a tabulku „kdo dodává harness". Cíl: aby v D5 slovo „harness" nikoho nepřekvapilo. Ztotožnění je naše zjednodušení — MS používá v M365 Copilot docs „orchestrator", v Copilot Studiu „harness".
- XPIA zmínit u Agent Instructions jednou větou (instrukce nepatří do knowledge) — hlubší bezpečnost až D5.
- PAYG: hned ráno zopakovat pravidlo z ways-of-working — iterace ano, bezcílné mlácení do chatu ne.

## Lab

- Krok 5 (permissions test) je nejcennější moment — nechat studenty říct nahlas, že cizí data nevidí; váže na licence vs. permissions z D1.
- Hlídat čas: 3 verze stačí, nenechat soutěžit v počtu promptů.

## Vazby

- Zpět: D1 `ai-landscape` (grounding, datové hranice), ways-of-working (PAYG chování).
- Dopředu: Agent Instructions → D4 `copilot-agents` (explicitní callback — „tuhle tabulku uvidíte znovu"); orchestrator/harness → D4 `copilot-agents` (dvě dráhy stavby, čí harness agent používá) → D5 Copilot Studio (harnessy, generative orchestration).
