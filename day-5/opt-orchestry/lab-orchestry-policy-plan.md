# Lab · Plán politik v Orchestry

> Modul: opt-orchestry · Odhad: 20 min · Režim: **simulace (papírově, bez instalace), samostatně podle šablony**

## Cíl

Navrhnout sadu governance politik pro 3rd-party vrstvu — a u každé říct, čím by se řešila čistě Microsoft nástroji z kurzu. Teprve kontrolní sloupec ukáže, co 3rd-party reálně přidává.

## Zadání

> Organizace: **800 lidí**, ~**40 nových Teams/webů měsíčně** zakládaných živelně, chystá Copilot rollout.

## Předpoklady

- [ ] Přečtený [README modulu](README.md) — request centrum, lifecycle, Copilot Readiness Dashboard (13 signálů).
- [ ] Znáš z kurzu: SAM inactive site policy (D3), Microsoft 365 Archive (D3), DAG reporty (D3), RCD/RAC (D2–D3).

## Kroky

1. Zkopíruj do poznámek šablonu a vyplň ji. Jeden řádek v každé tabulce je předvyplněný jako vzor.

```markdown
# Plán politik — 800 lidí, 40 nových workspaců/měsíc

## A. Šablony pro request centrum (3)
| Šablona | Kdo schvaluje | Výchozí privacy | Výchozí sensitivity label | Microsoft nástroj bez 3rd-party |
|---|---|---|---|---|
| Projektový tým | vedoucí projektu + IT | Private | Interní | Ruční proces: Teams/SharePoint creation omezené na skupinu + formulář a flow (D4) |
| Oddělení | | | | |
| Externí spolupráce | | | | |

## B. Lifecycle politika
| Prvek | Rozhodnutí | Microsoft nástroj bez 3rd-party |
|---|---|---|
| Kdy je workspace neaktivní | | SAM inactive site policy (D3) |
| Co se stane (notifikace → archivace) | | |
| Kdo rozhoduje | | |

## C. 3 nejdůležitější readiness signály pro Copilot rollout
| Signál | Proč je pro tuto firmu klíčový | Microsoft nástroj bez 3rd-party |
|---|---|---|
| Sdílecí odkazy „Anyone" / celá organizace | 40 nových webů měsíčně = rychle rostoucí oversharing | DAG reporty (D3) + RCD/RAC |
| | | |
| | | |

## D. Co 3rd-party reálně přidává
- <2–3 věty>
```

2. **A — šablony:** vyplň zbývající 2 řádky. U „Externí spolupráce" mysli na hosty a přísnější label.
3. **B — lifecycle:** dej **konkrétní prahy** (např. „bez aktivity 180 dní → notifikace vlastníkovi → po 30 dnech bez reakce archivace do Microsoft 365 Archive").
4. **C — readiness:** vyber ještě 2 signály (např. rozbité dědění oprávnění, chybějící sensitivity labely, workspace bez vlastníka) a odůvodni je zadáním firmy.
5. **Kontrolní sloupec:** ke každému řádku napiš Microsoft nástroj z kurzu, nebo „ruční proces", pokud žádný není.
6. **D — závěr:** ze sloupce „Microsoft nástroj" je vidět, kde 3rd-party jen přebaluje to, co už máš (např. lifecycle ≈ SAM inactive policy + Archive), a kde přidává proces nebo přehled (request workflow, jedno skóre pro management). Napiš to ve 2–3 větách.

## Ověření

- [ ] 3 šablony se schvalovatelem, privacy a labelem.
- [ ] Lifecycle politika s konkrétními prahy (dny) a rozhodovatelem.
- [ ] 3 readiness signály s odůvodněním ze zadání.
- [ ] Kontrolní sloupec vyplněný u všech řádků — bez něj je lab jen opis marketingu.
- [ ] Závěr D pojmenovává, co 3rd-party přidává a co jen přebaluje.

## Když něco nejde

| Situace | Co udělat |
|---|---|
| Málo času | Jen části C a D společně — readiness signály + Microsoft ekvivalenty jsou nejcennější. |
| Nevím Microsoft ekvivalent | Napiš „ruční proces" — i to je zjištění (tady 3rd-party přidává). |

## Fallback

- Lab je papírový — nepotřebuje tenant ani instalaci.
