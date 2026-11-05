# Instructor notes — Cowork a Code

## Timing

- 15 min výklad + 30 min `lab-cowork` + 30 min `lab-code`. Blok stojí mezi archive a copilot-agents — most „Copilot, který koná" → „agenti, které stavíte".
- Sloučení `sharepoint-agents` do `agent-builder` uvolní jen ~10 min (20 min demo → 10min segment). **D4 je tím o ~1 h delší** — když hoří čas: `lab-code` část A jako 15min instruktorské demo (část B hands-on), `lab-cowork` část C jako domácí úkol.

## Go/no-go (ráno před blokem)

- [ ] Studentské účty mají **Copilot licenci** a propsala se (přihlásit testovací `user.NN`, Home → přepínač Cowork viditelný).
- [ ] **Spending policy** (M365 AC → Copilot → Cost management) obsahuje studenty, služby **Cowork** a **Code**, per-user strop. **Auto-apply new services** vypnuté.
- [ ] Tenant ve **Frontier**, **Code tab** zapnutý, execution location = cloud, **GitHub connection = Off**, Organizational Data in Code = On (cloud).
- [ ] Knihovna `Vzorky` na studentských webech existuje (D2); kdo ji nemá, dostane 3 vzorky.
- [ ] Studenti mají čtení na listu `Zaměstnanci` (`/sites/hr-demo`).
- [ ] **Dry-run na testovacím `user.NN`** před blokem: (a) kam Cowork uloží nový Word — do `Vzorky`, nebo do OneDrivu? (docs popisují editaci existujících souborů a výstup v bočním panelu / OneDrivu); (b) načte Code SharePoint **list** (docs jmenují dokumenty, e-maily, schůzky, kalendář — listy ne)? Podle výsledku ohlásit fallback z labu předem.

No-go Cowork → fallback z labu (instruktor na plátně). No-go Code → demo, část B labu beze změny.

## Tripwires

- **Cowork je „agentic system", ne agent** — v M365 AC Agents ho nevypneš; přístup = spending policy. Bude se to hodit zítra v `copilot-admin`.
- **„Always allow"** v Cowork studenty láká — v labu je zakázané schválně. Zmínit, že u zákazníka je to otázka politiky.
- **E-maily jen sobě.** 20 studentů posílajících e-maily navzájem nebo instruktorovi = chaos; hlídat zadání.
- **Plánované prompty mazat** — tiše čerpají kredity i po kurzu. Po bloku zkontrolovat v Cost management, že nic neběží.
- **Code nepublikovat do organizace** — 20 dashboardů v Managed Runtime je úklid navíc. Jen prohlédnout možnosti.
- **GitHub off = data sovereignty** — nosná governance pointa labu Code; nepřepínat ani pro demo.
- EU Data Boundary: v Cowork jen GPT modely — kdo uvidí v model pickeru něco jiného, zapsat (stav tenantu vs. docs).
- Neslibovat sazby kreditů — ukázat spotřebu v Cost management po bloku.

## Vazby

- Zpět: nový Copilot a licence (D1), anatomie promptu (D2), knihovna `Vzorky` (D2), Power Automate (D3) jako srovnání.
- Dopředu: agenti odpoledne (Cowork ≠ agent; dashboard v Code vs. analytický dotaz v Agent Builderu), `skills` (D5, stejný `SKILL.md` jako custom skills v Cowork), `copilot-admin` a `monitoring` (D5 — spending policy, CopilotInteraction audit zahrnuje Cowork).
