# Konfigurace krok za krokem

> Typ: povinný · Den: 2 · Odhad: PM blok
> Prostředí: viz [`../../environment.md`](../../environment.md) · Názvosloví: [`../../GLOSSARY.md`](../../GLOSSARY.md)

## Cíle

- Student zná pořadí kroků: předpoklady → PAYG billing → dostupnost Copilot in SharePoint → rozsah → ověření.
- Student rozlišuje dva PAYG modely a umí nastavit Copilot Credits billing policy (vč. toho, proč tam budget není limit) i spending policy v Cost management (kde limit je).
- Student umí řídit dostupnost Copilot in SharePoint po GA (Site AI settings + RCD) a ví, že `KnowledgeAgentScope` je vyřazený.
- Student odchází s konfiguračním runbookem (dry-run z labu) včetně change-management kroků.

## Výklad

### Krok 0 — předpoklady

- **Azure subscription ve stejném tenantu** — M365 nemá vlastní usage billing; všechny PAYG metry se účtují přes Azure. Subscription v cizím tenantu nejde použít.
- **Resource group v té subscription** — na ni se váže meter a tečou do ní usage data; kdo má na RG aspoň *read*, vidí náklady v Cost Management. Tím se řídí, kdo v organizaci smí vidět AI útratu.
- **Role**: podle služby (viz krok 1) + vždy **Owner/Contributor na subscription**. Dvě nezávislé osy — M365 admin role sama nestačí.

### Krok 1 — PAYG billing (dva modely)

Dva **nezávislé** PAYG modely se stejnou Azure plumbing — nezaměňovat (viz [glosář](../../GLOSSARY.md)):

#### 1a — Document processing PAYG

