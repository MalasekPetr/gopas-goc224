# Lab · Agent volající agenta (`worker_agents`)

> Modul: agents-toolkit · Odhad: 25–30 min · Režim: **studenti hands-on, samostatně podle návodu** (navazuje na [`lab-toolkit-agent.md`](lab-toolkit-agent.md)); když tlačí čas, instruktorské demo · Publikum: **správci**
> Scénář: [`../copilot-agents/scenario-support-agent.md`](../copilot-agents/scenario-support-agent.md)

## Cíl

Postavit druhého agenta **Helpdesk Triáž NN**, který požadavky jen třídí a pro postupy řešení **volá tvého Support Asistenta NN** z předchozího labu. Pochopit, podle čeho Copilot vybírá volaného agenta a co to znamená pro správu (vlastnictví, závislosti, registr).

> [!IMPORTANT] Rozsah — pořád jen manifest
> Žádný kód, žádné API, žádné Azure. Propojení je **jedna vlastnost v manifestu** (`worker_agents`). Funkce je **preview**.

## Předpoklady

- [ ] Hotový a **provisionovaný** Support Asistent NN z [`lab-toolkit-agent.md`](lab-toolkit-agent.md) — test 1 z jeho tabulky prošel.
- [ ] Zapsaný **title ID** Support Asistenta (`M365_TITLE_ID` z `env/.env.dev` projektu `support-asistent-NN`, formát `písmeno_GUID`).
- [ ] VS Code + Agents Toolkit, přihlášení jako `user.NN@spdemo.online`.

## Jak to funguje

```mermaid
sequenceDiagram
  actor U as Uživatel
  participant T as Helpdesk Triáž NN<br/>(volající agent)
  participant C as Copilot Chat<br/>(broker)
  participant S as Support Asistent NN<br/>(worker agent)
  U->>T: „Uživatel nemůže nahrát soubor, access denied"
  T->>C: postup řešení patří runbookům
  C->>S: textový dotaz (vybráno podle name / description / conversation_starters)
  S-->>C: textová odpověď z knihovny Runbooky
  C-->>T: zapracuje odpověď
  T-->>U: kategorie + priorita + postup; v konverzaci je vidět volání Support Asistenta
```

- Volající agent má v manifestu `worker_agents` s **title ID** volaného agenta.
- Copilot Chat je **broker**: volaného agenta vybírá podle jeho `name`, `description` a textu `conversation_starters` — proto jsme je v předchozím labu napsali konkrétně.
- Mezi agenty jde **jen text**. Volaný agent pracuje ve vlastním kontextu.

## Kroky

### Část A — kontrola volaného agenta (3 min)

1. Otevři projekt `support-asistent-NN` a v `appPackage/declarativeAgent.json` zkontroluj, že `description` a tři `conversation_starters` odpovídají předchozímu labu (krok 8). **Podle nich ho Copilot vybírá.**
2. Ověř title ID: otevři `env/.env.dev` a zkopíruj hodnotu `M365_TITLE_ID`.
   - Pokud řádek chybí: otevři Support Asistenta v Copilotu, napiš `-developer on` a polož libovolný dotaz. V debug kartě najdi sekci **Agent metadata** → title ID. Pak `-developer off`.

### Část B — nový projekt Helpdesk Triáž (12 min)

3. Panel Toolkitu → **Create a New Agent/App** → **Declarative Agent** → **No Action** → složka stejná jako minule → název `helpdesk-triaz-NN`.
4. Otevři `appPackage/instruction.txt` (pokud neexistuje, vytvoř ho v `appPackage`), smaž obsah a vlož:

   ```text
   # Účel
   Jsi Helpdesk Triáž. Třídíš požadavky IT helpdesku: určíš kategorii a prioritu podle dopadu.

   # Kategorie
   - Incident: něco nefunguje.
   - Požadavek: uživatel chce něco nového (zařízení, přístup, software).
   - Dotaz: uživatel se ptá, jak něco udělat.

   # Priorita
   - P1: nedostupná služba pro více uživatelů, ztráta dat, bezpečnostní incident.
   - P2: omezení celého týmu nebo kritického uživatele.
   - P3: problém jednoho uživatele, existuje náhradní řešení.
   - P4: dotaz nebo požadavek bez dopadu na provoz.

   # Delegace
   Na postupy řešení (jak problém opravit) nemáš vlastní znalosti. Když uživatel potřebuje postup, vždy použij Support Asistenta. Když stačí kategorie a priorita, odpověz sám.

   # Výstup
   1. Kategorie.
   2. Priorita a odůvodnění v jedné větě.
   3. Pokud je potřeba postup: odpověď Support Asistenta.
   Odpovídej česky.
   ```

