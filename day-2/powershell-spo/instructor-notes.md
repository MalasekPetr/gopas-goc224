# Instructor notes — SPO PowerShell

## Timing

- 40 min výklad + 40 min lab. Instalace modulu umí sežrat 15 minut — mít připravený příkaz na slidu hned na začátku a nechat instalovat na pozadí během výkladu.

## Go/no-go — KLÍČOVÉ, otestovat před během

- **Otestovat, zda `Connect-SPOService` + `Get-*` funguje pod Global Reader.** Dokumentace uvádí jen SharePoint Administrator; Global Reader není dokumentovaný.
  - Funguje → studenti spouštějí sami pod svými účty (nejlepší varianta).
  - Nefunguje → rozhodnout: (a) dočasná role SharePoint Administrator na dobu bloku (riziko: `Set-SPOTenant` je tenant-wide — vyhlásit tvrdé pravidlo „žádný Set-*", případně odebrat roli hned po labu), nebo (b) studenti jen píšou, instruktor spouští na projektoru. Doporučení: (b) je bezpečnější, (a) je hodnotnější — rozhodnout podle skupiny.
- Modul aktualizovat na 16.0.26615.12013+ (kvůli `KnowledgeAgentScope` čtení).
- Referenční řešení pro go/no-go test a projektorový/fallback běh: `solution/tenant-inventory.ps1`.
- Pro návod Copilot inventarizace: ověřit, že `Get-SPOSite -Identity <url>` v aktuální verzi modulu vrací `RestrictContentOrgWideSearch` (RCD) — dokumentace RCD se vyvíjí. Referenční řešení: `solution/copilot-inventory.ps1`.

## Tripwires

- Aktuální verze modulu běží v PS7 nativně (`-UseWindowsPowerShell` už není potřeba) — pokud studentovi import spadne na kompatibilitě, má starou verzi z cache: `Update-Module Microsoft.Online.SharePoint.PowerShell -Force`. Mít na slidu.
- **Explicitní `Import-Module` je povinný** — manifest modulu exportuje wildcardem (`CmdletsToExport = *`), takže PS autoloading nefunguje a `Connect-SPOService` je bez importu „not recognized". Ověřeno na 16.0.27424.12000. Mít na slidu vedle instalace.
- `Get-SPOSite -Limit ALL` s 20 weby je rychlé, ale vysvětlit chování defaultů vlastností (s `-Limit` vrací defaulty — v produkci častý zdroj špatných reportů).
- Nenechat studenty „vylepšit" skript o `Set-SPOTenant` — kontrola v ověření labu.
- Neodbíhat k PnP.PowerShell — mimo rozsah, odkázat na glosář.

## Vazby

- Dopředu: `KnowledgeAgentScope` hodnota z labu = vstup do odpolední `configuration` (dry-run na ni naváže); inventura webů → D3 SAM (DAG reporty dělají totéž v UI).
- Zpět: skripty ukládat jako soubory na vlastní web (D1 návyky, MD/CSV formáty).
