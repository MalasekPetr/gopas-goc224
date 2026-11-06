# Lab · HR Asistent v Copilot Studiu — knowledge, nástroj, skill a evaluace

> Modul: copilot-studio · Odhad: 100 min · Režim: **studenti hands-on, samostatně podle návodu** (stejné kroky jako lektor); go/no-go instruktora, simulace jako fallback
> Navazuje na: D4 [`lab-agent-builder.md`](../../day-4/agent-builder/lab-agent-builder.md) · Scénář: [`scenario-hr-agent.md`](../../day-4/copilot-agents/scenario-hr-agent.md) · Náklady: [`explainer-copilot-credits.md`](explainer-copilot-credits.md)

## Cíl

Postavit v Copilot Studiu na **GitHub Copilot harnessu** agenta **HR Asistent NN**, který:

- odpovídá podle HR směrnice (knowledge),
- čte aktuální data z listu Zaměstnanci (nástroj SharePoint **Get items**),
- má **skill** na kontrolu certifikací, jehož popis vyladíš podle testu,
- projde **evaluací** a ty víš, kolik kreditů tě to stálo.

Je to tentýž HR scénář jako v D4. Agent Builder tam narazil na strop (filtr a počet nad listem), tady ho prorazíš.

> [!IMPORTANT] Tento lab čerpá Copilot Credits od první věty
> GitHub Copilot harness účtuje kredity za stavbu, každou zprávu v **Preview** i za běh evaluace. Licence Microsoft 365 Copilot to nekryje ([Usage-based billing](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/billing-credit-overview)). Instruktor nastavil limit na agenta. Pokládej **jen dotazy z tohoto návodu**, každý v nové konverzaci, a nezkoušej „ještě jednou pro jistotu".

## Předpoklady

- [ ] Přihlášení jako `user.NN@spdemo.online` na `https://copilotstudio.microsoft.com`.
- [ ] Máš přístup do prostředí **GOC224-lab** (role Environment Maker, ověřil instruktor).
- [ ] Na `https://ms365x17157302.sharepoint.com/sites/hr-demo` otevřeš list **Zaměstnanci** (Read stačí).
- [ ] Máš otevřené poznámky s tabulkou testů z D4 Agent Builder labu (pro srovnání).

## Kroky

### Část A — soubory k labu (5 min)

1. Stáhni si do počítače dva soubory z repozitáře kurzu (na GitHubu otevři soubor → **Download raw file**):
   - [`lab-files/hr-smernice-certifikace.md`](lab-files/hr-smernice-certifikace.md) — HR směrnice (bude knowledge),
   - [`lab-files/kontrola-certifikaci.md`](lab-files/kontrola-certifikaci.md) — skill (nahraješ v části F).
