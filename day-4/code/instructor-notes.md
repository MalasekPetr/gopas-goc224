# Instructor notes — Code

## Timing

- 20 min výklad (vč. Copilot Managed Runtime) + 30 min lab. Když hoří čas: `lab-code` část A jako 15min instruktorské demo, část B (governance checklist) hands-on.

## Go/no-go (ráno před blokem)

- [ ] Tenant ve **Frontier**, **Code tab** zapnutý, execution location = cloud, **GitHub connection = Off**, Organizational Data in Code = On (cloud).
- [ ] **Spending policy** obsahuje studenty a službu **Code**, per-user strop.
- [ ] Studenti mají čtení na listu `Zaměstnanci` (`/sites/hr-demo`); HR data čerstvě přenasazená (`New-HRAgentData.ps1 -Reseed -ReferenceDate <datum D4>`).
- [ ] **Dry-run na testovacím `user.NN`:** načte Code SharePoint list přes odkaz? (Docs zmiňují list jako připojený zdroj u sdílení.) Podle výsledku ohlásit CSV fallback předem.

No-go → demo, část B labu beze změny.

## Tripwires

- **Code nepublikovat do organizace** — 20 dashboardů v Managed Runtime je úklid navíc. Jen prohlédnout možnosti.
- **GitHub off = data sovereignty** — nosná governance pointa labu; nepřepínat ani pro demo.
- **Běh platí uživatel, ne tvůrce** — studenti to přehlédnou; otázka 6 governance checklistu.
- `/cost` v Code funguje (ověřeno 2026-11) — ukázat jako uživatelskou cestu ke spotřebě.

## Vazby

- Zpět: [`../cowork/`](../cowork/README.md) (tři režimy, kdy co), HR scénář (`copilot-agents`).
- Dopředu: Agent Builder odpoledne (tentýž dotaz jako agent — aplikace vs. agent), [`../ai-app-access/`](../ai-app-access/README.md), D5 `copilot-admin` (Apps → All apps, Environment groups).
