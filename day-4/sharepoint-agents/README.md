# SharePoint agents

> Typ: **referenční materiál** k 10min segmentu v [`../agent-builder/`](../agent-builder/README.md) (od 2026-11 už ne samostatný blok) · Den: 4
> Prostředí: viz [`../../environment.md`](../../environment.md) · Názvosloví: [`../../GLOSSARY.md`](../../GLOSSARY.md)
> Kontext: deklarativní agent, mapa cest a srovnání → [`../copilot-agents/`](../copilot-agents/README.md)

> [!WARNING] Ověřit k datu běhu — stav k 2026-10: SharePoint agents se mění
>
> - **Od poloviny listopadu 2026** otevře „Create agent" na webu **Agent Builder** a `.agent` soubor už se neuloží.
> - Stávající `.agent` soubory **přestanou odpovídat po březnu 2027**.
> - Čtyři cesty upgradu: použít přímo **Copilot in SharePoint**, převést agenta na **skill**, upgradovat přes **Agent Builder**, nebo publikovat agenta z **Copilot Studia**. Upgradovaní agenti se sdílejí na úrovni agenta, ne přes SharePoint permissions.
> - **SharePoint agents PAYG platí jen pro `.agent` soubory** — nelicencované použití přechází na PAYG Copilot appky.
>
> Zdroj: [Upgrade SharePoint agents](https://learn.microsoft.com/en-us/sharepoint/upgrade-sharepoint-agents). Tento běh (D4 = 5. 11. 2026) je ještě **před** přechodem — demo níže platí, jen to studentům avizuj jako „legacy cesta".

## Co to je

Agent, kterého staví **vlastník obsahu přímo na SharePoint webu** (`.agent` soubor), bez opuštění webu. Agent **žije s webem** — dědí jeho permissions i lifecycle. Jediná cesta, kde tvůrcem není maker/vývojář, ale vlastník obsahu.

## Limit: 1 zdroj a nic jiného (empiricky)

Přidání dalšího zdroje **odstranilo** ostatní (MC1255409, ověřeno v tenantu 2026-07). MS dokumentace takový limit **neuvádí** ([support článek](https://support.microsoft.com/sharepoint/copilot-in-sharepoint/create-an-agent-in-sharepoint) žádný strop zdrojů nemá) — nenalezeno v MS zdroji / ověřit živě před demem. HR scénář (list + 2 knihovny) se do **jednoho** SharePoint agenta nevejde → buď scopovat na jeden zdroj (např. knihovna `Smlouvy`), nebo víc agentů. **Omezení učí samo sebe** — proto tenhle blok.

## Licence: tvorba vs. použití

- **Tvorba: Copilot licence** → studenti ji od 2026-11 mají, ale cesta je legacy → **jen instruktorské demo** v segmentu Agent Builderu.
- **Použití: licence NEBO PAYG** (meter i pro nelicencované; jen pro `.agent` soubory) — vzor „licence gate-uje funkci, permissions gate-ují obsah" z D1.

## Distribuce

Jen web (+ sdílení do Teams chatu). Žádný org katalog / marketplace / source control.

## Lab

[`lab-sharepoint-agent.md`](lab-sharepoint-agent.md) — instruktor demo: single-source limit naživo. Scénář: [`../copilot-agents/scenario-hr-agent.md`](../copilot-agents/scenario-hr-agent.md).

## Zdroje (Microsoft)

[SharePoint agents](https://learn.microsoft.com/en-us/sharepoint/get-started-sharepoint-agents) · [Upgrade SharePoint agents](https://learn.microsoft.com/en-us/sharepoint/upgrade-sharepoint-agents) · [Create an agent in SharePoint (support)](https://support.microsoft.com/sharepoint/copilot-in-sharepoint/create-an-agent-in-sharepoint) · [MC1255409 — Lists as knowledge source](https://mc.merill.net/message/MC1255409)

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu — stav k 2026-10.
> Podpora listů: GA ~05/2026 (MC1255409), ale admin dokumentace to nereflektuje — ukázat jako příklad docs lag. Limit „1 zdroj" = empirický, MS ho nedokumentuje. Licence: Learn uvádí tvorbu = Copilot licence, support článek připouští licenci nebo PAYG — MS si odporuje. **Od pol. 11/2026 tvorba přes Agent Builder, `.agent` končí po 03/2027** → po Ignite (17.–20. 11. 2026) blok přehodnotit (rozhodnutí autora: legacy demo / segment „upgrade cesty").
