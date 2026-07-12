# Instructor notes — SAM

## Timing

- 60 min výklad + 30 min lab. Neutopit se v kompletním výčtu funkcí — kostra jsou 3 pilíře a RAC/RCD rozlišení.

## Go/no-go

- **Před během ověřit, že SAM je v tenantu odemčený** (dokumentovaně ho odemyká 1 přiřazená M365 Copilot licence; kurzovní tenant je Business Basic + PAYG — může být zamčeno!). No-go → lab fallback na screenshoty, rozhodovací část zůstává.
- Pokud SAM jede: připravit dopředu testovací „neaktivní" web, ať má inactive site policy co chytit.

## Tripwires

- RAC nasazený na špatný web = studenti ztratí přístup ke svým labům — RAC demo VÝHRADNĚ na obětní testovací web, nikdy na studentské weby.
- Change history reporty sahají jen 180 dní zpět, admin akce 30 dní — neprodávat jako plný audit (to je Purview, D4).
- „SAM zdarma s Copilotem" má výjimku: restricted site creation by apps = placený SAM Plan 1 add-on. Zmínit, ať licenční matice z D1 sedí.

## Vazby

- Zpět: licence vs. permissions (D1 licensing), oversharing jako AI riziko (D1 ai-landscape).
- Dopředu: nit „nástroje pro správu" → D4 `copilot-admin` (mapa SAM vs. M365 AC vs. 3rd-party), DAG/audit → D4 `monitoring`, RCD → D5 grounding agentů.
