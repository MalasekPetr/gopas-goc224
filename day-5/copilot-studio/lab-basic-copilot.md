# Lab · HR Asistent v Copilot Studiu — agent s analytikou nad listem

> Modul: copilot-studio · Odhad: 50 min · Režim: **studenti hands-on, samostatně podle návodu** (go/no-go instruktora); simulace fallback
> Navazuje na: D4 [`lab-agent-builder.md`](../../day-4/agent-builder/lab-agent-builder.md) · Scénář: [`scenario-hr-agent.md`](../../day-4/copilot-agents/scenario-hr-agent.md)

## Cíl

Postavit v Copilot Studiu agenta **HR Analytik NN** nad listem Zaměstnanci, položit mu dotazy, na které Agent Builder v D4 nestačil (filtr, počet), a otestovat hranici práv.

## Předpoklady

- [ ] Přihlášení jako `user.NN@spdemo.online` na `https://copilotstudio.microsoft.com` (přístup ověřil instruktor).
- [ ] V tomto prohlížeči jsi v posledních dnech otevřel list **Zaměstnanci** na `https://ms365x17157302.sharepoint.com/sites/hr-demo` — jinak ho teď otevři, ať se objeví v **Recent Lists**.
- [ ] Máš tabulku testů z D4 Agent Builder labu (pro srovnání).

> [!IMPORTANT] Který harness
> Lab jede na **standard harnessu** (klasická zkušenost) — účtuje se až po publikaci. Nová zkušenost (**GitHub Copilot harness**) čerpá Copilot Credits už při stavbě a testování ([Billing](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/billing-credit-overview)). MS dokumentuje **analytické a agregační dotazy nad listy výslovně pro novou zkušenost** ([SharePoint lists (GitHub Copilot)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/knowledge-sharepoint-lists)); na standard harnessu se list ingestuje do Dataverse a jak dobře agreguje, zjistíš právě testy 2 a 3.

## Kroky

### Část A — založení agenta (10 min)

1. Na domovské stránce Copilot Studia klikni **Other ways to build** a založ nového agenta ve **standard harnessu** (klasická zkušenost). Pokud jsi omylem v nové zkušenosti: **⋯** dole v bočním panelu → **Open classic experience**.
2. Vyplň:

   **Name:**

   ```text
   HR Analytik NN
   ```

   **Description** (podle popisu generative orchestration rozhoduje — piš pečlivě):

   ```text
   Odpovídá HR referentům na dotazy nad seznamem zaměstnanců: vyhledání podle osobního čísla, filtrování podle útvaru, lokality nebo platnosti certifikace a počty zaměstnanců.
   ```

   **Instructions:**

   ```text
   # Účel
   Jsi HR Analytik. Odpovídáš na dotazy nad listem Zaměstnanci.

   # Pravidla
   - Odpovídej česky a stručně.
   - Zaměstnance identifikuj osobním číslem a jménem.
   - U filtrů a počtů vypiš všechny odpovídající záznamy jako tabulku (osobní číslo, jméno, útvar, relevantní sloupec).
   - „Do 30 dnů" počítej od dnešního data.
   - Když údaj v listu není, napiš to. Nic si nedomýšlej.
   - Na dotazy mimo HR agendu odpověz: „Pomáhám jen s HR agendou."
   ```

3. Ulož / vytvoř agenta (**Create**).

### Část B — knowledge a nastavení (10 min)

4. Na stránce **Knowledge** klikni **Add knowledge**.
5. V sekci **Upload file** vyber **SharePoint** → **Browse items** → **Recent Lists** → zaškrtni **Zaměstnanci** → **Confirm selection**.
6. Vyplň název a popis zdroje:
   - Název: `Zaměstnanci`
   - Popis: `Seznam zaměstnanců: osobní číslo, jméno, útvar, pozice, manažer, lokalita, platnost certifikace, dokument k podpisu, stav.`
