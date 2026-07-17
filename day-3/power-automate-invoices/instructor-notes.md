# Instructor notes — Power Automate faktury

## Timing

- 40–50 min: 25 min výklad (anatomie + tři cesty vytěžení) + 15–20 min živé demo flow. **Bez labu** — čas jde bloku 4 (procode-vs-lowcode), který na demo flow navazuje.

## Demo checklist

- [ ] **Environment `GOC224-lab` (Sandbox) založený** + Copilot Credits PAYG billing policy připojená + DLP zkontrolované (SharePoint konektor povolený) — viz `explainer-environments.md`. Demo flow stavět v něm, NE v defaultu. Totéž prostředí použije páteční Copilot Studio lab.
- [ ] V úvodu bloku 5 min: environment strategie + ukázat „Microsoft 365 sandbox" v admin centru jako příklad environment sprawl (CDX artefakt — ignorujeme, nemažeme).
- [ ] Připravený flow v tenantu: knihovna „Faktury" na instruktorském webu, trigger (properties only), AI Builder invoice model, Start and wait for an approval, zápis metadat.
- [ ] 2 testovací faktury (PDF, česky) — jedna čistá, jedna „rozbitá" (sken nakřivo) na ukázku confidence.
- [ ] Schvalovací notifikaci předvést v Teams i e-mailu.

## Tripwires

- **Nevybírat deprecated triggery** „When a file is created in a folder" — v designeru jsou stále vidět; ukázat správný „(properties only)".
- Říkat **Azure AI Document Intelligence**, ne Cognitive Services / Form Recognizer; zmínit Foundry deštník jednou, nevrtat se v rebrandu.
- AI Builder umí česky — ale ukázat confidence score a říct, proč nízká confidence nesmí rovnou do metadat.
- Nezabřednout do stavby flow klik po kliku — blok je výkladový, stavba není cíl.

## Vazby

- Zpět: vytěžování → D2 `document-processing`; schvalování → D3 `esignature` (Approvals vs. podpis).
- Dopředu: demo flow = podklad pro lab v `procode-vs-lowcode`; provozní výjimky → D5 `monitoring` (runbook).
