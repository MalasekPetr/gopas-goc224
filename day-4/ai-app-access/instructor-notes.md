# Instructor notes — Přístup jiných AI k datům tenantu

## Timing

- 25 min výklad + 30 min lab (20 audit studentů + 10 demo). Blok stojí za `code` a před `copilot-agents`: „Copilot koná a staví uvnitř hranice — a kdo další sahá na data?"

## Původ

- Převzato z GOC223: `day-2/automation-strategy` (explainer — zkopírovaný beze změn obsahu, upravené vazby), `day-5/security-hardening` (CA pro workload identity, credentials), `day-5/permission-discovery` (`Sites.Selected` a granulární scopes). GOC224 je pro správce: studenti nic neregistrují (Global Reader), demo dělá instruktor.

## Go/no-go — před během

- [ ] Global Reader otevře v Entra admin centru **Enterprise apps**, **Permissions** a **User consent settings** (jen čtení).
- [ ] Připravená demo app registrace (single-tenant) s aplikačním `Sites.Selected` a jeden testovací web pro grant. Grant per web přes Graph / PnP — **instruktorský účet**, app-only provisioning dle vlastních pravidel; žádné identifikátory na plátno ani do repa.
- [ ] Pro demo consentu: testovací uživatel + nastavení user consentu na *verified publishers, selected permissions* nebo *Do not allow*, **admin consent workflow zapnutý**, instruktor jako reviewer. Vybrat neškodnou AI aplikaci třetí strany pro pokus o consent (nedokončovat — žádost zamítnout).
- [ ] Ověřit, zda je v tenantu karta **Agent identities** (Entra Agent ID) a zda v ní jsou agenti z Copilot Studia.
- [ ] Po demu: grant `Sites.Selected` odebrat, demo aplikaci smazat (nebo nechat pro D5 audit — rozhodnout).

## Tripwires

- **„Copilot je taky AI aplikace, proč ho neřešíme stejně?"** — Copilot běží uvnitř hranice služby M365 s právy uživatele a s MS závazky (EU Data Boundary, subprocesoři — D5). Cizí AI s aplikačními oprávněními vynáší data podle smlouvy s vydavatelem. Rozdíl je smluvní a architektonický, ne marketingový.
- **Změna user consent policy neodvolá staré granty** — studenti to předpokládají. Úklid = audit Enterprise apps + odvolání.
- **`Sites.Selected` po consentu nevidí nic** — „dal jsem consent a nefunguje" je správné chování, ne chyba.
- **Odvolat credential ≠ odebrat oprávnění** (GOC223 tripwire) — ztracený klíč se řeší smazáním credentialu podle thumbprintu.
- **CA pro workload identity** se vynucuje jen při přímém přiřazení service principalu, ne přes skupinu; multi-tenant SaaS aplikace nepokrývá.
- Neslibovat licence app governance a Agent ID funkcí — ověřit k datu běhu (README delta).
- Data sovereignty: u každé AI aplikace se ptát „kde data skončí" — vázat na registr aplikací v capstone.

## Vazby

- Zpět: Cowork a Code (uvnitř hranice), PnP aplikace kurzu (D2 `powershell-spo`), SAM/RCD (D3 — RCD nechrání před aplikačními oprávněními, ta jdou mimo search).
- Dopředu: agenti odpoledne (agent identity, Agent 365 registry u `worker_agents`), D5 `copilot-admin` (AI subprocesoři vs. nezávislí procesoři), D5 `monitoring` (`ConnectedAIAppInteraction`, sign-in logy aplikací), capstone (registr rizik: „nekontrolované AI aplikace").
