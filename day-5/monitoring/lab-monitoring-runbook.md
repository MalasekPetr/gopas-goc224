# Lab · Provozní monitoring — audit a incident runbook

> Modul: monitoring · Odhad: 35 min · Režim: **živý tenant (audit search) + runbook, samostatně podle návodu**

## Cíl

Najít vlastní Copilot stopu v Purview Audit, přečíst, k čemu Copilot přistoupil, a napsat incident runbook, který funguje i bez tebe.

## Zadání incidentu

> „V pondělí ráno hlásí uživatel, že Copilot v odpovědi ukázal obsah smlouvy, kterou by vidět neměl."

## Předpoklady

- [ ] Přihlášení jako `user.NN@spdemo.online` na `https://purview.microsoft.com` s rolí **View-Only Audit Logs** nebo **Audit Logs** (go/no-go instruktora).
- [ ] Během týdne jsi používal Copilot (D2–D4) — máš v auditu vlastní stopu. Auditní záznamy se objeví typicky za 60–90 minut.

## Kroky

### Část A — audit hands-on (12 min)

1. V Purview klikni na kartu **Audit**. Pokud ji nevidíš: **View all solutions** → sekce **Core** → **Audit**.
2. Na stránce **Search** vyplň:

   | Pole | Hodnota |
   |---|---|
   | **Date and time range (UTC)** | od pondělí tohoto týdne do teď |
   | **Record types** | `CopilotInteraction` (najdi přes vyhledávací pole v rozbalovacím seznamu) |
   | **Search name** | `Copilot NN` |
   | **Users** | `user.NN@spdemo.online` |

3. Klikni **Search**. Úloha se objeví v dashboardu se stavem *Queued* → *In Progress* → *Completed* (běží i po zavření prohlížeče).
4. Po dokončení klikni na úlohu **Copilot NN**. V seznamu výsledků vyber jeden záznam (např. z D4 agenta nebo Cowork) a otevři detail (fly-out).
5. V detailu najdi a zapiš:

   | Údaj | Co jsi našel |
   |---|---|
   | Datum a aplikace (např. Copilot in SharePoint, Cowork, agent) | |
   | **AccessedResources** — ke kterým souborům / webům Copilot přistoupil | |
   | Je mezi zdroji web grounding (`BingWebSearch`)? | |
   | Má některý zdroj sensitivity label? | |
   | Objevuje se `XPIADetected`? | |

### Část B — runbook (18 min)

6. Založ soubor `runbook-copilot-oversharing-NN.md` a zkopíruj šablonu. Každou fázi vyplň konkrétně: **kdo** (role, ne jméno), **kde** (portál / nástroj), **co** (konkrétní kroky).

   ```markdown
   # Runbook: Copilot ukázal obsah, který uživatel neměl vidět

   ## 1. Signál
   - Odkud přišel: <hlášení uživatele / alert / report>
   - Kdo přijímá: <role>
   - Co si zapíše hned: <kdo, kdy, jaký dotaz, jaký dokument>

   ## 2. Triáž
   - Je to výpadek služby? Kde ověřím: <M365 AC → Health → Service health>
   - Je to oversharing (oprávnění), nebo chyba Copilota?
   - Priorita: <P1–P4 a proč>

   ## 3. Diagnóza
   - Audit dotaz: Purview → Audit → Record types: CopilotInteraction; Users: <dotčený uživatel>; Date range: <od–do>
   - Co hledám v AccessedResources: <URL dokumentu>
   - Kdo má k dokumentu přístup a proč: <kde to ověřím — oprávnění webu / sdílení / DAG report>

   ## 4. Akce
   - Okamžité opatření: <oprava oprávnění / odebrání sdílecího odkazu / RCD na web / blokace agenta>
   - Proč právě tento nástroj: <…>
   - Kdo ho provede: <role>

   ## 5. Komunikace
   - Uživateli (1 věta): <…>
   - Vedení (1 věta): <…>

   ## 6. Post-mortem
   - Jaká politika se změní, aby se to neopakovalo: <SAM / RCD / revize přístupů / sensitivity label>
   ```

7. Ve fázi **Akce** vyber jeden nástroj z týdne a odůvodni ho. Nápověda:

   | Nástroj | Kdy | Kde |
   |---|---|---|
   | Oprava oprávnění / sdílecích odkazů | dokument je sdílený šíř, než má | web / knihovna → Spravovat přístup |
   | Restricted Content Discovery (RCD) | celý web nemá být v Copilotu dohledatelný | SharePoint admin center / PowerShell (D2) |
   | Restricted Access Control (RAC) | web má vidět jen vybraná skupina | SharePoint admin center (D3 SAM) |
   | Blokace agenta | problém způsobuje konkrétní agent | M365 AC → Agents |

8. **Test „sobota 2:00":** projdi runbook a u každého kroku si odpověz — zvládne ho kolega, který tě nezná a nemůže ti zavolat? Kde je jméno místo role nebo „zeptej se mě" místo odkazu, oprav.

## Ověření

- [ ] Našel jsi vlastní `CopilotInteraction` záznam a vyplnil tabulku z kroku 5.
- [ ] Runbook má všech 6 sekcí; diagnóza obsahuje konkrétní audit dotaz (record type, uživatel, období).
- [ ] Triáž začíná ověřením service health.
- [ ] Akce je zdůvodněná nástrojem z kurzu.
- [ ] Runbook prošel testem „sobota 2:00" (role místo jmen, odkazy místo paměti).

## Když něco nejde

| Příznak | Příčina | Řešení |
|---|---|---|
| Karta **Audit** chybí nebo hlásí chybu oprávnění | chybí role View-Only Audit Logs / Audit Logs | hlas instruktorovi → fallback |
| `CopilotInteraction` v **Record types** nenajdeš | překlep | do vyhledávacího pole seznamu napiš `Copilot` a vyber ze seznamu |
| Úloha vrátí 0 výsledků | špatné časové pásmo (UTC) nebo záznamy ještě nedorazily | rozšiř rozsah dat; záznam se objeví typicky za 60–90 min |
| Úloha dlouho běží | velký rozsah | zúžit na tvého uživatele a 5 dní; mezitím piš runbook |

## Fallback

- Audit role pro studenty nedostupná: instruktor promítne search nad vlastními interakcemi a otevře jeden záznam; tabulku z kroku 5 vyplníš podle plátna. Runbook (jádro labu) beze změny.

## Zdroje (Microsoft)

[Search the audit log](https://learn.microsoft.com/en-us/purview/audit-search) · [Audit Copilot interactions](https://learn.microsoft.com/en-us/purview/audit-copilot)
