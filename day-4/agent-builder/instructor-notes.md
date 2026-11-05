# Instructor notes — Agent Builder

## Go/no-go

- **Licence studentů** (od 2026-11): ověřit, že Copilot licence je propsaná (testovací `user.NN` → Vytvořit agenta). Určuje, jestli staví studenti (část B), nebo jen instruktor v demu (fallback).
- Demo stavět nad **instruktorským** webem, ne studentskými (práva, překvapení).

## Tripwires

- **Instrukce ≠ knowledge** (XPIA) — studenti rádi nacpou směrnici do instrukcí.
- **Negativní test** v evaluačním plánu je povinný — bez něj se agent „vždycky povede".
- Strop ukázat naživo: analytický dotaz („komu propadá certifikát do 30 dnů") Builder **neagreguje** — jen prioritizuje. To je most na Copilot Studio (D5), ne selhání labu.
- Sdílením agenta s embedded soubory sdílíš i obsah — zmínit u publikace.
- Dotaz „a umí to něco udělat (akci)?" → ne; Builder akce do externích služeb neumí, cesta = „copy to Copilot Studio" (D5).
- Email / People / Teams jako knowledge funguje jen licencovaným — studentům s licencí ano; u zákazníka s PAYG uživateli by to tiše nefungovalo.

## Vazby

- Zpět: Agent Instructions (D2), mapa cest a srovnání ([`../copilot-agents/`](../copilot-agents/README.md)).
- Zpět: dashboard v Code (`code`, dopoledne) odpověděl na „komu propadá certifikát" jako **aplikace** — Builder tentýž dotaz neagreguje; dobré srovnání aplikace vs. agent.
- SharePoint agents = volitelný blok na konci D4 (podpora `.agent` končí) — [`../opt-sharepoint-agents/`](../opt-sharepoint-agents/README.md); tady jen zmínit, že „Create agent" na webu vede do Agent Builderu.
- Dopředu: Agents Toolkit → správa v D5 `copilot-admin`; analytika ve Studiu (D5).

## Přesunuto z README

- Odhad bloku počítá s živým demem: HR Asistent nad instruktorským webem (popis → instrukce → knowledge → test).
- Před během ověřit, že je Copilot licence studentů propsaná — jinak jen instruktorské demo (viz Go/no-go).
- Po Ignite (17.–20. 11. 2026) projet Builder znovu (přebírá tvorbu SharePoint agentů).
