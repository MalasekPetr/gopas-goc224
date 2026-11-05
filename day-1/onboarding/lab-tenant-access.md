# Lab · Přístup do tenantu & ověření

> Modul: onboarding · Odhad: 30 min · Režim: **živý tenant, samostatně podle návodu** · Prostředí: [`../../environment.md`](../../environment.md)

## Cíl

Přihlásit se, zaregistrovat MFA, ověřit přístup ke svému webu a potvrdit, že funguje Copilot in SharePoint.

## Předpoklady

- [ ] Účet `user.NN@spdemo.online` + dočasné heslo (rozdané na začátku kurzu).
- [ ] Vlastní telefon s aplikací **Microsoft Authenticator** (doporučeno) nebo mobilní číslo pro SMS.
- [ ] Prohlížeč **Microsoft Edge**.

> [!NOTE] `NN` = číslo tvého účtu (11–30). Tento účet používáš celý týden.

## Kroky

### Část A — přihlášení a MFA (15 min)

1. V Edge vytvoř nový profil: **⋯ → Profily → Přidat profil** a přihlas se do něj účtem `user.NN@spdemo.online`. Celý týden pracuješ v tomto profilu (oddělí kurzový tenant od tvého pracovního).
2. Otevři `https://portal.office.com` a přihlas se dočasným heslem.
3. Na výzvu **změň heslo** (min. 8 znaků; zapiš si ho bezpečně).
4. Na výzvu **More information required** zaregistruj MFA — postup krok za krokem: [`mfa-setup.md`](mfa-setup.md).
5. Ověř registraci: otevři `https://aka.ms/mysecurityinfo` — musíš vidět aspoň jednu metodu (Authenticator nebo telefon).

**Kontrola:** po odhlášení a novém přihlášení tě tenant vyzve k MFA a projdeš.

### Část B — vlastní web (8 min)

6. Otevři svůj web: `https://ms365x17157302.sharepoint.com/sites/user.NN`. Jsi jeho **Owner**.
7. V levé navigaci otevři knihovnu **Dokumenty** → **Nahrát** → **Soubory** a nahraj libovolný dokument (Word/PDF, 1–3 strany, bez osobních údajů). Instruktor má záložní vzorek.

**Kontrola:** dokument je v knihovně a otevře se v prohlížeči.

### Část C — Copilot in SharePoint (7 min)

8. Na svém webu otevři panel **Copilot** (ikona Copilotu v hlavičce webu). Stránka nesmí být v režimu úprav.
9. Polož dotaz (doplň název souboru):

   ```text
   Shrň ve třech bodech dokument <název souboru> v knihovně Dokumenty.
   ```

10. Ověř, že odpověď vychází z tvého dokumentu (Copilot uvádí odkaz na zdroj).

## Ověření

- [ ] Přihlášení v samostatném profilu Edge funguje.
- [ ] `https://aka.ms/mysecurityinfo` ukazuje aspoň jednu MFA metodu.
- [ ] Dokument je nahraný na tvém webu.
- [ ] Copilot in SharePoint odpověděl nad tvým dokumentem s odkazem na zdroj.

## Když něco nejde

| Příznak | Příčina | Řešení |
|---|---|---|
| Nejde naskenovat QR kód / nechodí SMS | viz „Časté problémy" | [`mfa-setup.md`](mfa-setup.md); jinak instruktor |
| „Váš účet je zablokovaný" | příliš mnoho pokusů | hlas instruktorovi (odblokování účtu) |
| Web `user.NN` hlásí „Přístup odepřen" | jsi přihlášený jiným účtem | ověř vpravo nahoře účet; přepni profil Edge |
| Panel Copilot chybí | Copilot licence se ještě nepropsala, nebo je na webu Restricted Content Discovery | odhlas se a přihlas; jinak instruktor. PAYG bez licence Copilot in SharePoint nezpřístupní (ověřeno 2026-11) |
| Copilot odpoví obecně, bez odkazu na dokument | dokument se ještě neindexoval | počkej 5–10 minut a dotaz zopakuj |

## Fallback

- MFA nejde dokončit: řeší instruktor (dočasné obejití / reset metod); ostatní kroky dokončíš po vyřešení.
- Copilot in SharePoint nedostupný: konstatuj a pokračuj — konfiguraci řešíme v D2 `configuration`.
