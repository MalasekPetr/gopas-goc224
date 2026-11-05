# Lab · Návrh, tvorba a běh Skillu

> Modul: skills · Odhad: 35 min (15 návrh + review, 20 tvorba a běh) · Režim: **studenti hands-on, samostatně podle návodu** (Copilot licence od 2026-11; bez licence po GA nejede) — fallback instruktorský běh

## Cíl

Navrhnout Skill pro opakovaný postup na svém webu, nechat Copilot in SharePoint vytvořit jeho draft, uložit ho jako **site skill**, spustit ho nad dokumenty a porovnat výsledný `SKILL.md` se svým návrhem.

## Předpoklady

- [ ] Přihlášení jako `user.NN@spdemo.online` (Copilot licence).
- [ ] Tvůj web `https://ms365x17157302.sharepoint.com/sites/user.NN` — jsi jeho Owner (Edit stačí na tvorbu site skillu).
- [ ] Knihovna **Vzorky** se 3 dokumenty z D2 (smlouva, objednávka, zápis), případně i „Přehled vzorků NN" z D4 Cowork labu.

> [!NOTE] `NN` = tvoje číslo účtu. Skills nemají admin vypínač — jedou všude, kde je dostupný Copilot in SharePoint.

## Kroky

### Část A — návrh na papíře (10 min)

1. Do poznámek zkopíruj šablonu návrhu a vyplň ji. **Nemáš vlastní nápad?** Použij vzor pod šablonou.

   ```markdown
   # Návrh skillu
   - Název: <krátký, výstižný — podle něj se skill volá>
   - Kdy se má použít (účel, 1–2 věty): <…>
   - Vstupy: <co si má vyžádat — vybrané soubory, název knihovny / listu…>
   - Kroky:
     1. <…>
     2. <…>
     3. <…>
   - Výstup: <co je hotovo, kde to najdu>
   - Omezení: <co skill dělat nesmí>
   ```

   **Vzor — Kontrola vzorků:**

   ```markdown
   # Návrh skillu
   - Název: Kontrola vzorků
   - Kdy se má použít: Když chci zkontrolovat, že dokumenty v knihovně Vzorky obsahují protistranu a datum.
   - Vstupy: vybrané dokumenty v knihovně Vzorky
   - Kroky:
     1. U každého vybraného dokumentu zjisti název protistrany a klíčové datum.
     2. Pokud protistrana nebo datum chybí, zapiš název dokumentu a co chybí do listu Neúplné dokumenty.
     3. List Neúplné dokumenty vytvoř se sloupci Dokument a Chybí, pokud neexistuje.
   - Výstup: shrnutí v chatu (kolik dokumentů prošlo) + záznamy v listu Neúplné dokumenty
   - Omezení: dokumenty neměň ani nemaž; nic neposílej mimo web
   ```

2. **Kontrola omezení:** škrtni každý krok, který potřebuje externí systém, vlastní kód nebo práva, která nemáš. Skill umí jen to, co Copilot in SharePoint (shrnutí obsahu, práce se soubory a složkami, listy). Krok typu „pošli e-mail do externího systému" → poznámka „tohle už je agent nebo flow".

### Část B — peer review (5 min)

3. Vyměň návrh se sousedem. Soused hledá:

   | Hledám | Nalezeno (ano/ne + kde) |
   |---|---|
   | krok, který Copilot in SharePoint neumí | |
   | nejednoznačnou instrukci (D2 pravidla promptů) | |
   | chybějící vstup | |

4. Zapracuj aspoň jednu připomínku.

### Část C — tvorba site skillu (10 min)

