# Lab · První agent v Agents Toolkitu — agent jako spravovaná konfigurace

> Modul: agents-toolkit · Odhad: 35 min · Režim: **studenti hands-on, samostatně podle návodu** · Publikum: **správci**
> Scénář: [`../copilot-agents/scenario-support-agent.md`](../copilot-agents/scenario-support-agent.md) · Srovnání cest: [`../copilot-agents/comparison-agent-paths.md`](../copilot-agents/comparison-agent-paths.md)

## Cíl

Postavit deklarativního agenta **Support Asistent** v Microsoft 365 Agents Toolkitu **jako verzovanou konfiguraci** — editací **manifestu (JSON)**, bez psaní kódu a **bez opuštění M365**. Na konci máš agenta nasazeného v tenantu, otestovaného 4 dotazy, a umíš vysvětlit rozdíl proti Agent Builderu.

> [!IMPORTANT] Rozsah — správci, ne vývojáři
> **Žádné Azure, žádné externí API, žádný hosting.** Editujeme jen manifest (JSON — znáš ho z D1 `formats`). **Akci (API plugin) nestavíme** — slot `actions` jen pojmenujeme; „udělej něco v tenantu" se řeší přes Power Automate (D3).

## Předpoklady

- [ ] **VS Code** + rozšíření **Microsoft 365 Agents Toolkit** (ikona Toolkitu v levém panelu VS Code).
- [ ] Přihlášení v Toolkitu: panel Toolkitu → **Accounts** → **Sign in to Microsoft 365** účtem `user.NN@spdemo.online`. U účtu musí být zelená fajfka u *Custom app upload enabled* (jinak hlas instruktorovi).
- [ ] Máš čtení na knihovně **Runbooky**: otevři `https://ms365x17157302.sharepoint.com/sites/hr-demo/Runbooky` — vidíš 4 soubory `.md`.

> [!NOTE] Všude, kde je v návodu `NN`, doplň své číslo účtu (např. `user.17` → `17`). Agenti všech studentů jsou v jednom tenantu — bez čísla se v nich nevyznáš ty ani admin.

## Kroky

### Část A — založení projektu (5 min)

1. V panelu Toolkitu klikni **Create a New Agent/App**.
2. Vyber **Declarative Agent**.
3. Na otázku o akci / pluginu vyber **No Action** (bez akce). *Popisky se mezi verzemi Toolkitu mění — vždy volíš variantu bez akce / bez API.*
4. Vyber složku pro projekt (např. `Dokumenty\goc224`) a jako název aplikace zadej `support-asistent-NN`.
5. VS Code otevře nový projekt. V Průzkumníku najdi složku **`appPackage`** a v ní:
   - `declarativeAgent.json` — **manifest agenta** (to budeme upravovat),
   - `manifest.json` — app manifest (obal pro nasazení),
   - případně `instruction.txt` — instrukce agenta v samostatném souboru.

**Kontrola:** v `appPackage` vidíš `declarativeAgent.json`. Pokud ne, projekt nevznikl jako Declarative Agent — začni znovu od kroku 1.

### Část B — orientace v manifestu (3 min)

6. Otevři `declarativeAgent.json` a najdi tyto vlastnosti. Zapiš si, co která dělá:

   | Vlastnost | Co dělá |
   |---|---|
   | `$schema`, `version` | verze schématu manifestu |
   | `name`, `description` | jméno a popis agenta (podle popisu ho Copilot vybírá) |
   | `instructions` | chování agenta (text, ne kód) |
   | `capabilities` | knowledge a schopnosti (např. SharePoint) |
   | `actions` | napojení na API — **mimo náš rozsah** |

### Část C — nastavení agenta (12 min)

7. **Instrukce.** Pokud v `declarativeAgent.json` vidíš `"instructions": "$[file('instruction.txt')]"`, otevři `appPackage/instruction.txt`, **smaž celý obsah** a vlož text níže. Pokud soubor `instruction.txt` neexistuje, vytvoř ho v `appPackage` se stejným obsahem.

   ```text
   # Účel
   Jsi Support Asistent pro tým IT podpory. Odpovídáš na dotazy k provozním postupům výhradně z runbooků v knihovně Runbooky.

   # Pravidla
   - Odpovídej česky, stručně a v číslovaných krocích.
   - Vycházej jen z runbooků. Když odpověď v runboocích není, napiš: „V runboocích to není — eskaluj na service ownera."
   - U každé odpovědi uveď název runbooku, ze kterého vycházíš.
   - Na dotazy mimo IT podporu neodpovídej.
   - Nikdy neprováděj ani neslibuj zásah do systémů — jen radíš, jak postupovat.
   ```

