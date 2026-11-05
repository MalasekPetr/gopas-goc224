# Lab · Inventura tenantu skriptem

> Modul: powershell-spo · Odhad: 40 min · Režim: **studenti píšou skript podle kostry (varianta B)**; spuštění dle go/no-go — viz instructor-notes

## Cíl

Napsat skript `tenant-inventory.ps1`, který vytvoří AI-governance inventuru tenantu (nastavení tenantu + seznam webů) a uloží ji do CSV — a umět vysvětlit, proč je každý údaj pro Copilot důležitý.

## Předpoklady

- [ ] **PowerShell 7** (`pwsh`) — ověř: `$PSVersionTable.PSVersion` (Major = 7).
- [ ] Modul SPO v aktuální verzi:

  ```powershell
  Install-Module Microsoft.Online.SharePoint.PowerShell -Scope CurrentUser   # poprvé
  Update-Module  Microsoft.Online.SharePoint.PowerShell -Force               # když hlásí chybu kompatibility
  ```

- [ ] Admin URL tenantu: `https://ms365x17157302-admin.sharepoint.com`.
- [ ] Pro **spuštění** je potřeba role **SharePoint Administrator**. Studenti ji nemají (Global Reader) — `Connect-SPOService` projde, ale čtecí cmdlety skončí na 403. Skript proto píšeš celý a spuštění proběhne podle režimu, který vyhlásí instruktor.

## Kroky

### Krok 1 — kostra skriptu (5 min)

1. Ve VS Code vytvoř soubor `tenant-inventory.ps1` a vlož kostru. Místa `# TODO` doplníš v dalších krocích.

   ```powershell
   <#
   .SYNOPSIS
       AI-governance inventura tenantu: nastavení tenantu + seznam webů -> CSV.
   #>
   param(
       [Parameter(Mandatory)]
       [string]$AdminUrl,

       [string]$TemplateFilter,

       [string]$OutputCsv = "tenant-inventory.csv"
   )

   # Modul je nutné importovat explicitně (autoloading u něj nefunguje).
   Import-Module Microsoft.Online.SharePoint.PowerShell

   # TODO krok 2: připojení

   # TODO krok 3: nastavení tenantu

   # TODO krok 4: seznam webů + volitelný filtr šablony

   # TODO krok 5: export do CSV
   ```

### Krok 2 — připojení (3 min)

2. Pod `# TODO krok 2` doplň připojení k admin endpointu. Nápověda: cmdlet `Connect-SPOService`, parametr `-Url`, hodnota z parametru `$AdminUrl`.

### Krok 3 — nastavení tenantu (7 min)

3. Načti nastavení tenantu do proměnné `$tenant` cmdletem `Get-SPOTenant`.
4. Vypiš jako objekt (`[PSCustomObject]@{ … } | Format-List`) tři hodnoty:

   | Název ve výpisu | Vlastnost `$tenant` | Proč je to pro AI governance důležité |
   |---|---|---|
   | `RcdDelegatedToSiteAdmins` | `DelegateRestrictedContentDiscoverabilityManagement` | smí vlastníci webů sami zapnout Restricted Content Discovery — kdo rozhoduje, co Copilot „nevidí" |
   | `StorageQuotaMB` | `StorageQuota` | kolik obsahu tenant může mít |
   | `StorageQuotaUsedMB` | `StorageQuotaAllocated` | kolik je přiděleno webům |

5. Nad blok napiš komentář vlastními slovy: *co* čte a *proč*.

### Krok 4 — seznam webů (10 min)

6. Načti všechny weby do `$sites`: `Get-SPOSite -Limit ALL`.
7. Pokud je zadaný `$TemplateFilter`, vyfiltruj weby podle vlastnosti `Template` (`Where-Object Template -eq $TemplateFilter`).
8. Vyber sloupce do `$report`: `Url`, `Owner`, `StorageUsageCurrent`, `Template` (`Select-Object`) a vypiš je (`Format-Table -AutoSize`).
9. Komentář: proč je každý sloupec pro governance důležitý (Owner = kdo odpovídá za obsah; StorageUsageCurrent = váha webu v AI indexu; Template = team vs. communication web).

### Krok 5 — export (3 min)

10. Ulož `$report` do CSV: `Export-Csv -Path $OutputCsv -NoTypeInformation -Encoding utf8`.
11. Na konec přidej `Write-Host "Uloženo: $OutputCsv"`.

### Krok 6 — kontrola a rozšíření (7 min)

12. Zkontroluj, že ve skriptu **není žádný `Set-*` cmdlet** — inventura jen čte.
13. **Rozšíření pro rychlé:** pokud weby vracejí vlastnost `IsAuthoritative`, přidej ji jako pátý sloupec (nápověda: `$sites[0].PSObject.Properties['IsAuthoritative']`).
14. **Spuštění** podle režimu instruktora:

    ```powershell
    ./tenant-inventory.ps1 -AdminUrl https://ms365x17157302-admin.sharepoint.com
    # jen komunikační weby:
    ./tenant-inventory.ps1 -AdminUrl https://ms365x17157302-admin.sharepoint.com -TemplateFilter "SITEPAGEPUBLISHING#0"
    ```

### Krok 7 — otázky nad výsledkem (5 min)

15. Ze svého nebo promítnutého běhu odpověz:
    - Kolik webů má tenant?
    - Který web je největší (`StorageUsageCurrent`)?
    - Smí vlastníci webů sami spravovat RCD (`RcdDelegatedToSiteAdmins`)?

> [!IMPORTANT] Názvosloví / lineage
> Starší verze labu četly `KnowledgeAgentScope`. Microsoft ho při GA Copilot in SharePoint vyřadil (ctěn do 1. 11. 2026) — dostupnost dnes řídí Site AI settings + RCD ([Get started](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started)).

## Ověření

- [ ] Skript má `param`, `Import-Module`, připojení, 2 čtecí bloky a CSV export.
- [ ] Každý blok má komentář *co* a *proč*.
- [ ] Ve skriptu není žádný `Set-*` cmdlet.
- [ ] Znáš odpovědi na 3 otázky z kroku 15.
- [ ] Porovnej se vzorovým řešením [`solution/tenant-inventory.ps1`](solution/tenant-inventory.ps1) — až po dokončení.

## Když něco nejde

| Příznak | Příčina | Řešení |
|---|---|---|
| `Connect-SPOService` není rozpoznaný | chybí `Import-Module` | přidej `Import-Module Microsoft.Online.SharePoint.PowerShell` |
| Chyba kompatibility modulu v PS7 | stará verze modulu v cache | `Update-Module Microsoft.Online.SharePoint.PowerShell -Force` a nové okno `pwsh` |
| `Get-SPOTenant` vrací 403 / Access denied | účet nemá roli SharePoint Administrator | očekávané u studentů — běh dle režimu instruktora |
| CSV má rozbitou češtinu | chybí `-Encoding utf8` | doplň parametr v kroku 10 |
| Skript se nespustí (execution policy) | blokované nepodepsané skripty | `Set-ExecutionPolicy -Scope Process RemoteSigned` (jen pro aktuální okno) |

## Fallback

- Připojení nefunguje: instruktor spustí vybrané studentské skripty na projektoru; ostatní porovnávají výstup se svým kódem.
- Úplný offline fallback: instruktor rozdá CSV z vlastního běhu; studenti odpovídají na krok 15 nad hotovými daty.
