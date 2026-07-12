# Lab · Přístup do tenantu & ověření

> Modul: M00 · Režim: živý tenant · Prostředí: `../../environment.md`

## Cíl
Student se přihlásí, ověří přístup ke svému prostoru a potvrdí dostupnost Copilot in SharePoint.

## Předpoklady
- Účet `user.NN@spdemo.online` + heslo (rozdané na začátku).
- Vlastní telefon (Microsoft Authenticator) nebo mobilní číslo pro SMS — nutné pro registraci MFA.
- Přiřazená licence Business Basic + zapnutý PAYG na tenantu.
- Owner/Edit role na vlastním webu/knihovně.

## Kroky
1. Přihlas se na `https://portal.office.com` účtem `user.NN@spdemo.online` — a stejným účtem do profilu prohlížeče (Edge); účet používáš celý týden jako pracovní.
2. Dokonči reset hesla a **registraci MFA** (povinné, vynuceno Conditional Access) — postup: [`mfa-setup.md`](mfa-setup.md).
3. Otevři SharePoint → svůj web/knihovnu (`https://ms365x17157302.sharepoint.com/...`).
4. Nahraj testovací dokument do knihovny.
5. Otevři Copilot in SharePoint na webu a polož jednoduchý dotaz nad nahraným obsahem.

## Ověření
- [ ] Student se přihlásil a vidí svůj prostor.
- [ ] MFA zaregistrováno — `https://aka.ms/mysecurityinfo` ukazuje alespoň jednu metodu.
- [ ] Student nahrál dokument.
- [ ] Copilot in SharePoint odpověděl nad obsahem (potvrzení, že PAYG + přístup fungují).

## Fallback
- Problémy s registrací MFA (QR kód, SMS, zablokovaný účet): viz „Časté problémy" v [`mfa-setup.md`](mfa-setup.md); když nepomůže, řeší instruktor.
- Když Copilot in SharePoint není dostupný: ověřit PAYG billing policy a `KnowledgeAgentScope` (instruktor, admin) — patří do konfigurace den 2, tady jen konstatovat a pokračovat.
