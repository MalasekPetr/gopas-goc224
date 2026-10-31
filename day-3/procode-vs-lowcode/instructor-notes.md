# Instructor notes — Pro-code vs. low-code

## Timing

- 45 min výklad + 30 min lab + 10 min sdílení návrhů. Závěr dne — energie bude nízká, lab je diskusní, ne klikací.

## Tripwires

- **Neučit vyřazené**: add-in model (v SPO skončil 2. 4. 2026), TeamsFx SDK (support skončil 9/2026), „in a folder" triggery. Když se student zeptá na add-iny — „v SharePoint Online už nefungují, náhrada SPFx".
- SPFx 1.24 / Copilot UX components zmínit jednou větou jako novou hranu mapy (UI agenta v Copilotu, jen s Copilot licencí) — ne demo.
- Názvy: **Microsoft 365 Agents Toolkit** (ne Teams Toolkit), **Copilot connectors** (ne Graph connectors), **Agents SDK** (ne TeamsFx).
- Nezabřednout do SPFx detailů (toolchain, Heft…) — tady jde o rozhodovací mapu, ne o kurz vývoje.
- Custom connector sdílení: Power Automate + Power Apps + Copilot Studio ano, Logic Apps ne — častý dotaz.

## Lab

- Scénář A je nejsilnější (váže na Document Intelligence akcent z bloku 3) — nasměrovat tam většinu.
- Hlídat, ať kontrakt akce nesklouzne do vymýšlení celého API — 1 operace stačí.

## Vazby

- Zpět: demo flow (blok 3), Document Intelligence akcent, formáty (OpenAPI = JSON/YAML, D1).
- Dopředu: deklarativní vs. custom engine agent → D4 `copilot-agents` (hned zítra, 3. blok dne); repo-as-code přístup → D5 capstone.
