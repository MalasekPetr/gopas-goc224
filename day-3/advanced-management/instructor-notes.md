# Instructor notes — SAM

## Timing

- 60 min výklad + 30 min lab. Neutopit se v kompletním výčtu funkcí — kostra jsou 3 pilíře a RAC/RCD rozlišení.

## Go/no-go

- **Před během ověřit, že SAM je v tenantu odemčený** (odemyká ho 1 přiřazená M365 Copilot licence — v kurzovním tenantu ji má instruktorský účet; **běh 2026-07: potvrzeno odemčeno**). No-go → lab fallback na screenshoty, rozhodovací část zůstává.
- Pokud SAM jede: připravit dopředu testovací „neaktivní" web, ať má inactive site policy co chytit.

## Příprava ráno v den bloku — věci s latencí (KLÍČOVÉ)

- [ ] **Spustit generování DAG reportů** (sharing links, permission state) hned ráno — generují se asynchronně (desítky minut); v bloku se jen otevírají výsledky.
- [ ] **Aplikovat RCD na malý testovací web** (`Set-SPOSite -RestrictContentOrgWideSearch $true`) co nejdřív — propagace přes indexy není okamžitá; „Restricted" tag v admin centru je vidět hned (jistý vizuál), zmizení AI entry pointů na webu ukazovat jen pokud stihlo propagovat. Latence sama je lekce: „RCD není incident response tlačítko."
- [ ] Obětní web pro **RAC** + druhá browser identita (účet mimo povolenou security group) na zážitek „access denied".
- [ ] Na obětní web nasypat 2–3 sharing linky — čerstvé studentské weby mají DAG report nudný, tohle mu dá co ukázat.

## Demo checklist (pořadí v bloku)

1. **Otvírák — licenční pointa**: „SAM tu svítí, protože je v tenantu jedna Copilot licence" — živý důkaz D1 lekce. 2 minuty, velký efekt.
2. **Recent admin actions + change history report** — „je tam váš celý týden": založení 20 studentských webů, změny z D2 konfigurace („vzpomínáte na včerejší `Set-SPOTenant`? Tady je"). Okamžité, nulová příprava.
3. **DAG sharing links report** — třída tipuje nejčastější nález, pak otevřít předgenerovaný report + EEEU insights (klasický oversharing vektor, který Copilot zviditelní).
4. **RCD — uzavření smyčky z D2**: Restricted tag na testovacím webu → studenti znovu pustí `copilot-inventory.ps1` (read-only, dle D2 go/no-go) → `RestrictedContentDiscovery` True, `CopilotAvailable` False. Včerejší skript dnes detekuje admin zásah — nejsilnější můstek dne.
5. **RAC na obětním webu** — druhá identita dostane „access denied"; kontrast: RAC bere lidem přístup, RCD bere AI viditelnost.
6. **Inactive site policy** — tvorba v **simulation mode** (volby, notifikace) + na rovinu, že výsledky doběhnou později → revisit zítra ráno 5 min před backupem.
7. Bonus (zbyde-li 5 min): `Start-SPORestrictedContentDiscoverabilityReport` — tenant-wide RCD report z PowerShellu, navazuje na D2 scripting nit.

## Tripwires

- RAC nasazený na špatný web = studenti ztratí přístup ke svým labům — RAC demo VÝHRADNĚ na obětní testovací web, nikdy na studentské weby.
- Change history reporty sahají jen 180 dní zpět, admin akce 30 dní — neprodávat jako plný audit (to je Purview, D5).
- „SAM zdarma s Copilotem" má výjimku: restricted site creation by apps = placený SAM Plan 1 add-on. Zmínit, ať licenční matice z D1 sedí.

## Vazby

- Zpět: licence vs. permissions (D1 licensing), oversharing jako AI riziko (D1 ai-landscape).
- Dopředu: nit „nástroje pro správu" → D5 `copilot-admin` (mapa SAM vs. M365 AC vs. 3rd-party), DAG/audit → D5 `monitoring`, RCD → D5 grounding agentů.
