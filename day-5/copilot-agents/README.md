# M · Copilot Agents — cesty tvorby agentů

> Typ: povinný · Den: 5 (otvírák) · Odhad: AM blok — vč. živého dema Agent Builderu
> Prostředí: viz [`../../environment.md`](../../environment.md) · Názvosloví: [`../../GLOSSARY.md`](../../GLOSSARY.md)

## Cíle

- Student zná **všechny cesty tvorby agentů** a umí vybrat podle scénáře a publika.
- Student viděl živě stavbu agenta v **Agent Builderu**.
- Student navrhne agenta včetně **plánu vyhodnocení** (lab) — návrat pojmů z D2 (Agent Instructions!).

## Výklad

### Deklarativní agent — společný základ

Deklarativní agent = **instrukce + knowledge + akce** běžící na stejném orchestrátoru a modelech jako Microsoft 365 Copilot — žádný vlastní hosting; dědí ochrany dat Copilotu a prochází RAI validací ([Declarative agents overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/overview-declarative-agent)). Anatomie instrukcí = D2 prompting-fundamentals (purpose → guidelines → skills, 8 000 znaků, XPIA).

### Mapa cest tvorby

```mermaid
flowchart TB
  DA[Deklarativní agent<br>orchestrátor M365 Copilot]
  AB[Agent Builder<br>v M365 Copilot appce] --> DA
  CS[Copilot Studio<br>low-code, další blok] --> DA
  ATK[Agents Toolkit<br>pro-code, repo] --> DA
  SPA[SharePoint agents<br>.agent na webu] --> DA
  SK[Skills — SKILL.md<br>workflow, ne celý agent] -.doplněk.-> DA
```

| Cesta | Pro koho | Tvorba vyžaduje | Distribuce |
|---|---|---|---|
| **Agent Builder** | koncový uživatel | M365 Copilot licence, **nebo tenant s PAYG pro Copilot Studio** ([Agent Builder](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/agent-builder)) | sdílení + org katalog; **ne marketplace** |
| **Copilot Studio** | maker / power user | Copilot Studio přístup (kredity/PAYG) | org katalog přes schválení, marketplace |
| **Agents Toolkit** | vývojář | zdarma (VS Code); repo-as-code | org katalog, marketplace |
| **SharePoint agents** | vlastník obsahu | **tvorba: Copilot licence**; použití: licence NEBO PAYG ([SharePoint agents](https://learn.microsoft.com/en-us/sharepoint/get-started-sharepoint-agents)) | jen web (sdílení do Teams chatu) |
| **Skills** (preview) | uživatel webu | Edit na webu; `SKILL.md` v Agent Assets ([Skills](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-skills)) | v rámci webu |

### Agent Builder — demo v bloku

Lightweight tvorba přímo v M365 Copilot (web/Teams desktop; ne mobil): popis → instrukce → knowledge → publikace. Backend je Copilot Studio. Demo: agent „Průvodce kurzem" nad materiály na webu instruktora.

### Distribuce a governance — most na D4

Org flow: maker publikuje → **Requests** v admin centru → admin Publish/Reject → „Built by your org" v **Agent Store** ([Agent Store](https://learn.microsoft.com/en-us/microsoft-365/copilot/copilot-agent-store), [Publish options](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/publish)). Registry, blokace a Agent 365 — to všechno už znáte z D4 copilot-admin.

## Klíčové rozlišení

- **Agent vs. Skill**: Skill = uložený vícekrokový postup uvnitř Copilot in SharePoint (neumí externí systémy, nepřekročí práva uživatele); agent = samostatná persona s instrukcemi, knowledge a případně akcemi.
- **Tvorba vs. použití** (licenčně!): u SharePoint agentů PAYG uživatel agenta *použije*, ale k *tvorbě* potřebuje Copilot licenci. Stejný vzor „licence gate-uje funkci, permissions gate-ují obsah" z D1.
- **Kde se rozhoduje o kvalitě**: instrukce + popis (generative orchestration vybírá podle popisů — další blok). Proto lab vyžaduje evaluační plán, ne jen nápad.

## Naše prostředí

- Agent Builder demo dělá instruktor; hands-on část labu podle go/no-go (dostupnost Agent Builderu při PAYG bez Copilot licencí — ověřit!). Skills jedou na Edit práva — dostupné všem na vlastním webu.

## Lab

Viz [`lab-agent-design.md`](lab-agent-design.md) — návrh agenta a plán vyhodnocení (+ hands-on).

## Zdroje (Microsoft)

[Declarative agents overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/overview-declarative-agent) · [Agent Builder](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/agent-builder) · [SharePoint agents](https://learn.microsoft.com/en-us/sharepoint/get-started-sharepoint-agents) · [Skills in Copilot in SharePoint](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-skills) · [Agent Store](https://learn.microsoft.com/en-us/microsoft-365/copilot/copilot-agent-store) · [Publish options](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/publish)

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu — stav k 2026-07.
> Skills = preview (Copilot in SharePoint preview). Licenční matice tvorba/použití u SharePoint agentů se může při GA měnit — ověřit tabulku na get-started stránce. Agent Builder dostupnost v PAYG tenantu ověřit živě před během (go/no-go labu).
