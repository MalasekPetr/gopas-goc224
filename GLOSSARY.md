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
| **SharePoint Advanced Management (SAM)** | (dříve pod deštníkem „Premium") | governance webů/OneDrive | samostatný add-on |
| **Microsoft 365 Backup** | „SharePoint backup" | záloha SharePoint + OneDrive + Exchange | samostatný produkt |
| **Microsoft 365 Archive** | „SharePoint archive" | studená data / cold storage | samostatný produkt |
| **Copilot in SharePoint** | Knowledge Agent → AI in SharePoint | Copilot zážitek nad weby (vč. Skills) | opt-out preview, default-on pro Copilot licence |

> [!IMPORTANT] Backend vs. brand
> Microsoft dokumentace a URL stále nesou „syntex" (`learn.microsoft.com/microsoft-365/syntex/`). Studenty na to v labech upozornit, ať je URL nezmate.

## Dva PAYG modely (nezaměňovat)

| Model | Co platí | Metrika | Kde |
|---|---|---|---|
| **Document processing PAYG** | vytěžování dokumentů, OCR, překlad, eSignature | Azure metry (za stránku/dokument) | M365 admin center → billing |
| **Copilot Credits PAYG** | agenti / Copilot in SharePoint / Copilot Chat nad tenant daty | Copilot Credits ($0,01/kredit) | M365 admin center → PAYG billing policy + Azure |

Backup i Archive vyžadují nastavený (ex-Syntex) PAYG billing — stejná plumbing jako Document processing, ale samostatné produkty a pricing.

## Licence vs. permissions (nosný princip)

- **Licence** gate-uje *přístup k funkci* (M365 Copilot licence, resp. Copilot Credits PAYG → Copilot in SharePoint a Skills).
- **SharePoint permissions** gate-ují *kdo funkci použije* (Edit = tvorba Skill/agenta, View = spuštění).
- Skills nemají vlastní SKU ani PAYG metr.

## Aktuální licenční reálie

> [!WARNING] Ověřit k datu běhu — stav k 2026-07.

- Stack: E1 → E3 → E5 → **E7** (Frontier Suite; balí E5 + Copilot + Agent 365).
- **Copilot Business** (Business Standard/Premium base, ≤300 uživatelů) vs **Copilot Enterprise** — in-app funkce stejné; enterprise-only jsou Researcher/Analyst/Facilitator, model choice, Copilot Tuning.
- **Basic vs Premium Copilot split** — plný in-app Copilot jen v Premium; Basic = chat.
- Bezplatný Copilot Chat/Basic **nestačí** na grounding nad SharePointem — nutná placená Copilot licence nebo Copilot Credits PAYG.

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
