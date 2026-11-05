# Lab · Ukázková knihovna — autofill a image tagging

> Modul: document-processing · Odhad: 40 min · Režim: **živý tenant, samostatně podle návodu** (vlastní web; Document processing PAYG — malý vzorek!)

## Cíl

Zopakovat instruktorská dema na vlastní knihovně: autofill sloupec a image tagging, ověřit výsledky a odhadnout, kolik lab stál.

## Předpoklady

- [ ] Tvůj web `https://ms365x17157302.sharepoint.com/sites/user.NN` (Owner).
- [ ] Document processing PAYG zapnuté pro studentské weby (instruktor).
- [ ] Sada vzorků od instruktora: **3 dokumenty** (smlouva, objednávka, zápis) + **3 obrázky** — stáhni si je k sobě.

> [!WARNING] Autofill i image tagging se účtují za každý zpracovaný soubor. Pracuj jen se 3 + 3 vzorky.

## Kroky

### Část A — knihovna (5 min)

1. Na svém webu klikni **+ Nový** → **Knihovna dokumentů**, název `Vzorky` → **Vytvořit**.
2. Nahraj **jen 3 dokumenty** (**Nahrát → Soubory**). Obrázky zatím ne — image tagger zpracuje jen obrázky nahrané **po** jeho zapnutí (část C).

### Část B — autofill sloupec (15 min)

3. V knihovně klikni **+ Přidat sloupec** → typ **Jeden řádek textu** → **Další**.
4. Název sloupce: `Protistrana`.
5. V sekci **Autofill** panelu *Vytvořit sloupec* uprav navržený prompt na:

   ```text
   Z dokumentu vytáhni název druhé smluvní strany nebo dodavatele (firma nebo osoba, se kterou dokument uzavíráme). Vrať jen název bez právní formy. Pokud v dokumentu žádná protistrana není, vrať „neuvedeno".
   ```

   Prompt má **cíl** (co vytáhnout), **očekávání** (formát „jen název") a **pravidlo pro chybějící údaj** — anatomie z ranního bloku.
6. Otestuj prompt na jednom souboru (volba testu v panelu Autofill). Pokud výsledek nesedí, uprav prompt a otestuj znovu.
7. Ulož sloupec.
8. Existující dokumenty se samy nezpracují: označ v knihovně všechny 3 dokumenty → **⋯ (More options)** → **Autofill**.
9. Počkej, až se sloupec **Protistrana** vyplní (obnov stránku). U jednoho dokumentu hodnotu **ručně přepiš** — člověk má poslední slovo; zapiš, proč jsi ji změnil/a.

**Kontrola:** sloupec Protistrana má hodnotu u všech 3 dokumentů.

### Část C — image tagging (10 min + čekání)

10. V knihovně **Vzorky** klikni **Automatizovat** (Automate) → **Enable image tagger**. Do knihovny přibude sloupec **Image Tags**.
11. **Teď** nahraj 3 obrázky.
12. Tagy se objeví za **5 minut až 24 hodin**. Mezitím pokračuj částí D a vrať se.
13. U každého obrázku zapiš tagy a označ jeden, který je **špatně nebo nepřesně**. Sloupec Image Tags je editovatelný — chybný tag smaž.

### Část D — náklady (10 min)

14. Vytvoř `naklady-NN.md` v knihovně (nebo ve VS Code) a vyplň:

    ```markdown
    # Odhad nákladů labu — user.NN
    | Služba | Počet | Sazba (README) | Cena |
    |---|---|---|---|
    | Autofill (transakce = soubor × sloupec, vč. testů) | | $0.005 | |
    | Image tagging (obrázek) | 3 | $0.001 | |
    | Celkem | | | |

    Kde se spotřeba ověří: Azure Cost Management nad resource group PAYG (zpoždění až 24 h).
    ```

> [!WARNING] Ověřit k datu běhu — sazby z [PAYG pricing](https://learn.microsoft.com/en-us/microsoft-365/documentprocessing/syntex-pay-as-you-go-services), stav k 2026-10.

## Ověření

- [ ] Autofill sloupec Protistrana vyplněný u 3 dokumentů; prompt má cíl, očekávání a pravidlo pro chybějící údaj.
- [ ] Jedna hodnota ručně opravená s důvodem.
- [ ] Image tagger zapnutý **jen na knihovně Vzorky**; obrázky nahrané až po zapnutí.
- [ ] `naklady-NN.md` s výpočtem a místem ověření.

## Když něco nejde

| Příznak | Příčina | Řešení |
|---|---|---|
| Sekce **Autofill** v panelu sloupce chybí | služba není pro tvůj web povolená, nebo nepodporovaný typ sloupce | ověř typ (text, číslo, datum, volba…); jinak hlas instruktorovi → fallback |
| Sloupec se nevyplní | existující soubory se musí spustit ručně | krok 8: označit → **⋯ → Autofill** |
| **Enable image tagger** v menu Automatizovat chybí | image tagging není pro web povolený | hlas instruktorovi → fallback |
| Obrázky nemají tagy | nahrané před zapnutím taggeru, nebo ještě neuplynula doba zpracování | nahraj obrázek znovu; počkej (až 24 h) |
| Hodnota delší než 255 znaků se ořízne | limit textového sloupce | v nastavení sloupce **Další možnosti → Povolit neomezenou délku** |

## Fallback

- Autofill nedostupný na studentských webech: napiš prompt sloupce a pošli ho instruktorovi, který ho nasadí na demo knihovně; části C–D beze změny.
- Image tagging nefunguje: analýza tagů na instruktorově demo knihovně (jen čtení).

## Zdroje (Microsoft)

[Create an autofill column](https://learn.microsoft.com/en-us/microsoft-365/documentprocessing/autofill) · [Overview of autofill columns](https://learn.microsoft.com/en-us/microsoft-365/documentprocessing/autofill-overview) · [Enhanced image tagging](https://learn.microsoft.com/en-us/microsoft-365/documentprocessing/image-tagging) · [Image tagging overview](https://learn.microsoft.com/en-us/microsoft-365/documentprocessing/image-tagging-overview)
