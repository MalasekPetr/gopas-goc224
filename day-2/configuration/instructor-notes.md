# Instructor notes — Konfigurace

## Timing

- 45 min výklad + živé demo, 30 min lab. Demo dělat po výkladu kroku 1–2, ať lab krok 4 má na co navazovat.

## Demo checklist

- [ ] PAYG billing ukázat v Org settings (už nastaveno — jen provést obrazovkou, neklikat znovu).
- [ ] Copilot Credits: projít **Copilot → Billing & usage** — billing policy (users/groups, budget) a tab Pay-as-you-go services (connect ke Copilot Chat / SharePoint agents). Studenti pak totéž read-only jako Global Reader.
- [ ] **Copilot → Cost management** — projít obrazovkou spending policy (scope, služby, limited budget = tvrdý strop, Auto-apply new services). Studentská policy (Cowork, Code, Advanced work, per-user strop) je nastavená předem — ukázat ji, neměnit (detail D4 `cowork` a `code`).
- [ ] `Get-SPOSite` před a po zapnutí RCD na testovacím webu — ukázat rozdíl; zmínit, že `KnowledgeAgentScope` je od 1. 11. 2026 vyřazený (výsledek T3 z powershell-spo jako živý příklad).
- [ ] RCD zapínat na testovacích webech, **ne** na studentských (jinak jim rozbiješ odpolední document-processing lab).
- [ ] Site AI settings panel ukázat z pohledu vlastníka webu — po GA hlavní „kde je tlačítko" ovladač.

## Tripwires

- **PAYG ≠ Copilot in SharePoint.** Po GA license-only, ověřeno v tenantu 2026-11 (T1, D1) — proto mají studenti Copilot licenci. Říct to nahlas jako produktovou realitu „preview ≠ GA" (lekce sama o sobě).
- **Budget ≠ limit** — u billing policy (původní PAYG) budget jen notifikuje. Ve spending policy (Cost management) limit **je**. Studenti to snadno zamění; vázat na komunikační plán v labu (položka o nákladech).
- Parametry `KnowledgeAgent*` — jen jako historie (vyřazeno); studenti na ně narazí ve starších návodech.
- RCD přebíjí Site AI settings — zmínit, plné vysvětlení nechat na D3 SAM.
- Change management nepřeskakovat — je v osnově a v capstone rubrice.

## Go/no-go

- Ráno ověřený stav `Get-SPOTenant` / `Get-SPOSite` pro studenty (z powershell bloku) určuje, jestli lab krok 4 jede i přes PowerShell, nebo jen admin centrum.

## Vazby

- Zpět: RCD / IsAuthoritative inventura (ranní powershell-spo), PAYG modely (D1 licensing, glosář).
- Dopředu: RCD/RSS → D3 `advanced-management`; PAYG služby document processing → hned další blok; komunikační plán → D5 `capstone` (blueprint sekce).
