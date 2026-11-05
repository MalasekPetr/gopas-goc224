# Lab · Dashboard v Code a governance checklist

> Modul: cowork-code · Odhad: 30 min · Režim: **studenti hands-on** (Frontier); fallback instruktorské demo
> Data: list `Zaměstnanci` na HR webu — [`../copilot-agents/scenario-hr-agent.md`](../copilot-agents/scenario-hr-agent.md)

## Cíl

Postavit v Code malou aplikaci nad SharePoint listem a sepsat, co musí správce vědět, než něco takového povolí celé firmě.

## Předpoklady

- Copilot licence + spending policy pro Code + tenant ve Frontier (instruktor ověřil).
- Přístup ke čtení listu `Zaměstnanci` na HR webu (`/sites/hr-demo`).
- [Microsoft Copilot](https://m365.cloud.microsoft) na webu → tab **Code** (běh v cloudu — tak je tenant nastavený).

## Kroky

### Část A — stavba (20 min)

1. V Code popiš výsledek, ne implementaci. Kostra:

   > Postav jednoduchý dashboard nad SharePoint listem `Zaměstnanci` na webu <URL HR webu>. Chci: (1) tabulku zaměstnanců, kterým propadá certifikace do 30 dnů, (2) počet zaměstnanců podle útvaru, (3) seznam lidí s nepodepsaným dokumentem. Česky, bez úprav dat — jen čtení.

2. Sleduj živý náhled. Ověř jedno číslo ručně proti listu (např. počet v jednom útvaru).
3. Udělej **jednu iteraci** (např. filtr podle lokality) a zkus **revert** na předchozí verzi.
4. Aplikaci **nepublikuj pro celou organizaci**. Jen si prohlédni, jaké možnosti publikace a sdílení Code nabízí, a zapiš je.

### Část B — governance checklist (10 min)

5. Do MD poznámky odpověz:
   - **Kde aplikace běží** (cloud / zařízení) a kdo o tom rozhoduje.
   - **Jaká data** aplikace čte a pod čími právy. Co uvidí kolega bez přístupu k HR webu?
   - **Komu by byla sdílená**, kdybys ji publikoval, a kdo ji pak udržuje.
   - **Proč je v našem tenantu GitHub connection vypnutá** (data sovereignty).
   - **Kolik to stálo** — kde to uživatel a admin uvidí.
   - **Agent nebo aplikace?** Tentýž „komu propadá certifikát" uvidíš odpoledne v Agent Builderu — v čem se výsledky liší.

## Ověření

- [ ] Dashboard ukazuje 3 požadované přehledy; jedno číslo ručně ověřené.
- [ ] Iterace + revert vyzkoušené.
- [ ] Aplikace není publikovaná pro organizaci.
- [ ] Governance checklist má všech 6 odpovědí.

## Fallback

- Code tab se nenabízí (Frontier / Code tab / spending policy): instruktor postaví dashboard na plátně, studenti předem napíšou zadání (krok 1) a predikují, co aplikace ukáže; část B beze změny.
- Code neumí list načíst: použij export listu do Excelu jako vstup a zapiš rozdíl jako zjištění.

## Náklady

Code čerpá Copilot Credits navíc k licenci, v rámci per-user stropu spending policy. Spotřebu vidí uživatel vůči svému nároku a admin v Cost management.
