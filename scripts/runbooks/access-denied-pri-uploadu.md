# Runbook · „Access denied" při uploadu do knihovny

**Kategorie:** Incident · **Demo data — fiktivní**

## Příznak
Uživatel dostane při nahrávání souboru do dokumentové knihovny chybu **„Access denied"** nebo „Přístup odepřen".

## Nejčastější příčiny
1. Uživatel má na knihovně jen oprávnění **Read** (Číst), ne **Edit/Contribute**.
2. Cílová **složka dědí přerušená oprávnění** (unique permissions) a uživatel v ní není.
3. Knihovna vyžaduje **vyplnění povinného sloupce**, který upload nevyplní.

## Řešení
1. Ověř oprávnění: *Nastavení knihovny → Oprávnění pro tuto knihovnu*. Uživatel musí mít min. **Contribute**.
2. Pokud má složka unique permissions, přidej uživatele/skupinu přímo na složku, nebo obnov dědičnost.
3. Zkontroluj povinné sloupce — pokud existuje povinný sloupec bez výchozí hodnoty, upload přes drag&drop selže. Nastav výchozí hodnotu nebo sloupec zneповinni.

## Eskalace
Pokud přetrvává i s Contribute a bez unique permissions → tiket na **SharePoint admin** (priorita P3).
