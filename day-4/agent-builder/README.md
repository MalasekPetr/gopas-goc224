# Agent Builder

> Typ: povinný · Den: 4 · Odhad: krátký blok — vč. živého dema · Kdo staví: **studenti hands-on**
> Prostředí: viz [`../../environment.md`](../../environment.md) · Názvosloví: [`../../GLOSSARY.md`](../../GLOSSARY.md)
> Kontext: deklarativní agent, mapa cest a srovnání → [`../copilot-agents/`](../copilot-agents/README.md)

## Co to je

Lightweight tvorba deklarativního agenta **přímo v M365 Copilot appce** (web / Teams desktop; ne mobil): popis → instrukce → knowledge → publikace. Backend je Copilot Studio. **Nulová bariéra** — agent za pár minut, bez opuštění appky.

## Knowledge a strop

- **1 SharePoint list** (20k položek / 50 MB; přílohy se neindexují) + soubory/složky/weby (≤ 100).
- **Bez analytiky** — zdroje umí jen *prioritizovat*, ne agregovat/filtrovat („Only use specified sources" negarantuje úplný výčet). Dotazy typu „kolik/kdo/kdy" → **Copilot Studio (D5)**.
- **Bez akcí do externích služeb** — Builder je neumí; pro akce, konektory a workflow MS doporučuje „copy the agent to Copilot Studio" ([Agent Builder](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/agent-builder)).
- **Skills** (`SKILL.md`) lze k agentovi připojit (preview, max 8; [Add skills](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/agent-builder-add-skills)) — stejný formát jako Skills v Copilot in SharePoint (D5).
- Na PAYG bez licence nejsou dostupné knowledge zdroje Email / People / Teams messages / Teams meetings ([Prerequisites](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/prerequisites)).

## Kdo / licence / distribuce

- **Koncový uživatel.** Tvorba: M365 Copilot licence **nebo** tenant s PAYG pro Copilot Studio (u nás go/no-go — ověřit).
- Distribuce: sdílení + **org katalog** (Requests → admin), **ne marketplace**. Pozor: sdílením agenta s embedded soubory sdílíš i jejich obsah.
- Od pol. 11/2026 sem vede i „Create agent" na SharePoint webu (nástupce `.agent`, viz [`../sharepoint-agents/`](../sharepoint-agents/README.md)).

## Demo a lab

- Demo v bloku: HR Asistent nad instruktorským webem (popis → instrukce → knowledge → test).
- Lab: [`lab-agent-builder.md`](lab-agent-builder.md) — HR Asistent hands-on + evaluační plán.
- Scénář a data: [`../copilot-agents/scenario-hr-agent.md`](../copilot-agents/scenario-hr-agent.md) · srovnání cest: [`../copilot-agents/comparison-agent-paths.md`](../copilot-agents/comparison-agent-paths.md).

## Zdroje (Microsoft)

[Agent Builder](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/agent-builder) · [Agent Builder — knowledge](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/agent-builder-add-knowledge) · [Agent Builder — skills](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/agent-builder-add-skills) · [Agent capabilities & licensing](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/prerequisites)

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu — stav k 2026-10.
> Dostupnost Agent Builderu v PAYG tenantu (bez Copilot licencí) ověřit živě před během — určuje, jestli studenti staví sami, nebo je to instruktorské demo. UI labely se mění. Skills v Builderu = preview. Od pol. 11/2026 přebírá tvorbu SharePoint agentů — po Ignite (17.–20. 11. 2026) projet.
