# Lab · Rozšíření flow o vlastní akci

> Modul: procode-vs-lowcode · Odhad: 30 min · Režim: simulace (návrh nad demo flow z bloku 3)

## Cíl

Navrhnout rozšíření fakturového demo flow o vlastní akci — volbu vrstvy podložit limity, bezpečností a udržovatelností.

## Zadání

Demo flow z bloku 3 (trigger → AI Builder vytěžení → approval → metadata) je potřeba rozšířit. Vyber si JEDEN scénář:

- **A. Robustnější vytěžení** — nahradit AI Builder voláním **Azure AI Document Intelligence** (`prebuilt-invoice`).
- **B. Validace proti registru** — po vytěžení ověřit IČO dodavatele proti externímu API (ARES).
- **C. Notifikace mimo M365** — po schválení poslat data do interního ERP přes jeho REST API.

## Kroky

1. Zakresli, **kam** do flow akce vstupuje (před/po kterém kroku, co je vstup a výstup).
2. Rozhodni vrstvu: hotový konektor / **custom connector** / kód (Azure Function + Graph). Zapiš 2 argumenty.
3. Navrhni kontrakt custom connectoru: base URL, 1 operace (metoda + cesta), auth (doporučeně Entra ID) — stačí tabulka, ne OpenAPI.
4. Vyjmenuj 2 provozní rizika (throttling, výpadek API, confidence) a co s nimi flow udělá.
5. Odpověz: kdo tohle udrží za rok? (power user vs. vývojář — a co to znamená pro volbu vrstvy).

## Ověření

- [ ] Vstupní/výstupní bod ve flow je zakreslený.
- [ ] Volba vrstvy má 2 věcné argumenty.
- [ ] Kontrakt akce má URL, operaci a auth.
- [ ] Rizika mají ošetření, ne jen výčet.

## Fallback

- Málo času: scénář A společně na tabuli (nejblíž výkladu — Document Intelligence akcent), B/C jen ústně.
