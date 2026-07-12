# Lab · Aplikace a ověření politik (SAM)

> Modul: advanced-management · Odhad: 30 min · Režim: instruktor aplikuje (tenant-wide), studenti ověřují; plný fallback simulace

## Cíl

Vidět životní cyklus SAM politiky: výběr → aplikace → ověření dopadu — a přečíst DAG report.

## Předpoklady

- SAM funkce dostupné v tenantu (go/no-go instruktora).
- Studenti: Global Reader (čtení SharePoint admin centra), vlastní web s testovacím obsahem.

## Kroky

1. **Instruktor (demo):** otevře DAG reporty v SharePoint admin centru → sharing links report; třída tipuje, co bude nejčastější nález.
2. **Instruktor (demo):** aplikuje **inactive site policy** (nebo RCD na vybraný testovací web).
3. **Studenti:** v SharePoint admin centru (read-only) najdou aplikovanou politiku a zapíšou: na co cílí, koho notifikuje / co skrývá.
4. **Studenti:** pro svůj web rozhodnou RAC vs. RCD vs. nic — jedna věta odůvodnění (kdo web používá, co je na něm).
5. **Společně:** projít 2–3 rozhodnutí nahlas; konfrontovat s pravidlem „RAC = přístup, RCD = viditelnost pro AI".

## Ověření

- [ ] Student našel politiku v admin centru a popsal její dopad.
- [ ] Student má RAC/RCD/nic rozhodnutí pro svůj web s odůvodněním.
- [ ] Student umí říct, co ukazuje sharing links DAG report.

## Fallback

- SAM nedostupný (licence): kroky 1–2 na screenshotech z dokumentace; kroky 4–5 běží beze změny (rozhodování je papírové).
