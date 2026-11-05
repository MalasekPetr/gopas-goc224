# Lab · Plán archivace pro kolekci webů

> Modul: archive · Odhad: 25 min · Režim: **simulace, samostatně podle šablony**

## Cíl

Vybrat kandidáty na archivaci, spočítat dopad na náklady podle pravidla kvóty a napsat reaktivační pravidlo.

## Zadání

Použij CSV z D2 PowerShell labu, nebo tuto náhradní tabulku:

> **60 webů**, z toho **18 bez aktivity déle než 12 měsíců** (celkem **400 GB**). Licencovaná SharePoint kvóta tenantu **1 TB (1 000 GB)**. Aktivní data mimo těch 18 webů: **850 GB**.
>
> Tři konkrétní weby k rozhodnutí:
>
> | Web | Poslední aktivita | Velikost | Obsah |
> |---|---|---|---|
> | `/sites/projekt-alfa-2023` | před 20 měsíci | 60 GB | ukončený projekt, dokumentace |
> | `/sites/hr-archiv-smluv` | před 14 měsíci | 40 GB | staré pracovní smlouvy, občas dohledávané |
> | `/sites/intranet-stary` | před 13 měsíci | 25 GB | zastaralé směrnice, platné jsou na novém intranetu |

## Předpoklady

- [ ] Přečtený [README modulu](README.md) — $0.05/GB/měsíc **jen nad rámec kvóty**, reaktivace bez poplatku, 4měsíční zámek.

## Kroky

1. Zkopíruj šablonu a vyplň ji.

```markdown
# Plán archivace — <tenant>

## 1. Kritérium a výjimky
- Kritérium archivace:
- Výjimka 1 (nesmí do archivu):
- Výjimka 2:

## 2. Výpočet
| Položka | GB |
|---|---|
| Aktivní data po archivaci | |
| Archivovaná data | |
| Celkem (aktivní + archiv) | |
| Kvóta | 1 000 |
| Nad kvótou | |
| Cena archivu / měsíc ($0.05/GB nad kvótou) | |

## 3. Rozhodnutí pro 3 weby
| Web | Archiv / RCD / nechat | Odůvodnění (1 věta) |
|---|---|---|
| projekt-alfa-2023 | | |
| hr-archiv-smluv | | |
| intranet-stary | | |

## 4. Reaktivační pravidlo
- Kdo smí žádat:
- Kdo schvaluje a provede:
- Jak dlouho trvá:
- Co znamená 4měsíční zámek:

## 5. Kontrola proti backupu
- Jsou archivované weby v backup policy? Co z toho plyne:
```

2. **Kritérium a výjimky:** retence **není** výjimka — retence platí i v archivu. Hledej skutečné výjimky (např. web, který se v blízké době bude potřebovat aktivně používat; web, který potřebují aplikace nebo integrace).
3. **Výpočet:** archivací se data **nezmenší** — jen se přesunou do levnějšího tieru. Pravidlo: archiv je zdarma, dokud se **aktivní + archiv** vejde do kvóty. **Kontrola:** 850 + 400 = 1 250 GB → 250 GB nad kvótou → **$12,50/měsíc**.
4. **Rozhodnutí:** nápověda — používá se ještě? Má být dohledatelný v Copilotu? Je obsah zastaralý a mohl by Copilot plést (zastaralé směrnice → archiv nebo RCD, aby je Copilot necitoval)?
5. **Reaktivace:** reaktivovaný web **nejde 4 měsíce znovu archivovat**; reaktivace je pro SharePoint bez poplatku.
6. **Backup:** archiv **není záloha** — je to jediná kopie, jen levnější. Zapiš, jestli mají být kritické archivované weby v backup policy (D3 backup lab — předchozí blok).

## Ověření

- [ ] Kritérium + 2 skutečné výjimky (ne retence).
- [ ] Výpočet: 250 GB nad kvótou, $12,50/měsíc.
- [ ] 3 rozhodnutí archiv / RCD / nechat s odůvodněním.
- [ ] Reaktivační pravidlo včetně 4měsíčního zámku.
- [ ] Kontrola proti backupu zapsaná.

## Když něco nejde

| Situace | Co udělat |
|---|---|
| Vychází mi archiv celý zdarma | Sčítej aktivní **i** archivovaná data proti kvótě. |
| Nevím, kdy RCD a kdy archiv | RCD = web zůstává aktivní, jen ho Copilot nevidí; archiv = web se nepoužívá, levnější úložiště; k Copilotu MS uvádí, že na archivovaném obsahu není trénovaný — zda vypadne i z odpovědí, ověř v tenantu. |

## Fallback

- Bez CSV z D2 použij náhradní tabulku ze zadání.

> [!WARNING] Ověřit k datu běhu — cena a pravidlo kvóty podle [Archive pricing](https://learn.microsoft.com/en-us/microsoft-365/archive/archive-pricing), stav k 2026-10.
