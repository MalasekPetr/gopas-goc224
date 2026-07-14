# Lab · Inventura tenantu skriptem

> Modul: powershell-spo · Odhad: 40 min · Režim: studenti píšou skript (varianta B); spuštění dle go/no-go — viz instructor-notes

## Cíl

Napsat skript, který vytvoří AI-governance inventuru tenantu: weby + nastavení relevantní pro Copilot.

## Předpoklady

- PowerShell 7 + modul `Microsoft.Online.SharePoint.PowerShell` v aktuální verzi (od ~16.0.24810 podporuje PS7 nativně, `-UseWindowsPowerShell` už není potřeba). Pokud modul hlásí chybu kompatibility, jde o starou verzi z cache — `Update-Module Microsoft.Online.SharePoint.PowerShell -Force`.
- Admin URL tenantu (viz `../../environment.md`).
- Role **SharePoint Administrator** (nebo vyšší — Global Administrator) na účtu, kterým se studenti připojují. Bez ní `Connect-SPOService` proběhne, ale `Get-SPOTenant` / `Get-SPOSite -Limit ALL` skončí na 403 — SPO admin cmdlety vyžadují administrátorskou roli, členství ve site collection admins nestačí.

## Kroky

1. Napiš skript `tenant-inventory.ps1`, který:
   - se připojí (`Connect-SPOService -Url ...`),
   - vypíše z `Get-SPOTenant`: `KnowledgeAgentScope`, storage kvótu,
   - vypíše `Get-SPOSite -Limit ALL` jako tabulku: URL, Owner, StorageUsageCurrent, Template,
   - výstup uloží do CSV (`Export-Csv -Encoding utf8`).
2. Přidej komentář ke každému kroku: *co* čte a *proč* je to pro AI governance zajímavé.
3. Rozšíření pro rychlé: parametrizuj filtr šablony webu; přidej sloupec IsAuthoritative (jen pokud tenant parametr podporuje).
4. Spuštění podle režimu vyhlášeného instruktorem (vlastní přístup / instruktor na projektoru).
5. Nad výsledkem odpověz: kolik webů má tenant, který je největší, a jaká je hodnota `KnowledgeAgentScope`?

## Ověření

- [ ] Skript má connect + 2 čtecí bloky + CSV export a jde přečíst (komentáře).
- [ ] Student zná odpovědi na 3 otázky z kroku 5 (ze svého nebo promítnutého běhu).
- [ ] Ve skriptu není žádný `Set-*` cmdlet.

## Fallback

- Připojení pro studenty nefunguje: instruktor spustí vybrané studentské skripty na projektoru; ostatní validují výstup proti svému kódu.
- Úplný offline fallback: instruktor rozdá CSV z vlastního běhu; studenti dopisují krok 5 nad hotovými daty.
