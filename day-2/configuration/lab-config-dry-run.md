# Lab · Tenant configuration dry-run

> Modul: configuration · Odhad: 30 min · Režim: **simulace + živé ověření dopadu (Global Reader), samostatně podle šablony**

## Cíl

Sestavit konfigurační runbook pilotu Copilot in SharePoint pro fiktivní firmu a ověřit ho proti tomu, co instruktor předvedl živě.

## Zadání

> Firma: **150 lidí, 40 SharePoint webů, 10 pilotních Copilot uživatelů**. Dva weby (**HR**, **Finance**) nejsou uklizené — Copilot se na nich nesmí objevit, dokud neproběhne revize přístupů. URL: `https://contoso.sharepoint.com/sites/hr` a `https://contoso.sharepoint.com/sites/finance`.

> [!IMPORTANT] Názvosloví / lineage
> Do 1. 11. 2026 se pilot dělal tenant-wide parametrem `Set-SPOTenant -KnowledgeAgentScope IncludeSelectedSites`. Ten je vyřazený — po GA řídí *komu* licence, *kde ne* RCD a *UI na webu* Site AI settings (viz README, krok 2).

## Předpoklady

- [ ] Viděl/a jsi instruktorské demo konfigurace (README modulu, kroky 1–4).
- [ ] Přihlášení jako `user.NN@spdemo.online` (Global Reader) — pro krok 4.

## Kroky

### Krok 1 — runbook (15 min)

1. Zkopíruj šablonu a vyplň ji. Každý krok musí mít **kdo** (role), **kde** (admin centrum / PowerShell / nastavení webu) a **co**. Fáze 3 je předvyplněná jako vzor.

```markdown
# Runbook: pilot Copilot in SharePoint — Contoso

## 1. Předpoklady
| Co | Kdo (role) | Kde |
|---|---|---|
| Azure subscription ve stejném tenantu | | |
| Role pro konfiguraci (AI Administrator / SharePoint Administrator) | | |

## 2. Billing (Copilot Credits a Document processing)
| Co | Kdo | Kde |
|---|---|---|
| | | M365 AC → Copilot → Billing & usage / Cost management |

## 3. Dostupnost
| Co | Kdo | Kde |
|---|---|---|
| Přidělit Copilot licenci 10 pilotním uživatelům | User Administrator / License Administrator | M365 AC → Uživatelé → Aktivní uživatelé → Licence a aplikace |
| Vyřadit HR a Finance z Copilotu (RCD) | SharePoint Administrator | SharePoint Online Management Shell (příkaz níže) |
| Vlastníci ostatních webů: zvážit skrytí Copilot tlačítka pro návštěvníky | vlastník webu | Nastavení → Site AI |

## 4. Search a zdroje
| Co | Kdo | Kde |
|---|---|---|
| | | |

## 5. Komunikace
| Co | Komu | Kdy |
|---|---|---|
| | | |
| | | |
| | | |

## 6. Ověření
| Co ověřím | Jak | Očekávaný výsledek |
|---|---|---|
| | | |
```

### Krok 2 — příkazy RCD (5 min)

2. Do fáze 3 napiš příkazy pro oba citlivé weby. **Píšeš, nespouštíš.**

   ```powershell
   Connect-SPOService -Url https://contoso-admin.sharepoint.com
   Set-SPOSite -Identity https://contoso.sharepoint.com/sites/hr      -RestrictContentOrgWideSearch $true
   Set-SPOSite -Identity https://contoso.sharepoint.com/sites/finance -RestrictContentOrgWideSearch $true
   # ověření:
   Get-SPOSite -Identity https://contoso.sharepoint.com/sites/hr | Select-Object Url, RestrictContentOrgWideSearch
   ```

3. Do fáze 5 doplň 3 komunikační položky (co, komu, kdy). **Aspoň jedna musí řešit náklady** (Copilot Credits, Document processing).

### Krok 3 — živé ověření (5 min)

4. Jako Global Reader zkontroluj v M365 admin centru stav po instruktorském demu:
   - **Copilot → Settings** — co se nastavilo,
   - **Copilot → Cost management** — existuje spending policy?
   - (pokud ranní go/no-go dovolil PowerShell) `Get-SPOTenant` / `Get-SPOSite -Identity <web> | Select RestrictContentOrgWideSearch`.

### Krok 4 — reflexe (5 min)

5. Zapiš **1 rozdíl** mezi svým runbookem a skutečným postupem instruktora — a který z nich je správně a proč.

## Ověření

- [ ] Runbook má všech 6 fází; každý řádek má roli a místo provedení.
- [ ] RCD příkaz je syntakticky správně a runbook **nepoužívá** vyřazený `KnowledgeAgentScope`.
- [ ] Komunikační plán má 3 položky, aspoň jedna řeší náklady.
- [ ] Rozdíl z kroku 5 je zapsaný.

## Když něco nejde

| Situace | Co udělat |
|---|---|
| Nevím, kdo smí krok provést | Najdi roli v README modulu (sekce Předpoklady) nebo v [`../../GLOSSARY.md`](../../GLOSSARY.md). |
| Global Reader nevidí Cost management | Zapiš to; krok 4 dokonči podle plátna instruktora. |
| Nevím, co patří do fáze 4 | Restricted SharePoint Search (RSS) vs. RCD, autoritativní weby (`IsAuthoritative`) — viz README a [`explainer-copilot-controls.md`](explainer-copilot-controls.md). |

## Fallback

- Živé demo nedostupné: krok 3 nahraď screenshoty; runbook a reflexe zůstávají.
