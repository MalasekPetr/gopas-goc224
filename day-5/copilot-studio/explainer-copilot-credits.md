# Copilot Credits — co platíte, kde to vidíte a kolik stojí lab

> Modul: copilot-studio · Typ: výklad (~20 min) před labem · Navazuje na: D1 [`licensing`](../../day-1/licensing/README.md), D2 [`configuration`](../../day-2/configuration/README.md), D4 [`explainer-environments.md`](../../day-4/power-automate-invoices/explainer-environments.md)

## Cíle

- Pro každou AI službu kurzu rozhodnete, jestli ji kryje licence Microsoft 365 Copilot, nebo jestli čerpá Copilot Credits.
- Víte, ve kterém admin centru se která spotřeba řídí a co přesně dělá limit.
- Umíte vysvětlit, proč se stejná spotřeba ukazuje v M365 admin centru za pár hodin a v Azure až za den i déle.
- Spočítáte, kolik zhruba stojí dnešní lab, a víte, jak cenu shora omezit.

## Proč se tím zabývat

V D1 jste počítali kredity na papíře. Od D4 je čerpáte doopravdy: Cowork a Code za dva dny spotřebovaly v kurzovním tenantu přes 4 600 kreditů. Dnešní lab na GitHub Copilot harnessu je první místo v kurzu, kde se platí už **za stavbu a testování** agenta, ne až za jeho provoz. Správce, který nerozumí tomu, odkud kredity tečou a kdy se spotřeba objeví v reportu, se o překročení rozpočtu dozví z faktury.

## Copilot Credit — jednotka, ne produkt

**Copilot Credit** je společná měrná jednotka spotřeby AI služeb Microsoftu. Kolik kreditů operace stojí, určuje služba, která ji provedla. Cena jednoho kreditu při PAYG je orientačně **$0,01**; z kurzovního tenantu: 212 kreditů se v Azure objevilo jako €1,90, tedy zhruba €0,009 za kredit (viz D1 [`licensing`](../../day-1/licensing/README.md), sekce Copilot Credits).

Kredity přicházejí ze tří zdrojů a systém je čerpá v tomto pořadí ([Managing usage-based billing](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-manage-copilot-credits)):

1. **Předplacené kapacitní balíčky** (prepaid capacity packs) — politika vždy čerpá nejdřív je.
2. **Copilot Credit Pre-Purchase Plan (P3)** — předplacený objem, který leží nad PAYG.
3. **Pay-as-you-go** — skutečná spotřeba se fakturuje na Azure předplatné.

Kurzovní tenant nemá předplacené balíčky, takže všechno jde přes PAYG — proto na dashboardu vidíte „Prepaid Copilot Credits used: 0".

## Kdo co platí — čtyři skupiny služeb

Rozhodující otázka je vždy stejná: **kryje to licence Microsoft 365 Copilot?**

| Služba | Kryje licence M365 Copilot? | Jak se účtuje | Kde se řídí |
|---|---|---|---|
| Copilot Chat, Copilot in SharePoint, agenti v Copilotu, **standard harness** agenti v kanálech Microsoft 365 | ano, pro licencovaného uživatele pod jeho identitou (fair use) | uživatel bez licence nebo kanál mimo M365: sazebník — classic answer 1, generative answer 2, agent action 5, tenant graph grounding 10 kreditů | PPAC (Copilot Studio), M365 AC (Copilot Chat PAYG) |
| **Cowork, Code, Copilot Managed Runtime, Advanced work, Work IQ API** | ne | Copilot Credits podle spotřeby | M365 AC → Copilot → Cost management, **identity-based** spending policy |
| **GitHub Copilot harness** agenti a workflows v Copilot Studiu | **ne, nikdy** | tokeny + nástroje (vč. knowledge a MCP) + harness, **od začátku stavby** — Preview, generování přirozeným jazykem, evaluace | PPAC → Licensing → Copilot Studio, nebo M365 AC **resource-based** policy |
| Computer use (CUA) | ne | kredity za veškeré použití | PPAC |

