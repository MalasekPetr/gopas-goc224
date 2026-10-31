# Glosář — závazné názvosloví

Jediný zdroj pravdy pro názvy produktů, formátů a PowerShell konvence. Všechny moduly se odkazují sem.

> [!WARNING] Ověřit k datu běhu — stav k 2026-10.
> Ceny, preview stavy a licenční balíčky se mění po měsících. Před každým během projet položky s tímto markerem. Microsoft Ignite 17.–20. 11. 2026 → po něm projet znovu.

## Produktové názvy

Značka „SharePoint Premium" byla rozdělena. **Není** 1:1 přejmenovaná na jeden produkt.

| Používat | Dřívější názvy | Rozsah | Poznámka |
|---|---|---|---|
| **Document processing for Microsoft 365** | Syntex → SharePoint Premium (content-AI část) | vytěžování dokumentů, PAYG | prioritní služby: Autofill columns, Document translation, OCR, eSignature |
| **eSignature** | SharePoint eSignature | podepisování dokumentů | služba pod Document processing; v UI stále „SharePoint eSignature" |
| **SharePoint Advanced Management (SAM)** | (dříve pod deštníkem „Premium") | governance webů/OneDrive | licenční cesty: Plan 1 add-on (cena — ověřit, MS stránka ji neuvádí), NEBO ≥1 Copilot licence v tenantu (vč. E7, které Copilot obsahuje); výjimka: restricted site creation by apps = jen Plan 1 |
| **Microsoft 365 Backup** | „SharePoint backup" | záloha SharePoint + OneDrive + Exchange | samostatný produkt |
| **Microsoft 365 Archive** | „SharePoint archive" | studená data / cold storage | samostatný produkt |
| **Copilot in SharePoint** | Knowledge Agent → AI in SharePoint | Copilot zážitek nad weby (vč. Skills) | GA rollout od 30. 9. 2026; hybridní model: everyday funkce v Copilot licenci, „Advanced work" = licence + Copilot Credits (usage-based billing); řízení dostupnosti přes Site AI settings + RCD (PowerShell `KnowledgeAgent*` vyřazeny k 1. 11. 2026) — [Get started](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started) |
| **Agent 365** | (nový, GA 1. 5. 2026) | governance/security control plane pro AI agenty | per-user, $15/měs nebo v E7; agenti se nelicencují, licencuje se uživatel |

> [!IMPORTANT] Backend vs. brand
> Dokumentace se přesunula pod `learn.microsoft.com/microsoft-365/documentprocessing/`, ale názvy stránek stále nesou „syntex" (`syntex-overview`, `syntex-pay-as-you-go-services`). Studenty na to v labech upozornit, ať je URL nezmate.

## Dva PAYG modely (nezaměňovat)

| Model | Co platí | Metrika | Kde |
|---|---|---|---|
| **Document processing PAYG** | vytěžování dokumentů, OCR, překlad, eSignature | Azure metry (za stránku/dokument) | M365 admin center → billing |
| **Copilot Credits** | AI spotřeba Copilota a agentů — **dvě správní plochy**, viz níže | Copilot Credits | M365 admin center + Azure |

Copilot Credits se spravují na dvou místech (stav 2026-10):

| Plocha | Co pokrývá | Strop | Kde |
|---|---|---|---|
| **Pay-as-you-go (původní)** | Copilot Chat, SharePoint agents (`.agent`), Copilot Retrieval API | **ne** — budget jen posílá upozornění | Billing policy → připojit ke službě |
| **Usage-based billing (nová)** | Cowork, Advanced work in SharePoint / OneDrive, Code, Work IQ API, Copilot Managed Runtime, Teams Phone Agent; volitelně Copilot Studio | **ano** — limited budget odstřihne přístup do 1. dne dalšího měsíce; min. 2 000 kreditů/uživatel/měs.; spending policy zároveň **řídí přístup** | **Copilot → Cost management** |

Pozor: u Cowork, Advanced work a Code MS uvádí „Copilot license required" — Credits tam nenahrazují licenci, jen ji rozšiřují. Spending policy má default zapnuté **Auto-apply new services** → nové UBB služby se do policy přidají samy. Zdroje: [PAYG overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/pay-as-you-go/pay-as-you-go-overview) · [Usage-based billing](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-overview-copilot-credits) · [Spending policies](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-manage-copilot-credits).

Backup i Archive vyžadují nastavený (ex-Syntex) PAYG billing — stejná plumbing jako Document processing, ale samostatné produkty a pricing.

**Další PAYG metry (stejná Azure plumbing):** SharePoint/OneDrive Storage (nad kvótu, public preview 2026), Microsoft 365 Backup (dle objemu), Microsoft 365 Archive (cold storage nad kvótu). Společný jmenovatel: všechny se účtují přes připojenou **Azure subscription + resource group**; setup vyžaduje SharePoint nebo Global Admin.

> [!NOTE] Nosný teaching point zůstává: **nezaměňovat Document processing PAYG vs Copilot Credits**. Storage/Backup/Archive jsou další PAYG metry, ale jiná kategorie (úložiště/data), ne AI zpracování.

## Licence vs. permissions (nosný princip)

- **Licence** gate-uje *přístup k funkci*. Od GA (30. 9. 2026) MS **výslovně** uvádí Copilot in SharePoint (vč. Skills) jako license-only: „Users must have an active Microsoft 365 Copilot license." ([Get started](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started)). Na kurzu jsme 2026-07-17 (ještě v preview) empiricky ověřili, že fungovaly i na PAYG bez licence — **po GA je nutné znovu otestovat** (tripwire T1, viz instructor notes `day-1/licensing`). **Tvorba a nasazení agentů přes Agents Toolkit** bez Copilot licence je od 2026-09 i **dokumentovaná** (grounding na org data = licence nebo PAYG; [Prerequisites](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/prerequisites)). Copilot Chat a použití SharePoint agents = licence NEBO PAYG. **Tvorba SharePoint agenta** vyžaduje Copilot licenci (empiricky; od pol. 11/2026 se tvorba přesouvá do Agent Builderu).
- **SharePoint permissions** gate-ují *kdo funkci použije* (Edit = tvorba Skill/agenta, View = spuštění).
- **Spending policy** (usage-based billing) je u Cowork a Advanced work v SharePointu třetí brána: bez ní uživatel službu nepoužije, ani s licencí.
- Skills nemají vlastní SKU. Tvorba a běžné použití jsou v licenci; skills v plánovaných AI automatizacích a práce ve velkém („Advanced work") čerpají Copilot Credits.

## Aktuální licenční reálie

> [!WARNING] Ověřit k datu běhu — stav k 2026-10.

- Stack: E1 → E3 → E5 → **E7** (Frontier Suite; E5 + Copilot + **Microsoft Entra Suite** + Agent 365) — [Compare E3/E5/E7](https://learn.microsoft.com/en-us/microsoft-365/copilot/compare-copilot-e3-e5-e7).
- **Copilot Business** (≤300 uživatelů; base: Business Basic / Standard / Premium, Apps for Business, Teams Essentials) — MS: „provides the same Microsoft Copilot capabilities" jako Copilot pro enterprise ([License options](https://learn.microsoft.com/en-us/microsoft-365/copilot/copilot-license-options)). Dřívější seznam „enterprise-only" funkcí (Researcher/Analyst/Facilitator, model choice, Tuning) MS zdrojem nepodložen — ověřit.
- **Od 1. 12. 2026** jdou nové Copilot / Copilot Business licence koupit **bez base subscription**; dosavadní nabídky nesou od 16. 10. 2026 v názvu „(add-on)". U nových Copilot Business přes CSP je od 1. 12. 2026 usage-based billing **default zapnutý** (výchozí limit 4 000 kreditů/uživatel/měs.) — [Partner Center, říjen 2026](https://learn.microsoft.com/en-us/partner-center/announcements/2026-october).
- **Štítky Copilota v aplikacích:** *Microsoft 365 Copilot (Premium/Pro)* = licence, plný zážitek, priority access · *Microsoft 365 Copilot (Basic)* = bez licence, standard access k Copilotu ve Word/Excel/PowerPoint/OneNote · *Copilot Chat (Basic)* = bez licence, bez Copilota v aplikacích ([Copilot Chat overview](https://learn.microsoft.com/en-us/copilot/overview)).
- Bezplatný Copilot Chat **nestačí** na grounding nad SharePointem — nutná Copilot licence nebo Copilot Credits PAYG. Výjimka: **Copilot Chat v Outlooku** grounduje i bez licence na poštu, kalendář, schůzky, chaty a omezenou sadu souvisejícího obsahu ([Copilot Chat overview](https://learn.microsoft.com/en-us/copilot/overview)).
- **Researcher / Analyst** = součást Copilot licence (Premium), admin je může blokovat ([Service description](https://learn.microsoft.com/en-us/office365/servicedescriptions/office-365-platform-service-description/microsoft-365-copilot)).
- **Nový Copilot (25. 9. 2026):** Home (Chat + Cowork + Office v aplikaci Copilot), Code (Frontier preview), Autopilot (ex-Scout, Frontier). Licence pokrývá work-grounded Chat a Copilota v aplikacích; Cowork, Code a Autopilot běží na Copilot Credits (usage-based billing) — [Introducing the new Copilot](https://blogs.microsoft.com/blog/2026/09/25/introducing-the-new-copilot-with-home-code-and-autopilot/), [Cowork](https://learn.microsoft.com/en-us/copilot/cowork/).

## AI subprocesoři (modely třetích stran)

> [!WARNING] Ověřit k datu běhu — stav k 2026-10.
>
> - **OpenAI** (modely provozované přímo OpenAI) = **Microsoft subprocesor** od 2026-07; default zapnuto od 24. 7. 2026; **uvnitř EU Data Boundary** (s výhradami EUDB dokumentace), mimo in-country processing. Modely přes Azure OpenAI se toho nastavení netýkají ([OpenAI subprocessor](https://learn.microsoft.com/en-us/microsoft-365/copilot/openai-subprocessor)).
> - **Anthropic** = **Microsoft subprocesor** (pod Microsoft DPA), ale **mimo EU Data Boundary**. **EU/EFTA/UK: default vypnuto**; jinde on-by-default. **„Anthropic models with Data Retention"** (např. Claude Fable 5, Mythos 5) = Anthropic jako **nezávislý procesor** (drží data až 30 dní), vždy opt-in. Fable 5.1 může u způsobilých organizací běžet i v režimu subprocesoru ([Anthropic models](https://learn.microsoft.com/en-us/microsoft-365/copilot/connect-to-ai-subprocessor)).
> - **xAI (Grok)** v Cowork = **nezávislý procesor**.
> - **V tenantu uvnitř EU Data Boundary nabízí Cowork jen GPT modely** ([Cowork models](https://learn.microsoft.com/en-us/copilot/cowork/cowork-models)).
> - **Copilot in SharePoint / Skills běží na Microsoftem spravovaném OpenAI modelu — na Anthropicu nezávisí.**
>
> Detail: [`day-5/copilot-admin/explainer-ai-subprocessors.md`](day-5/copilot-admin/explainer-ai-subprocessors.md).

## Formáty (proč je studenti potřebují)

| Formát | Role v kurzu |
|---|---|
| **Markdown (MD)** | materiály kurzu, Skills (`SKILL.md`), dokumentace |
| **JSON** | SharePoint column/view formatting, konfigurace, API payloady |
| **YAML** | front-matter, konfigurační soubory, pipeline definice |

## PowerShell

- Používáme **SPO Management Shell** — modul `Microsoft.Online.SharePoint.PowerShell`.
- Pokrývá rozsah kurzu: tenant/site admin, `Set-SPOTenant`, SAM cmdlety (vč. Restricted Content Discovery), lifecycle webů.
- `KnowledgeAgentScope` / `KnowledgeAgentSelectedSitesList` / `...Operation` (preview ovládání Copilot in SharePoint) jsou **vyřazené** — MS je ctí jen do 1. 11. 2026, pak dostupnost řídí Site AI settings + RCD ([Get started](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started)).
- **PnP.PowerShell** není pro rozsah kurzu potřeba.

> [!WARNING] Ověřit k datu běhu
> Nejnovější preview cmdlety občas přistanou nejdřív v PnP než v SPO modulu. Ověřit před během.

## Vývojářské nástroje (pro-code agenti)

| Nástroj | Co to je | Licenční dotyk |
|---|---|---|
| **Microsoft 365 Agents Toolkit** | nástupce Teams Toolkitu; VS Code / Visual Studio / GitHub Copilot / CLI; scaffolduje deklarativní a custom engine agenty, manifest, provisioning, MCP akce | zdarma |
| **GitHub Copilot** | AI asistent při psaní kódu; Agents Toolkit je pro něj dostupný | vlastní licence (mimo M365) |
| **Copilot Studio** | low-code stavba agentů; dvě „harness" prostředí: **standard** (klasické) a **GitHub Copilot harness** (nová zkušenost, preview) | Copilot Credits / M365 Copilot licence (zero-rating jen na standard harness); GitHub Copilot harness čerpá kredity už od stavby a licence ho nekryje |
| **Agent Builder** | lightweight tvorba deklarativních agentů přímo v Copilotu (bez opuštění appky); umí připojit Skills (preview); externí akce ne → „copy to Copilot Studio" | Copilot licence / Copilot Credits PAYG — ověřit k datu běhu |

Rozhodovací osa pro [`day-3/procode-vs-lowcode`](day-3/procode-vs-lowcode/): deklarativní agent (Agents Toolkit, source-controlled) vs. Copilot Studio (low-code) vs. SPFx/Graph. Agenti jako kód sedí na repo-as-code přístup kurzu.

## Azure AI služby (mimo M365)

| Používat | Dřívější názvy | Kde v kurzu |
|---|---|---|
| **Azure AI services** | Azure Cognitive Services | zastřešující rodina Azure AI služeb |
| **Azure AI Document Intelligence** | Form Recognizer (→ součást ex-Cognitive Services) | D3 — robustnější alternativa vytěžování faktur vůči AI Builder / Document processing |

> [!IMPORTANT] Názvosloví
> „Azure Cognitive Services" je zastaralý brand — v materiálech používat **Azure AI services**, pro faktury konkrétně **Azure AI Document Intelligence**. Účtování jde přes Azure subscription (třetí kategorie vedle obou M365 PAYG modelů).
