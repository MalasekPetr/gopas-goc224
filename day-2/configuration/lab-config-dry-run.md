# Lab · Tenant configuration dry-run

> Modul: configuration · Odhad: 30 min · Režim: simulace + živé ověření dopadu (Global Reader)

## Cíl

Sestavit konfigurační runbook pro fiktivní firmu a ověřit, že odpovídá tomu, co instruktor právě předvedl živě.

## Zadání

Firma (150 lidí, 40 SharePoint webů, 10 pilotních Copilot uživatelů) chce zapnout Copilot in SharePoint jen pro 5 vybraných webů.

## Kroky

1. Napiš runbook jako číslovaný MD checklist: předpoklady → PAYG → scope → search/zdroje → komunikace → ověření. U každého kroku: *kdo* (role) a *kde* (admin centrum / PowerShell).
2. Ke kroku scope napiš konkrétní příkaz: `Set-SPOTenant -KnowledgeAgentScope ...` + `KnowledgeAgentSelectedSitesList` pro 5 webů. (Píšeš, nespouštíš.)
3. Přidej 3 položky komunikačního plánu (co, komu, kdy) — minimálně jedna musí řešit PAYG náklady.
4. **Živé ověření:** po instruktorském demu zkontroluj jako Global Reader stav v admin centru (a `Get-SPOTenant`, pokud ranní go/no-go dovolil) — sedí s tvým runbookem?
5. Zapiš 1 rozdíl mezi tvým dry-run návrhem a skutečným postupem instruktora.

## Ověření

- [ ] Runbook má 6 fází s rolemi a místem provedení.
- [ ] Scope příkaz je syntakticky správně (hodnoty z README).
- [ ] Komunikační plán řeší náklady.
- [ ] Krok 5 (rozdíl) je zapsaný — dry-run bez reflexe je jen opis.

## Fallback

- Živé demo nedostupné (preview výpadek): krok 4 nahradit screenshoty; runbook a reflexe zůstávají.