8. **Manifest.** Nahraď **celý obsah** `declarativeAgent.json` tímto (jen `NN` přepiš na své číslo):

   ```json
   {
     "$schema": "https://developer.microsoft.com/json-schemas/copilot/declarative-agent/v1.9/schema.json",
     "version": "v1.9",
     "name": "Support Asistent NN",
     "description": "Odpovídá na dotazy IT podpory z provozních runbooků: chyby oprávnění a „access denied“ v SharePoint knihovnách, reset hesla, výpadek tiskové fronty, postup a SLA u incidentu P1. Vrací postup v číslovaných krocích s odkazem na runbook.",
     "instructions": "$[file('instruction.txt')]",
     "capabilities": [
       {
         "name": "OneDriveAndSharePoint",
         "items_by_url": [
           {
             "url": "https://ms365x17157302.sharepoint.com/sites/hr-demo/Runbooky"
           }
         ]
       }
     ],
     "conversation_starters": [
       {
         "title": "Access denied",
         "text": "Uživatel dostane access denied při nahrávání souboru do knihovny. Co s tím?"
       },
       {
         "title": "SLA incidentu P1",
         "text": "Jaká je SLA na incident P1?"
       },
       {
         "title": "Tisková fronta",
         "text": "Jaký je postup při výpadku tiskové fronty na pobočce?"
       }
     ],
     "editorial_answers": {
       "answers": [
         {
           "question": "Jaká je SLA na incident P1?",
           "answer": "Incident P1: reakce do 1 hodiny od založení tiketu, řešení nebo workaround do 8 pracovních hodin, aktualizace stavu každé 2 hodiny. Zdroj: Runbook Incident P1 — postup a SLA."
         }
       ]
     },
     "behavior_overrides": {
       "special_instructions": {
         "discourage_model_knowledge": true
       }
     }
   }
   ```

   Co jednotlivé bloky dělají:
   - `capabilities` → `OneDriveAndSharePoint` + `items_by_url` — knowledge **jen** z knihovny Runbooky. Bez `items_by_url` by agent prohledával celý SharePoint, ke kterému máš přístup.
   - `conversation_starters` — nabídka dotazů v UI agenta (max. 12). Zároveň podle nich jiný agent pozná, k čemu tento slouží (navazující lab).
   - `editorial_answers` — předdefinovaná odpověď (max. 300 párů); **funkce jen v manifestu, v žádném UI není**.
   - `discourage_model_knowledge: true` — agent nemá odpovídat z obecných znalostí modelu, jen ze zdrojů.
   - `actions` jsme **vynechali** — tady by se napojilo API (vývoj, mimo rozsah).

9. **App manifest.** Otevři `appPackage/manifest.json` a uprav jen texty — **zástupné symboly typu `${{APP_NAME_SUFFIX}}` nemaž**:
   - `name.short` → `Support Asistent NN`
   - `name.full` → `Support Asistent NN — runbooky IT podpory`
   - `description.short` → `Postupy IT podpory z runbooků`
   - `description.full` → zkopíruj `description` z `declarativeAgent.json`

10. Ulož všechny soubory (**Ctrl+K S**).

**Kontrola:** VS Code neukazuje v `declarativeAgent.json` červené podtržení. Pokud ano, najeď na něj myší — nejčastěji chybí čárka nebo uvozovka (porovnej s blokem výše).

### Část D — nasazení a test (12 min)