Aktivace: M365 admin center → **Setup → Billing and licenses → Activate pay-as-you-go services** → tab **Billing** → **Document processing services**; pozdější správa **Settings → Org settings → Pay-as-you-go services** ([Set up PAYG billing](https://learn.microsoft.com/en-us/microsoft-365/documentprocessing/syntex-azure-billing)). Význam sekcí panelu **Set up billing and turn on services**:

- **Azure subscription** — přes koho tečou peníze (Owner/Contributor nutný).
- **Resource group** — kam se váže meter; v Azure **Cost analysis** pak filtr *Product* + tag *Site* ukáže útratu per web (latence až 24 h).
- **Region** — kde budou uložena **usage metadata** (tenant ID, názvy webů). Data-residency rozhodnutí, ne výkonové — obsah dokumentů zůstává v tenantu.
- **Terms of service** — samostatné PAYG podmínky (jiný právní režim než M365 subscription).

Odemyká doc processing služby (Autofill columns, OCR, translation, eSignature, …) a je to stejná plumbing, na kterou navazují Backup/Archive/Storage metry (D4). Role: SharePoint nebo Global Admin.

#### 1b — Copilot Credits PAYG (Copilot bez licencí)

Usage-based přístup ke Copilot službám bez plné M365 Copilot licence — účtuje se za **Copilot Credits**. Pokrývá: **M365 Copilot Chat** (placené funkce = grounding nad tenant daty), **SharePoint agents** (jen `.agent` soubory), Copilot Retrieval API (preview); Copilot Studio má PAYG vlastní ([Overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/pay-as-you-go/pay-as-you-go-overview) · [Setup](https://learn.microsoft.com/en-us/microsoft-365/copilot/pay-as-you-go/setup)). Setup je **dvoukrokový** — a ty kroky mají různý význam:

1. **Billing policy** (admin center → **Copilot → Billing & usage** → tab **Billing policies** → *Add a billing policy*): účetní identita = Azure subscription + resource group + region + **users/groups** (komu se smí účtovat) + volitelný budget. Policy odděluje *kdo platí* od *co se platí* — proto jich lze mít až 50 (např. per oddělení) a jednu policy připojit k více službám.
2. **Connect policy ke službě** (tab **Pay-as-you-go services** → *Microsoft 365 Copilot Chat* / *SharePoint agents* → vybrat policy): **teprve tohle** službu uživatelům z policy zpřístupní. Samotná policy nic nezapíná; disconnect přístup odebírá (propagace do ~2 h).

- **Budget ≠ limit.** Budget jen posílá e-mailové notifikace při milnících útraty — **strop nevynucuje**, služba běží dál i po překročení. U téhle plochy tvrdý limit neexistuje; hlídá se přes notifikace + Azure Cost Management. Nosný teaching point do komunikačního plánu (lab, krok 3).
- Role: Billing Admin / **AI Administrator** / Global Admin; **Global Reader vidí read-only** — přesně náš studentský model (ověření v labu).
- Ověření funkčnosti: uživatel bez licence zkusí agenta (např. *Learning Coach*), základní prompt ≈ 12 kreditů; útrata pak v **Copilot Credits Report**.

#### 1c — Copilot Credits přes usage-based billing (Cost management)

Druhá, novější plocha pro Copilot Credits: **Copilot → Cost management** → **Configuration** → *Add spending policy* ([Usage-based billing](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-overview-copilot-credits) · [Spending policies](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-manage-copilot-credits)). Pokrývá Cowork, **Advanced work in SharePoint** / OneDrive, Code, Work IQ API, Copilot Managed Runtime; volitelně Copilot Studio.

- Spending policy = **scope** (users/groups nebo prostředí/agenti) + **vybrané služby** + **limity** + billing method. Policy zároveň **řídí přístup** — kdo v ní není, službu nepoužije.
- **Limited budget je tvrdý strop**: po vyčerpání uživatel ztratí přístup do 1. dne dalšího měsíce. Minimum 2 000 kreditů/uživatel/měs.
- **Auto-apply new services** je default zapnuté → nové UBB služby se do policy přidají samy. U kontrolovaného rolloutu vypnout.
- U Cowork, Advanced work a Code MS vyžaduje Copilot licenci — Credits ji nenahrazují. V našem tenantu (bez licencí) tedy jen ukázka obrazovky.

### Krok 2 — dostupnost Copilot in SharePoint

- Stav: **GA rollout od 30. 9. 2026**; everyday funkce v Copilot licenci bez opt-in kroku, „Advanced work" přes Copilot Credits (krok 1c) ([Get started with Copilot in SharePoint](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started)).
- **`Set-SPOTenant -KnowledgeAgentScope` (+ `KnowledgeAgentSelectedSitesList`, `...Operation`) je vyřazený** — MS ctí stávající nastavení jen **do 1. 11. 2026**. Od té doby se dostupnost řídí:
  - **Site AI settings** (vlastník webu, *Settings → Site AI*): který agent se otevře z ikony v hlavičce (Copilot in SharePoint nebo vlastní agent), skrytí Copilot tlačítka pro návštěvníky webu, zapnutí advanced document processing pro web.
  - **Restricted Content Discovery** — na webu s RCD se Copilot in SharePoint ani AI akce neobjeví, bez ohledu na ostatní nastavení (most na D3 SAM).
- Tenant-wide vypínač po GA MS nedokumentuje — *kdo* funkci má, řídí licence; *kde* se neobjeví, řídí RCD.

### Krok 3 — vyhledávání a zdroje

Grounding jede přes Microsoft Graph a search — co není v indexu / na co nejsou práva, Copilot nenajde. Restricted SharePoint Search a RCD jsou vypínače viditelnosti; autoritativní obsah lze značit (`-IsAuthoritative`, viz ranní PowerShell).

Detailní výklad tří ovladačů (scope × RCD × IsAuthoritative) vč. kombinačních scénářů a častých omylů: [`explainer-copilot-controls.md`](explainer-copilot-controls.md).

### Krok 4 — change management a komunikace

Technický rollout je menší půlka. Komunikační plán: co se zapíná, koho se to týká, co s náklady (PAYG!), kam hlásit problémy. Vzory: [Copilot enablement resources](https://learn.microsoft.com/en-us/microsoft-365/copilot/microsoft-365-copilot-enablement-resources) (5 kroků: readiness → licence → apps/network → setup → welcome + feedback).

```mermaid
flowchart LR
  A[Předpoklady<br>Azure + role] --> B[PAYG billing<br>doc processing + Copilot Credits]
  B --> C[Copilot in SharePoint<br>Site AI settings + RCD]
  C --> D[Search / zdroje<br>RSS, RCD, autoritativní weby]
  D --> E[Change management<br>komunikace + podpora]
  E --> F[Ověření<br>Get-SPOTenant + UI]
```

## Klíčové rozlišení

- **Licence vs. PAYG u Copilot in SharePoint**: po GA MS výslovně uvádí Copilot licenci jako prerekvizitu; Copilot Credits PAYG (krok 1b) dokumentovaně kryje jen **Copilot Chat a SharePoint agents**. V preview fungoval Copilot in SharePoint v našem tenantu i na PAYG (2026-07-17) — stav po GA viz výsledek go/no-go z D1 (`../../day-1/licensing/instructor-notes.md`).
- **Billing policy vs. connect**: policy je jen účetní identita (kdo + přes co platí); přístup ke službě vzniká až připojením policy ke konkrétní službě. Dva kroky = dvě různá rozhodnutí.
- **Billing policy (1b) vs. spending policy (1c)**: první jen účtuje a upozorňuje, druhá řídí přístup a umí tvrdý strop.
- **Zapnout vs. zpřístupnit**: Site AI settings a RCD říkají *kde* se funkce objeví; licence/kredity říkají *kdo* ji smí použít; permissions říkají *nad čím*. Tři nezávislé vypínače.

## Naše prostředí

- Konfigurace = **instruktorské demo** (tenant-wide + admin role). Studenti: dry-run runbook (lab) + ověření dopadu jako Global Reader (admin centrum read-only, `Get-SPOTenant` dle ranního go/no-go).

## Lab

Viz [`lab-config-dry-run.md`](lab-config-dry-run.md) — tenant configuration dry-run (simulace).

## Zdroje (Microsoft)

[Get started with Copilot in SharePoint](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started) · [Set up pay-as-you-go billing (doc processing)](https://learn.microsoft.com/en-us/microsoft-365/documentprocessing/syntex-azure-billing) · [Copilot pay-as-you-go overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/pay-as-you-go/pay-as-you-go-overview) · [Usage-based billing](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-overview-copilot-credits) · [Spending policies](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-manage-copilot-credits) · [Set up Copilot pay-as-you-go](https://learn.microsoft.com/en-us/microsoft-365/copilot/pay-as-you-go/setup) · [Copilot enablement resources](https://learn.microsoft.com/en-us/microsoft-365/copilot/microsoft-365-copilot-enablement-resources)

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu — stav k 2026-10.
> Copilot in SharePoint: GA rollout od 30. 9. 2026; `KnowledgeAgent*` parametry ctěny jen do 1. 11. 2026, pak Site AI settings + RCD. Nedostupné v GCC/GCC High/DoD.
> Copilot Credits mají dvě plochy: PAYG (Copilot → Billing & usage; budget = jen notifikace) a usage-based billing (Copilot → Cost management; tvrdý strop). Služby se mezi nimi přesouvají — po Ignite (17.–20. 11. 2026) ověřit cesty v admin centru; cena za kredit dle glosáře, ověřit v ceníku.
