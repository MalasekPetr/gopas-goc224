# Lab · Delegovaný úkol v Cowork

> Modul: cowork · Odhad: 30 min · Režim: **studenti hands-on, samostatně podle návodu** (vlastní účet a web)
> Data: knihovna `Vzorky` na vlastním webu z D2 ([`../../day-2/document-processing/lab-sample-library.md`](../../day-2/document-processing/lab-sample-library.md))

## Cíl

Delegovat na Cowork úkol, který končí reálnými akcemi (Word dokument + e-mail), projít schvalování akcí, zjistit cenu a porovnat Cowork s agentem a flow.

## Předpoklady

- [ ] Přihlášení jako `user.NN@spdemo.online` (Copilot licence + spending policy pro Cowork — ověřil instruktor).
- [ ] Knihovna **Vzorky** na tvém webu `https://ms365x17157302.sharepoint.com/sites/user.NN` obsahuje 3 dokumenty (smlouva, objednávka, zápis). Pokud chybí, nahraj do ní 3 vzorky od instruktora (**Nahrát → Soubory**).

> [!NOTE] `NN` = tvoje číslo účtu. Popisky v Cowork se mění — drž se smyslu kroku, ne přesného textu tlačítka.

## Kroky

### Část A — příprava a zadání (5 min)

1. Otevři `https://copilot.cloud.microsoft` → karta **Home** → v poli pro dotaz přepni přepínač z **Chat** na **Cowork**.
2. Vedle pole pro dotaz nech **model picker** na **Auto** a **reasoning effort** přepni z **Medium** na **Low** — šetří kredity, na tenhle úkol stačí.
3. Klikni na **+** v poli pro dotaz → **Attach cloud files** → najdi svůj web `user.NN` → knihovnu **Vzorky** → označ všechny 3 dokumenty → potvrď.
4. Do pole vlož zadání (přepiš `NN`):

   ```text
   Projdi 3 připojené dokumenty z knihovny Vzorky na webu https://ms365x17157302.sharepoint.com/sites/user.NN.
   Vytvoř Word dokument „Přehled vzorků NN" s tabulkou o sloupcích: Dokument, Typ, Protistrana, Klíčové datum, Co z dokumentu plyne.
   Ulož ho do knihovny Vzorky na stejném webu.
   Pak mi pošli e-mail na user.NN@spdemo.online (jen mně) s předmětem „Přehled vzorků NN", třemi větami shrnutí a odkazem na dokument.
   ```

**Kontrola:** zadání obsahuje cíl (Word + e-mail), kontext (3 dokumenty), očekávání (sloupce tabulky) a omezení (e-mail jen sobě) — anatomie promptu z D2.

### Část B — běh a schvalování (15 min)

5. Odešli (**Send**). Sleduj boční panel vpravo a do poznámek zapiš:
   - které **skills** Cowork načetl (např. *Word*, *Email*, *Enterprise Search*),
   - jaké **kroky** postupně provádí.
6. Když se objeví **schvalovací dialog** (náhled akce + tlačítko pojmenované akcí, např. **Create** nebo **Send**):
   - přečti si náhled a u medium/high rizika si všimni **indikátoru rizika**,
   - **nepoužívej** šipku vedle tlačítka (*Always allow* / přeskočení dalších dotazů) — chceš vidět každou akci.
7. U **prvního** schvalovacího dialogu klikni **Cancel**. Sleduj, co Cowork udělá (zeptá se, pokračuje bez akce, skončí?). Zapiš.
8. Napiš do konverzace: `Tu akci, kterou jsem zrušil, proveď znovu.` a tentokrát ji schval.
9. Ověř výsledek:
   - Kde je dokument? Podívej se do bočního panelu (seznam souborů) a do knihovny **Vzorky**. **Zapiš, kam ho Cowork uložil.** Pokud je v OneDrivu, přesuň ho do `Vzorky` (v OneDrivu: **⋯ → Přesunout do**).
   - Přišel e-mail do tvé schránky `user.NN@spdemo.online`?
   - Sedí tabulka s obsahem dokumentů? Jednu nepřesnost (je-li) zapiš.

### Část C — automatizace, cena a srovnání (10 min)

10. Otevři **Tasks** → **Automations**. Prohlédni si, jak se tentýž úkol dá naplánovat. **Nic natrvalo nezakládej** — každý naplánovaný běh čerpá kredity bez tebe. Pokud plán pro ukázku založíš (např. `Spouštěj tento úkol každé pondělí v 8:00.`), hned ho v **Automations** smaž.
11. **Kolik to stálo:** napiš do konverzace `/cost` a zapiš odpověď. (V Code `/cost` funguje; u Cowork ho MS dokumentace neuvádí — zapiš, co se stalo.)
12. Jako Global Reader otevři **M365 admin center → Copilot → Cost management → Consumption → Users** a najdi svou spotřebu. Data mají zpoždění — pokud tam ještě nejsi, ověříš zítra v D5.
13. Vyplň tabulku:

    | Kritérium | Cowork | Agent | Power Automate flow (D4 dopoledne) |
    |---|---|---|---|
    | Kdo úkol spouští | | | |
    | Kdo schvaluje akce | | | |
    | Opakovatelnost | | | |
    | Auditní stopa | | | |
    | Náklad | | | |

## Ověření

- [ ] Dokument „Přehled vzorků NN" existuje a víš, kam ho Cowork uložil; je v knihovně `Vzorky`.
- [ ] E-mail přišel jen tobě.
- [ ] Zapsané skills a kroky, které Cowork použil.
- [ ] Jedna akce zrušená a znovu vyžádaná — víš, co se stalo.
- [ ] V **Automations** nezůstal žádný naplánovaný úkol.
- [ ] Zapsaný výsledek `/cost` a tabulka Cowork / agent / flow.

## Když něco nejde

| Příznak | Příčina | Řešení |
|---|---|---|
| Přepínač **Cowork** chybí | nejsi ve spending policy pro Cowork, nebo licence ještě není propsaná | odhlas se a přihlas; jinak hlas instruktorovi → fallback |
| Cowork knihovnu `Vzorky` nenajde | dokumenty nejsou připojené | zopakuj krok 3 (**+ → Attach cloud files**) |
| Dokument je v OneDrivu, ne ve `Vzorky` | Cowork ukládá výstupy do OneDrive/SharePoint workspace | přesuň ručně (krok 9) — a zapiš to jako zjištění |
| Úkol skončil chybou limitu | vyčerpaný per-user strop ve spending policy | hlas instruktorovi; pokračuj částí C bez dalšího běhu |
| Cowork se ptá na upřesnění | zadání je pro něj nejednoznačné | odpověz nebo vyber nabízenou možnost; zapiš si, co v zadání chybělo |

## Fallback

- Cowork se nenabízí: instruktor pustí úkol na svém účtu na plátně. Ty napíšeš zadání (část A), predikuješ skills a schvalovací body a pak je porovnáš s během; část C beze změny.

## Zdroje (Microsoft)

[Cowork overview](https://learn.microsoft.com/en-us/copilot/cowork/) · [Get started with Cowork](https://learn.microsoft.com/en-us/copilot/cowork/get-started) · [Cowork FAQ](https://learn.microsoft.com/en-us/copilot/cowork/cowork-faq)
