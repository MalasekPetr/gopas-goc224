# Instructor notes — SharePoint agents

## Go/no-go

- **Tvorba = Copilot licence** → jen instruktorské demo, nezakládat na tom studentský lab. Studenti sledují + predikují.
- Testovací web s knihovnou `Smlouvy` připravený (data z `New-HRAgentData.ps1`).
- Ráno ověřit, že „Create agent" ještě vytváří `.agent` (přechod na Agent Builder je avizovaný na pol. 11/2026); jinak fallback z labu.

## Tripwires

- **1 zdroj a nic jiného** (MC1255409) — nosná pointa; přidání listu shodí knihovnu, ukázat naživo. Říkat jako empirii: MS dokumentace limit neuvádí.
- Nezaměnit „SharePoint agent" (na webu, deklarativní) s **Copilot in SharePoint / Skills** (D5; na PAYG fungovaly v preview — stav po GA dle T1 z D1) — jiná věc. Pozor: jedna z upgrade cest je právě „převést agenta na skill".
- Docs lag k listům (GA ~05/2026, admin docs to neuvádějí) — dobrý příklad „ověř stav k datu běhu".
- **Legacy avízo:** od pol. 11/2026 tvorba přes Agent Builder, `.agent` končí po 03/2027; PAYG pro SharePoint agents platí jen pro `.agent`. Studenti si mají odnést „co dělat s existujícími `.agent` u zákazníka" (4 upgrade cesty).

## Vazby

- Zpět: Agent Builder (předchozí blok), mapa cest a srovnání ([`../copilot-agents/`](../copilot-agents/README.md)).
- Dopředu: Agents Toolkit (agent jako kód); správa/registr agentů → D5 `copilot-admin`.
