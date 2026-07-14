# Instructor notes — Konfigurace

## Timing

- 45 min výklad + živé demo, 30 min lab. Demo dělat po výkladu kroku 1–2, ať lab krok 4 má na co navazovat.

## Demo checklist

- [ ] PAYG billing ukázat v Org settings (už nastaveno — jen provést obrazovkou, neklikat znovu).
- [ ] Copilot Credits: projít **Copilot → Billing & usage** — billing policy (users/groups, budget) a tab Pay-as-you-go services (connect ke Copilot Chat / SharePoint agents). Studenti pak totéž read-only jako Global Reader.
- [ ] `Get-SPOTenant` před a po změně scope — ukázat rozdíl.
- [ ] Změnu scope dělat na testovacích webech, **ne** na studentských (jinak jim rozbiješ odpolední document-processing lab).
- [ ] Site AI settings panel ukázat z pohledu vlastníka webu.

## Tripwires

- **Neslibovat PAYG = Copilot in SharePoint.** Preview je license-based; náš tenant jede na Copilot Credits — pokud něco nefunguje, říct to nahlas jako produktovou realitu, ne chybu tenantu (a je to lekce sama o sobě).
- **Budget ≠ limit** — zdůraznit, že budget u billing policy jen notifikuje, strop nevynucuje. Studenti to intuitivně čekají obráceně; vázat na komunikační plán v labu (položka o nákladech).
- Parametry `KnowledgeAgent*` — vysvětlit jednou, proč se jmenují jinak než produkt (preview kompatibilita), a dál používat bez komentáře.
- RCD přebíjí scope — zmínit, plné vysvětlení nechat na D3 SAM.
- Change management nepřeskakovat — je v osnově a v capstone rubrice.

## Go/no-go

- Ráno ověřený stav `Get-SPOTenant` pro studenty (z powershell bloku) určuje, jestli lab krok 4 jede i přes PowerShell, nebo jen admin centrum.

## Vazby

- Zpět: `KnowledgeAgentScope` čtení (ranní powershell-spo), PAYG modely (D1 licensing, glosář).
- Dopředu: RCD/RSS → D3 `advanced-management`; PAYG služby document processing → hned další blok; komunikační plán → D5 `capstone` (blueprint sekce).
