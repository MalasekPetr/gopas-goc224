# Lab · Plán archivace pro kolekci webů

> Modul: archive · Odhad: 25 min · Režim: simulace

## Cíl

Vybrat kandidáty na archivaci z inventury webů a spočítat dopad na náklady.

## Zadání

Použij inventuru z D2 PowerShell labu (CSV: weby, storage, aktivita) — nebo náhradní tabulku od instruktora: 60 webů, z toho 18 bez aktivity >12 měsíců (celkem 400 GB), tenant má licencovanou kvótu 1 TB, aktuálně obsazeno 850 GB aktivními daty.

## Kroky

1. Definuj archivační kritérium (stáří aktivity, vlastnictví, typ webu) — a 2 výjimky, které se archivovat nesmí (např. web s retencí do soudního sporu? — smí, retence platí i v archivu; najdi skutečné výjimky).
2. Spočítej: kolik GB jde do archivu, co zbude v aktivním, vejde se součet do kvóty? Kolik bude archiv stát měsíčně (pravidlo „zdarma do kvóty")?
3. Rozhodni pro 3 konkrétní weby ze seznamu: archiv / RCD / nechat — jedna věta odůvodnění (nápověda: používá se? má být v Copilotu?).
4. Napiš reaktivační pravidlo: kdo smí žádat, jak dlouho trvá, co znamená 4měsíční zámek.
5. Ověř plán proti backup otázce: jsou archivované weby v backup policy?

## Ověření

- [ ] Kritérium + skutečné výjimky (ne retence — ta v archivu platí).
- [ ] Výpočet nákladů používá pravidlo kvóty správně.
- [ ] 3 rozhodnutí archiv/RCD/nechat s odůvodněním.
- [ ] Reaktivační pravidlo + backup kontrola.

## Fallback

- Bez CSV z D2: instruktor rozdá náhradní tabulku ze zadání.
