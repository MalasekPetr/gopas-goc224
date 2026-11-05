# Lab · Licenční matice a odhad nákladů

> Modul: licensing · Odhad: 35 min · Režim: **simulace, samostatně podle šablony** · Podklad: [`README.md`](README.md), [`../../GLOSSARY.md`](../../GLOSSARY.md)

## Cíl

Sestavit licenční matici (co který plán a doplněk odemyká) a spočítat modelový měsíční náklad na Copilot Credits pro fiktivní firmu.

## Zadání

> **Contoso Strojírny**, 200 zaměstnanců na Microsoft 365 Business Premium. Plán: 30 lidí z back-office dostane Copilot licenci, 170 lidí zůstane bez licence a bude používat 2 interní agenty (HR, IT podpora). 10 lidí z back-office bude používat Cowork.

## Předpoklady

- [ ] Přečtený [`README.md`](README.md) — sekce 1 (licenční vrstvy), 2 (dva PAYG modely, dvě plochy Copilot Credits) a 4 (licence vs. permissions).

## Kroky

### Část A — licenční matice (15 min)

1. Zkopíruj do poznámek tabulku a doplň **Ano / Ne / licence + Credits / PAYG**. Dva řádky jsou předvyplněné jako vzor.

   | Schopnost | Bez Copilot licence | Bez licence + Copilot Credits (PAYG) | S Copilot licencí | Zdroj v README |
   |---|---|---|---|---|
   | Copilot Chat nad webem (web-grounded) | Ano | Ano | Ano | §1 |
   | Copilot Chat nad daty tenantu | | | | |
   | Copilot ve Word / Excel / Outlook / Teams (plný) | | | | |
   | Copilot in SharePoint (everyday) + Skills | Ne | **Ne** (po GA, ověřeno 2026-11) | Ano | §4 |
   | Použití agentů (Agent Builder, SharePoint agent) | | | | |
   | Tvorba SharePoint agenta | | | | |
   | Advanced work v SharePointu | | | | |
   | Cowork | | | | |
   | Code | | | | |
   | Document processing (autofill, image tagging) | | | | |

2. Pod tabulku napiš ke každému z těchto pojmů jednu větu:
   - **Dva PAYG modely** — Document processing (Azure metry) vs. Copilot Credits.
   - **Dvě plochy Copilot Credits** — Billing & usage (původní PAYG, budget jen upozorní) vs. Cost management (spending policy, tvrdý strop).
   - **Licence vs. permissions** — co řeší každá z nich.

### Část B — modelový výpočet (15 min)

3. Vyplň tabulku. Použij předpoklady z README: ~**12 kreditů** na tenant-grounded konverzaci s agentem, **~$0,01 za kredit** (PAYG retail).

   | Položka | Předpoklad objemu | Výpočet | Kredity / měsíc | $ / měsíc |
   |---|---|---|---|---|
   | Agenti pro 170 lidí bez licence | 170 lidí × 2 konverzace denně × 20 pracovních dnů | 170 × 2 × 20 × 12 | 81 600 | ≈ 816 |
   | Agenti pro 30 lidí s licencí | | (s licencí bez metrování) | 0 | 0 |
   | Cowork pro 10 lidí | doplň vlastní předpoklad | sazbu ověř v Copilot Credit Estimatoru | | |

4. Odpověz: Je pro 170 lidí levnější PAYG, nebo by se vyplatilo dát licenci části z nich? Napiš, jaké číslo k rozhodnutí potřebuješ (cena licence za uživatele z aktuálního ceníku) a jak by vypadal výpočet bodu zvratu.
5. Napiš, **kde nastavíš strop**: u agentů bez licence (původní PAYG — budget jen upozorní) a u Cowork (spending policy — tvrdý strop). Proč je to rozdíl?

> [!WARNING] Ověřit k datu běhu — stav k 2026-11.
> Ceny licencí a sazby kreditů se mění. Čísla v labu jsou modelová; reálný výpočet dělej z aktuálního ceníku a [Copilot Credit Estimatoru](https://aka.ms/CopilotCreditPlanningModel).

## Ověření

- [ ] Matice odlišuje **oba PAYG modely** a u Copilot Credits obě plochy (původní PAYG vs. usage-based billing).
- [ ] Řádky Cowork / Advanced work / Code jsou „licence + Credits" (ne „Credits místo licence").
- [ ] Řádek Copilot in SharePoint ukazuje, že PAYG bez licence nestačí.
- [ ] Výpočet má uvedený předpoklad objemu u každé položky.
- [ ] Krok 5 správně říká, kde strop existuje a kde ne.

## Když něco nejde

| Situace | Co udělat |
|---|---|
| Nevím, co patří do buňky | Najdi řádek v [`README.md`](README.md) §1–§4 nebo v [`../../GLOSSARY.md`](../../GLOSSARY.md). |
| Nemám cenu licence | Napiš výpočet obecně: `bod zvratu = cena licence / (konverzace × 12 × $0,01)`. |

## Fallback

- Lab je papírový — nepotřebuje tenant. Při nedostatku času část A společně, část B jen řádek „Agenti pro 170 lidí".
