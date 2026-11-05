# Lab · HR Asistent v Agent Builderu (hands-on)

> Modul: agent-builder · Odhad: 40 min · Režim: **studenti hands-on, samostatně podle návodu**; simulace fallback
> Scénář a data: [`../copilot-agents/scenario-hr-agent.md`](../copilot-agents/scenario-hr-agent.md) · Návrh: [`../copilot-agents/lab-agent-design.md`](../copilot-agents/lab-agent-design.md)

## Cíl

Postavit agenta **HR Asistent NN** v Agent Builderu nad daty zaměstnanců, otestovat ho evaluačním plánem a na vlastní kůži vidět jeho strop — analytiku, kterou neumí, prolomí zítra Copilot Studio (D5).

## Předpoklady

- [ ] Přihlášení jako `user.NN@spdemo.online` (s Copilot licencí) na `https://m365.cloud.microsoft/chat`.
- [ ] Vidíš HR web `https://ms365x17157302.sharepoint.com/sites/hr-demo`: list **Zaměstnanci** (20 řádků) a knihovny **Certifikáty** a **Smlouvy**.

> [!NOTE] `NN` = tvoje číslo účtu. Všichni stavíte nad stejnými daty — číslo v názvu agenta odliší tvého agenta od ostatních.

## Kroky

### Část A — evaluační plán (8 min, psací)

1. Do poznámek si zkopíruj tabulku. Sloupec „Očekávání" je předvyplněný podle dat scénáře, kritérium úspěchu si napiš sám (např. „projdou testy 1, 2, 4, 5").

   | # | Typ | Dotaz | Očekávání | Výsledek |
   |---|---|---|---|---|
   | 1 | lookup | „Ukaž údaje a manažera zaměstnance s osobním číslem 10018." | údaje z listu Zaměstnanci (útvar, pozice, manažer, platnost certifikace) | |
   | 2 | hledání v souboru | „Najdi pracovní smlouvu pro osobní číslo 10024." | odkaz na dokument v knihovně Smlouvy | |
   | 3 | analytický | „Komu propadá certifikát do 30 dnů?" | **neúplný nebo nespolehlivý výčet** (správně: 10018, 10022, 10027) | |
   | 4 | negativní | „Jaké bude zítra počasí v Praze?" | odmítne — není to HR dotaz | |
   | 5 | hranice práv | „Ukaž mzdový výměr osobního čísla 10013." | jen pokud máš ke knihovně Smlouvy přístup; agent nikdy neukáže víc, než smíš vidět ty | |

### Část B — stavba agenta (17 min)

2. V Microsoft 365 Copilot klikni v levém panelu na **New agent**.
3. Na stránce **New agent** klikni **Skip to configure** (stavíme ručně, ať vidíš každé pole).
4. Vyplň na kartě **Configure**:

   **Name** (max. 30 znaků):

   ```text
   HR Asistent NN
   ```

   **Description**:

   ```text
   Pomáhá HR referentům s údaji o zaměstnancích, certifikátech a smlouvách na HR webu. Vyhledá zaměstnance podle osobního čísla a najde k němu dokumenty.
   ```

   **Instructions** (zkopíruj celé):

   ```text
   # Účel
   Jsi HR Asistent pro HR referenty. Pomáháš dohledat údaje o zaměstnancích, jejich certifikacích a smlouvách.

   # Zdroje
   - List Zaměstnanci: údaje o zaměstnancích. Klíčem je Osobní číslo.
   - Knihovna Certifikáty: skeny certifikátů, metadata Osobní číslo a Platí do.
   - Knihovna Smlouvy: smlouvy a dodatky, metadata Osobní číslo a Stav podpisu.

   # Pravidla
   - Odpovídej česky a stručně.
   - Zaměstnance vždy identifikuj osobním číslem a jménem.
   - U dokumentu vždy uveď název souboru a odkaz.
   - Když údaj ve zdrojích nenajdeš, napiš to. Nic si nedomýšlej.
   - Na dotazy mimo HR agendu odpověz: „Pomáhám jen s HR agendou."
   - Osobní údaje uváděj jen v rozsahu, na který se uživatel ptá.
   ```

5. **Knowledge** — přidej tři zdroje:
   - **List Zaměstnanci:** v sekci **Knowledge** klikni na ikonu **Attach cloud files** (mrak) → v levém panelu **Recent lists** → vyber **Zaměstnanci**. *Když ho tam nevidíš:* otevři list v prohlížeči, klikni **Share** → **Copy link**, vlož odkaz do pole **Enter URL** a stiskni **Enter**. Web sám o sobě listy **nezahrnuje** — list musí být přidaný zvlášť.
   - **Knihovna Certifikáty:** otevři ji v prohlížeči, zkopíruj adresu z adresního řádku **bez části za `?`** a vlož ji do **Enter URL** → **Enter**.
   - **Knihovna Smlouvy:** stejně jako Certifikáty.
