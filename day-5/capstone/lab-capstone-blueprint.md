# Lab · Závěrečný projekt — rollout blueprint

> Modul: capstone · Odhad: 40 min + 20 min prezentace · Režim: **individuální design dokument (MD), samostatně podle šablony**

## Cíl

Sestavit rollout blueprint pro vlastní organizaci — každé rozhodnutí opřené o konkrétní nástroj z kurzu — a obhájit ho ve 3 minutách.

## Předpoklady

- [ ] Máš své výstupy z týdne: návrh agenta (D4), runbook (D5 monitoring), tabulku z admin tour (D5), poznámky z labů.
- [ ] **Nemáš vlastní organizaci** (konzultant, student)? Použij fiktivní firmu: **Contoso Strojírny, 200 zaměstnanců, 60 SharePoint webů, 30 Copilot licencí, cíl: Copilot pro back-office (HR, finance, nákup).**

## Kroky

### Krok 1 — založ dokument (2 min)

1. Na svém webu `https://ms365x17157302.sharepoint.com/sites/user.NN` vytvoř v knihovně Dokumenty soubor `blueprint-NN.md` (nebo ho piš ve VS Code) a zkopíruj do něj šablonu:

```markdown
# Rollout blueprint: <organizace>

## 1. Kontext
- Velikost (lidé / weby):
- Licenční stav (Copilot licence, PAYG, spending policy):
- Cíl nasazení (1 věta):
- Hlavní rizikové místo (1 věta):

## 2. Konfigurace
| Oblast | Rozhodnutí | Nástroj z kurzu | Proč |
|---|---|---|---|
| Licence vs. PAYG | | D1 licensing | |
| Copilot Credits (PAYG / spending policy, strop, Auto-apply) | | D2 configuration | |
| Kde Copilot nesmí (RCD / RSS) | | D2 configuration, D3 SAM | |
| Autoritativní obsah | | D2 configuration | |

## 3. Automatizace
- Proces k automatizaci (vzor: faktury z D4 power-automate-invoices):
- Cesta vytěžení a schvalování:
- Kde rozhoduje pravidlo / člověk a kde jen AI navrhuje:
- Agent (z návrhu D4): název, účel, cesta tvorby, kdo ho udržuje:
- Cesta bez AI, kterou jsem zvážil/a (pravidlo, flow, pohled listu…), a proč nestačí:

## 4. Governance
| Oblast | Rozhodnutí | Kde (portál) |
|---|---|---|
| SAM politiky (inactive sites, RAC, DAG) | | SharePoint admin center |
| Kdo má AI Administrator | | Entra / M365 AC |
| Agenti — registr, schvalování publikace | | M365 AC → Agents |
| Aplikace z Code / Cowork | | M365 AC → Apps |
| Audit + runbook | | Purview Audit |
| Backup policy + archivní strategie | | M365 AC / SharePoint admin center |

## 5. Registr rizik
| Riziko | Dopad | Pravděpodobnost | Mitigace (nástroj z kurzu) | Vlastník (role) |
|---|---|---|---|---|
| Oversharing | | | | |
| Náklady Copilot Credits | | | | |
| Ztráta dat | | | | |
| Nekontrolovaní agenti | | | | |
| Adopční selhání | | | | |

## 6. Change enablement
1. <komunikační krok — co, komu, kdy>
2.
3.

## 7. Roadmapa
| Fáze | Rozsah | Go/no-go brána (měřitelná) |
|---|---|---|
| Pilot | | |
| Rozšíření | | |
| Plný provoz | | |
```

### Krok 2 — vyplň sekce (38 min)

2. **Kontext** (3 min) — 4 řádky, žádné odstavce.
3. **Konfigurace** (7 min) — u každé oblasti konkrétní rozhodnutí, ne „zapneme Copilota". Příklad dobrého řádku:

   | Oblast | Rozhodnutí | Nástroj z kurzu | Proč |
   |---|---|---|---|
   | Copilot Credits | spending policy pro skupinu „Back-office pilot", per-user strop (např. 1 000 kreditů/měsíc — konkrétní číslo podle odhadu z Copilot Credit Estimatoru), Auto-apply vypnuté | D2 configuration | nové služby schvalujeme ručně, pilot má tvrdý strop |

4. **Automatizace** (7 min) — jeden proces + jeden agent. Agenta zkopíruj z návrhu D4 a doplň, kdo ho bude udržovat. **Hledej nejefektivnější nástroj, ne AI za každou cenu:** dá se to vyřešit pohledem listu, pravidlem nebo flow? Kolik by stál každý běh s AI? Musí výsledek vyjít pokaždé stejně? Když cesta bez AI stačí, napiš to — je to plnohodnotná odpověď. Viz README, sekce *Efektivní nástroj, ne AI za každou cenu*.
5. **Governance** (7 min) — u každého řádku konkrétní politika a portál. Opři se o tabulku z D5 admin tour.
6. **Registr rizik** (8 min) — 5 povinných kategorií. Mitigace musí být **nástroj z kurzu** (např. „RCD na weby HR a Finance", ne „školení"). Vlastník = role. Příklad:

   | Riziko | Dopad | Pravděpodobnost | Mitigace | Vlastník |
   |---|---|---|---|---|
   | Náklady Copilot Credits | nové služby (Cowork, Code) začnou čerpat kredity bez schválení | střední | Auto-apply new services vypnuté u všech spending policies; měsíční kontrola Cost management → Consumption | AI Administrator |

7. **Change enablement + roadmapa** (6 min) — 3 komunikační kroky; 3 fáze, každá s **měřitelnou** branou (např. „≥ 60 % pilotních uživatelů aktivních týdně podle usage reportu a 0 incidentů oversharingu za 4 týdny").

### Krok 3 — prezentace (3 min na studenta)

8. Připrav 3 věty:
   - **Kontext** (1 věta),
   - **rozhodnutí, na které jsi hrdý/á**, a proč (klidně to, kde jsi AI záměrně nepoužil/a),
   - **největší riziko** a jak ho mitiguješ.
9. Ostatní: každý položí aspoň jednu otázku za celý blok.

## Ověření

- [ ] Všech 7 sekcí vyplněných; každá odkazuje na konkrétní nástroj nebo politiku z kurzu.
- [ ] Každé použití AI v sekci Automatizace má zdůvodnění, proč nestačí cesta bez AI, a kroky s pevným výsledkem řeší pravidlo, flow nebo člověk.
- [ ] Registr rizik má 5 kategorií, každé riziko mitigaci nástrojem z kurzu a vlastníka (roli).
- [ ] Roadmapa má 3 fáze s měřitelnými go/no-go branami.
- [ ] Prezentace proběhla a ustála otázku.

## Když něco nejde

| Situace | Co udělat |
|---|---|
| Nestíhám | Sekce 2–4 jsou jádro; 5–7 dopiš po prezentacích. |
| Nevím, který nástroj na mitigaci | Projdi „Klíčové rozlišení" v README modulů D2–D5 — každý řeší jedno riziko. |
| Mitigace zní obecně („školení", „hlídat") | Přepiš na konkrétní nastavení: kde (portál), co (politika), kdo (role). |

## Fallback

- Časová tíseň: sekce 2–4 jsou jádro; 5–7 lze dopsat po prezentacích.
