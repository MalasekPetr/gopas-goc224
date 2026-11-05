# Lab · Backup posture review & restore drill

> Modul: backup · Odhad: 30 min · Režim: **simulace (návrh, samostatně podle šablony) + instruktorské demo restore**

## Cíl

Posoudit backup posture fiktivní firmy, navrhnout backup policy s cenovým argumentem a napsat restore plán s měřitelnou testovací kadencí.

## Zadání

> **Firma:** 200 lidí, 60 webů (z toho **10 kritických** — smlouvy, finance), OneDrive pro všechny, Exchange Online. Dnes žádný backup — spoléhá na koš a verzování.
> **Incident:** včera v 14:20 škodlivý skript přepsal obsah 2 kritických webů. Koš nestačil (soubory nebyly smazané, ale přepsané napříč stovkami verzí).
>
> **Objemy pro výpočet:** 10 kritických webů = 300 GiB · všech 60 webů = 1 000 GiB · OneDrive 200 × 10 GiB = 2 000 GiB · Exchange 200 × 5 GiB = 1 000 GiB.

## Předpoklady

- [ ] Přečtený [README modulu](README.md) — rozsah, RPO/RTO, cena ($0.15/GiB/měsíc chráněného obsahu, obnovy zdarma).

## Kroky

1. Zkopíruj šablonu a vyplň ji.

```markdown
# Backup posture — <firma>

## 1. Díry současného stavu (3)
| # | Díra | Proč je to problém při incidentu ze zadání |
|---|---|---|
| 1 | | |
| 2 | | |
| 3 | | |

## 2. Backup policy
| Varianta | Rozsah | GiB | Cena / měsíc |
|---|---|---|---|
| A — jen kritické | 10 kritických webů | 300 | |
| B — vše | weby + OneDrive + Exchange | | |
- Doporučení a argument:
- Kdo dostane roli Microsoft 365 Backup Administrator (role, ne jméno):

## 3. Restore plán pro incident
| Položka | Rozhodnutí |
|---|---|
| Restore point (čas) | |
| Typ obnovy (celý web / granulární) | |
| Očekávané RTO | |
| Kdo obnovu spouští a kdo ji ověřuje | |

## 4. Testovací kadence (drill)
| Co | Jak často | Kdo | Měřítko úspěchu |
|---|---|---|---|
| | | | |
```

2. **Díry:** mysli na hromadný incident (koš a verzování řeší jednotlivé soubory, ne přepsání stovek souborů), na RPO bez záloh a na to, kdo by obnovu vůbec dělal.
3. **Policy:** spočítej obě varianty ($0.15 × GiB). Kontrola: varianta A = **$45/měsíc**, varianta B = 4 000 GiB → **$600/měsíc**. Napiš, kterou doporučíš a proč.
4. **Restore plán:** restore pointy jsou **à 10 minut** po dobu 2 týdnů → vyber poslední bod **před 14:20**. Express restore webu trvá **10–120 minut**; obnova celého webu = vrácení do stavu před incidentem (zmizí i legitimní změny po 14:20 — napiš, jak je dohledáš).
5. **Kadence:** měřitelně. Minimum: **1 express restore testovacího webu za kvartál**, měří se doba obnovy proti cílovému RTO.
6. **Demo:** instruktor ukáže výběr restore pointu a obnovu testovacího webu. Porovnej skutečný čas s odhadem z kroku 4.

## Ověření

- [ ] 3 konkrétní díry vázané na incident ze zadání.
- [ ] Obě varianty policy spočítané ($45 / $600), doporučení s argumentem, role určená.
- [ ] Restore plán má čas restore pointu před 14:20, typ obnovy, RTO a odpovědné role.
- [ ] Kadence drilu je měřitelná (ne „občas otestovat").

## Když něco nejde

| Situace | Co udělat |
|---|---|
| Nevím, jak dohledat legitimní změny po incidentu | Audit log (D5) + verze souborů po obnově; nebo granulární obnova jen přepsaných souborů (preview — ověřit). |
| Nesedí mi výpočet | GiB × 0,15 = $/měsíc; B = 1 000 + 2 000 + 1 000 GiB. |

## Fallback

- Backup v tenantu nezapnutý (go/no-go): krok 6 na screenshotech z dokumentace; kroky 1–5 beze změny.

> [!WARNING] Ověřit k datu běhu — cena a RPO/RTO podle [Backup pricing](https://learn.microsoft.com/en-us/microsoft-365/backup/backup-pricing) a [Backup overview](https://learn.microsoft.com/en-us/microsoft-365/backup/backup-overview), stav k 2026-10.
