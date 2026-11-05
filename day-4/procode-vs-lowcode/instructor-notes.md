# Instructor notes — Pro-code vs. low-code

## Timing

- 45 min výklad + 30 min lab + 10 min sdílení návrhů. Dopolední blok D4 — lab je diskusní, ne klikací; navazuje přímo na demo flow.

## Tripwires

- **Neučit vyřazené**: add-in model (v SPO skončil 2. 4. 2026), TeamsFx SDK (support skončil 9/2026), „in a folder" triggery. Když se student zeptá na add-iny — „v SharePoint Online už nefungují, náhrada SPFx".
- SPFx 1.24 / Copilot UX components zmínit jednou větou jako novou hranu mapy (UI agenta v Copilotu, jen s Copilot licencí) — ne demo.
- Tabulka „Aplikace pro uživatele" (~5 min): pointa je **kdo platí běh** a **kde výsledek žije** (Managed Runtime vs. HTML page vs. SPFx). HTML pages jsou do konce 12/2026 v GA rolloutu — před během ověřit, že je tenant má (*+ New → HTML page* na studentském webu).
- Názvy: **Microsoft 365 Agents Toolkit** (ne Teams Toolkit), **Copilot connectors** (ne Graph connectors), **Agents SDK** (ne TeamsFx).
- Nezabřednout do SPFx detailů (toolchain, Heft…) — tady jde o rozhodovací mapu, ne o kurz vývoje.
- Custom connector sdílení: Power Automate + Power Apps + Copilot Studio ano, Logic Apps ne — častý dotaz.

## Lab

- Scénář A je nejsilnější (váže na Document Intelligence akcent z bloku 3) — nasměrovat tam většinu.
- Hlídat, ať kontrakt akce nesklouzne do vymýšlení celého API — 1 operace stačí.

## Vazby

- Zpět: demo flow (předchozí blok `power-automate-invoices`), Document Intelligence akcent, formáty (OpenAPI = JSON/YAML, D1).
- Dopředu: deklarativní vs. custom engine agent → D4 `copilot-agents` (týž den odpoledne); repo-as-code přístup → D5 capstone.

## Přesunuto z README (2026-11)

- Dev nástroje (Agents Toolkit, SPFx toolchain) jen ukázat, neinstalovat.
- SPFx 1.25 (12/2026–1/2027, SPFx CLI místo Yeomana) do výkladu nepatří — jen pro případ dotazu.
- Po Ignite (17.–20. 11. 2026) projet delta sekci README.
