# M · Orchestry — možnosti řízení Copilotu (volitelný)

> Typ: **volitelný (V)** · Den: 5 (po monitoringu) · Odhad: krátký blok
> Prostředí: viz [`../../environment.md`](../../environment.md) · Názvosloví: [`../../GLOSSARY.md`](../../GLOSSARY.md)

> [!NOTE] Volitelný **leaf** modul — Capstone na něm nezávisí (kdo ho nestihne, není znevýhodněn). Navazuje na 3rd-party řádek mapy vrstev z `copilot-admin`; běží hned po `monitoring`.

## Cíle

- Student ví, co 3rd-party governance vrstva přidává nad Microsoft nástroje (SAM, CCS, Agent 365).
- Student umí formulovat kritéria „kdy nekupovat" — kdy Microsoft stack stačí.

## Výklad

> [!IMPORTANT] Zdroje tohoto modulu jsou **třetí strana** (orchestry.com), ne Microsoft — výjimka z kurzovního pravidla, u produktových tvrzení to říkat explicitně.

### Co Orchestry přidává

- **Provisioning se šablonami** — standardizované zakládání Teams/webů/Groups přes **request centrum** se schvalováním (governance od vzniku, ne dodatečně) ([orchestry.com — governance](https://www.orchestry.com/microsoft-365-governance)).
- **Lifecycle a archivace** — automatizované řízení stárnutí workspaces, permission/guest reviews, delegace na vlastníky.
- **Copilot Readiness Dashboard** — tenant-wide skóre z **13 governance signálů** (sharing linky, rozbité dědění, chybějící labely, ownership drift…) — „jsme připraveni pustit Copilota?" jako číslo ([orchestry.com — Copilot readiness](https://www.orchestry.com/microsoft-365-copilot/copilot-readiness)).

### Kam patří v mapě vrstev (z copilot-admin)

Microsoft nástroje řídí *co a kdo smí*; Orchestry a spol. přidávají *proces a přehled*: šablonový vznik, request workflow, readiness skóre. Překryv existuje (lifecycle vs. SAM inactive sites, archivace vs. M365 Archive) — 3rd-party dává jednotné UX a delegaci, platí se za to licencí navíc.

## Klíčové rozlišení

- **Kupovat vs. nekupovat**: malý tenant s IT kapacitou → SAM + CCS + skripty stačí; velká organizace se samoobslužným zakládáním workspaces → 3rd-party šetří provozní práci. Rozhoduje objem requestů a kdo je vyřizuje, ne feature list.
- **Readiness skóre vs. DAG reporty**: stejná data (oversharing, labely), jiné podání — DAG = syrové reporty pro admina, readiness = agregát pro management. Obojí stojí na tom, co učil D3.

## Naše prostředí

- Bez instalace do kurzovního tenantu — výklad + průchod veřejnými materiály/screenshoty. Lab je papírový.

## Lab

Viz [`lab-orchestry-policy-plan.md`](lab-orchestry-policy-plan.md) — plán politik (simulace).

## Zdroje (třetí strana — Orchestry)

[Microsoft 365 governance](https://www.orchestry.com/microsoft-365-governance) · [Copilot readiness](https://www.orchestry.com/microsoft-365-copilot/copilot-readiness)

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu — stav k 2026-07.
> 3rd-party feature set a pricing se mění rychleji než Microsoft docs; před během projít orchestry.com. Zvážit rotaci příkladů (ShareGate, AvePoint…) podle publika — modul je o *kategorii* nástrojů, ne o jednom vendorovi.