5. Nahraď **celý obsah** `appPackage/declarativeAgent.json` tímto. Přepiš `NN` na své číslo a **`<TITLE_ID>` na title ID svého Support Asistenta** z kroku 2 (uvozovky ponech):

   ```json
   {
     "$schema": "https://developer.microsoft.com/json-schemas/copilot/declarative-agent/v1.9/schema.json",
     "version": "v1.9",
     "name": "Helpdesk Triáž NN",
     "description": "Třídí požadavky IT helpdesku — určí kategorii (incident, požadavek, dotaz) a prioritu P1–P4. Postupy řešení předává Support Asistentovi.",
     "instructions": "$[file('instruction.txt')]",
     "conversation_starters": [
       {
         "title": "Access denied",
         "text": "Uživatel hlásí access denied při nahrávání do knihovny. Jak to zařadit a co s tím?"
       },
       {
         "title": "Nový monitor",
         "text": "Uživatel chce nový monitor. Jakou prioritu dát?"
       }
     ],
     "worker_agents": [
       {
         "id": "<TITLE_ID>"
       }
     ]
   }
   ```

   Všimni si:
   - **Žádné `capabilities`** — Triáž nemá vlastní knowledge. Vše o postupech ví jen Support Asistent.
   - `worker_agents` existuje od schématu **1.6** — proto `v1.9` v `$schema` i `version`. Starší verze schématu by `worker_agents` odmítla.
   - Příklad správného zápisu: `"id": "U_2c27ae89-1f78-4ef7-824c-7d83f77eda28"` (tvoje hodnota bude jiná).

6. V `appPackage/manifest.json` uprav texty (zástupné symboly `${{...}}` nemaž): `name.short` → `Helpdesk Triáž NN`, `name.full` → `Helpdesk Triáž NN — třídění požadavků`, `description.short` → `Třídění požadavků helpdesku`, `description.full` → `description` z `declarativeAgent.json`.
7. Ulož (**Ctrl+K S**), zkontroluj, že JSON nemá červené podtržení.
8. Panel Toolkitu → **Lifecycle** → **Provision**.

### Část C — testy (10 min)

9. V projektu `helpdesk-triaz-NN` klikni v panelu Toolkitu **Preview your app (F5)**. Polož dotazy a zapiš výsledek:

   | # | Dotaz v Helpdesk Triáž NN | Očekávání | Výsledek |
   |---|---|---|---|
   | 1 | „Uživatel hlásí access denied při nahrávání do knihovny. Jak to zařadit a co s tím?" | kategorie Incident, priorita P3 + **postup od Support Asistenta** (v konverzaci je vidět jeho volání) | |
   | 2 | „Uživatel chce nový monitor. Jakou prioritu dát?" | Požadavek, P4, **bez volání** Support Asistenta | |
   | 3 | viz krok 10 | delegace selže nebo je nespolehlivá | |

10. **Test 3 — popis je rozhraní.** V projektu **support-asistent-NN** změň v `declarativeAgent.json` jen řádek `description` na:

    ```json
    "description": "Pomocník.",
    ```

    a smaž celý blok `conversation_starters` (včetně čárky před ním nebo za ním, aby JSON zůstal platný). **Provision** Support Asistenta. Pak v Helpdesk Triáži zopakuj dotaz 1 a zapiš, co se stalo.
11. **Vrať změnu zpět:** v projektu `support-asistent-NN` spusť v terminálu `git checkout -- appPackage/declarativeAgent.json` (vrátí verzi z commitu v1) a znovu **Provision**. Ověř, že dotaz 1 v Triáži opět deleguje.

### Část D — governance reflexe (5 min)

12. Odpověz do poznámek:
    - Kdo **vlastní** kterého agenta a kdo smí změnit `description` volaného agenta? (Test 3 ukázal, že tím tiše rozbije volajícího.)
    - Co se stane uživateli, který Support Asistenta **nemá nainstalovaného**? (MS: uživatel musí volaného agenta mít.)
    - Kde to uvidí admin — **registr agentů** v M365 AC (zítra D5 `copilot-admin`).
    - Proč je změna `worker_agents` nebo `description` v gitu (diff, review) bezpečnější než klikání?

## Ověření

- [ ] `helpdesk-triaz-NN/appPackage/declarativeAgent.json` má `v1.9`, žádné `capabilities` a `worker_agents` s title ID tvého Support Asistenta.
- [ ] Test 1 delegoval, test 2 ne; výsledek testu 3 zapsaný.
- [ ] Support Asistent je vrácený do verze v1 (`git checkout`) a znovu provisionovaný.
- [ ] Governance reflexe má 4 odpovědi.

## Když něco nejde

| Příznak | Příčina | Řešení |
|---|---|---|
| Provision Triáže hlásí chybu u `worker_agents` | starší verze schématu | `$schema` i `version` musí být `v1.9` (min. 1.6) |
| Test 1 nedeleguje, odpovídá jen kategorií | title ID je špatně, nebo Support Asistent není nainstalovaný pro tvůj účet | zkontroluj title ID (krok 2); otevři Support Asistenta v Copilotu, ať je nainstalovaný; zkus dotaz znovu |
| Delegace nejde ani se správným ID | volaný agent není v registru agentů (MS uvádí registraci v Agent 365 agent registry) | hlas instruktorovi — ověří v M365 AC → Agents; pokračuj fallbackem |
| JSON po kroku 10 je červený | zůstala visící čárka po smazání `conversation_starters` | poslední vlastnost v objektu nesmí končit čárkou |
| `git checkout` hlásí, že soubor není v gitu | v předchozím labu chyběl commit | vrať `description` a `conversation_starters` ručně podle kroku 8 předchozího labu |

## Fallback

- Provision nebo volání neprojde (registr agentů / preview): části A a B (manifest) jsou plnohodnotný deliverable. Instruktor pustí testy na svém přípravném páru agentů, ty predikuješ výsledky testů 1–3 a pak je porovnáš.

## Zdroje (Microsoft)

[Connect to other agents from a declarative agent](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/declarative-agent-connected-agent) · [Declarative agent manifest 1.9 — worker agent object](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/declarative-agent-manifest-1.9) · [Agent registry](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/agent-registry)
