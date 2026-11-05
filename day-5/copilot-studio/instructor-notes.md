# Instructor notes — Copilot Studio

## Timing

- 40 min výklad + 50 min lab. Největší hands-on týdne — výklad nekynout, DLP a kredity stačí po 5 minutách s odkazem na README.

## Go/no-go — otestovat před během

- **Přístup studentů do Copilot Studia**: PAYG billing policy / trial pro 20 účtů — ověřit přihlášení testovacím studentským účtem vč. založení agenta a SharePoint knowledge. No-go → fallback (stavba podle návrhů studentů na projektoru).
- **Environment**: studenti staví v `GOC224-lab` (Sandbox, založený v D3 — viz `../../day-4/power-automate-invoices/explainer-environments.md`), role Environment Maker, billing policy připojená k tomuto environmentu. Ověřit, že se Copilot Studio otvírá v něm, ne v defaultu (přepínač environmentu vpravo nahoře).
- **Harness**: ověřit, kam vede „New agent" v tenantu (nová zkušenost = GitHub Copilot harness, účtuje od stavby) a jak se dostat na standard harness (*Other ways to build* / *Open classic experience*). Testovacím účtem po pár testech zkontrolovat stránku **Monitor** — čerpá test panel na standard harnessu kredity?
- **HR data čerstvá:** expirace certifikátů jsou offsety od `-ReferenceDate`. Den před D4 přenasadit `scripts/New-HRAgentData.ps1 -Reseed -ReferenceDate <datum D4>` (jinak „do 30 dnů" ≠ 10018/10022/10027). Offsety 7/21/28 dní, nejbližší další 60 → výsledek drží i přes D5.
- Ověřit, že **Restricted SharePoint Search není zapnutý** (blokoval by SharePoint knowledge celé třídě).
- **Analytika nad listem — který harness:** MS dokumentuje analytické/agregační dotazy nad SharePoint listy (až 10 listů, 120k řádků) **pro novou zkušenost (GitHub Copilot harness)**, která čerpá kredity od stavby. Na standard harnessu se list ingestuje do Dataverse, agregace tam dokumentované nejsou. Dry-run testů 2 a 3 z labu (správně: 10018/10022/10027; 4 nepodepsané 10017/10019/10025/10029) na standard harnessu. Když selžou: buď to nechat jako zjištění („standard vs. nový harness"), nebo testy 2–3 ukázat instruktorsky v nové zkušenosti (kredity jen za jeden účet).
- Test hranice práv v labu = druhý knowledge zdroj na web spolužáka (`/sites/user.MM`), ke kterému student nemá přístup → „no response". Ověřit, že studenti k cizím webům opravdu přístup nemají.
- DLP politiky prostředí: nesmí blokovat SharePoint knowledge, ale ideálně mít **zablokovaný HTTP node a neautentizovaný chat** — governance příklad k ukázání.

## Tripwires

- „Message packs" neexistují — **Copilot Credits** (od 9/2025). Studenti s dřívější zkušeností se budou ptát.
- Test hranice práv (test 5, krok 10) je hvězda labu — nechat každou dvojici říct výsledek nahlas; váže celý týden (permissions > licence > scope).
- Hlídat publikaci — krok 13 je záměrně zákaz; kdo publikuje, dělá to přes Requests flow jako demo pro všechny.
- Kreditová disciplína: 20 studentů × ladění = reálné peníze; budget alert z D1 pořád běží (jen upozorní). Kdo omylem staví v nové zkušenosti (GitHub Copilot harness), čerpá kredity od první věty — přesměrovat na standard harness.

## Vazby

- Zpět: návrhy a evaluační plány (včerejší copilot-agents, D4), Skills (ranní blok — skill vs. topic!), popisy/instrukce (D2), DLP a registry (D4), RSS/RCD (D2–D3).
- Dopředu: capstone — agent je jedna sekce blueprintu, evaluační plán a governance flow se recyklují.
