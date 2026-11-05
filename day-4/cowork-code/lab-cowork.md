# Lab · Delegovaný úkol v Cowork

> Modul: cowork-code · Odhad: 30 min · Režim: **studenti hands-on** (vlastní účet a web)
> Data: knihovna `Vzorky` na vlastním webu z D2 ([`../../day-2/document-processing/lab-sample-library.md`](../../day-2/document-processing/lab-sample-library.md))

## Cíl

Delegovat na Cowork úkol, který končí reálnými akcemi (dokument + zpráva), projít schvalování akcí a porovnat Cowork s agentem a flow.

## Předpoklady

- Copilot licence + spending policy pro Cowork (instruktor ověřil).
- Na vlastním webu knihovna `Vzorky` se 3 dokumenty (smlouva / objednávka / zápis). Pokud chybí, nahraj 3 vzorky od instruktora.
- Otevři [Microsoft Copilot](https://copilot.cloud.microsoft) → **Home** → přepínač **Cowork** (vedle Chat).

## Kroky

### Část A — zadání (5 min)

1. Napiš zadání podle anatomie promptu z D2 (cíl → kontext → očekávání → zdroj). Kostra:

   > Projdi 3 dokumenty v knihovně `Vzorky` na mém webu <URL>. Vytvoř Word dokument „Přehled vzorků" s tabulkou: dokument, typ, protistrana, klíčové datum, co z dokumentu plyne. Ulož ho do téže knihovny. Pak mi pošli e-mail (jen mně) se 3 větami shrnutí a odkazem na dokument.

2. Přidej dokumenty přes **+ → Attach cloud files**, ať Cowork nehledá naslepo.

### Část B — běh a schvalování (15 min)

3. Odešli a sleduj boční panel: které **skills** Cowork načetl (Word, Email, Enterprise Search…) a jaké kroky provádí. Zapiš je.
4. U každého schvalovacího dialogu si přečti náhled akce. **Nepoužívej „Always allow"** — cílem je vidět každou akci.
5. Jednu akci záměrně **zruš** (Cancel) a sleduj, jak Cowork pokračuje. Pak ji v konverzaci vyžádej znovu.
6. Ověř výsledek: dokument je v knihovně `Vzorky`, e-mail dorazil, tabulka sedí s obsahem dokumentů. Jednu nepřesnost (je-li) zapiš.

### Část C — plánovaný prompt a srovnání (10 min)

7. V tabu **Automations** si prohlédni, jak by se tentýž úkol naplánoval (např. každé pondělí). **Plán nezakládej natrvalo** — každý běh čerpá kredity. Pokud ho pro ukázku založíš, na konci ho smaž.
8. Vyplň tabulku: tentýž úkol jako **Cowork**, jako **agent**, jako **Power Automate flow** (D3). Kritéria: kdo spouští, kdo schvaluje, opakovatelnost, auditní stopa, náklad.
9. **Kolik to stálo:** zkus v konverzaci `/cost` (v Code funguje, u Cowork ho MS docs neuvádí — zapiš, co se stalo). Jako Global Reader otevři **M365 AC → Copilot → Cost management → Consumption → Users** a najdi svou spotřebu (data mají zpoždění — pokud tam ještě nejsi, ověř zítra v D5).

## Ověření

- [ ] Dokument „Přehled vzorků" existuje (zapiš, kam ho Cowork uložil; pokud mimo `Vzorky`, přesuň ho tam) a e-mail přišel jen tobě.
- [ ] Zapsané skills a kroky, které Cowork použil.
- [ ] Jedna akce zrušená a znovu vyžádaná — víš, co se stalo.
- [ ] Žádný plánovaný prompt nezůstal aktivní.
- [ ] Tabulka Cowork / agent / flow vyplněná.

## Fallback

- Cowork se nenabízí (chybí spending policy / licence se ještě nepropsala): instruktor pustí úkol na svém účtu na plátně, studenti píšou zadání (část A) a predikují skills a schvalovací body; část C beze změny.

## Náklady

Cowork čerpá Copilot Credits **navíc** k licenci, v rámci per-user stropu spending policy. Jeden pořádně zadaný úkol místo pěti pokusů.
