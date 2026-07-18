# GOC224 — website content (gopas.eu)

> [!NOTE] Editor note
> Each "##" heading below corresponds to one field on the course page; the text under it is the content for that field. "Editor note" blocks themselves are not page content — do not copy them to the website.

Compared to the currently live page: the title now includes "Agents" and drops "SharePoint Premium" (that brand was split by Microsoft into separate products — Document processing, SharePoint Advanced Management, Microsoft 365 Backup/Archive, Copilot in SharePoint...); the outline adds modules missing from the current page — Agent Builder, SharePoint agents, Microsoft 365 Agents Toolkit, Skills, and Copilot Studio as its own item.

## URL

`microsoft-365-managing-sharepoint-copilot-agents-and-content-services_goc224`

> [!NOTE] Editor note
> New slug (drops "sharepoint-premium"). Set up a 301 redirect from the current `microsoft-365-managing-sharepoint-copilot-and-sharepoint-premium_goc224`.

## Course title

Microsoft 365: Managing SharePoint Copilot, Agents, and Content Services

## Short description (meta description / teaser)

A hands-on five-day course on deploying and managing SharePoint Copilot, AI agents, and Microsoft 365 content services — from licensing through configuration and governance to operational monitoring and a rollout blueprint.

## Course overview

This course takes administrators and architects through the full deployment cycle of Microsoft 365 Copilot on SharePoint: from orientation in the AI landscape and licensing models, through step-by-step tenant configuration, to content services (eSignature, backup, archive) and the governance layer (SharePoint Advanced Management). A dedicated block covers automation — Power Automate and the choice between pro-code and low-code extensibility. The core of the course is agent creation: participants work through every creation path (the creation-path map, Agent Builder, SharePoint agents, Microsoft 365 Agents Toolkit) and their subsequent administration (Copilot Control System, Agent 365, operational monitoring). The course closes with building an agent in Copilot Studio and a personal rollout blueprint for the participant's own organization.

## Who this course is for

- SharePoint / Microsoft 365 administrators and solution architects
- Governance, compliance, and platform owners
- Automation practitioners (low-code and pro-code)

## Format and duration

- 5 days, instructor-led, with hands-on labs in a test tenant
- Level: advanced

> [!NOTE] Editor note
> Price intentionally omitted — GOPAS sales fills it in directly in the CMS/price list.

## Course outline

### Day 1 — Foundation

- **Onboarding & working rules** — introduction to the course environment and collaboration rules.
- **Formats: JSON, MD, YAML** — literacy in the formats used throughout the course (configuration, documentation, Skills).
- **SharePoint technology introduction** — SharePoint Online architecture as a content and AI platform.
- **AI landscape and positioning Copilot** — history of AI/LLMs, responsible AI principles, web-grounded vs. tenant-grounded, where Copilot in SharePoint fits.
- **Licensing models and cost posture** — Copilot licensing tiers, the two PAYG models, the licensing-vs-permissions principle.

> Optional, time permitting: SharePoint Online information architecture.

### Day 2 — Prompting, Scripting & Configuration

- **Prompting fundamentals and agent anatomy** — prompt structure, the Orchestrator's role, Prompt/Context/custom instructions/Memory/Agent Instructions.
- **SharePoint PowerShell (SPO module)** — installing and connecting the SPO Management Shell, reading tenant state, reporting scripts.
- **Step-by-step configuration** — the sequence for enabling Copilot in SharePoint (PAYG billing → enablement → scope → verification), `KnowledgeAgentScope`.
- **Document processing for Microsoft 365 (fundamentals)** — the service family (OCR, autofill columns, image tagging, etc.) and its PAYG licensing; live configuration and demo.

### Day 3 — Content Services, Governance & Automation

- **eSignature scenarios** — SharePoint eSignature within the Document processing family, eIDAS signature levels, the approval/signing flow.
- **SharePoint Advanced Management (SAM)** — the three pillars of SAM, choosing a policy for a governance problem, licensing as tenant readiness for Copilot.
- **Power Automate — incoming invoices** — the end-to-end flow (receipt → extraction → approval → storage), three extraction paths including Azure AI Document Intelligence.
- **Pro-code vs. low-code agents and extensibility patterns** — choosing the extensibility layer (connector / Power Automate / SPFx / Graph), current dev tools.

### Day 4 — Data Protection & Agent Creation

- **Microsoft 365 Backup** — scope (SharePoint, OneDrive, Exchange), RPO/RTO, recovery planning.
- **Microsoft 365 Archive** — cold-data strategy, interplay with retention, eDiscovery, and Copilot.
- **Agents — the creation-path map** — an overview of every agent-creation path, the declarative agent, designing with an evaluation plan.
- **Agent Builder** — lightweight declarative agent creation directly inside the M365 Copilot app (hands-on).
- **SharePoint agents** — an agent built by the content owner directly on the site, inheriting the site's permissions and lifecycle.
- **Microsoft 365 Agents Toolkit** — an agent as managed configuration, repo-as-code (manifest, version control, provisioning).

### Day 5 — Administration, Building & Rollout

- **Tools for managing Copilot and agents** — the Copilot Control System, the Agents section of the M365 admin center, Agent 365.
- **Operational monitoring and compliance** — the audit trail in Purview, sources of operational signal, an incident runbook.
- **Skills — extending Copilot in SharePoint** — the anatomy of `SKILL.md`, designing and reviewing a Skill, governance without an admin switch.
- **Copilot Studio — building on SharePoint** — an agent with SharePoint knowledge, generative vs. classic orchestration, DLP.
- **Capstone & next steps** — a rollout blueprint: a design document for deploying Copilot and content services, an adoption roadmap.

> Optional, time permitting: Orchestry — third-party governance and provisioning.

## Course outcome

Participants leave with their own rollout blueprint — a deployment design for Microsoft 365 Copilot, agents, and content services for their organization, covering configuration, automation, governance, risks, and an adoption plan.

## Pre-publish checklist for the editor

- [ ] Set up a 301 redirect from the current `microsoft-365-managing-sharepoint-copilot-and-sharepoint-premium_goc224` to the new URL listed above.
- [ ] Fill in the course price (GOPAS sales).
- [ ] Verify product names and PAYG rates are current — Microsoft changes licensing bundles and pricing on a month-to-month basis.
- [ ] Check that no "Editor note" block was left copied into the published text.
