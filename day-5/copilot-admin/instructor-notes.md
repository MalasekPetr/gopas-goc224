# Instructor notes — Copilot admin

## Timing

- 45 min výklad + 30 min lab. Tohle je modul, kvůli kterému správci na kurz přišli — nespěchat, mapa vrstev musí sednout.

## Před během

- [ ] Proklikat živý tenant: Copilot Settings taby, **Cost management**, Agents sekce, Overview dashboard — **UI se mění po měsících**, slidy vs. realita.
- [ ] Ověřit, že Global Reader otevře Cost management (docs: reader role read-only) — jinak krok 2 labu (Cost management) promítnout.
- [ ] Mít v tenantu aspoň 2–3 agenty (z D4 `copilot-agents` / testovací), ať registr není prázdný a je co blokovat.
- [ ] Ověřit, co přesně Global Reader vidí v sekci Agents (preview oblasti se mění) — určuje rozsah labu.
- [ ] Testovací agent na blokaci (demo) — ne ten, který potřebují pozdější bloky D5 (Studio)!

## Tripwires

- **AI Administrator** role — zdůraznit jako novinku least privilege (správa Copilotu bez Global Admina); ladí s celokurzovým role modelem. Nově **AI Reader** (read-only) — alternativa ke Global Reader pro Copilot/agenty.
- „Copilot Control System" — dnes **Copilot controls**, rámec, ne stránka v admin centru. Studenti název znají ze starších materiálů.
- Researcher/Analyst: součást Copilot licence, admin je může blokovat — ale Researcher zůstává v Tools i při vypnutých agentech; Cowork se v Agents vypnout nedá (přístup = spending policy).
- Agent 365: licencuje se **uživatel**, ne agent (glosář) — čekat dotaz „kolik stojí agent". A „potřebuju Agent 365 na registry?" — ne, registry a základní governance jsou v M365 plánech.
- Nezabřednout do Purview auditu — to je další blok; tady jen říct „usage ≠ audit".

## Vazby

- Zpět: SAM jako SharePoint vrstva (D3) — mapa vrstev na ni naváže; archiv/RCD = „co AI vidí".
- Dopředu: audit → `monitoring` (hned potom); 3rd-party řádek mapy → **Orchestry** (samostatný volitelný blok D5 hned po monitoringu); registr a publikace → `copilot-agents` (**včera, D4** — Agent Store flow).

## Přesunuto z README (samostudium)

- Před během proklikat živý tenant a srovnat se slidy (Copilot Settings taby, Cost management, Agents, Agent 365 dashboard); po Ignite (17.–20. 11. 2026) znovu.
- README má novou kap. 5 „Aplikace z Code — sekce Apps" a řádek Apps v mapě vrstev — při výkladu navázat na krok 4 labu.
- Ověřit názvosloví v UI: README říká **Registry**, lab krok 3 **Agents → All agents** — sjednotit podle živého tenantu.
