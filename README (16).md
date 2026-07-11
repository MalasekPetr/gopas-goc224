# Instructor notes — M00 Onboarding

## Timing
- Celé dopoledne. Velká rezerva na přihlašování/MFA/reset hesel u 20 účtů — historicky největší žrout času.

## Před během — checklist prostředí
- [ ] Hesla pro `user.11`–`user.30` připravena k rozdání.
- [ ] Licence Business Basic přiřazené všem 20 účtům.
- [ ] PAYG billing policy zapnutá a pokrývající studentské účty (Copilot Credits).
- [ ] Budget alert na PAYG nastavený (spotřebu nezastaví, ale upozorní).
- [ ] Copilot in SharePoint dostupný (preview enablement, `KnowledgeAgentScope`).
- [ ] Každý student má vlastní web s rolí Site Collection Admin / Owner.
- [ ] Studentům přiřazen **Global Reader** na celý týden.

## Model rolí (viz `../../environment.md`)
- Studenti: **Global Reader** (celý týden) + **Owner** na vlastním webu. **Ne Global Admin.**
- Tenant-wide operace (`Set-SPOTenant`, service enablement) = instruktorské demo.
- **Lifecycle:** Po ráno nastavit role → Pá večer deaktivovat účty (ochrana PAYG).

## Tripwires
- Onboarding vs. konfigurace: nezapínat funkce tady, jen přístup.
- Poznámka k názvosloví (SharePoint Premium → aktuální názvy) říct hned na začátku.
- Role ≠ ochrana PAYG — kredity žere používání Copilota. PAYG hlídá budget alert + páteční deaktivace.

## PAYG cost watch
- 20 studentů × opakované dotazy = reálné Azure náklady bez tvrdého stropu. Zmínit studentům v pravidlech práce.
