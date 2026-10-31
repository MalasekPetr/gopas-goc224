# Lab · Tenant configuration dry-run

> Modul: configuration · Odhad: 30 min · Režim: simulace + živé ověření dopadu (Global Reader)

## Cíl

Sestavit konfigurační runbook pro fiktivní firmu a ověřit, že odpovídá tomu, co instruktor právě předvedl živě.

## Zadání

Firma (150 lidí, 40 SharePoint webů, 10 pilotních Copilot uživatelů) chce pilotovat Copilot in SharePoint. Dva weby (HR, Finance) nejsou uklizené a Copilot se na nich nesmí objevit, dokud neproběhne revize přístupů.

> [!IMPORTANT] Názvosloví / lineage
> Do 1. 11. 2026 se pilot dělal tenant-wide parametrem `Set-SPOTenant -KnowledgeAgentScope IncludeSelectedSites`. Ten je vyřazený — po GA řídí *komu* licence, *kde ne* RCD a *UI na webu* Site AI settings (viz README, krok 2).

## Kroky

1. Napiš runbook jako číslovaný MD checklist: předpoklady → PAYG → dostupnost (licence + RCD + Site AI settings) → search/zdroje → komunikace → ověření. U každého kroku: *kdo* (role) a *kde* (admin centrum / PowerShell / nastavení webu).
2. Ke kroku dostupnost napiš konkrétní příkaz pro oba citlivé weby: `Set-SPOSite -Identity <url> -RestrictContentOrgWideSearch $true`. (Píšeš, nespouštíš.) Doplň, kdo přidělí licence 10 pilotním uživatelům a co udělají vlastníci ostatních webů v Site AI settings.
3. Přidej 3 položky komunikačního plánu (co, komu, kdy) — minimálně jedna musí řešit PAYG náklady.
4. **Živé ověření:** po instruktorském demu zkontroluj jako Global Reader stav v admin centru (a `Get-SPOTenant`, pokud ranní go/no-go dovolil) — sedí s tvým runbookem?
5. Zapiš 1 rozdíl mezi tvým dry-run návrhem a skutečným postupem instruktora.

## Ověření

- [ ] Runbook má 6 fází s rolemi a místem provedení.
- [ ] RCD příkaz je syntakticky správně a runbook nepoužívá vyřazený `KnowledgeAgentScope`.
- [ ] Komunikační plán řeší náklady.
- [ ] Krok 5 (rozdíl) je zapsaný — dry-run bez reflexe je jen opis.

## Fallback

- Živé demo nedostupné (výpadek / GA rollout ještě nedorazil do tenantu): krok 4 nahradit screenshoty; runbook a reflexe zůstávají.
