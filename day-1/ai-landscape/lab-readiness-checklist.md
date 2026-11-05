# Lab · Readiness checklist a gap log

> Modul: ai-landscape · Odhad: 30 min · Režim: **simulace / řízená diskuse, samostatně podle šablony** · Prostředí: [`../../environment.md`](../../environment.md)

## Cíl

Sestavit Copilot readiness checklist pro kurzový tenant (nebo svou organizaci) a zapsat gapy s dopadem a akcí — s důrazem na datové hranice a governance.

## Předpoklady

- [ ] Hotový onboarding lab (přístup do tenantu).
- [ ] Přečtený [`README.md`](README.md) — grounding, permission trimming, EU Data Boundary, AI subprocesoři.

## Kroky

### Část A — checklist (15 min)

1. Zkopíruj tabulku a u každé položky zapiš **OK / gap / N/A** a **jak jsi to ověřil/a** (kde jsi to viděl/a, nebo „odhad").

   | Oblast | Kontrolní otázka | Stav | Jak ověřeno |
   |---|---|---|---|
   | Identita | Mají všichni uživatelé MFA? | | |
   | Identita | Je nastavený Conditional Access? | | |
   | Grounding | Víme, které weby jsou přesdílené (odkazy „celá organizace" / „kdokoli")? | | |
   | Grounding | Používají se sensitivity labely? | | |
   | Grounding | Mají citlivé weby (HR, finance) omezený přístup? | | |
   | Datové hranice | Víme, že je tenant v EU Data Boundary a co z ní je vyňato (web search, Anthropic modely)? | | |
   | Datové hranice | Je rozhodnuto, zda povolit AI subprocesory (OpenAI, Anthropic)? | | |
   | Licencování | Víme, kdo má Copilot licenci a kdo jen Copilot Chat / PAYG? | | |
   | Governance | Existují pravidla práce s AI pro uživatele? | | |
   | Governance | Je určený vlastník AI governance (role)? | | |

   **Vzor vyplnění pro kurzový tenant:**

   | Oblast | Kontrolní otázka | Stav | Jak ověřeno |
   |---|---|---|---|
   | Identita | Mají všichni uživatelé MFA? | OK | onboarding lab — MFA vynucené Conditional Access |

### Část B — gap log (10 min)

2. Každý **gap** přepiš do gap logu. Akce musí být konkrétní (co, kde, kdo) a pokud možno odkazovat na nástroj, který uvidíš během kurzu.

   | Oblast | Gap | Dopad | Akce | Vlastník (role) | Modul kurzu |
   |---|---|---|---|---|---|
   | Grounding | nevíme, které weby jsou přesdílené | Copilot najde a ukáže obsah, který vidět nemá | spustit DAG report sdílecích odkazů, citlivé weby omezit RAC / RCD | SharePoint admin | D3 `advanced-management` |
   | | | | | | |

3. Zapiš **aspoň jeden bod k datovým hranicím** (EU Data Boundary, vyňetí web search nebo Anthropic modelů, rozhodnutí o subprocesorech).

### Část C — sdílení (5 min)

4. Řekni nahlas jeden gap, který považuješ za nejrizikovější, a proč.

## Ověření

- [ ] Checklist má vyplněných všech 10 položek včetně „jak ověřeno".
- [ ] Každý gap má dopad, konkrétní akci a vlastníka (roli).
- [ ] Aspoň jeden bod k datovým hranicím.

## Když něco nejde

| Situace | Co udělat |
|---|---|
| Nevím, jak položku ověřit | Zapiš „odhad" a do gap logu akci „ověřit v <modul>". |
| Nemám vlastní organizaci | Vyplň pro kurzový tenant podle [`../../environment.md`](../../environment.md). |

## Fallback

- Bez přístupu do tenantu: řízená diskuse nad modelovým tenantem, checklist vyplníte společně.
