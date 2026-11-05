# Lab · Admin tour — Copilot & Agents

> Modul: copilot-admin · Odhad: 30 min · Režim: živý tenant (Global Reader, read-only)

## Cíl

Projít obě admin sekce vlastníma očima a umět říct, kde se která správní otázka řeší.

## Předpoklady

- Global Reader (celý týden) — sekce Copilot i Agents jsou read-only viditelné.

## Kroky

1. Otevři M365 admin center → **Copilot → Settings**. Projdi taby (User access, Data access, Copilot actions, Other settings) a zapiš: kde se řídí self-service nákupy, kde web grounding, kde PAYG billing, kde AI subprocesoři a nezávislí procesoři.
1b. Otevři **Copilot → Cost management**: jaké spending policies existují, které služby pokrývají, mají limited budget (tvrdý strop)? Je zapnuté *Auto-apply new services*?
2. Otevři sekci **Agents**. Zapiš: kolik agentů registry ukazuje, jakých typů, a jestli existují **ownerless agents** (governance dluh!).
3. Najdi **Requests** — čeká něco na schválení? Popiš, co by admin viděl při publikaci agenta.
3b. **Aplikace z Code (D4) — Copilot Managed Runtime:** otevři **Apps → All apps** — je tu některá aplikace z včerejška (i nepublikovaná)? Pak **Apps → Settings → Environment groups** → default group: které konektory smí aplikace používat, proč je akce „Send an HTTP request" blokovaná a jestli jde aplikaci sdílet s hosty. Najdi ve **Cost management** spending policy pro službu *Copilot Managed Runtime* (kdo platí za běh?). Global Reader vidí vše read-only ([Governance settings](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/apps/governance)).
4. Otevři **Reports → Usage → Microsoft Copilot**: aktivní uživatelé za týden kurzu — poznáváš vlastní aktivitu z labů (zpoždění ~48 h)? Najdi i samostatný **Agents** report (preview).
5. Vyplň mapu vrstev (tabulka z README) vlastními slovy: ke každé z 6 otázek jedno místo v UI, kde jsi odpověď našel/našla.
6. **Instruktorské demo:** blokace testovacího agenta + co uvidí uživatel; schválení requestu.

## Ověření

- [ ] Student ukáže v UI: data access nastavení, Cost management, agent registry, usage report.
- [ ] Mapa vrstev vyplněná vlastními slovy (ne opsaná).
- [ ] Student odpoví: „Chci zakázat agenta X pro všechny — kam kliknu?" a „Chci vědět, kdo Copilot reálně používá — kam?"
- [ ] Student odpoví: „Kde uvidím a omezím aplikace, které si lidé postavili v Code?" (Apps → All apps / Environment groups; detail DLP v PPAC).

## Fallback

- Global Reader některý tab nevidí (preview změny, např. Cost management): promítnout z instruktorského účtu; mapa vrstev zůstává individuální.
