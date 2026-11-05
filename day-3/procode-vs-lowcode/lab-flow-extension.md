# Lab · Rozšíření flow o vlastní akci

> Modul: procode-vs-lowcode · Odhad: 30 min · Režim: **simulace (návrh nad demo flow z bloku 3), samostatně podle šablony**

## Cíl

Navrhnout rozšíření fakturového demo flow o vlastní akci a volbu vrstvy (konektor / custom connector / kód) podložit limity, bezpečností a udržovatelností.

## Zadání

Demo flow z bloku 3: **trigger (nová faktura v knihovně) → AI Builder vytěžení → schválení → zápis metadat**. Vyber si **jeden** scénář rozšíření:

| Scénář | Co přidáváš |
|---|---|
| **A. Robustnější vytěžení** | nahradit AI Builder voláním **Azure AI Document Intelligence** (`prebuilt-invoice`) |
| **B. Validace proti registru** | po vytěžení ověřit IČO dodavatele proti externímu API (ARES) |
| **C. Notifikace mimo M365** | po schválení poslat data do interního ERP přes jeho REST API |

## Předpoklady

- [ ] Viděl/a jsi demo flow z bloku 3 ([`../power-automate-invoices/`](../power-automate-invoices/README.md)).
- [ ] Přečtený [README modulu](README.md) — mapa možností a rozhodovací osa.

## Kroky

1. Zkopíruj šablonu a vyplň ji pro svůj scénář. U scénáře B je vyplněný vzor tabulky kontraktu.

```markdown
# Rozšíření flow — scénář <A/B/C>

## 1. Kam akce vstupuje
trigger → AI Builder vytěžení → [ZDE?] → schválení → [ZDE?] → zápis metadat
- Po kterém kroku:
- Vstup akce:
- Výstup akce:

## 2. Vrstva
- Volba: <hotový konektor / custom connector / kód (Azure Function + Graph)>
- Argument 1:
- Argument 2:

## 3. Kontrakt akce
| Položka | Hodnota |
|---|---|
| Base URL | |
| Operace (metoda + cesta) | |
| Vstupní parametry | |
| Výstup | |
| Autentizace | |

## 4. Provozní rizika
| Riziko | Co flow udělá |
|---|---|
| | |
| | |

## 5. Kdo to udrží za rok
- <power user / vývojář> — co to znamená pro volbu vrstvy:
```

   **Vzor kontraktu pro scénář B (ARES):**

   | Položka | Hodnota |
   |---|---|
   | Base URL | `https://ares.gov.cz/ekonomicke-subjekty-v-be/rest` |
   | Operace | `GET /ekonomicke-subjekty/{ico}` |
   | Vstupní parametry | `ico` (8 číslic) z vytěžení |
   | Výstup | obchodní jméno, sídlo, stav subjektu |
   | Autentizace | žádná (veřejné API) — v custom connectoru typ *No authentication* |

2. **Krok 1 — vstup:** u scénáře A akce nahrazuje krok vytěžení; u B jde **za** vytěžení a **před** schválení; u C **za** schválení.
3. **Krok 2 — vrstva:** dva argumenty z rozhodovací osy (limity, bezpečnost, udržovatelnost). Nápověda: existuje hotový konektor? Potřebuješ Entra ID auth? Kdo bude kód udržovat?
4. **Krok 3 — kontrakt:** tabulka, ne OpenAPI. Pro interní API (scénář C) doporučeně **Entra ID** autentizace.
5. **Krok 4 — rizika:** dvě rizika **s ošetřením** (např. throttling → retry policy; výpadek API → větev „ruční kontrola"; nízká confidence vytěžení → vrátit k člověku).
6. **Krok 5 — údržba:** jedna věta: kdo to bude za rok opravovat, a jestli to sedí s tvou volbou vrstvy.

## Ověření

- [ ] Vstupní a výstupní bod ve flow je určený.
- [ ] Volba vrstvy má 2 věcné argumenty.
- [ ] Kontrakt má URL, operaci, vstup, výstup a autentizaci.
- [ ] Rizika mají ošetření, ne jen výčet.
- [ ] Odpověď „kdo to udrží" je v souladu s volbou vrstvy.

## Když něco nejde

| Situace | Co udělat |
|---|---|
| Nevím, jestli existuje hotový konektor | Pro Document Intelligence konektor existuje; pro ARES a interní ERP ne → custom connector. |
| Nevím, jakou autentizaci | Veřejné API: bez autentizace / API klíč; interní API: Entra ID. |

## Fallback

- Málo času: scénář A společně na tabuli (nejblíž výkladu — Document Intelligence), B a C jen ústně.
