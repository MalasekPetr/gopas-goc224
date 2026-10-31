# Výklad · AI subprocesoři v Microsoft 365 Copilot (OpenAI, Anthropic, xAI, EU Data Boundary)

> Modul: copilot-admin · Doplněk k sekci „AI providers" v Copilot → Settings → Data access · Governance/compliance téma (ISO 27001, datová suverenita)
> Prostředí: viz [`../../environment.md`](../../environment.md) · Názvosloví: [`../../GLOSSARY.md`](../../GLOSSARY.md)

Microsoft 365 Copilot používá modely provozované Microsoftem (Azure OpenAI) a vedle nich **modely provozované třetími stranami**. Pro compliance je klíčové vědět **kdo data zpracovává, kde, a zda to opouští Microsoft boundary.**

## Přehled poskytovatelů (stav 2026-10)

| Poskytovatel | Role | EU Data Boundary | Default v EU | Zdroj |
|---|---|---|---|---|
| **Azure OpenAI** (provozuje Microsoft) | Microsoft | uvnitř | zapnuto | — |
| **OpenAI** (provozuje OpenAI) | Microsoft **subprocesor** (od 07/2026) | **uvnitř** (s výhradami EUDB dokumentace); mimo in-country processing | **zapnuto** (od 24. 7. 2026) | [OpenAI subprocessor](https://learn.microsoft.com/en-us/microsoft-365/copilot/openai-subprocessor) |
| **Anthropic** (běžné modely) | Microsoft **subprocesor** | **mimo** | vypnuto | [Anthropic models](https://learn.microsoft.com/en-us/microsoft-365/copilot/connect-to-ai-subprocessor) |
| **Anthropic models with Data Retention** | **nezávislý procesor** | mimo | vypnuto všude | tamtéž |
| **xAI (Grok)** v Cowork | **nezávislý procesor** | mimo | — | [Cowork models](https://learn.microsoft.com/en-us/copilot/cowork/cowork-models) |

> [!IMPORTANT] Cowork v EU tenantu
> „If your organization is within the EU Data Boundary, only GPT models are supported." — v Cowork tedy EU tenant Claude ani Grok nevybere ([Cowork models](https://learn.microsoft.com/en-us/copilot/cowork/cowork-models)).

## OpenAI jako Microsoft subprocesor

- Od 2026-07 může Microsoft vedle Azure OpenAI používat i modely **provozované přímo OpenAI** — pod Microsoft DPA a Product Terms, s Enterprise Data Protection.
- Default **zapnuto** pro způsobilé komerční zákazníky (od 24. 7. 2026); vypíná se volbou *No users*. Modely přes Azure OpenAI se tím nevypínají — vypnutí jen odebere funkce/modely dostupné výhradně přes OpenAI.
- Uvnitř EU Data Boundary, ale **mimo in-country processing** závazky.

## Anthropic jako Microsoft subprocesor

- Anthropic je **onboardovaný Microsoft subprocesor** — běžné modely spadají pod **Microsoft Product Terms + DPA** (Enterprise Data Protection, Customer Copyright Commitment platí).
- Plochy, kde se Anthropic modely *můžou* použít po zapnutí: **Microsoft 365 Copilot (apps + chat), Researcher, Copilot Studio, Power Platform, Copilot in Microsoft 365 apps, SharePoint AI capabilities**. Konkrétní ukázky: Researcher, Copilot v Excelu (Edit), Copilot Cowork, výběr modelu v Copilot Studiu.
- **UI indikátor**: v Copilotu je vidět, když zrovna běží Claude.

## Kde se to zpracovává (nosné pro suverenitu)

> [!WARNING] Data opouštějí Microsoft boundary
> Anthropic inference **neběží na Azure** — data jdou z Azure na **Anthropic infra (AWS/GCP), převážně v USA**, a jsou **vyřazena z EU Data Boundary** i in-country závazků. Když Anthropic zapnete, porušíte „data zůstávají v Microsoft/Azure" — flagovat u zákazníků.

## Default podle regionu

- **EU / EFTA / UK: VYPNUTO ve výchozím stavu** (opt-in). → naše české tenanty default off.
- Zbytek komerčního cloudu: on-by-default. GCC/GCC High/DoD a další sovereign cloudy: Anthropic nedostupný (federal GCC/High/DoD), non-federal GCC opt-in od 22. 7. 2026.

## Subprocesor vs. nezávislý procesor

| | Kdo zpracovává | Terms | Retence | Default |
|---|---|---|---|---|
| **Běžné Anthropic modely** | Microsoft **subprocesor** | Microsoft DPA/Product Terms | dle Microsoft | dle regionu (EU off) |
| **Anthropic models with Data Retention** (např. Claude Fable 5, Mythos 5) | Anthropic jako **nezávislý procesor** | **Anthropic** Commercial Terms + DPA | Anthropic drží data (30 dní; flagovaný obsah až 2 roky / skóre 7 let) | **vždy off, jen explicitní opt-in** |

> [!IMPORTANT] Názvosloví
> Dřívější štítek „Preview models with Data Retention" se dnes jmenuje **„Anthropic models with Data Retention"**. „Fable-class" modely se dělí: **Fable 5.1** může u způsobilých organizací běžet v režimu **subprocesoru** (Microsoft DPA, bez retence u Anthropicu, stačí zapnutý Anthropic); jiné Fable-class modely jsou „with Data Retention" ([Anthropic models](https://learn.microsoft.com/en-us/microsoft-365/copilot/connect-to-ai-subprocessor)).

Pro citlivá zákaznická data = Anthropic models with Data Retention **tvrdé ne** bez samostatného posouzení a souhlasu.

## Kde se to ovládá

M365 admin center → **Copilot → Settings → Data access** ([Configure Copilot settings](https://learn.microsoft.com/en-us/microsoft-365/copilot/configure-copilot-admin-center)):

- **„AI providers operating as Microsoft subprocessors"** → OpenAI, Anthropic: zapnout/vypnout, přiřadit per uživatel/skupina (security group).
- **„AI providers operating as independent processors"** → poskytovatelé pod vlastními podmínkami (např. xAI, Anthropic models with Data Retention).

Role **AI Administrator** nebo Global Admin. Pro Copilot Studio / Power Platform navíc kontrola v **Power Platform admin centru** (Allow external LLMs).

> [!WARNING] MS si odporuje — per-group scoping Anthropicu
> [Anthropic models](https://learn.microsoft.com/en-us/microsoft-365/copilot/connect-to-ai-subprocessor) uvádí přiřazení per uživatel/skupina, [Cowork models](https://learn.microsoft.com/en-us/copilot/cowork/cowork-models) píše, že nastavení je **tenant-wide** a nejde jím dát Anthropic jen podmnožině uživatelů. Neřešit za MS — v tenantu ověřit, jak se to chová v Cowork vs. jinde.

> [!WARNING] Copilot Studio — výběr modelu = suverenitní rozhodnutí
> V Copilot Studiu vybírá model **tvůrce agenta** (GPT, Claude a další). Volba modelu provozovaného mimo Azure může znamenat zpracování mimo geografii tenantu — u zákaznických agentů flagovat a dokumentovat.

## A Skills / Copilot in SharePoint?

**Copilot in SharePoint běží na Microsoft-managed modelu od OpenAI, model se nekonfiguruje** ([get-started](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started#models)). Skills tedy **na Anthropicu nezávisí** — v této cestě se Claude aktuálně nepoužívá. Anthropic je věc *jiných* Copilot ploch a je řízený výše uvedeným přepínačem.

## Pro ISO 27001 / zákaznická review

- Ověřit stav obou přepínačů „AI providers" v tenantu zákazníka (Anthropic v EU = default off; **OpenAI subprocesor = default on**).
- Zapnutí Anthropicu = **transfer mimo EUDB** → dokumentovat, získat souhlas, zvážit dopad na registr zpracování.
- OpenAI subprocesor: uvnitř EUDB, ale mimo in-country processing — relevantní pro zákazníky s požadavkem na zpracování v ČR/konkrétní zemi.
- Anthropic models with Data Retention a nezávislé procesory (xAI) držet vypnuté, pokud nejsou samostatně schváleny.

## Zdroje (Microsoft)

[Anthropic models in Microsoft Online Services](https://learn.microsoft.com/en-us/microsoft-365/copilot/connect-to-ai-subprocessor) · [OpenAI as a subprocessor](https://learn.microsoft.com/en-us/microsoft-365/copilot/openai-subprocessor) · [Cowork models](https://learn.microsoft.com/en-us/copilot/cowork/cowork-models) · [Configure Copilot settings](https://learn.microsoft.com/en-us/microsoft-365/copilot/configure-copilot-admin-center) · [Overview of AI Subprocessors](https://learn.microsoft.com/en-us/microsoft-365/copilot/copilot-subprocessor-overview) · [Copilot in M365 apps with Anthropic models](https://learn.microsoft.com/en-us/microsoft-365/copilot/copilot-anthropic-apps) · [Microsoft Online Services Subprocessors List](https://aka.ms/subprocessor)

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu — stav k 2026-10.
> Přibyl OpenAI jako subprocesor (default on, uvnitř EUDB) a xAI jako nezávislý procesor v Cowork; „Preview models with Data Retention" → „Anthropic models with Data Retention". Default-on rollout mimo EU/UK a data se hýbou; docs `connect-to-ai-subprocessor` (ms.date 2026-09) a `openai-subprocessor` (ms.date 2026-10) ověřit. Model Copilot in SharePoint (dnes OpenAI) se může měnit — ověřit sekci Models v get-started. Seznam ploch s Anthropicem se rozšiřuje.
