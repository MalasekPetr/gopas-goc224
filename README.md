# GOC224 — Microsoft 365: správa SharePoint Copilot a obsahových služeb

Zdrojové materiály pětidenního kurzu **GOC224** (GOPAS). Kurz je určený správcům Microsoft 365 a SharePointu, kteří mají v organizaci zavést a řídit Copilot, agenty a obsahové služby — od licencí a nákladů přes konfiguraci a ochranu dat až po tvorbu agentů a plán nasazení.

Materiály jsou psané v Markdownu s Mermaid diagramy a čtou se přímo na GitHubu. Každý výkladový modul je napsaný tak, aby z něj šlo studovat i bez lektora.

Katalogový název kurzu obsahuje „SharePoint Premium". Microsoft tuto značku rozdělil na samostatné produkty (Document processing for Microsoft 365, SharePoint Advanced Management, Microsoft 365 Backup, Microsoft 365 Archive). V materiálech proto používáme aktuální názvy podle [`GLOSSARY.md`](GLOSSARY.md).

## Jak kurz studovat

1. Začněte v [`agenda.md`](agenda.md) — určuje pořadí modulů. Přehled každého dne najdete v `day-N/README.md`.
2. V každém modulu si nejdřív přečtěte `README.md`: cíle, výklad, klíčová rozlišení a shrnutí.
3. Pak projděte lab (`lab-*.md`). Laby mají předpoklady, číslované kroky, kontrolu výsledku a postup „když něco nejde".
4. Neznámý pojem nebo název produktu dohledáte v [`GLOSSARY.md`](GLOSSARY.md). Údaje o kurzovním tenantu, na který se laby odkazují, jsou v [`environment.md`](environment.md).

Fakta o licencích, cenách a funkcích jsou ozdrojovaná odkazy na Microsoft. Protože se tento obor mění po měsících, má každý modul na konci sekci **Stav produktu / delta** s tím, co je potřeba ověřit k datu studia.

## Přehled dnů

| Den | Téma | Co se naučíte |
|---|---|---|
| [1](day-1/README.md) | Foundation | přístup do tenantu, formáty JSON/MD/YAML, SharePoint, mapa AI nástrojů, licence a náklady |
| [2](day-2/README.md) | Prompting, scripting & konfigurace | prompt a agentní anatomie, SharePoint PowerShell, konfigurace Copilota, Document processing |
| [3](day-3/README.md) | Obsahové služby, governance & ochrana dat | eSignature, SharePoint Advanced Management, Microsoft 365 Backup a Archive, Skills |
| [4](day-4/README.md) | Automatizace, Copilot, který koná, & tvorba agentů | Power Automate, pro-code vs. low-code, Cowork, Code, přístup AI aplikací k datům, Agent Builder, Agents Toolkit |
| [5](day-5/README.md) | Správa, stavba & rollout | správa Copilota a agentů, monitoring, Copilot Studio, rollout blueprint |

## Legenda

- **Povinný** modul — součást každého běhu.
- **Volitelný** modul (slug s prefixem `opt-`) — doplněk podle času a potřeb skupiny; žádný povinný modul na něm nestojí.
- `> [!WARNING] Ověřit k datu běhu` — fakt, který se rychle mění (ceny, preview, PAYG).
- `> [!IMPORTANT] Názvosloví` — přejmenování produktu, které v UI nebo dokumentaci mate.

## Struktura repozitáře

```text
gopas-goc224/
├─ README.md          # tento soubor
├─ agenda.md          # pořadí modulů (jediný zdroj pravdy)
├─ GLOSSARY.md        # závazné názvosloví
├─ CONVENTIONS.md     # pravidla psaní materiálů
├─ environment.md     # kurzovní tenant (údaje pro studenty)
├─ _templates/        # šablony modulu a labu
└─ day-1/ … day-5/    # moduly po dnech; modul = složka se slugem
     └─ <modul>/      # README.md (výklad), lab-*.md, instructor-notes.md
```

Soubory `instructor-notes.md` jsou poznámky pro lektora (časování, rizika, záložní postupy); ke studiu je nepotřebujete. Pravidla pro autory materiálů jsou v [`CONVENTIONS.md`](CONVENTIONS.md).
