# Instructor notes — eSignature

## Timing

- 45–60 min výklad + 25 min lab. Otvírák dne — navázat na D2 document-processing („další prioritní služba stejné rodiny, stejný PAYG").

## Tripwires

- Neříkat „SharePoint Premium eSignature" — viz glosář; v UI je „SharePoint eSignature", produktově patří pod Document processing.
- **Dva PAYG modely nezaměňovat**: eSignature jede na Document processing PAYG (Azure metry), ne na Copilot Credits.
- Partner provider ≠ zadarmo: PAYG setup je nutný i pro Adobe/Docusign, jen se neúčtují requesty — platí se licence providera.
- Word podpora vyžaduje Enterprise/Current/Beta channel — v učebně (Business Basic, web only) demonstrovat na PDF.
- **eIDAS opatrně**: učíme rozhodovací rámec (SES/AES/QES tabulka), ne právní poradenství — na dotazy typu „stačí to na naši smlouvu?" odpovídat „úroveň určuje váš právník, IT vybírá nástroj". CZ specifikum (297/2016 Sb., uznávaný podpis vůči veřejné správě) zmínit — pro studenty ze státní správy je to dealbreaker nativního eSignature.

## Go/no-go pro živé demo

- Go: eSignature zapnuté v tenantu + testovací PDF připravené + druhý účet na roli podepisujícího.
- No-go: nechat simulaci; demo přesunout na konec dne, pokud zbyde čas.

## Vazby

- Dopředu: audit trail → D5 `monitoring` (Purview Audit); schvalování → blok 3 (Power Automate Approvals).
- Zpět: PAYG setup → D2 `configuration`; rodina Document processing → D2 `document-processing`.