Zdroje: [Billing rates (standard harness)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-messages-management), [What consumes Copilot Credits](https://learn.microsoft.com/en-us/power-platform/admin/manage-usage-github-copilot-harness#what-consumes-copilot-credits-in-copilot-studio-today), [Usage-based billing](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/billing-credit-overview).

U GitHub Copilot harnessu Microsoft neuvádí sazbu za zprávu, ale orientační rozpětí na úkol:

| Typ úkolu | Příklad | Odhad kreditů |
|---|---|---|
| light | pár zdrojů, lehké uvažování, nejvýš jeden výstup | 100–300 |
| medium | víc zdrojů, strukturované uvažování, 2+ výstupy | 300–500 |
| heavy | široká agregace, hluboká analýza, mnoho výstupů | více než 500 |

Zdroj: diagram na stránce [Usage-based billing](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/billing-credit-overview). Přesnější odhad pro konkrétního agenta dává [Copilot Credits estimator](https://nptnlopppecostweb.azurewebsites.net/#/estimator); výsledky jsou orientační.

## Kde se spotřeba řídí — dvě admin centra

### M365 admin centrum → Copilot → Cost management

**Identity-based spending policy** řídí služby podle toho, *kdo* je používá ([Managing usage-based billing](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-manage-copilot-credits)). Kurzovní tenant má jednu:

| Nastavení | Hodnota v kurzu |
|---|---|
| Scope | skupina Students |
| Agents and services | Cowork, Code, Copilot Managed Runtime, Advanced work v OneDrive a SharePointu, Work IQ API a další; nové služby se přidávají automaticky |
| Billing method | Pay-as-you-go (Azure předplatné kurzu) |
| Spending limit | 20 000 kreditů měsíčně za celou policy |
| User limit | 2 000 kreditů měsíčně na uživatele |
| Alerts | zapnuté, e-mail instruktorovi |

Jak se limity chovají:

- Microsoft uvádí pro limit na uživatele **nejméně 2 000 kreditů měsíčně** a rozlišuje minimum (politika ho musí splnit) od doporučené hodnoty (při nižší politiku uložíte a admin centrum navrhne vyšší limit).
- Uživatel, který limit vyčerpá, ztratí přístup ke službám politiky do **1. dne dalšího měsíce**. Může požádat o další kredity, ale do jiné politiky automaticky nepřejde.
- Úloha, která už běží a přes limit přeteče, smí doběhnout. Přečerpání se do limitu nepočítá a Microsoft ho podle svého uvážení nefakturuje ([Monitor spending](https://learn.microsoft.com/en-us/copilot/implement/usage-based-billing-copilot-credits-monitor-spending)).
- Spending policy **nerezervuje** kredity, jen omezuje.

**Resource-based spending policy** řídí Copilot Studio podle toho, *který agent nebo prostředí* kredity čerpá ([Manage Copilot Studio costs](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-manage-copilot-studio-costs)):

- Je opt-in. Dokud ji nevytvoříte, platí nastavení v Power Platform admin centru.
- Pokrývá konkrétní agenty, nebo celá prostředí. U prostředí můžete nastavit limit politiky **a limit na agenta** — například 10 000 kreditů za politiku a 1 000 na agenta. Limit na agenta tak platí i pro agenty, kteří vzniknou až po vytvoření politiky.
- Má přednost: **M365 AC před PPAC** a **resource-based před identity-based**. Limity překrývajících se politik se nesčítají.
- **Nepokrývá AI Builder** (prompty v topics a agent flows). Prostředí s AI Builderem pod ni nedávejte.
- Projeví se do 12 minut od vytvoření.

> **Pozor:** identity-based politika kurzu (2 000 na uživatele) agenty z Copilot Studia **nepokrývá** — Copilot Studio v jejím seznamu služeb není. Lab v Copilot Studiu se platí přes prostředí `GOC224-lab`.

### Power Platform admin centrum → Licensing → Copilot Studio

Tady se Copilot Studio řídí, pokud prostředí nepokrývá resource-based politika z M365 AC ([Manage costs for GitHub Copilot harness](https://learn.microsoft.com/en-us/power-platform/admin/manage-usage-github-copilot-harness)):

- **Manage Copilot Credits** — kolik předplacených kreditů má prostředí přidělených a zda smí čerpat z kapacity tenantu (*Draw from the available capacity in my tenant*).
- **PAYG billing plan** — propojení prostředí s Azure předplatným. Azure budgety a alerty jen upozorní, **spotřebu nezastaví**.
- **Manage Agents → Set limit** — měsíční limit pro jednoho agenta, práh upozornění a **Stop usage**, který agenta po dosažení limitu vypne.
- Kredity se účtují **prostředí**, ve kterém agent běží, ne tvůrci ani uživateli. Kdo smí agenty stavět, řídí role v prostředí, ne limity.
- **Manage → Copilot Studio** má sloupec **Harness** (GitHub Copilot / Standard / Copilot Chat) — tak správce najde agenty, kteří čerpají kredity za všechno.

## Kde spotřebu vidíte a kdy

Stejná spotřeba se objeví na několika místech, každé s jiným zpožděním. Tohle je nejčastější zdroj zmatku.

| Kde | Co ukazuje | Jak čerstvé |
|---|---|---|
| Cowork, příkaz `/cost` | přibližné kredity otevřené úlohy | průběžně |
| Copilot Studio, karta **Monitor** agenta | kredity jednoho agenta, případně rozpad podle aktivit | MS interval neuvádí — ověřit |
| M365 AC → Cost management → **Overview** | celkem, prepaid vs. PAYG, trend po dnech | obnova **každé 4 hodiny** |
| M365 AC → Cost management → **Consumption** | podle politik, uživatelů, skupin, služeb | obnova **každé 2 hodiny** |
| PPAC → Licensing → Copilot Studio | podle prostředí a agentů, stažitelný report | MS interval neuvádí — ověřit |
| **Azure Cost Management** (Cost analysis) | fakturační záznamy v měně předplatného | **8–24 h** (EA/MCA), u pay-as-you-go předplatného **až 72 h**; odhad se aktualizuje **6× denně** |

Zdroje: [Monitor Copilot Credit spending](https://learn.microsoft.com/en-us/copilot/implement/usage-based-billing-copilot-credits-monitor-spending), [Understand Cost Management data](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/understand-cost-mgt-data), [View costs — Copilot PAYG](https://learn.microsoft.com/en-us/microsoft-365/copilot/pay-as-you-go/view-cost).

**Proč je Azure tak pozadu.** M365 admin centrum čte provozní telemetrii služby. Azure Cost Management čeká na fakturační záznam: služba spotřebu odešle do fakturačního systému, ten ji ocení a teprve pak se objeví v Cost analysis. Navíc v Azure je to až do vystavení faktury jen **odhad** — měsíc se uzavírá až zhruba 72 hodin po konci fakturačního období a částky se do té doby mohou přepočítat. Cost analysis navíc částky zaokrouhluje.

**Příklad z kurzovního tenantu (ráno 6. 11. 2026):**

- M365 AC → Cost management ukazoval **4 628 PAYG kreditů** za měsíc: 212 ze 4. 11. a zhruba 4 400 z 5. 11. (Code 3 252, Cowork 1 366, Managed Runtime 10).
- Azure Cost analysis ukazoval pro meter *Pay As You Go Copilot Credit* jen **€1,90** — to odpovídá 212 kreditům ze 4. 11. Špička z 5. 11. ještě nedorazila.
- Závěr: **M365 AC je provozní pohled (hodiny), Azure je faktura (den až tři dny)**. Když chcete vědět, jestli třída nepřečerpává, díváte se do M365 AC nebo PPAC, ne do Azure. Azure spotřebu jen fakturuje; limit je součástí spending policy v M365 AC — zpoždění v Azure proto neznamená, že limit nefunguje (naše odvození, MS to výslovně neuvádí).

**Jak spotřebu číst v Azure** (pozorováno v kurzovním tenantu 2026-11):

- Každá spending policy je v Azure samostatný resource typu `microsoft.powerplatform/accounts` (u nás *all users policy* ve skupině `copilot-credits-rg`).
- Služba se jmenuje **Microsoft Copilot Studio** a meter **Pay As You Go Copilot Credit**, i když jde o Cowork nebo Code. Rozlišíte je tagem `servicename` (Group by → Tag).
- Očekávání (ověřit po dry-runu): agenti z labu půjdou přes billing plan prostředí `GOC224-lab`, tedy jako jiný resource.

## Kolik stojí tento lab

Lab má kolem 20 úkolů na studenta: 6 testů v části E, 4–5 v části F, 4 konverzace evaluace a k tomu stavba (nahrání znalostí, nástroj, skill).

| | Výpočet | Kredity | Orientačně |
|---|---|---|---|
| Jeden student | ~20 light úkolů × 100–300 | 2 000–6 000 | $20–60 |
| Třída 20 studentů | 20 × 2 000–6 000 | 40 000–120 000 | $400–1 200 |
| **Se stropem 3 000 na agenta** | 20 × 3 000 | **nejvýš 60 000** | **nejvýš ~$600** |
| Pro srovnání: celý D4 (Cowork + Code) | skutečnost z tenantu | 4 628 | ~$46 |

Co cenu zvyšuje: dlouhé konverzace (každý tah znovu posílá kontext), generování souborů (medium/heavy úkol), opakované běhy evaluace, pokusy „ještě jednou". Co ji snižuje: krátké instrukce, nová konverzace pro nový dotaz, jen dotazy z návodu, jeden běh evaluace ([Billing rates — reasoning models](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-messages-management#how-tokens-are-counted-for-reasoning-models)).

Strop v kurzu nastavuje instruktor jedním ze dvou způsobů: resource-based politika v M365 AC na prostředí `GOC224-lab` s limitem 3 000 na agenta, nebo limit na každého agenta v PPAC (Manage Agents → Set limit → Stop usage). Agent, který limit vyčerpá, odpoví „This agent is currently unavailable. It has reached its usage limit."

## Shrnutí

- Copilot Credit je jednotka (~$0,01 při PAYG). Nejdřív se čerpají předplacené balíčky, pak P3, nakonec PAYG.
- Licence M365 Copilot kryje Copilot Chat a standard harness agenty v kanálech M365. Cowork, Code, Managed Runtime a **GitHub Copilot harness** platíte kredity vždy — GitHub Copilot harness už od stavby.
- Identity-based politika v M365 AC řídí Cowork a Code podle uživatelů; Copilot Studio se řídí v PPAC nebo resource-based politikou v M365 AC, která má přednost.
- M365 AC se obnovuje po 2–4 hodinách, Azure Cost Management má zpoždění 8–72 hodin a do faktury ukazuje jen odhad.
- Dnešní lab stojí řádově stovky dolarů za třídu; strop na agenta z něj dělá předvídatelnou částku.

## Zdroje (Microsoft)

- **Kredity a sazby:** [Billing rates and management (standard harness)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-messages-management) · [Usage-based billing (GitHub Copilot harness)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/billing-credit-overview) · [Copilot Studio licensing](https://learn.microsoft.com/en-us/microsoft-copilot-studio/billing-licensing)
- **Řízení v M365 AC:** [Managing AI experiences enabled by usage-based billing](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-manage-copilot-credits) · [Manage Copilot Studio costs in M365 AC](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-manage-copilot-studio-costs) · [Monitor Copilot Credit spending](https://learn.microsoft.com/en-us/copilot/implement/usage-based-billing-copilot-credits-monitor-spending)
- **Řízení v PPAC:** [Manage costs for agents powered by the GitHub Copilot harness](https://learn.microsoft.com/en-us/power-platform/admin/manage-usage-github-copilot-harness) · [Govern Copilot Credit consumption](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/govern-credit-consumption)
- **Azure:** [Understand Cost Management data](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/understand-cost-mgt-data) · [View costs — Copilot PAYG](https://learn.microsoft.com/en-us/microsoft-365/copilot/pay-as-you-go/view-cost)

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu — stav k 2026-11.
>
> - Cena kreditu, sazebník standard harnessu a rozpětí 100–300 / 300–500 / 500+ pro GitHub Copilot harness ověřit proti licensing guide.
> - Resource-based politiky v M365 AC jsou opt-in novinka; seznam služeb identity-based politik se rozšiřuje automaticky.
> - Interval obnovy karty Monitor a PPAC reportů MS neuvádí — změřit v tenantu.
> - Po Ignite (17.–20. 11. 2026) projít znovu.
