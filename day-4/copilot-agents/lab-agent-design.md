# Lab · Návrh agenta a plán vyhodnocení

> Modul: copilot-agents · Odhad: 40 min · Režim: **návrh v MD, samostatně podle šablony**; stavba v navazujících blocích
> Worked example: [`scenario-hr-agent.md`](scenario-hr-agent.md) · Cesty tvorby: [`README.md`](README.md) · Srovnání: [`comparison-agent-paths.md`](comparison-agent-paths.md)

## Cíl

Navrhnout agenta pro scénář ze své praxe — účel, instrukce, knowledge, cestu tvorby — a plán, podle kterého poznáš, že funguje. Výstupem je jeden MD soubor, ze kterého půjde agenta rovnou postavit (odpoledne v Agent Builderu, zítra v Copilot Studiu).

## Předpoklady

- [ ] Znáš strukturu instrukcí z D2 [`prompting-fundamentals`](../../day-2/prompting-fundamentals/README.md) (purpose → guidelines → skills).
- [ ] Máš otevřenou tabulku cest tvorby v [`README.md`](README.md).
- [ ] Editor pro Markdown (VS Code, nebo nový soubor `navrh-agenta-NN.md` na svém SharePoint webu).

## Kroky

### Krok 1 — vyber scénář (5 min)

1. Vyber opakovaný dotaz ze své práce, na který dnes odpovídá člověk (FAQ oddělení, onboarding, směrnice, provozní postupy). **Nemáš vlastní?** Použij **HR Asistenta** — vzorové vyplnění je níže.
2. Zkopíruj si šablonu do souboru `navrh-agenta-NN.md`:

```markdown
# Návrh agenta: <název>

## 1. Účel (jedna věta)
<Agent pomáhá KOMU s ČÍM.>

## 2. Instrukce
# Účel
<…>
# Pravidla
- <…>
- <…>
# Co nedělat
- <…>

## 3. Knowledge
| Zdroj | URL / umístění | Kdo k němu má přístup |
|---|---|---|
| | | |

## 4. Cesta tvorby
- Volba: <Agent Builder / Copilot Studio / Agents Toolkit / SharePoint agent>
- Argument 1 (kdo tvoří a udržuje): <…>
- Argument 2 (kam se distribuuje): <…>

## 5. Plán vyhodnocení
| # | Typ | Dotaz | Očekávání |
|---|---|---|---|
| 1 | běžný | | |
| 2 | běžný | | |
| 3 | běžný | | |
| 4 | negativní | | |
| 5 | hranice práv | | |

Kritérium úspěchu: <např. projdou min. 4 z 5, testy 4 a 5 povinně>
```

### Krok 2 — vyplň šablonu (25 min)

3. **Účel:** jedna věta „Agent pomáhá KOMU s ČÍM". Když potřebuješ dvě věty, máš dva agenty.
4. **Instrukce** (max. ~1 500 znaků pro lab): **chování**, ne obsah. Fakta (ceník, směrnice, postupy) patří do knowledge, ne do instrukcí — instrukce ≠ knowledge (D2, XPIA).
5. **Knowledge:** konkrétní weby / knihovny / listy s URL. U každého zdroje napiš, kdo k němu má přístup — agent nikdy neukáže víc, než smí vidět uživatel.
6. **Cesta tvorby:** vyber z tabulky v README a napiš 2 argumenty — kdo agenta postaví a **bude udržovat**, a kam se bude distribuovat.
7. **Plán vyhodnocení:** 5 dotazů s očekávanou odpovědí. Povinně:
   - **negativní test** — na co agent odpovídat **nemá**,
   - **test hranice práv** — dotaz na data, ke kterým tazatel nemá přístup.

### Krok 3 — peer review (10 min)

