# Lab · Anatomie promptu nad vlastním obsahem

> Modul: prompting-fundamentals · Odhad: 30 min · Režim: **živý tenant, samostatně podle návodu** (Copilot in SharePoint, Copilot licence)

## Cíl

Na vlastní kůži změřit, jak kvalita promptu mění kvalitu odpovědi — stejná potřeba ve 3 verzích — a ověřit, že Copilot nevidí, co nevidíš ty.

## Předpoklady

- [ ] Tvůj web `https://ms365x17157302.sharepoint.com/sites/user.NN` s **3 dokumenty** v knihovně Dokumenty. Pokud máš jen jeden z D1, nahraj ještě 2 vzorky od instruktora (**Nahrát → Soubory**).
- [ ] Panel **Copilot** na webu funguje (onboarding lab, část C).

## Kroky

### Krok 1 — verze 1: holý cíl (3 min)

1. Otevři panel Copilot na svém webu a napiš:

   ```text
   Shrň dokumenty.
   ```

2. Odpověď si zkopíruj do poznámek.

### Krok 2 — verze 2: plná anatomie (7 min)

3. Napiš nový prompt se čtyřmi částmi — **cíl, kontext, očekávání, zdroj**. Vzor (přizpůsob svým dokumentům):

   ```text
   Cíl: Připrav podklad pro poradu vedení k dokumentům v knihovně Dokumenty.
   Kontext: Vedení má na téma 2 minuty a zajímají ho termíny a rizika.
   Očekávání: Tabulka se sloupci Dokument, Hlavní sdělení, Termín, Riziko. Maximálně 5 řádků, česky.
   Zdroj: Použij jen dokumenty v knihovně Dokumenty na tomto webu.
   ```

4. Porovnej s verzí 1 a zapiš **konkrétně, co přibylo** (např. „termíny jsou vytažené", „je tam tabulka", „odpověď cituje 3 zdroje").

### Krok 3 — verze 3: iterace (5 min)

5. Navaž follow-up promptem, který výstup zpřesní. Vyber jednu variantu:

   ```text
   Přidej ke každému řádku odkaz na zdrojový dokument a seřaď tabulku podle termínu.
   ```

   ```text
   Zkrať sloupec Hlavní sdělení na max. 10 slov a vynech dokumenty bez termínu.
   ```

6. Zapiš, jestli iterace výstup zlepšila.

### Krok 4 — záznam (7 min)

7. Ve VS Code nebo v knihovně Dokumenty (**Nový → Textový dokument**, ulož jako `prompty-NN.md`) zapiš:

   ```markdown
   # Prompty — user.NN
   | Verze | Prompt | Hodnocení (1 věta) |
   |---|---|---|
   | 1 | Shrň dokumenty. | |
   | 2 | <tvůj prompt> | |
   | 3 | <tvůj follow-up> | |
   ```

### Krok 5 — hranice práv (5 min)

8. Vyber číslo spolužáka `MM` (jiné než tvoje) a zeptej se na **svém** webu:

   ```text
   Shrň dokumenty na webu https://ms365x17157302.sharepoint.com/sites/user.MM.
   ```

9. Očekávání: Copilot **nic nenajde** — k webu spolužáka nemáš přístup a grounding je permissions-trimmed. Zapiš výsledek.

## Ověření

- [ ] Tři verze promptu + hodnocení uložené v `prompty-NN.md`.
- [ ] Umíš říct konkrétní rozdíl mezi verzí 1 a 2 (ne „je to lepší", ale co přibylo).
- [ ] Test hranice práv: Copilot obsah webu spolužáka nevrátil.

## Když něco nejde

| Příznak | Příčina | Řešení |
|---|---|---|
| Copilot neodpovídá z dokumentů | dokumenty se ještě neindexovaly | počkej 5–10 minut po nahrání |
| Verze 1 a 2 jsou skoro stejné | dokumenty jsou krátké nebo podobné | v kroku 3 přitvrď očekávání (formát, délka) a sleduj, co se změní |
| Test hranice práv vrátil obsah | máš k webu spolužáka přístup | zvol jiné `MM`, nebo hlas instruktorovi — je to nález |

## Fallback

- Copilot in SharePoint nedostupný: napiš 3 verze promptu na papír a projdi je v páru; instruktor vybrané spustí ve svém prostředí.

## Poznámka k nákladům

Everyday Copilot in SharePoint je v licenci, ale stejné návyky platí v Cowork a Advanced work, kde každá iterace čerpá Copilot Credits. Tři promyšlené verze > deset náhodných.
