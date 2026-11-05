# Lab · Dashboard v Code a governance checklist

> Modul: code · Odhad: 30 min · Režim: **studenti hands-on, samostatně podle návodu** (Frontier); fallback instruktorské demo
> Data: list `Zaměstnanci` na HR webu — [`../copilot-agents/scenario-hr-agent.md`](../copilot-agents/scenario-hr-agent.md)

## Cíl

Postavit v Code malou aplikaci nad SharePoint listem, zjistit, kolik stála, a sepsat, co musí správce vědět, než něco takového povolí celé firmě.

## Předpoklady

- [ ] Přihlášení jako `user.NN@spdemo.online` (Copilot licence + spending policy pro Code + tenant ve Frontier — ověřil instruktor).
- [ ] Vidíš list **Zaměstnanci** na `https://ms365x17157302.sharepoint.com/sites/hr-demo` (20 řádků).
- [ ] Zkopírovaný odkaz na list: otevři list → **Share** → **Copy link** (nebo adresa z adresního řádku bez části za `?`).

> [!NOTE] Code je Frontier preview — popisky se mění. Drž se smyslu kroku.

## Kroky

### Část A — stavba (18 min)

1. Otevři `https://m365.cloud.microsoft` → v aplikaci Copilot karta **Code**.
2. Založ nový projekt a jako místo běhu vyber **Cloud** (lokální běh je v našem tenantu vypnutý). Model nech **Auto**.
3. Do konverzace vlož (přepiš `<ODKAZ NA LIST>` a `NN`):

   ```text
   Postav jednoduchý dashboard v češtině nad SharePoint listem Zaměstnanci: <ODKAZ NA LIST>
   Chci tři části:
   1. Tabulka zaměstnanců, kterým sloupec „Certifikace platí do" vyprší do 30 dnů od dneška (osobní číslo, jméno, útvar, datum).
   2. Počet zaměstnanců podle sloupce „Útvar" jako sloupcový graf.
   3. Seznam zaměstnanců, kteří mají „Dokument k podpisu" = Ano.
   Data jen čti, nic neměň. Nahoru dej nadpis „HR přehled NN".
   ```

4. Pokud se Code zeptá na **oprávnění k datovému zdroji** (SharePoint), povol ho. Pokud se zeptá na upřesnění, odpověz.
5. Sleduj **živý náhled** vpravo. **Ověř jedno číslo ručně:** v listu Zaměstnanci si vyfiltruj jeden útvar a porovnej počet s grafem. Správnou odpověď pro část 1 zjisti v listu: vyfiltruj sloupec **Certifikace platí do** na období dnes až dnes + 30 dní (při čerstvém nasazení dat to jsou **10018, 10022, 10027**). Zapiš, jestli dashboard sedí.
6. **Iterace:** napiš `Přidej nahoru filtr podle sloupce Lokalita.` a ověř, že filtr funguje.
7. **Revert:** napiš `Vrať aplikaci do verze před přidáním filtru.` a ověř, že filtr zmizel.
8. Aplikaci **nepublikuj pro organizaci** a **nesdílej**. Jen si prohlédni, jaké možnosti publikace a sdílení Code nabízí (zeptej se: `Jak bych tuto aplikaci publikoval a sdílel?`), a zapiš je.
9. Napiš **`/cost`** a zapiš, kolik kreditů stavba stála (v Code funguje — ověřeno 2026-11).

**Kontrola:** náhled ukazuje nadpis „HR přehled NN" a tři části; část 1 odpovídá filtru v listu z kroku 5; část 3 obsahuje 10017, 10019, 10025, 10029.

### Část B — governance checklist (12 min)

10. Do poznámek odpověz na 7 otázek. Nápovědu najdeš v [README modulu](README.md), sekce *Kde aplikace žije — Copilot Managed Runtime*.

    | # | Otázka | Tvoje odpověď |
    |---|---|---|
    | 1 | **Kde aplikace běží** (cloud / zařízení) a kdo o tom rozhoduje? | |
    | 2 | **Jaká data** čte a pod čími právy? Co uvidí kolega bez přístupu k HR webu? | |
    | 3 | **Komu by byla sdílená**, kdybys ji publikoval, a kdo ji pak udržuje? | |
    | 4 | **Proč je v našem tenantu GitHub connection vypnutá?** (data sovereignty) | |
    | 5 | **Kolik to stálo** — `/cost` z kroku 9 + kde to uvidí admin? | |
    | 6 | **Kdo platí za běh** publikované aplikace? (spending policy *Copilot Managed Runtime*) | |
    | 7 | **Agent nebo aplikace?** Tentýž dotaz „komu propadá certifikát" uvidíš odpoledne v Agent Builderu — v čem se výsledky liší? | |

## Ověření

- [ ] Dashboard ukazuje 3 požadované části; část 1 sedí s filtrem v listu; jedno číslo ručně ověřené.
- [ ] Iterace (filtr) i revert vyzkoušené.
- [ ] Aplikace není publikovaná ani sdílená.
- [ ] `/cost` zapsaný.
- [ ] Governance checklist má všech 7 odpovědí.

## Když něco nejde

| Příznak | Příčina | Řešení |
|---|---|---|
| Karta **Code** chybí | tenant / účet není ve Frontier, Code tab vypnutý, nebo chybí spending policy | hlas instruktorovi → fallback |
| Code list nenačte nebo hlásí chybu oprávnění | odkaz na list obsahuje parametry, nebo nemáš k listu přístup | použij čistý odkaz bez `?`; ověř, že list v prohlížeči otevřeš |
| Část 1 nesedí (jiné osoby) | Code špatně interpretoval sloupec nebo datum | napiš `Zkontroluj filtr „do 30 dnů od dneška" nad sloupcem Certifikace platí do.` a porovnej znovu |
| Code chce připojit GitHub | GitHub je v tenantu záměrně vypnutý | odmítni; projekt zůstává v cloudu Copilotu |
| Code list nečte vůbec | zdroj nepodporovaný ve tvé verzi | exportuj list (**Exportovat → CSV**), nahraj CSV do konverzace a zapiš rozdíl jako zjištění |

## Fallback

- Code se nenabízí: instruktor postaví dashboard na plátně podle kroku 3. Ty napíšeš zadání, predikuješ, co aplikace ukáže, a vyplníš část B.

## Náklady

Code čerpá Copilot Credits navíc k licenci, v rámci per-user stropu spending policy. Spotřebu vidíš přes `/cost`, admin v Cost management.

## Zdroje (Microsoft)

[Copilot Code](https://learn.microsoft.com/en-us/copilot/code/) · [Use Copilot Code](https://learn.microsoft.com/en-us/copilot/code/use-code) · [Copilot Code requirements](https://learn.microsoft.com/en-us/copilot/code/code-requirements) · [What is Copilot Managed Runtime](https://learn.microsoft.com/en-us/microsoft-365/managed-apps/)
