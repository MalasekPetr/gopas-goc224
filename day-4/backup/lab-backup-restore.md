# Lab · Backup posture review & restore drill

> Modul: backup · Odhad: 30 min · Režim: simulace (návrh) + instruktorské demo restore

## Cíl

Posoudit backup posture fiktivní firmy a napsat restore plán s testovací kadencí.

## Zadání

Firma: 200 lidí, 60 webů (10 kritických — smlouvy, finance), OneDrive pro všechny, Exchange. Dnes: žádný backup, spoléhá na koš a verzování. Včera je potkal škodlivý skript, který přepsal obsah 2 webů — koš nestačil.

## Kroky

1. **Posture review:** zapiš 3 díry současného stavu (koš/verzování vs. hromadný incident, RPO bez záloh, kdo by obnovoval).
2. **Návrh policy:** co zálohovat (vše vs. kritické — argument přes $0.15/GB/měs), kdo dostane roli Microsoft 365 Backup Administrator.
3. **Restore plán:** pro scénář ze zadání urči — jaký restore point (10min pointy!), jaký typ obnovy (full site rollback vs. granular), očekávané RTO z čísel v README.
4. **Testovací kadence:** navrhni drill (co, jak často, kdo, jak se měří úspěch). Minimum: 1 express restore testovacího webu za kvartál.
5. **Demo:** instruktor předvede restore point picker a obnovu testovacího webu; porovnej s odhadem z kroku 3.

## Ověření

- [ ] Posture review má 3 konkrétní díry.
- [ ] Policy návrh má rozsah + roli + cenový argument.
- [ ] Restore plán má point, typ obnovy a RTO odhad.
- [ ] Kadence drilu je měřitelná (ne „občas otestovat").

## Fallback

- Backup v tenantu nezapnutý (go/no-go): krok 5 na screenshotech z docs; kroky 1–4 beze změny.
