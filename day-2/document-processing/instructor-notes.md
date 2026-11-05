# Instructor notes — Document processing

## Timing

- Největší blok dne: 40 min výklad + konfigurace, 2× 10 min demo, 40 min lab, 10 min nálezy. Chránit před skluzem dopoledních bloků — radši zkrátit výklad než dema a lab.

## Před během — checklist

- [ ] PAYG billing aktivní; autofill + image tagging **scope zahrnuje studentské weby** (Selected sites — přidat všech 20).
- [ ] Sada vzorků: 3 dokumenty CZ (smlouva, objednávka, zápis — s jasnou „protistranou") + 3 obrázky (jeden schválně víceznačný, ať tagging ukáže limity), distribuce přes odkaz.
- [ ] Demo knihovna připravená, ale autofill sloupec zakládat AŽ živě — to je celé demo.
- [ ] Budget alert zkontrolovaný — 20 studentů × ~10 transakcí je drobné, ale viditelné.
- [ ] Structured/freeform: pokud se má ukázat víc než slide, ověřit **Power Platform environment**; bez AI Builder kreditů jde transakce na M365 PAYG metr $0,05/stránku (ceník) — ověřit v tenantu, compare stránka MS uvádí „not applicable". Bez ověření jen výklad nad maticí, demo nechat na prebuilt/unstructured (M365 PAYG).
- [ ] Promo kapacita zdarma: podle promo stránky do 12/2026 (100 stran autofill+unstructured, 2 500 obrázků/měs. na tenant) — dema 3+3 se do ní vejdou; v Azure Cost Management ověřit, zda se reálně neúčtují.

## Dema

1. **Autofill**: sloupec „Protistrana" + prompt sloupce; ukázat dobrý vs. líný prompt (váže na ranní prompting blok). Ukázat přepis hodnoty člověkem.
2. **Image tagging**: zapnout na knihovně, nahrát obrázky, ukázat tagy + kde se spravují (managed metadata). Zdůraznit: účtuje se per knihovna se zapnutým taggingem.

## Tripwires

- Neříkat Syntex ani SharePoint Premium (glosář); URL v docs „syntex" — upozornit jednou.
- **Autofill překryv s Copilot in SharePoint** (GA: everyday autofill v Copilot licenci, real-time/site-wide přes Copilot Credits) — zmínit, náš tenant jede Document processing PAYG cestou. Stejná funkce, dvě cesty účtování = živá ilustrace „Document processing PAYG ≠ Copilot Credits".
- Studenti rádi nahrají 50 obrázků „na zkoušku" — vzorek je 3+3, říct proč (PAYG).
- eSignature z rodiny nevykládat — má vlastní blok zítra (D3).

## Vazby

- Zpět: prompt anatomie (ranní blok) přímo v promptu autofill sloupce; PAYG modely (D1 licensing).
- Dopředu: eSignature (D3/1), vytěžování faktur — prebuilt modely vs. Azure (D4/1), náklady/observabilita → D5 `monitoring`.

## Přesunuto z README (samostudium, 2026-11)

- Konfiguraci (M365 AC → Pay-as-you-go services → Document & image services) a obě dema předvádí instruktor **živě na plátně**; studenti pak totéž opakují v labu na knihovně Vzorky.
