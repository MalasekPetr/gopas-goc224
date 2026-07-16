# Lab · HR Asistent — Agent Builder (hands-on) + SharePoint agent (demo)

> Modul: copilot-agents · Odhad: 45 min · Režim: **studenti hands-on v Agent Builderu** (dle go/no-go) + **instruktor ukáže** SharePoint agent
> Scénář a data: [`scenario-hr-agent.md`](scenario-hr-agent.md) · Srovnání cest: [`comparison-agent-paths.md`](comparison-agent-paths.md)

## Cíl

Postavit agenta **HR Asistent** v **Agent Builderu** (studenti) nad daty zaměstnanců a vidět, kde je jeho strop — a jak se od něj liší **SharePoint agent** (instruktor). Analytiku, kterou ani jeden neumí, prolomí zítra Copilot Studio (D5).

## Předpoklady

- Data na HR webu (`/sites/hr-demo`): list `Zaměstnanci` + knihovny `Certifikáty`/`Smlouvy`.
- Agent Builder dostupný pro studenty (go/no-go instruktora — PAYG tenant).
- Návrh instrukcí z [`lab-agent-design.md`](lab-agent-design.md).

> [!IMPORTANT] Kdo co staví
> **Agent Builder = studenti** (hands-on). **SharePoint agent = jen instruktor ukáže** — jeho tvorba vyžaduje Copilot licenci, studenti na Business Basic + PAYG ho netvoří (ověřeno). **Toolkit má vlastní lab** [`lab-toolkit-agent.md`](lab-toolkit-agent.md) na scénáři Support (runbooky, bez akce).

## Kroky

### Část A — evaluační plán (všichni, psací)

1. Napiš **5 testovacích dotazů** pro HR Asistenta. Povinně:
   - 1 **lookup** („údaje a manažer osobního čísla 10018"),
   - 1 **hledání v souboru** („najdi podepsanou pracovní smlouvu pro 10024"),
   - 1 **analytický** („komu propadá certifikát do 30 dnů") — očekávej, že v D4 **selže**,
   - 1 **negativní test** (na co NEMÁ odpovídat),
   - 1 **test hranice práv** (řadový zaměstnanec chce cizí mzdový výměr → „no response").
2. Ke každému dotazu **očekávaný výsledek** + **kritérium úspěchu** (kolik z 5 musí projít).

### Část B — Agent Builder (studenti hands-on)

3. V Copilot appce → **Vytvořit agenta**; instrukce z části A (D2: purpose → guidelines). **Instrukce ≠ knowledge.**
4. **Knowledge:** list `Zaměstnanci` + knihovny `Certifikáty`/`Smlouvy`.
5. Spusť **5 testů** z části A, zapiš skóre (x/5).
6. Ověř na vlastní kůži: dotaz 1 a 2 projdou, **analytický dotaz 3 nedá spolehlivý výčet** (Builder zdroje jen prioritizuje). Zapiš, co přesně vrátil.
7. Udělej **jednu iteraci** instrukcí/popisu a změř efekt na nejhorší test (iterace = D2 lekce).

### Část C — SharePoint agent (instruktor ukáže)

8. Instruktor na `/sites/hr-demo` založí agenta scopovaného na **jednu knihovnu** `Smlouvy`; dotaz 2 projde, dotaz 1 (list) ne.
9. Instruktor **zkusí přidat list jako druhý zdroj** → shodí knihovnu (MC1255409). Pointa: **1 zdroj a nic jiného** — HR scénář se do jednoho SP agenta nevejde.

### Reflexe — most do D5

10. Dotaz 3 a 4 (analytika) neprošly u žádné dnešní cesty. Kdo je umí? **Zítra Copilot Studio** nad týmiž daty.

## Ověření

- [ ] Evaluační plán má lookup, hledání v souboru, analytický, negativní a test hranice práv.
- [ ] Student zapsal skóre Agent Builderu (x/5) + jednu iteraci se změřeným efektem.
- [ ] Zaznamenáno, že analytický dotaz v D4 selhal a proč (Builder neagreguje).
- [ ] Test hranice práv dopadl „no response" (permission trimming).

## Fallback

- Agent Builder nedostupný pro studenty (go/no-go): část A je plnohodnotný deliverable; instruktor postaví HR agenta v demu, třída píše predikce a pak se ověří. SharePoint agent je tak jako tak instruktorské demo.

## PAYG poznámka

Každý testovací dotaz = Copilot Credits. 5 promyšlených testů + 1 iterace, ne brute-force ladění (viz `environment.md`).
