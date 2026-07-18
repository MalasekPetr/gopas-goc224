# Glosář — závazné názvosloví

Jediný zdroj pravdy pro názvy produktů, formátů a PowerShell konvence. Všechny moduly se odkazují sem.

> [!WARNING] Ověřit k datu běhu — stav k 2026-07.
> Ceny, preview stavy a licenční balíčky se mění po měsících. Před každým během projet položky s tímto markerem.

## Produktové názvy

Značka „SharePoint Premium" byla rozdělena. **Není** 1:1 přejmenovaná na jeden produkt.

| Používat | Dřívější názvy | Rozsah | Poznámka |
|---|---|---|---|
| **Document processing for Microsoft 365** | Syntex → SharePoint Premium (content-AI část) | vytěžování dokumentů, PAYG | prioritní služby: Autofill columns, Document translation, OCR, eSignature |
| **eSignature** | SharePoint eSignature | podepisování dokumentů | služba pod Document processing; v UI stále „SharePoint eSignature" |
| **SharePoint Advanced Management (SAM)** | (dříve pod deštníkem „Premium") | governance webů/OneDrive | dvě licenční cesty: Plan 1 add-on ($3/user/měs), NEBO ≥1 M365 Copilot licence v tenantu (výjimka: restricted site creation by apps = jen Plan 1) |
| **Microsoft 365 Backup** | „SharePoint backup" | záloha SharePoint + OneDrive + Exchange | samostatný produkt |
| **Microsoft 365 Archive** | „SharePoint archive" | studená data / cold storage | samostatný produkt |
| **Copilot in SharePoint** | Knowledge Agent → AI in SharePoint | Copilot zážitek nad weby (vč. Skills) | opt-out preview, default-on pro Copilot licence |
| **Agent 365** | (nový, GA 1. 5. 2026) | governance/security control plane pro AI agenty | per-user, $15/měs nebo v E7; agenti se nelicencují, licencuje se uživatel |

> [!IMPORTANT] Backend vs. brand
> Microsoft dokumentace a URL stále nesou „syntex" (`learn.microsoft.com/microsoft-365/syntex/`). Studenty na to v labech upozornit, ať je URL nezmate.

## Dva PAYG modely (nezaměňovat)

| Model | Co platí | Metrika | Kde |
|---|---|---|---|
| **Document processing PAYG** | vytěžování dokumentů, OCR, překlad, eSignature | Azure metry (za stránku/dokument) | M365 admin center → billing |
| **Copilot Credits PAYG** | Copilot Chat (nad tenant daty) + použití SharePoint agents + **Skills / Copilot in SharePoint** a **tvorba/nasazení agentů přes Agents Toolkit** (empiricky fungují i na PAYG bez Copilot licence — MS nedokumentuje, ověřeno na kurzu 2026-07-17) | Copilot Credits ($0,01/kredit) | M365 admin center → PAYG billing policy + Azure |

Backup i Archive vyžadují nastavený (ex-Syntex) PAYG billing — stejná plumbing jako Document processing, ale samostatné produkty a pricing.

**Další PAYG metry (stejná Azure plumbing):** SharePoint/OneDrive Storage (nad kvótu, public preview 2026), Microsoft 365 Backup (dle objemu), Microsoft 365 Archive (cold storage nad kvótu). Společný jmenovatel: všechny se účtují přes připojenou **Azure subscription + resource group**; setup vyžaduje SharePoint nebo Global Admin.

> [!NOTE] Nosný teaching point zůstává: **nezaměňovat Document processing PAYG vs Copilot Credits**. Storage/Backup/Archive jsou další PAYG metry, ale jiná kategorie (úložiště/data), ne AI zpracování.

## Licence vs. permissions (nosný princip)

- **Licence** gate-uje *přístup k funkci*. MS dokumentuje **Copilot in SharePoint a Skills jako license-only**, ale **empiricky fungují i na PAYG bez Copilot licence** — tvorba i použití (ověřeno na kurzu 2026-07-17; Microsoft to takto nedokumentuje). Totéž platí pro **tvorbu a nasazení agentů přes Agents Toolkit** na PAYG. Copilot Chat a použití SharePoint agents = licence NEBO PAYG. **Výjimka: tvorba SharePoint agenta Copilot licenci vyžaduje** (empiricky potvrzeno — použití jde přes PAYG).
- **SharePoint permissions** gate-ují *kdo funkci použije* (Edit = tvorba Skill/agenta, View = spuštění).
- Skills nemají vlastní SKU ani PAYG metr.

## Aktuální licenční reálie

> [!WARNING] Ověřit k datu běhu — stav k 2026-07.

- Stack: E1 → E3 → E5 → **E7** (Frontier Suite; balí E5 + Copilot + Agent 365).
- **Copilot Business** (Business Standard/Premium base, ≤300 uživatelů) vs **Copilot Enterprise** — in-app funkce stejné; enterprise-only jsou Researcher/Analyst/Facilitator, model choice, Copilot Tuning.
- **Basic vs Premium Copilot split** — plný in-app Copilot jen v Premium; Basic = chat.
- Bezplatný Copilot Chat/Basic **nestačí** na grounding nad SharePointem — nutná placená Copilot licence nebo Copilot Credits PAYG.

## AI subprocesoři (modely třetích stran)

> [!WARNING] Ověřit k datu běhu — stav k 2026-07.
> Copilot může vedle OpenAI používat **Anthropic** modely. Anthropic = **Microsoft subprocesor** (pod Microsoft DPA), ale inference **mimo Azure / EU Data Boundary** (AWS/GCP, US). **EU/EFTA/UK: default vypnuto**; jinde on-by-default. **Preview models with Data Retention** (Claude Fable 5, Mythos 5) = Anthropic jako **nezávislý procesor** (drží data), vždy opt-in. **Copilot in SharePoint / Skills běží na OpenAI modelu — na Anthropicu nezávisí.** Detail: [`day-5/copilot-admin/explainer-ai-subprocessors.md`](day-5/copilot-admin/explainer-ai-subprocessors.md).

## Formáty (proč je studenti potřebují)

| Formát | Role v kurzu |
|---|---|
| **Markdown (MD)** | materiály kurzu, Skills (`SKILL.md`), dokumentace |
| **JSON** | SharePoint column/view formatting, konfigurace, API payloady |
| **YAML** | front-matter, konfigurační soubory, pipeline definice |

## PowerShell

- Používáme **SPO Management Shell** — modul `Microsoft.Online.SharePoint.PowerShell`.
- Pokrývá rozsah kurzu: tenant/site admin, `Set-SPOTenant` (vč. `KnowledgeAgentScope`), SAM cmdlety, lifecycle webů.
- **PnP.PowerShell** není pro rozsah kurzu potřeba.

> [!WARNING] Ověřit k datu běhu
> Nejnovější preview cmdlety občas přistanou nejdřív v PnP než v SPO modulu. Ověřit před během.

## Vývojářské nástroje (pro-code agenti)

| Nástroj | Co to je | Licenční dotyk |
|---|---|---|
| **Microsoft 365 Agents Toolkit** | nástupce Teams Toolkitu; VS Code / Visual Studio / GitHub Copilot / CLI; scaffolduje deklarativní a custom engine agenty, manifest, provisioning, MCP akce | zdarma |
| **GitHub Copilot** | AI asistent při psaní kódu; Agents Toolkit je pro něj dostupný | vlastní licence (mimo M365) |
| **Copilot Studio** | low-code stavba agentů | Copilot Credits / M365 Copilot licence |
| **Agent Builder** | lightweight tvorba deklarativních agentů přímo v M365 Copilot (bez opuštění appky) | M365 Copilot licence / Copilot Credits — ověřit k datu běhu |

Rozhodovací osa pro [`day-3/procode-vs-lowcode`](day-3/procode-vs-lowcode/): deklarativní agent (Agents Toolkit, source-controlled) vs. Copilot Studio (low-code) vs. SPFx/Graph. Agenti jako kód sedí na repo-as-code přístup kurzu.

## Azure AI služby (mimo M365)

| Používat | Dřívější názvy | Kde v kurzu |
|---|---|---|
| **Azure AI services** | Azure Cognitive Services | zastřešující rodina Azure AI služeb |
| **Azure AI Document Intelligence** | Form Recognizer (→ součást ex-Cognitive Services) | D3 — robustnější alternativa vytěžování faktur vůči AI Builder / Document processing |

> [!IMPORTANT] Názvosloví
> „Azure Cognitive Services" je zastaralý brand — v materiálech používat **Azure AI services**, pro faktury konkrétně **Azure AI Document Intelligence**. Účtování jde přes Azure subscription (třetí kategorie vedle obou M365 PAYG modelů).
