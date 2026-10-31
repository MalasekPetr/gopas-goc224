# SharePoint Advanced Management (SAM)

> Typ: povinný · Den: 3 · Odhad: AM/PM blok
> Prostředí: viz [`../../environment.md`](../../environment.md) · Názvosloví: [`../../GLOSSARY.md`](../../GLOSSARY.md)

## Cíle

- Student umí zařadit SAM jako **SharePoint vrstvu správy** (weby, obsah, sdílení) v mapě nástrojů pro správu.
- Student zná tři pilíře SAM a umí vybrat politiku pro konkrétní governance problém.
- Student ví, jak se SAM licencuje a proč je to „příprava tenantu na Copilot".

## Výklad

### Tři pilíře SAM

Spravuje se ze SharePoint admin centra ([SAM overview](https://learn.microsoft.com/en-us/sharepoint/advanced-management)):

```mermaid
flowchart TB
  SAM[SharePoint Advanced Management]
  SAM --> S[Content sprawl]
  SAM --> L[Content lifecycle]
  SAM --> O[Oversharing]
  S --> S1[Site ownership policy · inactive site policy · atestace webů]
  L --> L1[Change history 180 dní · admin akce 30 dní · restricted site creation]
  O --> O1[RAC · Conditional Access kontexty · block download · RCD · DAG reporty · access reviews]
```

- **Content sprawl**: politika vlastnictví webů, **inactive site policy** (notifikace vlastníkům), atestace.
- **Content lifecycle**: katalog webů, **change history reporty (180 dní zpět)**, nedávné admin akce (30 dní), omezení zakládání webů aplikacemi.
- **Agenti** (nové): reporty agent insights a agent-access insights + **SharePoint Admin Agent** ([SAM overview](https://learn.microsoft.com/en-us/sharepoint/advanced-management)) — SAM se rozšiřuje i na governance agentů nad SharePointem.
- **Oversharing** (nejdůležitější pro Copilot): **Restricted Access Control (RAC)** — přístup k webu/OneDrive jen pro security groups; **Restricted Content Discovery (RCD)** — web zůstane přístupný, ale Copilot/search ho negrounduje; **DAG reporty** (permission state, sharing links za 28 dní, EEEU insights, per-user permissions); site access reviews; porovnání politik až přes 10 000 webů.

### Proč před Copilotem

Copilot respektuje permissions — **oversharing se stává AI problémem**: co je přesdílené, Copilot ochotně najde. SAM (DAG reporty → RAC/RCD) je hlavní Microsoft nástroj, jak to srovnat před rolloutem. Tahle nit pokračuje v D5 [`copilot-admin`](../../day-5/copilot-admin/README.md).

### Licencování

SAM není jeden SKU, ale sada funkcí se **dvěma odemykacími cestami** ([SAM features in Copilot licenses](https://learn.microsoft.com/en-us/sharepoint/sharepoint-advanced-management-features-copilot-license), [Prerequisites](https://learn.microsoft.com/en-us/sharepoint/sharepoint-advanced-management-prerequisites)):

- **SAM Plan 1 add-on** — samostatná per-user licence (cena: ověřit, MS stránka ji neuvádí; viz D1); cesta pro organizace bez Copilotu.
- **Copilot licence** — **jedna přiřazená licence odemyká SAM funkce pro celý tenant** (přesně náš případ). Platí i pro **E7**, které Copilot obsahuje. Feature set je totožný s Plan 1 až na jedinou dokumentovanou výjimku: *restricted site creation by apps* vyžaduje Plan 1 i tak. DAG report nad sensitivity labels chce navíc E5.
- Formulační pozor: neříkat „SAM zdarma s Copilotem" — Copilot licence je dražší než Plan 1; odemčení SAM je vedlejší efekt.
- **Role:** nově existuje **SharePoint Advanced Management Administrator** — SAM jde delegovat bez plné role SharePoint Administrator ([Prerequisites](https://learn.microsoft.com/en-us/sharepoint/sharepoint-advanced-management-prerequisites)).

## Klíčové rozlišení

- **RAC vs. RCD**: RAC bere lidem *přístup*; RCD bere Copilotu/search *viditelnost* (lidé s odkazem se dostanou dál). Pro „tajné, ale používané" weby je správně RCD, pro „nikdo tam nemá co dělat" RAC.
- **SAM vs. Purview**: SAM řídí *weby a sdílení* (SharePoint vrstva); Purview řídí *data a compliance* (labely, retence, audit). Doplňují se, nenahrazují.
- **Licence vs. permissions** znovu: SAM licence odemyká funkce adminovi; na obsah webů tím admin práva nezískává.

## Naše prostředí

- Politiky aplikuje **instruktor** (SharePoint admin, tenant-wide dopad); studenti jako Global Reader čtou SharePoint admin centrum a ověřují výsledek — viz lab.

## Lab

Viz [`lab-sam-policies.md`](lab-sam-policies.md) — aplikace a ověření politik.

## Zdroje (Microsoft)

[SharePoint Advanced Management overview](https://learn.microsoft.com/en-us/sharepoint/advanced-management) · [SAM features in Copilot licenses](https://learn.microsoft.com/en-us/sharepoint/sharepoint-advanced-management-features-copilot-license) · [SAM prerequisites](https://learn.microsoft.com/en-us/sharepoint/sharepoint-advanced-management-prerequisites)

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu — stav k 2026-10.
> Odemknutí SAM přes Copilot licenci: v běhu 2026-07 **potvrzeno** (instruktorský účet má Copilot licenci) — pro další běhy ověřit znovu. Feature set SAM roste po měsících (overview aktualizovaná 2026-10: agent insights, agent-access insights, SharePoint Admin Agent). Nová role SAM Administrator. Cena Plan 1 — ověřit v ceníku. Stará URL `sharepoint-advanced-management-licensing` přesměrovává na *features-copilot-license*.