7. Klikni **Add to agent**. Počkej, až je zdroj ve stavu **Ready**.
8. **Test hranice práv — druhý zdroj:** znovu **Add knowledge** → v sekci **Featured** vyber **SharePoint** → vlož URL webu spolužáka, ke kterému **nemáš přístup**, např. `https://ms365x17157302.sharepoint.com/sites/user.MM` (MM = jiné číslo než tvoje) → název `Cizí web` → **Add to agent**.
9. V nastavení agenta (**Settings** → **Generative AI**) vypni **Use general knowledge** a vypni **Web Search**. Agent pak odpoví „no response", když ve zdrojích nic nenajde.

**Kontrola:** na stránce **Knowledge** jsou 2 zdroje (Zaměstnanci, Cizí web), obecné znalosti i web search jsou vypnuté.

### Část C — testy (20 min)

10. Otevři testovací panel (**Test**) a polož dotazy **přesně v uvedeném znění**:

    | # | Typ | Dotaz | Očekávání | Výsledek | V D4 (Agent Builder) |
    |---|---|---|---|---|---|
    | 1 | lookup | „Ukaž údaje a manažera zaměstnance s osobním číslem 10018." | záznam z listu | | |
    | 2 | filtr | „Komu propadá certifikát do 30 dnů?" | **10018, 10022, 10027** | | |
    | 3 | počet | „Kolik zaměstnanců má nepodepsaný dokument? Vypiš je." | **4: 10017, 10019, 10025, 10029** | | |
    | 4 | negativní | „Jaké bude zítra počasí v Praze?" | odmítne / no response | | |
    | 5 | hranice práv | „Co je v dokumentech na webu Cizí web?" | **no response** — k webu nemáš přístup | | |

11. Do posledního sloupce přepiš výsledky stejných typů dotazů z D4. **Kde je rozdíl a proč?**
12. **Jedna iterace:** u nejhoršího testu uprav jednu věc — popis zdroje (krok 6), popis agenta nebo jednu větu instrukcí — a test zopakuj. Zapiš efekt.
13. Agenta **nepublikuj** do žádného kanálu. Publikace (Requests → admin) je instruktorské demo.

## Ověření

- [ ] Agent *HR Analytik NN* na standard harnessu se zdrojem Zaměstnanci (Ready) a vypnutými obecnými znalostmi.
- [ ] Tabulka 5 testů vyplněná včetně srovnání s D4.
- [ ] Test 5 dopadl „no response" (permission trimming).
- [ ] Jedna iterace se změřeným efektem.
- [ ] Agent nepublikovaný.

## Když něco nejde

| Příznak | Příčina | Řešení |
|---|---|---|
| Copilot Studio nejde otevřít / nemáš prostředí | přístup studentů není povolený | hlas instruktorovi → fallback |
| List není v **Recent Lists** | list jsi v tomto prohlížeči neotevřel | otevři ho v SharePointu a zkus znovu, nebo vlož URL listu |
| Zdroj zůstává ve stavu přípravy | ingest do Dataverse běží | počkej pár minut; mezitím piš testy |
| Testy 2–3 vrací neúplný výčet | standard harness agreguje hůř než nová zkušenost | zapiš jako zjištění; iteruj popis zdroje (krok 6) — viz rámeček *Který harness* |
| Test 5 vrátí obsah | URL vede na web, kam přístup máš | zvol jiné číslo `MM` |
| Agent odpovídá z obecných znalostí | v Generative AI zůstalo zapnuté Use general knowledge | krok 9 |

## Fallback

- Copilot Studio nedostupný: instruktor postaví agenta podle části A–B na plátně, třída zapisuje predikce do tabulky testů a pak je porovná.

## Poznámka k nákladům

Na standard harnessu MS účtuje až po publikaci; studenti s M365 Copilot licencí mají zero-rating pro odpovědi a tenant graph grounding. Přesto 5 promyšlených testů + 1 iterace, ne brute-force ladění.

## Zdroje (Microsoft)

[Access standard harness agents](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/switch-experiences) · [Add SharePoint as a knowledge source](https://learn.microsoft.com/en-us/microsoft-copilot-studio/knowledge-add-sharepoint) · [SharePoint lists (GitHub Copilot harness)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/knowledge-sharepoint-lists) · [Billing — GitHub Copilot harness](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/billing-credit-overview)
