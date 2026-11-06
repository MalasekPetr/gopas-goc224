# Instructor notes — Copilot Studio

## Timing (D5 dopoledne, ~3 h)

| Čas | Blok |
|---|---|
| 0:00–0:35 | výklad README: Copilot Studio, čtyři harnessy a jejich stav, knowledge vs. nástroj (maker credentials), skills a evaluace, DLP |
| 0:35–0:55 | [`explainer-copilot-credits.md`](explainer-copilot-credits.md) + živá prohlídka: M365 AC → Copilot → Cost management (Overview, Consumption) a Azure Cost analysis — ukázat zpoždění Azure na reálných číslech |
| 0:55–1:05 | přestávka |
| 1:05–2:45 | lab [`lab-hr-agent-studio.md`](lab-hr-agent-studio.md) (100 min) |
| 2:45–3:00 | rozbor: test 6 (hranice práv), skill před/po úpravě popisu, kredity z karty Monitor nahlas; most do odpoledne (copilot-admin uvidí agenty studentů) |

Studenti dělají **totéž co lektor** (rozhodnutí autora 2026-11). Lektor jede o jednu část napřed na projektoru.

## Go/no-go — ráno před blokem

- **Strop kreditů (povinné, jinak no-go hands-on).** Lab na GitHub Copilot harnessu čerpá kredity od první věty a identity-based politika *All Users Policy* (Students, 20 000/měs., 2 000/uživatel) **agenty z Copilot Studia nepokrývá**.
  - **Výši stropu určí dry-run, ne odhad.** Odhad 2 000–6 000 na studenta je široký; pevných 3 000 by část studentů zastavilo uprostřed části F nebo G (Stop usage vypne agenta i v rozběhnuté konverzaci). Projeď celý lab jednou (viz Dry-run níže), přečti kartu Monitor a nastav **per-agent limit ≈ 1,5× spotřeba dry-runu**. Když Monitor do ~15 min nic neukáže, strop je rozpočtové rozhodnutí autora (výchozí návrh 3 000).
  - **Limit politiky** = per-agent limit × počet agentů: 20 studentů + lektor + dry-run agent = **22 agentů** (při 3 000 → 66 000).
  - **Portál!** Varianta A je v **M365 admin centru** (`admin.microsoft.com`), ne v PPAC — PPAC má v menu také „Copilot" (Copilot hub), ale Cost management v něm není (záměna při běhu 2026-11). Viz explainer, *Dva portály*.
  - **A (doporučeno, pokud v `GOC224-lab` už neběží AI Builder demo z D4):** `admin.microsoft.com` → Copilot → Cost management → Configuration → Add spending policy → Policy scope **Resources** → **Resource collection → Specific environments** = `GOC224-lab` → limit politiky + **per-agent limit**, alert na instruktora. Platí i pro agenty založené až v labu; projeví se do 12 minut. Resource-based politika nahradí PPAC alokaci a billing plan prostředí a **nepokrývá AI Builder**.
  - **B:** po části B labu v PPAC → Licensing → Copilot Studio → **Manage Agents** → u každého agenta *HR Asistent NN* → **Set limit**, práh upozornění, **Stop usage** zapnout. Ruční práce pro 20 agentů (~10 min) — udělat během části C.
- **Billing prostředí:** `GOC224-lab` má PAYG billing plan (D4) nebo ho pokrývá varianta A. Bez zdroje kreditů se agent nespustí ani v Preview.
- **Dry-run jedním studentským účtem:** agenta pojmenovat **HR Asistent DRYRUN** (ať nekoliduje s agentem studenta) a po dry-runu ho smazat nebo započítat do limitu politiky. Založit přes **Agent** (ne *Other ways to build*), projít testy 1–4, nahrát skill, spustit evaluaci; pak zkontrolovat kartu **Monitor** (kolik kreditů) a PPAC → Manage → Copilot Studio, sloupec **Harness** = GitHub Copilot. Výsledek z Monitoru použít ve výkladu jako „kolik stál dry-run".
- **Přístup:** studenti mají v `GOC224-lab` roli Environment Maker; Copilot Studio se otevírá v `GOC224-lab`, ne v defaultu.
- **DLP prostředí** povoluje konektor **SharePoint** (jinak nástroj Get items nejde přidat).
- **Maker credentials:** zjistit nastavení PPAC → `GOC224-lab` → Settings → Product → Features → *Control maker credential options*. Pro výklad je ideální ukázat obě volby; pro lab nechat výchozí (obě povolené) — studenti v kroku 15 jen zapisují, co vidí.
- **Evaluate** (preview) dostupné v tenantu? Když ne, část G přeskočit (lab to umí).
- **HR data čerstvá:** `scripts/New-HRAgentData.ps1 -Reseed -ReferenceDate <datum D4>`. Offsety 7/21/28 dní (10018/10022/10027), propadlé 10016/10024, další nejbližší 60 → výsledky drží i přes D5.
- **Restricted SharePoint Search vypnuté** (jinak SharePoint knowledge nejde) a studenti opravdu nemají přístup na cizí `/sites/user.MM`.

