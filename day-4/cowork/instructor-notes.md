# Instructor notes — Cowork

## Timing

- 15 min výklad + 30 min lab. Když hoří čas: `lab-cowork` část C (Automations, cena, srovnání) jako domácí úkol.

## Go/no-go (ráno před blokem)

- [ ] Studentské účty mají **Copilot licenci** a propsala se (testovací `user.NN`: Home → přepínač Cowork viditelný).
- [ ] **Spending policy** (M365 AC → Copilot → Cost management) obsahuje studenty a službu **Cowork**, per-user strop. **Auto-apply new services** vypnuté.
- [ ] Knihovna `Vzorky` na studentských webech existuje (D2); kdo ji nemá, dostane 3 vzorky.
- [ ] **Dry-run na testovacím `user.NN`:** kam Cowork uloží nový Word — do `Vzorky`, nebo do OneDrivu? (FAQ: výstupy do OneDrive/SharePoint workspace.) Podle výsledku ohlásit krok 9 labu předem.

No-go → fallback z labu (instruktor na plátně).

## Tripwires

- **Cowork je „agentic system", ne agent** — v M365 AC Agents ho nevypneš; přístup = spending policy. Bude se to hodit v D5 `copilot-admin`.
- **„Always allow"** studenty láká — v labu je zakázané schválně. U zákazníka je to otázka politiky.
- **E-maily jen sobě.** 20 studentů posílajících e-maily navzájem = chaos; hlídat zadání.
- **Plánované prompty mazat** — tiše čerpají kredity i po kurzu. Po bloku zkontrolovat v Cost management.
- EU Data Boundary: v Cowork jen GPT modely — kdo uvidí v model pickeru něco jiného, zapsat.
- Neslibovat sazby kreditů — ukázat spotřebu v Cost management po bloku.

## Vazby

- Zpět: nový Copilot a licence (D1), anatomie promptu (D2), knihovna `Vzorky` (D2), skills (D3, stejný `SKILL.md`), Power Automate (D4 dopoledne) jako srovnání.
- Dopředu: [`../code/`](../code/README.md), agenti odpoledne (Cowork ≠ agent), [`../ai-app-access/`](../ai-app-access/README.md) (kdo další sahá na data tenantu), `copilot-admin` a `monitoring` (D5 — spending policy, CopilotInteraction audit zahrnuje Cowork).
