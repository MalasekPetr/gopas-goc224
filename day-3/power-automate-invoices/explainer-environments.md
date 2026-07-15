# Výklad · Power Platform Environments — strategie a náš tenant

> Modul: power-automate-invoices (úvod před prvním Power Platform blokem) · Platí i pro D5 Copilot Studio
> Prostředí: viz [`../../environment.md`](../../environment.md) · Názvosloví: [`../../GLOSSARY.md`](../../GLOSSARY.md)

Než postavíme první flow: **kde vlastně poběží?** Environment je základní kontejner Power Platformy — a rozhodnutí „do kterého" má governance, licenční i nákladové důsledky. Páteční Copilot Studio lab na dnešním rozhodnutí přímo stojí.

## Co je environment

Kontejner pro apps, flows, agenty a data (Dataverse) + **hranice pro security, DLP, billing a lifecycle**. Aplikace z jednoho environmentu nevidí data druhého ([Environments overview](https://learn.microsoft.com/en-us/power-platform/admin/environments-overview)). Pro SharePoint admina: environment je pro Power Platform to, co site collection pro SharePoint — jednotka správy a izolace.

## Typy environmentů

| Typ | K čemu | Pro kurz důležité |
| --- | --- | --- |
| **Default** | 1 na tenant, automaticky; **každý uživatel je maker**, nejde smazat ani zablokovat přístup | největší governance riziko — viz doporučení níže |
| **Production** | ostrá řešení | plná kapacita, zálohy 28 dní |
| **Sandbox** | test/vývoj; **jde resetnout** (reset trvale smaže apps/flows/konektory/connections) a přepnout do **administration mode** (přístup jen SysAdmin/Customizer) | reset = elegantní úklid mezi běhy kurzu ([Sandbox environments](https://learn.microsoft.com/en-us/power-platform/admin/sandbox-environments)) |
| **Developer** | osobní workspace makera; až **3 na uživatele**, nepočítají se do kapacity tenantu; po 90 dnech nečinnosti automatický úklid; bez Dynamics apps | cíl environment routingu |
| **Trial** | 30denní zkouška | expiruje — nestavět nic trvalého |

## Doporučená strategie (Microsoft guidance, 2026-05)

Z [Environment strategy](https://learn.microsoft.com/en-us/power-platform/guidance/adoption/environment-strategy):

1. **Default environment = „Personal Productivity", nic víc.** Přejmenuj ho tak, minimalizuj jeho použití (blokovat nejde — ale omezit ano): DLP politika, sharing limity (běžně 5–50 uživatelů), welcome message s pravidly, revize adminů. Default je pro drobné M365 produktivity kustomizace, **ne pro produkční řešení**.
2. **Environment routing** — makery automaticky přesměruje z defaultu do **vlastního developer environmentu** ([Default environment routing](https://learn.microsoft.com/en-us/power-platform/admin/default-environment-routing)); vzniklé environmenty jsou managed a přes **environment groups** dostávají pravidla hromadně. Doplněk: zákaz ručního zakládání environmentů + security group v routing politice.
3. **Vyhrazené environmenty pro reálná řešení** — dev/test/prod s pipelines; sdílený sandbox je lepší než stavět v defaultu, izolovaný developer environment je lepší než sdílený sandbox.
4. **DLP od začátku** (D5 Copilot Studio na to naváže): Business/Non-business/Blocked konektory per environment — flow s fakturami nemá mít vedle sebe povolený osobní Dropbox.

## „Microsoft 365 sandbox" v našem tenantu

V Power Platform admin centru kurzovního tenantu uvidíš předprovisionovaný environment (typicky „Microsoft 365 sandbox" apod.). **Není to žádná M365 funkce ani produkt** — je to artefakt **CDX demo tenantu** (přichází s demo obsahem při provisioningu; Microsoft ho nikde nedokumentuje). Jak s ním zacházet:

- **Nestavět v něm kurzovní assety** — nevíš, co v jeho Dataverse demo content má, a nemáš záruku stavu.
- **Nemazat bez kontroly** — pokud na něm visí demo obsah tenantu, jeho smazání může rozbít jiné demo scénáře; pro kurz stačí ho **ignorovat**.
- Využij ho didakticky: je to učebnicový příklad **environment sprawl** — „environmenty, o kterých admin neví, jak vznikly" jsou přesně to, co strategie výše řeší.

## Doporučení pro kurz (rozhodnutí dnes, platí do pátku)

1. **Založ vyhrazený environment `GOC224-lab`, typ Sandbox** — studentské flows (kdyby na ně došlo) a hlavně **páteční agenti z Copilot Studia** vzniknou tady, ne v defaultu. Po běhu kurzu **reset** = čistý stůl pro další běh.
2. **Připoj k němu Copilot Credits PAYG billing policy** (D2, krok 1b — policy se váže na environment; bez ní studenti v pátek agenta nespustí) a **zkontroluj DLP** (SharePoint konektor musí být povolený).
3. **Default nech čistý** — instruktorské demo flow dnes běží v `GOC224-lab`, ať jde příkladem vlastní governance lekci.
4. Studentům dej do environmentu roli **Environment Maker** (tvorba bez admin práv).

## Zdroje (Microsoft)

[Environments overview](https://learn.microsoft.com/en-us/power-platform/admin/environments-overview) · [Environment strategy](https://learn.microsoft.com/en-us/power-platform/guidance/adoption/environment-strategy) · [Sandbox environments](https://learn.microsoft.com/en-us/power-platform/admin/sandbox-environments) · [Default environment routing](https://learn.microsoft.com/en-us/power-platform/admin/default-environment-routing)

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu — stav k 2026-07.
> Environment routing zatím chytá makery při vstupu přes make.powerapps.com — pokrytí dalších vstupních bodů (Copilot Studio!) se rozšiřuje průběžně; před během ověřit, kudy routing platí. Managed Environments funkce (groups, rules, sharing limity) rostou po vlnách — strategie doc aktualizován 2026-05. Vazba billing policy ↔ environment: ověřit v admin centru, že `GOC224-lab` je u policy uvedený.
