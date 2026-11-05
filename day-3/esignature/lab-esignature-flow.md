# Lab · eSignature schvalovací flow

> Modul: esignature · Odhad: 25 min · Režim: **simulace, samostatně podle šablony** (zapnutí služby = admin operace)

## Cíl

Navrhnout kompletní podpisový proces pro konkrétní scénář — od požadavku po archivaci a audit — a rozhodnout mezi Microsoft eSignature a partnerským poskytovatelem.

## Zadání

> **Dodavatelská smlouva.** Interní schvalovatel: vedoucí nákupu. Externí podepisující: jednatel dodavatele (mimo tenant). Smlouva vzniká ve Wordu, podepisuje se PDF.

## Předpoklady

- [ ] Přečtený [README modulu](README.md) — poskytovatelé, B2B, retence, audit.

## Kroky

1. Zkopíruj šablonu a vyplň ji. Řádek „Příprava dokumentu" je předvyplněný jako vzor.

```markdown
# Podpisový proces — dodavatelská smlouva

## A. Fáze procesu
| # | Fáze | Aktér | Nástroj | Výstup |
|---|---|---|---|---|
| 1 | Příprava dokumentu | referent nákupu | Word v SharePoint knihovně Smlouvy | finální PDF |
| 2 | Interní schválení | | | |
| 3 | Podpisový request | | | |
| 4 | Podpis | | | |
| 5 | Uložení | | | |
| 6 | Audit | | | |

## B. Poskytovatel
- Volba: <Microsoft eSignature / Adobe Acrobat Sign / Docusign>
- Argument 1:
- Argument 2:

## C. Externí podepisující
- Co musí být v tenantu povoleno:

## D. Uložení a retence
- Kde skončí podepsaný dokument:
- Jak dlouho se drží pracovní kopie a proč:

## E. Dohledání za půl roku
- Kde:
- Co přesně hledám:
```

2. **A — fáze:** u každé fáze rozliš **schválení** (Approvals v Power Automate / Teams — interní souhlas) a **podpis** (eSignature — právně podepsaný dokument). Interní schválení není podpis.
3. **B — poskytovatel:** dva věcné argumenty. Nápověda: je podepisující externí? Má firma už licenci Adobe / Docusign? Kolik stojí request v PAYG (README)? Jaký typ podpisu podle eIDAS potřebujete?
4. **C — externí podepisující:** co musí být povoleno, aby dostal request mimo tenant (Microsoft Entra B2B integrace pro SharePoint a OneDrive).
5. **D — uložení:** kam se podepsaný dokument uloží a jak dlouho se drží pracovní kopie (výchozí retence vs. vaše retenční politika).
6. **E — audit:** kde a co hledáš (Purview Audit, aktivity eSignature; konkrétní období a dokument).

## Ověření

- [ ] Všech 6 fází má aktéra, nástroj a výstup; schválení a podpis jsou rozlišené.
- [ ] Volba poskytovatele má 2 věcné argumenty.
- [ ] B2B předpoklad pro externího podepisujícího je identifikovaný.
- [ ] Uložení a retence jsou konkrétní.
- [ ] Auditní dohledání je konkrétní (portál, aktivita, období).

## Když něco nejde

| Situace | Co udělat |
|---|---|
| Nevím, jestli fáze je schválení, nebo podpis | Ptej se: vzniká právně podepsaný dokument? Ano = eSignature, ne = Approvals. |
| Nevím cenu requestu | Viz README modulu a [PAYG pricing](https://learn.microsoft.com/en-us/microsoft-365/documentprocessing/syntex-pay-as-you-go-services) — ověřit k datu běhu. |

## Fallback

- eSignature je v tenantu zapnuté a zbývá čas: instruktor předvede živý request na testovacím PDF; sleduj notifikaci a audit trail a porovnej je se svou fází 3–6.