2. Otevři směrnici a přečti si ji (2 minuty). Všimni si lhůt: **30 dní**, **14 dní**, **5 pracovních dnů**, **10 pracovních dnů**. Podle nich budeš kontrolovat odpovědi.
3. Otevři skill. Všimni si hlavičky: `name` a **úmyslně úzký** `description` („jeden konkrétní zaměstnanec"). Opravíš ho v části F.

**Kontrola:** oba soubory máš uložené a víš, kde jsou.

### Část B — založení agenta (10 min)

4. Otevři `https://copilotstudio.microsoft.com`. Vlevo dole v **přepínači prostředí** vyber **GOC224-lab** (ne výchozí prostředí).
5. Na domovské stránce vyber **Agent** (nebo vlevo **Agents** → **New agent**). Tím zakládáš agenta na GitHub Copilot harnessu. **Nevolíš** *Other ways to build* — to je standard harness.
6. Do **Name** napiš (NN = tvoje číslo):

   ```text
   HR Asistent NN
   ```

7. Do **Instructions** vlož:

   ```text
   Jsi HR Asistent. Pomáháš HR referentům se stavem zaměstnanců, certifikací a dokumentů k podpisu.

   Pravidla a lhůty ber ze znalostního zdroje Směrnice HR a u každého pravidla uveď zdroj. Aktuální data o zaměstnancích ber z nástroje Načti zaměstnance. Nevymýšlej zaměstnance, data ani pravidla.

   Odpovídej česky, stručně a věcně. Zaměstnance identifikuj osobním číslem a jménem. U seznamů vypiš všechny odpovídající záznamy jako tabulku. Data počítej od dnešního data.

   Do odpovědí nedávej e-mailové adresy. Nic neodesílej a neměň data — jen připravuješ podklady.

   Na dotazy mimo HR agendu odpověz: „Pomáhám jen s HR agendou."
   ```

8. Klikni **Save**.

**Kontrola:** agent *HR Asistent NN* existuje v prostředí GOC224-lab a nahoře vidíš karty **Build**, **Preview**, **Evaluate** a **Monitor**.

### Část C — knowledge: směrnice a hranice práv (10 min)

9. Na kartě **Build** v sekci **Knowledge** otevři **Add knowledge** → **Drag and drop or click to upload** → nahraj `hr-smernice-certifikace.md` → **Add to agent**. Počkej, až se nahrání dokončí.
10. Klikni na nahraný soubor a v **Edit knowledge source** vyplň:
    - Name: `Směrnice HR`
    - Description:

      ```text
      Pravidla HR pro certifikace (lhůty, upozornění manažera, propadlé certifikace) a dokumenty k podpisu (urgence, eskalace). Neobsahuje data o konkrétních zaměstnancích.
      ```

    Klikni **Save**.
11. **Test hranice práv — druhý zdroj:** znovu **Add knowledge** → **SharePoint** → vlož URL webu spolužáka, ke kterému **nemáš přístup**, například `https://ms365x17157302.sharepoint.com/sites/user.MM` (MM = jiné číslo než tvoje) → název `Cizí web` → **Add to agent**.

**Kontrola:** v sekci Knowledge jsou 2 zdroje: Směrnice HR a Cizí web.

### Část D — nástroj nad listem Zaměstnanci (15 min)

12. Na kartě **Build** v sekci **Tools** otevři **Add a tool** → **Connectors** → vyhledej `SharePoint` → u SharePointu klikni **See more** → vyber akci **Get items** → **+ Add** (vytvoří se připojení pod tvým účtem).
13. Klikni na přidaný nástroj. V **Tool details** nastav:
    - Name: `Načti zaměstnance`
    - Description for AI:

      ```text
      Načte aktuální seznam zaměstnanců z listu Zaměstnanci: osobní číslo (OsobniCislo), jméno, útvar (Utvar), pozice, manažer (Manazer), lokalita, vyžadované certifikace (VyzadovaneCertifikace), certifikace platí do (CertifikacePlatiDo), dokument k podpisu (DokumentKPodpisu), stav. Použij pro dotazy na konkrétní zaměstnance, filtry, počty a certifikace. Nástroj jen čte, nic nemění.
      ```

14. V sekci **Inputs** u každého vstupu přepni na **Custom** a vyplň:

    | Vstup | Hodnota |
    |---|---|
    | Site address | `https://ms365x17157302.sharepoint.com/sites/hr-demo` |
    | List name | `Zaměstnanci` |

    Ostatní volitelné vstupy nech beze změny. List má 20 řádků, nástroj vrátí všechny.
15. **Governance kontrola — čí identitou nástroj čte:** v detailu nástroje hledej nastavení autentizace (**Additional details** / **Authentication** — přesný název se může lišit). Zapiš si, zda je zvoleno **End user credentials** (každý uživatel čte svými právy), nebo **Maker-provided credentials** (všichni čtou tvými právy). Nic neměň. Pokud nastavení nevidíš, zapiš „nenalezeno".
16. Klikni **Done** a pak **Save**.

**Kontrola:** v sekci Tools je nástroj *Načti zaměstnance* s vyplněnou adresou webu a názvem listu.

### Část E — testy knowledge a nástroje (15 min)

17. Přepni na kartu **Preview**. Každý dotaz polož **v nové konverzaci** a **přesně v uvedeném znění**. Když se agent poprvé zeptá na oprávnění k SharePointu, klikni **Approve** (může se zeptat víckrát).

    | # | Typ | Dotaz | Očekávání | Výsledek | V D4 (Agent Builder) |
    |---|---|---|---|---|---|
    | 1 | směrnice | „Kolik dní předem musí HR upozornit na konec platnosti certifikace a koho?" | 30 dní, přímého manažera; cituje Směrnici HR | | — |
    | 2 | lookup | „Ukaž údaje a manažera zaměstnance s osobním číslem 10018." | Markéta Horáková, Výroba, Svářeč, Ostrava, manažer Tomáš Procházka | | |
    | 3 | filtr | „Komu propadá certifikát do 30 dnů?" | osoby s „Certifikace platí do" ≤ dnes + 30 dní — ověř filtrem v listu (při čerstvě nasazených datech **10018, 10022, 10027**) | | |
    | 4 | počet | „Kolik zaměstnanců má nepodepsaný dokument? Vypiš je." | **4: 10017, 10019, 10025, 10029** | | |
    | 5 | negativní | „Jaké bude zítra počasí v Praze?" | „Pomáhám jen s HR agendou." | | |
    | 6 | hranice práv | „Co je v dokumentech na webu Cizí web?" | nic z cizího webu — k webu nemáš přístup | | |

18. U testů 2–4 otevři podrobnosti aktivity (průběh odpovědi) a ověř, že agent volal nástroj **Načti zaměstnance**.
19. Do posledního sloupce přepiš výsledky stejných dotazů z D4. **Kde je rozdíl a proč?**

**Kontrola:** tabulka testů 1–6 je vyplněná; testy 3 a 4 odpovídají filtru v listu.

### Část F — skill a jeho popis (20 min)

20. Na kartě **Build** v sekci **Skills** vyber **Upload a skill** a nahraj `kontrola-certifikaci.md`. Ověř, že se skill objevil v sekci Skills.
21. V **Preview** (nová konverzace) polož:

    ```text
    Má Markéta Horáková (10018) platnou certifikaci?
    ```

    Očekávání: v aktivitě je vidět skill *kontrola-certifikaci*; odpověď: certifikace platí, ale propadá do 30 dnů, upozornit manažera Tomáše Procházku.
22. Nová konverzace — **široký dotaz**:

    ```text
    Připrav podklady pro manažery: komu propadá nebo už propadla certifikace a co mají podle směrnice udělat.
    ```

    Prohlédni aktivitu. Popis skillu mluví jen o „jednom konkrétním zaměstnanci", takže skill se nemusí spustit nebo výsledek nebude seskupený podle manažerů. Zapiš, co se stalo.
23. **Uprav popis skillu.** V souboru `kontrola-certifikaci.md` nahraď řádek `description:` tímto:

    ```yaml
    description: Použij, když uživatel potřebuje stav certifikací — kontrolu jednoho zaměstnance, seznam propadajících nebo propadlých certifikací, přehled podle útvaru, lokality nebo manažera, nebo podklady a upozornění pro manažery.
    ```

    Ulož soubor. Na kartě **Build** otevři skill → **(...)** → **Replace** a nahraj upravený soubor. Pokud Replace chybí, skill smaž a nahraj znovu.
24. Nová konverzace — zopakuj široký dotaz z kroku 22. Očekávání (při čerstvě nasazených datech):
    - **Tomáš Procházka**: 10018, 10022, 10027 — propadá do 30 dnů, objednat obnovu, školení do 14 dní,
    - **Jana Nováková**: 10016, 10024 — propadlá, přeřadit a zaevidovat do 5 pracovních dnů,
    - u každého manažera návrh upozornění, žádné e-mailové adresy.
25. Nová konverzace — `Jak upéct chleba?` Skill se **nesmí** spustit a agent odpoví „Pomáhám jen s HR agendou."

    | Test | Skill spuštěn? | Výsledek |
    |---|---|---|
    | 21 — jeden zaměstnanec | | |
    | 22 — široký dotaz, úzký popis | | |
    | 24 — široký dotaz, nový popis | | |
    | 25 — mimo rozsah | | |

**Kontrola:** po úpravě popisu skill obslouží široký dotaz a nespustí se na dotaz mimo HR.

### Část G — evaluace (15 min)

> [!NOTE]
> Evaluace na GitHub Copilot harnessu je v preview. Když karta **Evaluate** chybí, přeskoč na část H a zapiš „Evaluate nedostupné".

26. Otevři kartu **Evaluate** → **New evaluation** (nebo **+ Create your first evaluation**). Případné podmínky preview potvrď.
27. V **Create or select a data set** vyber typ **Conversations** → **Or, write some questions yourself**. Název: `HR Asistent NN — evaluace`. Ověř, že metoda testu je **General quality**.
28. Přes **+ Add conversations** → **Write a conversation** přidej 4 konverzace (každou ulož **Done** → **Save**):

    | Konverzace | Otázka uživatele | Očekávaná odpověď (pro tvou kontrolu) |
    |---|---|---|
    | směrnice | `Do kdy musí proběhnout školení po upozornění na konec platnosti certifikace?` | do 14 dní od upozornění |
    | filtr | `Kdo z útvaru Výroba má certifikát propadající do 30 dnů?` | 10018, 10022, 10027 |
    | nejasný dotaz | `Potřebuju něco ohledně certifikátů.` | agent se doptá, o koho nebo o co jde |
    | mimo rozsah | `Doporuč mi restauraci na týmový oběd.` | Pomáhám jen s HR agendou. |

    Očekávanou odpověď General quality neporovnává, je jen pro tvou ruční kontrolu.
29. Klikni **Run**. Když se otevře **Manage connections**, vyber připojení pod svým účtem → **Continue**. Počkej na dokončení a otevři výsledky.
30. U každé konverzace zapiš skóre a jestli odpověď odpovídá očekávání. U nejslabší konverzace najdi příčinu (instrukce, popis nástroje, popis skillu).

**Kontrola:** evaluace doběhla, máš zapsané 4 výsledky a jednu příčinu. Druhý běh nespouštěj — každý běh stojí kredity.

### Část H — kolik to stálo a kdo to řídí (10 min)

31. Otevři kartu **Monitor** a zapiš, kolik kreditů agent zatím spotřeboval. Porovnej s odhadem v [`explainer-copilot-credits.md`](explainer-copilot-credits.md#kolik-stojí-tento-lab).
32. Odpověz do poznámek:
    - Kdo platí kredity tvého agenta — ty, nebo prostředí GOC224-lab? (MS: kredity se účtují prostředí, ne tvůrci ani uživateli.)
    - Co by se stalo, kdyby nástroj z kroku 15 běžel pod **maker-provided credentials** a agenta by použil kolega bez práv na `hr-demo`?
    - Proč tvého agenta nejde publikovat do kanálu **SharePoint**? (Nápověda: srovnání harnessů v README.)
    - Kde odpoledne v `copilot-admin` agenta uvidí správce a podle čeho pozná, že běží na GitHub Copilot harnessu?
33. Agenta **nepublikuj** a **nemaž** — odpoledne s ním pracuje `copilot-admin`. Publikaci do Teams předvede instruktor.

## Ověření

- [ ] Agent *HR Asistent NN* na GitHub Copilot harnessu v GOC224-lab, se 2 zdroji knowledge, nástrojem *Načti zaměstnance* a skillem *kontrola-certifikaci*.
- [ ] Tabulka testů 1–6 vyplněná včetně srovnání s D4; test 6 nevrátil nic z cizího webu.
- [ ] Skill: zapsaný rozdíl mezi úzkým a novým popisem; test mimo rozsah skill nespustil.
- [ ] Evaluace se 4 konverzacemi doběhla (nebo zapsáno „Evaluate nedostupné").
- [ ] Zapsaná spotřeba kreditů z karty Monitor a 4 odpovědi governance reflexe.

## Když něco nejde

| Příznak | Příčina | Řešení |
|---|---|---|
| Copilot Studio se otevře v jiném prostředí | přepínač prostředí | vlevo dole vyber GOC224-lab; když ho nevidíš, hlas instruktorovi |
| Agent nemá sekci **Skills** | agent vznikl přes *Other ways to build* (standard harness) | založ agenta znovu přes **Agent** na domovské stránce |
| „This agent is currently unavailable. It has reached its usage limit." | agent vyčerpal limit kreditů | hlas instruktorovi; dál pokračuj predikcí výsledků do tabulek |
| Nástroj vrací chybu přístupu | chybí souhlas nebo Read na `hr-demo` | v Preview klikni **Approve**; ověř, že list otevřeš v prohlížeči |
| Testy 3–4 nesedí s očekáváním | data nasazená k jinému datu | zdroj pravdy je filtr v listu; porovnej s ním |
| Test 6 vrátí obsah | na web `user.MM` máš přístup | zvol jiné číslo `MM` a zdroj uprav |
| Replace u skillu chybí | verze UI | skill smaž a nahraj upravený soubor znovu |
| Evaluace se nespustí | chybí připojení | obnov stránku, v Manage connections vytvoř připojení pod svým účtem, spusť znovu |

## Fallback

- Copilot Studio nebo prostředí nedostupné, případně vyčerpaný limit: instruktor staví agenta podle částí B–F na plátně, ty zapisuješ predikce do tabulek testů a pak je porovnáš se skutečností.

## Zdroje (Microsoft)

[Agents powered by the GitHub Copilot harness](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/overview) · [Skills overview](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/skills-overview) · [Add SharePoint as a knowledge source](https://learn.microsoft.com/en-us/microsoft-copilot-studio/knowledge-add-sharepoint) · [Control maker-provided credentials](https://learn.microsoft.com/en-us/microsoft-copilot-studio/configure-no-maker-authentication) · [Usage-based billing](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/billing-credit-overview)

---

Postup labu vychází z oficiálních labů Microsoftu *Create an equipment recommendation agent* a *Evaluate and publish a support agent* ([MicrosoftLearning/mslearn-copilotstudio](https://github.com/MicrosoftLearning/mslearn-copilotstudio), licence MIT, Copyright (c) 2019 Sidney Andrews), upravených na HR scénář a prostředí kurzu GOC224.