8. Vyměň si návrh se sousedem a zkontroluj podle checklistu v sekci Ověření. Ke každé nesplněné položce napiš jeden konkrétní návrh opravy.
9. Uprav svůj návrh podle připomínek. Návrh použiješ v [`../agent-builder/lab-agent-builder.md`](../agent-builder/lab-agent-builder.md) (dnes) a v D5 `copilot-studio`.

## Vzorové vyplnění — HR Asistent

```markdown
# Návrh agenta: HR Asistent

## 1. Účel
Agent pomáhá HR referentům dohledat údaje o zaměstnancích, certifikátech a smlouvách.

## 2. Instrukce
# Účel
Jsi HR Asistent pro HR referenty. Pomáháš dohledat údaje o zaměstnancích, jejich certifikacích a smlouvách.
# Pravidla
- Odpovídej česky a stručně.
- Zaměstnance identifikuj osobním číslem a jménem.
- U dokumentu uveď název souboru a odkaz.
# Co nedělat
- Nedomýšlej si údaje, které ve zdrojích nejsou.
- Neodpovídej na dotazy mimo HR agendu.

## 3. Knowledge
| Zdroj | URL / umístění | Kdo k němu má přístup |
|---|---|---|
| List Zaměstnanci | /sites/hr-demo — list Zaměstnanci | HR tým (v kurzu všichni studenti) |
| Knihovna Certifikáty | /sites/hr-demo — knihovna Certifikáty | HR tým |
| Knihovna Smlouvy | /sites/hr-demo — knihovna Smlouvy | HR tým; mzdové výměry jen HR vedení |

## 4. Cesta tvorby
- Volba: Agent Builder (dnes), Copilot Studio (zítra kvůli analytice)
- Argument 1: staví a udržuje HR referent sám, bez IT
- Argument 2: sdílí se jen HR týmu, ne celé organizaci

## 5. Plán vyhodnocení
| # | Typ | Dotaz | Očekávání |
|---|---|---|---|
| 1 | běžný | Ukaž údaje a manažera os. č. 10018. | záznam z listu |
| 2 | běžný | Najdi pracovní smlouvu pro os. č. 10024. | odkaz na soubor ve Smlouvy |
| 3 | běžný | Komu propadá certifikát do 30 dnů? | osoby z listu s „Certifikace platí do" ≤ dnes + 30 dní (při čerstvém nasazení dat 10018, 10022, 10027); Builder neagreguje — očekávej selhání |
| 4 | negativní | Jaké bude zítra počasí? | odmítne |
| 5 | hranice práv | Ukaž mzdový výměr os. č. 10013. | uživatel bez přístupu nedostane nic |

Kritérium úspěchu: projdou testy 1, 2, 4, 5; test 3 dokumentuje strop nástroje.
```

## Ověření (checklist pro peer review)

- [ ] Účel je jedna věta „KOMU s ČÍM".
- [ ] Instrukce popisují chování a **neobsahují fakta** (ta jsou v knowledge).
- [ ] Každý zdroj má umístění a informaci, kdo k němu má přístup.
- [ ] Volba cesty má 2 argumenty, jeden z nich o **údržbě**.
- [ ] Plán vyhodnocení má 5 dotazů s očekáváním, včetně **negativního testu** a **testu hranice práv**.
- [ ] Kritérium úspěchu je měřitelné (počet testů).

## Když něco nejde

| Situace | Co udělat |
|---|---|
| Nemám vlastní scénář | Použij HR Asistenta; ve stavbě pak porovnáš svoje očekávání s realitou. |
| Instrukce mají přes 1 500 znaků | Pravděpodobně obsahují fakta — přesuň je do zdroje a v instrukcích na zdroj jen odkaž. |
| Nevím, jak napsat test hranice práv | Zeptej se na dokument, který na webu existuje, ale tazatel k němu nemá oprávnění. Očekávání: agent ho nenajde. |

## Fallback

- Návrh je samostatný deliverable — nepotřebuje tenant. 2–3 návrhy projdeme nahlas, instruktor jeden postaví v demu.
