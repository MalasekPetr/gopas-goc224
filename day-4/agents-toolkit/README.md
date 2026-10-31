# Microsoft 365 Agents Toolkit

> Typ: povinný · Den: 4 · Odhad: krátký blok — **studenti hands-on, společně** · Publikum: **správci**
> Prostředí: viz [`../../environment.md`](../../environment.md) · Názvosloví: [`../../GLOSSARY.md`](../../GLOSSARY.md)
> Kontext: deklarativní agent, mapa cest a srovnání → [`../copilot-agents/`](../copilot-agents/README.md)

## Co to je

**Microsoft 365 Agents Toolkit** (nástupce Teams Toolkitu; VS Code / Visual Studio) scaffolduje deklarativního agenta **jako kód** — manifest `declarativeAgent.json`. Repo-as-code: git, review, CI/CD, provisioning. Tvorba zdarma a **bez Copilot licence** — MS to od 2026-09 dokumentuje; grounding na org data = licence nebo PAYG; nutné povolené nahrávání vlastních aplikací (Teams admin center → *Upload custom apps*) ([Prerequisites](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/prerequisites)).

> [!NOTE] Pro-code mapa MS
> MS dnes jako doporučený pro-code start uvádí **Work IQ Dev Tools** (preview) a Agents Toolkit „pro nižší úroveň kontroly" ([Choose development tools](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/choose-plugin-development-tools)). Pro náš rámec (agent jako spravovaná konfigurace) zůstáváme u Toolkitu; po Ignite (17.–20. 11. 2026) ověřit.

## Rámec kurzu — správci, ne vývojáři, jen M365

Učíme ho jako **„agent jako spravovaná konfigurace"** — governance a ALM (manifest v gitu, opakovatelný `Provision`, publikace přes schválení), **ne jako vývoj**. **Akce / API plugin / Azure jsou mimo rozsah** — v labu jen pojmenujeme slot `actions`; „udělej něco v tenantu" = Power Automate (D3).

## Knowledge — fakta z manifestu (schema 1.7, ověřeno i v 1.9)

- SharePoint knowledge = **weby / knihovny / složky / soubory**; `list_id` = **knihovna** (ne list), `unique_id` = soubor/složka.
- Aktuální schema **1.9** (2026-09) přidalo `agent_skills` (max 8 odkazů na `SKILL.md`) a capability `Fabric`; 1.8 přidalo EmailActions/MeetingActions ([manifest 1.9](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/declarative-agent-manifest-1.9)). Listy jako knowledge nezná ani 1.9.
- **Strukturovaný list manifest jako knowledge nezná** — tabulková data jen přes `Dataverse` / Copilot konektor / akci. Proto Toolkit nedělá HR list; jeho scénář je čtení runbooků.
- Manifest-only funkce (v žádném UI): `editorial_answers` (až 300 Q&A), `behavior_overrides.special_instructions.discourage_model_knowledge`, `user_overrides`.

## Lab

[`lab-toolkit-agent.md`](lab-toolkit-agent.md) — první agent jako spravovaná konfigurace nad knihovnou `Runbooky`. Scénář: [`../copilot-agents/scenario-support-agent.md`](../copilot-agents/scenario-support-agent.md).

## Zdroje (Microsoft)

[Add knowledge sources (Agents Toolkit)](https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/build-declarative-agents-add-knowledge) · [Declarative agent manifest 1.7](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/declarative-agent-manifest-1.7) · [Declarative agent manifest 1.9](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/declarative-agent-manifest-1.9) · [Agent capabilities & licensing](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/prerequisites) · [Choose development tools](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/choose-plugin-development-tools)

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu — stav k 2026-10.
> Verze Toolkitu (dříve uváděno 6.0) — MS zdroj nenalezen, ověřit; názvy šablon se mění (stavíme „Declarative Agent" bez akce). Manifest 1.9 listy jako knowledge stále nezná — `list_id` je knihovna. **Provisioning i běh deklarativního agenta bez Copilot licence** = empiricky ověřeno na kurzu 2026-07-17 a od 2026-09 i **dokumentováno** (prerequisites); na PAYG ale nefunguje knowledge Email / People / Teams messages / meetings. Work IQ Dev Tools (preview) — po Ignite ověřit, zda nemění doporučenou pro-code cestu.