6. Zapni přepínač **Only use specified sources** (agent upřednostní tvoje zdroje; obecné znalosti tím úplně nezablokuješ).
7. **Starter Prompts** — přidej dva (název + text):

   | Název | Text |
   |---|---|
   | Údaje zaměstnance | Ukaž údaje a manažera zaměstnance s osobním číslem 10018. |
   | Smlouva | Najdi pracovní smlouvu pro osobní číslo 10024. |

8. Počkej, až u zdrojů v **Knowledge** zmizí stav **Preparing** (tlačítkem obnovit nad sekcí si stav načteš znovu).

**Kontrola:** v sekci **Knowledge** jsou 3 položky (1 list + 2 knihovny), přepínač **Only use specified sources** je zapnutý.

### Část C — testy (10 min)

9. Přepni na kartu **Try it** a polož 5 dotazů z tabulky v části A **přesně v uvedeném znění**. Do sloupce „Výsledek" zapiš: prošlo / neprošlo + co agent vrátil.
10. U testu 3 porovnej výčet se správnou odpovědí (10018, 10022, 10027). **Builder data neagreguje ani nefiltruje — jen prioritizuje zdroje.** Zapiš, které osoby chyběly nebo přebývaly.
11. **Jedna iterace:** vyber nejhorší test kromě testu 3, uprav jednu větu v **Instructions** nebo **Description** (např. přidej „Když se ptám na osobní číslo, vypiš všechny sloupce záznamu jako odrážky.") a test zopakuj. Zapiš, jestli se výsledek zlepšil.
12. Klikni **Create** (vpravo nahoře; popisek se může lišit). Agent se uloží a objeví v seznamu agentů v levém panelu Copilotu. **Nesdílej ho s celou organizací** — je to tvůj testovací agent.

### Reflexe — most do D5

13. Test 3 neprošel. Proč? Kdo ho umí? Zapiš jednou větou. (Dopoledne ho jako **aplikace** zvládl dashboard v Code; jako **agent** ho zítra zvládne Copilot Studio.)

## Ověření

- [ ] Agent *HR Asistent NN* má instrukce z kroku 4 a 3 zdroje (list Zaměstnanci, knihovny Certifikáty a Smlouvy).
- [ ] Tabulka s 5 testy je vyplněná, skóre zapsané (x/5).
- [ ] Test 3: zapsáno, které osoby chyběly / přebývaly, a proč (Builder neagreguje).
- [ ] Jedna iterace se změřeným efektem.
- [ ] Agent není sdílený s celou organizací.

## Když něco nejde

| Příznak | Příčina | Řešení |
|---|---|---|
| V levém panelu není **New agent** | licence se nepropsala nebo admin Agent Builder vypnul | odhlas se a přihlas znovu; jinak hlas instruktorovi a jdi na fallback |
| List **Zaměstnanci** není v **Recent lists** | list jsi v poslední době neotevřel | otevři list v prohlížeči a zkus znovu, nebo přidej přes **Share → Copy link → Enter URL** |
| URL nejde přidat | odkaz obsahuje parametry za `?` nebo neobsahuje `/sites/…` | smaž vše od `?`; odkaz musí obsahovat `/sites/hr-demo/` |
| Agent odpovídá „nemám informace" i na test 1 | zdroj je ještě ve stavu **Preparing** | počkej pár minut, obnov sekci **Knowledge** |
| Agent odpovídá z obecných znalostí | vypnutý přepínač **Only use specified sources** | zapni ho; obecné znalosti tím ale úplně nezablokuješ (MS) |

## Fallback

- Agent Builder nedostupný: část A je plnohodnotný deliverable. Instruktor postaví HR Asistenta v demu přesně podle části B, třída píše do tabulky predikce a pak je porovná s výsledky na plátně.

## Poznámka k nákladům

S Copilot licencí agent v Copilotu kredity nečerpá. U uživatelů na PAYG by ale každý testovací dotaz byl Copilot Credits — proto 5 promyšlených testů + 1 iterace, ne brute-force.

## Zdroje (Microsoft)

[Build agents in Agent Builder](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/agent-builder-build-agents) · [Add knowledge sources in Agent Builder](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/agent-builder-add-knowledge) · [Agent Builder overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/agent-builder)
