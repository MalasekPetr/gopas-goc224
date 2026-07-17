# Provozní skripty kurzu GOC224

Automatizace životního cyklu kurzového tenantu: provisioning studentů → laby → offboarding.
Všechny skripty jsou idempotentní (bezpečné spustit opakovaně) a podporují `-WhatIf` (dry-run).

> [!IMPORTANT] Identifikátory
> Repo je public. **Žádný skript nemá zabudované identifikátory** — tenant GUID, ClientId
> aplikací a cert thumbprint se předávají výhradně parametry na příkazové řádce.
> Nikdy je sem nedoplňujte ani necommitujte výstupy s hesly (`student-credentials.csv`
> je gitignored).

## Životní cyklus kurzu

| Fáze | Skript | API |
|---|---|---|
| 1. Účty studentů (vytvoření/reaktivace, licence, skupina) | `New-CourseStudents.ps1` | Graph |
| 2. Studentské weby `/sites/user.<N>` | `New-CourseStudentSites.ps1` | PnP |
| 3. Demo data pro agent scénáře (HR list, knihovny, runbooky) | `New-HRAgentData.ps1` | PnP |
| 4. Dočasné admin role pro D2 lab (grant/revoke) | `Set-CourseStudentRoles.ps1` | Graph |
| 5. Offboarding — smazání obsahu a artefaktů studentů | `Remove-CourseStudentData.ps1` | Graph + PnP |
| 6. Offboarding — disable sign-in + uvolnění licencí | `Disable-CourseStudents.ps1` | Graph |

Pořadí offboardingu: **nejdřív 5, pak 6** — mazání OneDrive obsahu vyžaduje ještě
licencované účty. Mailboxy se neřeší: odebráním licence se odpojí a po 30 dnech smažou samy.

## Přihlašování — tři režimy (všechny skripty)

1. **Interactive** (default) — browser/WAM popup. Pozor: popup jde do default browseru;
   pokud v něm běží jiná identita než admin cílového tenantu, auth tiše selže.
2. **`-UseDeviceCode`** — kód zadáte v libovolném browseru/profilu. Řeší problém č. 1.
3. **`-CertificateThumbprint` + `-ClientId` + `-TenantId` (GUID)** — app-only, bez
   jakéhokoli promptu. Doporučeno pro dávkové operace (offboarding = 20+ připojení).

## Potřebné app registrace

### A. Interaktivní/device-code režim (delegated)

PnP.PowerShell už nemá sdílené ClientId — jednorázově vytvořte app pro interaktivní login:

```powershell
Register-PnPEntraIDAppForInteractiveLogin -ApplicationName "PnP-GOC224" -Tenant <tenant>.onmicrosoft.com
```

Vrácené ClientId předávejte PnP skriptům přes `-ClientId`. Graph skripty v delegated
režimu ClientId nepotřebují (použijí Microsoft Graph PowerShell app) — stačí účet
s odpovídajícími admin rolemi.

### B. App-only režim (certificate)

App registrace s certifikátem (self-signed stačí) a těmito **application permissions**:

| API | Permission | Používá |
|---|---|---|
| Graph | `User.ReadWrite.All` | New/Disable-CourseStudents, Remove-CourseStudentData |
| Graph | `Directory.Read.All` | Remove-CourseStudentData (ownedObjects) |
| Graph | `Group.ReadWrite.All` | New-CourseStudents, Remove-CourseStudentData |
| Graph | `Organization.Read.All` | New/Disable-CourseStudents (SKU lookup) |
| Graph | `Application.ReadWrite.All` | Remove-CourseStudentData |
| Graph | `UserAuthenticationMethod.ReadWrite.All` | Remove-CourseStudentData |
| Graph | `AppCatalog.Read.All` | Remove-CourseStudentData (report) |
| Graph | `RoleManagement.ReadWrite.Directory` | Set-CourseStudentRoles (jen pokud app-only) |
| SharePoint | `Sites.FullControl.All` | všechny PnP skripty |

Pokud je app registrovaná v jiném (domovském) tenantu jako multitenant, v kurzovém
tenantu vytvořte service principal a udělte consent (přihlášeni jako admin kurzového tenantu):

```
https://login.microsoftonline.com/<courseTenantId>/adminconsent?client_id=<ClientId>
```

Po každém přidání permission na app je nutné consent URL spustit znovu.

> [!WARNING] Bezpečnost
> Tato kombinace oprávnění je fakticky plná kontrola nad tenantem — certifikát je klíč
> k celému tenantu. Používejte jen pro kurzový/demo tenant, private key neexportujte
> a po skončení kurzu zvažte smazání service principalu v kurzovém tenantu
> (Entra → Enterprise applications).

## Offboarding — co skripty nepokryjí (ruční kroky)

1. **PAYG spending policies**: M365 admin center → Copilot → Cost Management — vyjmout
   studenty z policy; za týden zkontrolovat Consumption tab (žádné API neexistuje).
2. **Power Platform**: Copilot Studio agenti, flows, per-student developer environments —
   Power Platform admin center → Environments.
3. **Teams apps**: org-uploaded aplikace vypíše `Remove-CourseStudentData.ps1` v reportu —
   smazat v Teams admin center → Manage apps.

## Demo data

`hr-employees-seed.csv` + `runbooks/*.md` — **výhradně fiktivní data** pro agent scénáře
(D4/D5). Datumové údaje jsou offsety vůči `-ReferenceDate`, takže edge-cases (končící
certifikace, nepodepsané dodatky) zůstávají platné při každém běhu kurzu. Nikdy sem
nenahrávejte reálná personální data.