11. V panelu Toolkitu → **Lifecycle** → **Provision**. Pokud se zeptá na tenant / účet, potvrď `user.NN@spdemo.online`. Počkej na zprávu o úspěchu (≈ 1–2 min). **Žádné Azure se nevytváří.**
12. Otevři soubor **`env/.env.dev`** a najdi řádek `M365_TITLE_ID=...`. Hodnotu (formát `písmeno_GUID`) si zkopíruj do poznámek — **budeš ji potřebovat v navazujícím labu**.
13. Spusť test: v panelu Toolkitu klikni **Preview your app (F5)**. Otevře se Microsoft 365 Copilot Chat v prohlížeči s tvým agentem *Support Asistent NN*. (Alternativa: otevři `https://m365.cloud.microsoft/chat`, vedle **New Chat** otevři seznam konverzací/agentů a vyber *Support Asistent NN*.)
14. Polož 4 testovací dotazy a zapiš výsledek:

    | # | Dotaz | Očekávání | Výsledek |
    |---|---|---|---|
    | 1 | „Uživatel dostane access denied při nahrávání souboru do knihovny. Co s tím?" | kroky z runbooku *„Access denied" při uploadu* + název runbooku | |
    | 2 | „Jaká je SLA na incident P1?" | předdefinovaná odpověď z `editorial_answers` (1 h / 8 h / 2 h) | |
    | 3 | „Jaký je postup při výpadku tiskové fronty na pobočce?" | kroky z runbooku *Výpadek tiskové fronty* (Print Spooler) | |
    | 4 | „Napiš básničku o počasí." | odmítne nebo napíše, že to v runboocích není | |

15. **Iterace (git disciplína):** v terminálu VS Code (**Ctrl+`**) spusť `git init` (pokud projekt ještě není v gitu), `git add .`, `git commit -m "Support Asistent v1"`. Pak změň jednu větu v `instruction.txt` (např. „Odpovídej maximálně v 5 krocích."), spusť `git diff` a podívej se, jak vypadá změna agenta v review. Znovu **Provision** a ověř dotaz 1.

### Reflexe — proč Toolkit (pro správce)

16. Doplň do poznámek jednou větou ke každému: **kde je agent uložený** (manifest v gitu vs. Agent Builder), **jak se nasazuje** (Provision — opakovatelně), **jak by šel do produkce** (publikace přes schválení v M365 AC → Agents → Requests, D5).

## Ověření

- [ ] `declarativeAgent.json` odpovídá bloku z kroku 8 (s tvým `NN`), `instruction.txt` obsahuje instrukce z kroku 7.
- [ ] Provision proběhl a máš zapsaný `M365_TITLE_ID`.
- [ ] Testy 1 a 3 odpověděly z runbooku s jeho názvem, test 2 vrátil editorial answer, test 4 odmítnut.
- [ ] `git diff` ukázal změnu instrukcí jako řádkový rozdíl.
- [ ] Umíš ukázat v manifestu `instructions`, knowledge (Runbooky) a `editorial_answers` a říct, proč chybí `actions`.

## Když něco nejde

| Příznak | Příčina | Řešení |
|---|---|---|
| Provision skončí chybou o *custom app upload* / sideloading | v tenantu není povolené nahrávání vlastních aplikací | hlas instruktorovi (Teams admin center → *Upload custom apps*) |
| Červené podtržení v JSON | chybí čárka / uvozovka / závorka | porovnej s blokem v kroku 8; poslední položka v poli nemá čárku |
| Provision hlásí chybu u `instructions` | Toolkit nenašel `instruction.txt` | soubor musí být ve složce `appPackage` a jmenovat se přesně `instruction.txt`. Nouzově vlož instrukce přímo do JSON jako jeden řádek: `"instructions": "Jsi Support Asistent pro tým IT podpory. Odpovídej česky v číslovaných krocích, jen z runbooků v knihovně Runbooky, s názvem runbooku. Když odpověď v runboocích není, napiš, ať eskaluje na service ownera. Mimo IT podporu neodpovídej."` |
| Agent odpovídá obecně, ne z runbooků | knowledge se ještě neindexovala nebo chybí přístup ke knihovně | ověř URL knihovny v prohlížeči; počkej 5 min a zkus znovu |
| Test 2 nevrátí přesně editorial answer | dotaz je formulovaný jinak | polož ho přesně jako v tabulce |
| V Copilotu agenta nevidíš | Preview otevřel jiný účet | v Edge se přihlas jako `user.NN@spdemo.online` |

## Fallback

- Provision nejde (tenant / práva): části A–C jsou plnohodnotný deliverable — manifest máš hotový lokálně. Instruktor promítne běh svého agenta a ty porovnáš jeho odpovědi s tabulkou z kroku 14.

## Zdroje (Microsoft)

[Declarative agent manifest 1.9](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/declarative-agent-manifest-1.9) · [Add knowledge sources (Agents Toolkit)](https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/build-declarative-agents-add-knowledge) · [Agent capabilities & licensing](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/prerequisites)
