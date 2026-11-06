# Agenda — pořadí bloků

Jediný zdroj pravdy o pořadí modulů. Složky jsou slugy uložené ve složce dne; pořadí v rámci dne drží tato tabulka.

**5 dní · ~4–8 bloků/den.** P = povinný, V = volitelný.

## Den 1 — Foundation

| # | Blok | Slug | Typ |
|---|---|---|---|
| 1 | Onboarding & pravidla práce *(celé dopoledne)* | `day-1/onboarding` | P |
| 2 | Formáty: JSON, MD, YAML | `day-1/formats` | P |
| 3 | SharePoint technologický úvod | `day-1/sharepoint-intro` | P |
| 4 | Informační architektura SPO | `day-1/opt-ia-spo` | V |
| 5 | AI landscape a pozicování Copilotu | `day-1/ai-landscape` | P |
| 6 | Licenční modely a řízení nákladů | `day-1/licensing` | P |

## Den 2 — Prompting, scripting & konfigurace

| # | Blok | Slug | Typ |
|---|---|---|---|
| 1 | Základy promptování a agentní anatomie | `day-2/prompting-fundamentals` | P |
| 2 | SharePoint PowerShell (SPO module) | `day-2/powershell-spo` | P |
| 3 | Konfigurace krok za krokem | `day-2/configuration` | P |
| 4 | Základy Document processing for Microsoft 365 *(největší blok dne — živá konfigurace + dema autofill columns a image tagging)* | `day-2/document-processing` | P |

> [!NOTE] Prompting hned ráno — studenti používají Copilot od D1, prompt literacy se úročí celý týden (a šetří Copilot Credits). PowerShell je scripting-literacy opener před konfiguračními moduly.

## Den 3 — Obsahové služby, governance & ochrana dat

| # | Blok | Slug | Typ |
|---|---|---|---|
| 1 | Scénáře eSignature | `day-3/esignature` | P |
| 2 | SharePoint Advanced Management (SAM) | `day-3/advanced-management` | P |
| 3 | Microsoft 365 Backup | `day-3/backup` | P |
| 4 | Microsoft 365 Archive | `day-3/archive` | P |
| 5 | Skills — rozšíření Copilot in SharePoint *(studenti hands-on)* | `day-3/skills` | P |

> [!NOTE] Dějová linka dne: eSignature → SAM politiky (nit „nástroje pro správu", pokračuje v D5 `copilot-admin`) → ochrana dat (backup → archive) → Skills jako most k agentům v D4. Orientačně ~370 min.

## Den 4 — Automatizace, Copilot, který koná, & tvorba agentů

| # | Blok | Slug | Typ |
|---|---|---|---|
| 1 | Power Automate — příchozí faktury *(jen výklad + demo; akcent Azure AI Document Intelligence jako alternativa)* | `day-4/power-automate-invoices` | P |
| 2 | Pro-code vs. low-code agenti a vzory rozšíření | `day-4/procode-vs-lowcode` | P |
| 3 | Cowork — Copilot, který koná *(studenti hands-on)* | `day-4/cowork` | P |
| 4 | Code — Copilot, který staví *(studenti hands-on, Frontier)* | `day-4/code` | P |
| 5 | Přístup jiných AI k datům tenantu — aplikační registrace, podnikové aplikace, consent, agent identity *(audit + demo)* | `day-4/ai-app-access` | P |
| 6 | Agenti — mapa cest tvorby *(úvod: deklarativní agent, srovnání, návrhový lab)* | `day-4/copilot-agents` | P |
| 7 | Agent Builder *(studenti hands-on)* | `day-4/agent-builder` | P |
| 8 | Microsoft 365 Agents Toolkit *(agent jako spravovaná konfigurace; + agent volající agenta přes `worker_agents`)* | `day-4/agents-toolkit` | P |
| 9 | SharePoint agents *(instruktorské demo — legacy `.agent`, podpora končí 03/2027)* | `day-4/opt-sharepoint-agents` | V |

> [!NOTE] Od běhu 2026-11: Backup, Archive a Skills přesunuté do D3; Power Automate a procode do D4 (vyvážení zátěže). Cowork a Code jsou samostatné moduly. SharePoint agents jsou volitelné — „Create agent" na webu od pol. 11/2026 otevírá Agent Builder a `.agent` soubory přestanou odpovídat po 03/2027. Nový blok `ai-app-access` (převzatý a rozšířený z GOC223). D4 je nejplnější den (~470 min bez volitelného bloku) — viz instructor notes `cowork` / `code` pro zkrácení.

## Den 5 — Správa, stavba & rollout

| # | Blok | Slug | Typ |
|---|---|---|---|
| 1 | Copilot Studio — stavba nad SharePointem + Copilot Credits *(celé dopoledne, ~3 h)* | `day-5/copilot-studio` | P |
| 2 | Nástroje pro správu Copilotu a agentů (M365 AC: Copilot & Agents, Agent 365, 3rd-party mapa) | `day-5/copilot-admin` | P |
| 3 | Provozní monitoring a compliance | `day-5/monitoring` | P |
| 4 | Orchestry — governance/provisioning (3rd-party) | `day-5/opt-orchestry` | V |
| 5 | Závěrečný projekt a další kroky *(rollout blueprint)* | `day-5/capstone` | P |

> [!NOTE] D5 dopoledne dokončí **stavbu** agentů v Copilot Studiu (GitHub Copilot harness) včetně výkladu Copilot Credits a reálné ceny labu. Odpoledne se správa (copilot-admin → monitoring → volitelná Orchestry) dívá na agenty, které studenti právě postavili, a den uzavírá **rollout blueprint** (capstone). Oblouk „postavili jste — teď to řídíte — a plánujete nasazení".
