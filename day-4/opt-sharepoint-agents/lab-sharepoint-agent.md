# Lab · SharePoint agent — limit jednoho zdroje (demo)

> Modul: opt-sharepoint-agents · Odhad: 20 min · Režim: **instruktorské demo** (studenti sledují + predikují)
> Scénář a data: [`../copilot-agents/scenario-hr-agent.md`](../copilot-agents/scenario-hr-agent.md)

## Cíl

Vidět SharePoint agent naživo a pochopit jeho **limit — 1 zdroj a nic jiného** (empiricky, MS ho nedokumentuje) — a proč se do něj HR scénář (list + 2 knihovny) nevejde.

> [!WARNING] Ověřit k datu běhu — stav k 2026-10
> Od pol. 11/2026 otevře „Create agent" Agent Builder a `.agent` soubor nevznikne; `.agent` přestanou odpovídat po 03/2027 ([Upgrade SharePoint agents](https://learn.microsoft.com/en-us/sharepoint/upgrade-sharepoint-agents)). Pokud už UI v tenantu přepnulo, použij fallback.

> [!IMPORTANT] Proč jen demo
> Tvorba SharePoint agenta vyžaduje **Copilot licenci** — bez licence ho uživatel na PAYG může *používat*, ne *tvořit* (ověřeno). Legacy cesta → staví instruktor, studenti sledují a predikují.

## Předpoklady

- Data na `/sites/hr-demo`: knihovna `Smlouvy` (+ list `Zaměstnanci`).
- Instruktorský účet s Copilot licencí.

## Kroky (instruktor)

1. Na `/sites/hr-demo` → **Create agent**; scope omez na **jednu knihovnu** `Smlouvy`.
2. Dotaz „najdi podepsanou pracovní smlouvu pro 10024" → projde (hledání v knihovně).
3. Dotaz „ukaž údaje osobního čísla 10018" (list) → agent na list nevidí.
4. **Zkus přidat list `Zaměstnanci` jako druhý zdroj** → ukáž, že to **shodí** knihovnu (MC1255409; pokud se chování změnilo, je to živý příklad „docs vs. realita" — zapsat).
5. Predikce třídy: kolik agentů by HR scénář potřeboval? (list + 2 knihovny = víc agentů, nebo jiná cesta.)

## Ověření

- [ ] Studenti zaznamenali: SharePoint agent = **1 zdroj**, přidání druhého shodí první.
- [ ] Formulováno, proč se HR scénář do jednoho SP agenta nevejde.
- [ ] Zmíněn licenční gate (tvorba = Copilot licence, použití = i PAYG — PAYG jen pro `.agent`).
- [ ] Zmíněn přechod: od pol. 11/2026 tvorba přes Agent Builder, `.agent` končí po 03/2027.

## Fallback

- Bez licence/tenantu: promítnout přípravné screenshoty; třída jen predikuje chování a pak se ověří proti záznamu.
- „Create agent" už otevírá Agent Builder (přechod dorazil dřív): ukázat nové chování jako lekci o rychlosti změn, limit 1 zdroje vysvětlit nad screenshoty.