## Náklady — co říct a co hlídat

| | Kredity | Orientačně |
|---|---|---|
| Odhad na studenta (~20 light úkolů × 100–300) | 2 000–6 000 | $20–60 |
| Třída 20 studentů bez stropu | 40 000–120 000 | $400–1 200 |
| Se stropem 3 000 na agenta (22 agentů) | max. 66 000 | max. ~$660 |
| Skutečnost D4 (Cowork + Code, celá třída) | 4 628 | ~$46 |

- V průběhu labu sledovat PPAC → Licensing → Copilot Studio → Manage Agents (spotřeba po agentech). M365 AC Cost management se obnovuje po 2–4 h, Azure po 8–72 h — pro řízení labu **nepoužívat Azure**.
- Studenti s vyčerpaným limitem dostanou „This agent is currently unavailable. It has reached its usage limit." → dál jen predikce do tabulky (fallback v labu). Limit nezvedat bez důvodu.

## Tripwires

- **„Proč neběžíme na standard harnessu zadarmo?"** Protože skills a evaluace v jednom editoru má jen GitHub Copilot harness; standard harness je dál plně podporovaný a pro jednoduché agenty je to správná volba (MS: nemigrovat bez obchodního důvodu).
- **Harness se volí při založení a nejde změnit.** Kdo založí přes *Other ways to build*, nemá sekci Skills → založit znovu.
- **Název harnessu:** blog 3. 11. 2026 uvádí „Microsoft Copilot harness", Learn zatím „GitHub Copilot harness". Data nejdou do služby GitHub Copilot.
- **Test 6 (hranice práv)** je dál hvězda labu. Navázat na krok 15: knowledge je security-trimmed, ale nástroj pod maker credentials by hranici obešel — to je pointa pro správce.
- **Skill vs. Skills v SharePointu (D3):** společná myšlenka (Markdown, název, popis), jiná plocha. Netvrdit, že jde o identický formát.
- **GitHub Copilot harness nemá kanál SharePoint** — studenti se zeptají „jak to dát na web". Odpověď: Teams + Microsoft 365, nebo web; SharePoint kanál jen standard harness.
- Hlídat publikaci — studenti nepublikují; publikaci do Teams předvést jednou na lektorském agentovi.
- „Message packs" neexistují — **Copilot Credits** (od 9/2025).

## Vazby

- Zpět: evaluační plán (D4 `copilot-agents`), Skills (D3), popisy a instrukce (D2), environments a billing plan (D4 `power-automate-invoices`), spending policy (D2 `configuration`), Cowork/Code spotřeba (D4).
- Dopředu (odpoledne): `copilot-admin` — agenti studentů v PPAC inventáři (sloupec Harness), registr agentů, Cost management; `monitoring` — spotřeba a audit; capstone — agent jako sekce blueprintu, rozpočet kreditů jako riziko.

## Změny 2026-11 (D5 dopoledne)

- Lab přepsán z *HR Analytik* (standard harness, bez kreditů) na *HR Asistent* (GitHub Copilot harness: knowledge + nástroj Get items + skill + evaluace). Postup převzatý z MIT labů Microsoftu (mslearn-copilotstudio, laby 02 a 04) — **ne** z PL-7008 (proprietární licence, zakazuje výuku i odvozená díla).
- Blok přesunut na D5 dopoledne (~3 h) a doplněn výklad Copilot Credits.
