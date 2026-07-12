# GOC224 — Microsoft 365: správa SharePoint Copilot a obsahových služeb

Zdrojové materiály kurzu **GOC224** (GOPAS). Vše je psané v Markdownu s Mermaid diagramy, renderovatelné přímo na GitHubu.

> [!NOTE]
> Katalogový název kurzu zní „…a SharePoint Premium". Značka „SharePoint Premium" byla Microsoftem rozdělena — viz [`GLOSSARY.md`](GLOSSARY.md). V materiálech používáme aktuální názvosloví; katalogový název řeší poznámka k terminologii v úvodu (M `onboarding` / `sharepoint-intro`).

## Jak repo číst

- **Pořadí modulů** je definované v [`agenda.md`](agenda.md) — složky jsou pojmenované **slugy**, ne čísly, aby vkládání dalších modulů nerozhazovalo číslování.
- **Závazné názvosloví** (produkty, formáty, PowerShell) je v [`GLOSSARY.md`](GLOSSARY.md) — jediný zdroj pravdy.
- **Konvence** (MD styl, Mermaid, currency-markery) jsou v [`CONVENTIONS.md`](CONVENTIONS.md).
- **Šablony** modulu a labu jsou v [`_templates/`](_templates/).
- **Prostředí kurzu** (pracovní tenant, na který se laby odkazují) je v [`environment.md`](environment.md).

## Struktura

```text
goc224/
├─ README.md          # tento soubor
├─ CONVENTIONS.md      # jak psát materiály
├─ GLOSSARY.md         # závazné názvosloví
├─ agenda.md           # 5denní pořadí bloků (single source of order)
├─ _templates/         # module.md, lab.md
├─ day-1/ … day-5/     # obsah po dnech; každý modul = složka se slugem
```

## Legenda

- **Povinný** modul — součást každého běhu.
- **Volitelný** modul (slug s prefixem `opt-`) — spouští se dle času / potřeb skupiny.
- Currency-markery v textu:
  - `> [!WARNING] Ověřit k datu běhu` — fast-moving fakt (ceny, preview, PAYG).
  - `> [!IMPORTANT]` — lineage / přejmenování, na které studenty upozornit.

## Stav

Scaffold. Den 1 vyplněný jako kostry (struktura + Mermaid placeholdery), dny 2–5 zatím jako přehledové stuby. Obsah doplňujeme postupně.
