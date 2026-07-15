# Instructor notes — Backup

## Timing

- 40 min výklad + 30 min lab (vč. dema v kroku 5). RPO/RTO tabulka je jádro — nechat studenty čísla použít v labu, ne je jen ukázat.
- **Otvírák dne (5 min, před výkladem):** revisit výsledků **inactive site policy** ze včerejšího SAM bloku (simulation doběhla přes noc) + kontrola, zda dopropagovalo RCD na testovacím webu (AI entry pointy zmizely?).

## Go/no-go

- Backup zapnutý v tenantu + testovací web v policy aspoň den předem (ať existují restore pointy!). No-go → demo na screenshotech.
- Pozor na náklady: policy jen na 1–2 testovací weby, ne na studentské (20 × weby × $0.15/GB se zbytečně sčítá).

## Tripwires

- Neříkat „SharePoint backup" jako produkt — **Microsoft 365 Backup** (glosář), kryje i Exchange a OneDrive.
- **Purview retence ≠ backup retence** — čekat dotaz „proč mi retence nestačí"; odpověď: retence řeší compliance životní cyklus, ne hromadnou obnovu; a Purview politiky zálohy neovlivňují.
- Nezaměnit s Azure Backup — jiný produkt, jiný svět.
- Data sovereignty argument: zálohy neopouštějí M365 boundary — dobrá zpráva pro compliance, říct explicitně.

## Vazby

- Zpět: PAYG plumbing (D2 configuration, glosář — třetí kategorie metrů: storage/data).
- Dopředu: `archive` hned potom (stejná Azure plumbing, jiný problém — cold data vs. obnova); drill/runbook myšlení → `monitoring`.