5. Otevři svůj web a knihovnu **Vzorky**. Stránka **nesmí být v režimu úprav**.
6. Otevři panel **Copilot in SharePoint** (ikona Copilotu v hlavičce webu).
7. Vlož do chatu požadavek na tvorbu. Pro vzor:

   ```text
   Vytvoř site skill s názvem „Kontrola vzorků". Použije se, když chci zkontrolovat dokumenty v knihovně Vzorky.
   Vstup: vybrané dokumenty v knihovně Vzorky.
   Kroky: 1) U každého dokumentu zjisti název protistrany a klíčové datum. 2) Pokud protistrana nebo datum chybí, zapiš název dokumentu a co chybí do listu „Neúplné dokumenty". 3) Pokud list neexistuje, vytvoř ho se sloupci Dokument a Chybí.
   Výstup: v chatu napiš, kolik dokumentů prošlo a kolik ne.
   Dokumenty neměň ani nemaž.
   ```

   U vlastního návrhu přepiš text podle své šablony — **vždy napiš „site skill"**, ať se uloží na web, ne do OneDrivu.
8. Copilot vrátí **draft definice skillu**. Přečti ho a porovnej se svým návrhem. Pokud něco nesedí, napiš úpravu, např. `Do kroku 2 doplň, že datum musí být ve formátu D. M. RRRR.`
9. Potvrď uložení (Copilot se zeptá, zda skill uložit).

**Kontrola:** v knihovnách webu přibyla **Agent Assets** a v ní složka `Skills/Kontrola vzorků/` se souborem `SKILL.md`.

### Část D — běh a porovnání (10 min)

10. V knihovně **Vzorky** označ zaškrtnutím 3 dokumenty.
11. V chatu Copilot in SharePoint napiš:

    ```text
    Spusť skill Kontrola vzorků na vybrané dokumenty.
    ```

12. Sleduj chat: objeví se **skill indicator card** (potvrzení, že se skill načetl). Odpověz na doplňující otázky, pokud se Copilot zeptá.
13. Ověř výsledek: odpověď v chatu + (pokud některý dokument neprošel) list **Neúplné dokumenty** v obsahu webu.
14. Otevři `Agent Assets/Skills/Kontrola vzorků/SKILL.md` a zapiš: **co Copilot v definici změnil nebo doplnil** oproti tvému návrhu.
15. Bonus: napiš do chatu `/skills` a podívej se na seznam **Built-in skills**.

> [!WARNING] Plánované spouštění skillu (scheduled AI automations) je „Advanced work" a čerpá Copilot Credits. V labu ho **nezakládej**.

## Ověření

- [ ] Návrh má název, účel, vstupy, kroky, výstup a omezení a prošel kontrolou omezení.
- [ ] Peer review proběhlo, min. 1 připomínka zapracovaná.
- [ ] `Agent Assets/Skills/<název>/SKILL.md` existuje na tvém webu.
- [ ] Při běhu se objevila skill indicator card; výsledek v chatu (a případně v listu) zapsaný.
- [ ] Zapsaný rozdíl mezi návrhem a uloženým `SKILL.md`.

## Když něco nejde

| Příznak | Příčina | Řešení |
|---|---|---|
| Panel Copilot in SharePoint chybí | licence se nepropsala, nebo je na webu Restricted Content Discovery | odhlas se a přihlas; jinak hlas instruktorovi → fallback |
| Copilot skill uložil do OneDrivu | vytvořil **personal** skill | napiš `Ulož ho jako site skill na tento web.` |
| Copilot nechce vytvořit skill | stránka je v režimu úprav | ukonči úpravy (Uložit / Zahodit) a zkus znovu |
| Skill se při běhu nenačte (chybí indicator card) | dotaz neodpovídá účelu skillu | zavolej ho přesně jménem (krok 11) |
| List Neúplné dokumenty nevznikl | všechny dokumenty prošly | v pořádku — zapiš „všechny prošly"; pro test nahraj dokument bez data |

## Fallback

- Skills studentům nejedou (licence nepropsaná): části A a B jsou plnohodnotný deliverable. Instruktor vytvoří a spustí 2–3 vybrané návrhy na svém webu, autoři porovnají draft se svým návrhem.

## Zdroje (Microsoft)

[Extend Copilot in SharePoint with skills](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-skills) · [Get started with Copilot in SharePoint](https://learn.microsoft.com/en-us/sharepoint/copilot-in-sharepoint-get-started)
