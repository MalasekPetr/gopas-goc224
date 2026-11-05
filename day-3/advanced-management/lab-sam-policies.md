# Lab · Aplikace a ověření politik (SAM)

> Modul: advanced-management · Odhad: 30 min · Režim: **instruktor aplikuje (tenant-wide), studenti ověřují samostatně podle návodu**; plný fallback simulace

## Cíl

Vidět životní cyklus SAM politiky (výběr → aplikace → ověření dopadu), přečíst DAG report a rozhodnout RAC / RCD / nic pro svůj web.

## Předpoklady

- [ ] Přihlášení jako `user.NN@spdemo.online` (Global Reader) — SharePoint admin center vidíš jen pro čtení.
- [ ] SharePoint admin center: `https://ms365x17157302-admin.sharepoint.com`.
- [ ] Tvůj web `https://ms365x17157302.sharepoint.com/sites/user.NN` s obsahem z D1–D2.

> [!NOTE] Popisky v SharePoint admin centru se mění — drž se smyslu kroku. Pokud v levé navigaci položku nevidíš, rozbal **Show all**.

## Kroky

### Krok 1 — DAG report (instruktor + ty, 7 min)

1. Instruktor otevře **Reports → Data access governance** → report **Sharing links**. Než ho spustí, tipni si a zapiš: *jaký typ odkazů bude nejčastější?* (Anyone / celá organizace / konkrétní lidé)
2. Otevři stejný report ve svém prohlížeči (jen čtení) a zapiš:

   | Údaj | Hodnota |
   |---|---|
   | Nejčastější typ sdílecích odkazů | |
   | Web s nejvíce odkazy | |
   | Trefil/a ses v tipu? | |

### Krok 2 — aplikace politiky (instruktor, 5 min)

3. Instruktor aplikuje **inactive site policy** (**Policies → Site lifecycle management**) nebo **RCD** na testovací web. Sleduj, co nastavuje.

### Krok 3 — ověření (ty, 8 min)

4. V SharePoint admin centru najdi aplikovanou politiku a vyplň:

   | Otázka | Odpověď |
   |---|---|
   | Kde v admin centru je (cesta) | |
   | Na jaké weby cílí (rozsah, kritérium) | |
   | Co dělá (notifikuje vlastníka / skrývá z Copilotu / omezuje přístup) | |
   | Koho notifikuje a jak často | |

5. **Můstek na D2 (jen pokud ranní go/no-go dovolil PowerShell):** spusť znovu `copilot-inventory.ps1` z D2. U webu s RCD se `RestrictedContentDiscovery` překlopí na `True` a `CopilotAvailable` na `False`. Zapiš řádek před a po.

### Krok 4 — rozhodnutí pro tvůj web (5 min)

6. Rozhodni pro svůj web jednu z možností a doplň odůvodnění jednou větou:

   | Možnost | Kdy | Tvoje volba + odůvodnění |
   |---|---|---|
   | **RAC** (Restricted Access Control) | web smí vidět jen určitá skupina — omezuje **přístup** | |
   | **RCD** (Restricted Content Discovery) | web zůstává přístupný, ale nemá se objevovat v Copilotu a vyhledávání — omezuje **viditelnost pro AI** | |
   | **nic** | obsah je určený všem, kdo k webu mají přístup | |

### Krok 5 — společně (5 min)

7. Projdeme nahlas 2–3 rozhodnutí a porovnáme je s pravidlem **„RAC = přístup, RCD = viditelnost pro AI"**.

## Ověření

- [ ] Tabulka DAG reportu vyplněná (včetně tipu).
- [ ] Našel/a jsi politiku v admin centru a popsal/a její dopad.
- [ ] Máš RAC / RCD / nic rozhodnutí pro svůj web s odůvodněním.
- [ ] (Pokud jel PowerShell můstek) Ukázal/a jsi změněný řádek a vysvětlil/a, proč se `CopilotAvailable` změnilo.

## Když něco nejde

| Příznak | Příčina | Řešení |
|---|---|---|
| Reports → Data access governance chybí | SAM funkce nejsou v tenantu dostupné | zapiš; pokračuj fallbackem |
| Report je prázdný | report ještě neběžel / data se generují | instruktor promítne svůj běh |
| Politiku v admin centru nenajdeš | rozbalená jen část navigace | **Show all** v levém panelu; hledej pod **Policies** |
| Inventura z D2 se nezměnila | RCD se propisuje se zpožděním | počkej pár minut a spusť znovu |

## Fallback

- SAM nedostupný (licence): kroky 1–3 na screenshotech z dokumentace; kroky 4–5 beze změny (rozhodování je papírové).

## Zdroje (Microsoft)

[SharePoint Advanced Management](https://learn.microsoft.com/en-us/sharepoint/advanced-management)
