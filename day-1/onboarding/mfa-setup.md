# Jak zaregistrovat vícefaktorové ověřování (MFA)

> Modul: M00 · Prostředí: [`../../environment.md`](../../environment.md)

> Účet `user.NN@spdemo.online` je po celou dobu kurzu váš **pracovní účet na počítači v učebně GOPAS** — přihlaste se jím do prohlížeče (profil Edge) a používejte ho celý týden. Při prvním přihlášení je nutné zaregistrovat vícefaktorové ověřování (MFA); bez něj se ke zdrojům tenantu nedostanete.

---

## Účel

Vícefaktorové ověřování (MFA) přidává druhý ověřovací krok při přihlašování. Kromě hesla potvrzujete svou identitu prostřednictvím mobilní aplikace nebo SMS kódu. Tím se výrazně snižuje riziko neoprávněného přístupu, i v případě úniku hesla.

---

## Cílová skupina

Všichni studenti kurzu s účtem `user.NN@spdemo.online` (NN = 11–30) v tenantu kurzu.

---

## Předpoklady

- Aktivní účet `user.NN@spdemo.online` s heslem od instruktora
- Vlastní chytrý telefon (doporučeno) nebo mobilní číslo pro SMS
- Připojení k internetu na telefonu i na počítači v učebně

---

## Postup

### Krok 1 – Otevřete registrační stránku

1. Otevřete prohlížeč a přejděte na: **https://aka.ms/mfasetup**
2. Přihlaste se kurzovním účtem (`user.NN@spdemo.online`).
3. Pokud MFA ještě není zaregistrováno, zobrazí se výzva:
   *„Vyžadovány další informace – Vaše organizace potřebuje další informace k zabezpečení vašeho účtu."*
4. Klikněte na **Další** a zahajte registraci.

---

### Krok 2 – Zaregistrujte aplikaci Microsoft Authenticator (doporučeno)

> **Poznámka:** Aplikace Microsoft Authenticator nabízí nejbezpečnější a nejpohodlnější způsob ověřování. Instalace trvá přibližně 2 minuty.

#### 2a – Nainstalujte aplikaci do telefonu

1. Otevřete **App Store** (iPhone) nebo **Google Play** (Android).
2. Vyhledejte **Microsoft Authenticator** a nainstalujte aplikaci vydanou *Microsoft Corporation*.
3. Otevřete aplikaci a klepněte na **Přidat účet**.

#### 2b – Propojte aplikaci se svým účtem

1. Na registrační stránce vyberte **Microsoft Authenticator** a klikněte na **Další**.
2. Na obrazovce se zobrazí QR kód.
3. V aplikaci Authenticator klepněte na ikonu **+** → **Pracovní nebo školní účet** → **Naskenovat QR kód**.
4. Namiřte fotoaparát telefonu na QR kód na obrazovce počítače.
5. Váš účet se zobrazí v aplikaci. Na počítači klikněte na **Další**.
6. Do telefonu přijde testovací oznámení – klepněte na **Schválit**.
7. Klikněte na **Další** a poté na **Hotovo**.

---

### Krok 3 – Zaregistrujte záložní metodu (doporučeno)

Registrace druhé metody zajistí přístup k účtu v případě, že ztratíte přístup k primární metodě.

1. Přejděte na **https://aka.ms/mysecurityinfo**.
2. Vyberte **+ Přidat metodu**.
3. Zvolte **Telefon** a zadejte své mobilní číslo.
4. Vyberte **Poslat mi kód** (SMS).
5. Zadejte obdržený ověřovací kód a potvrďte.

---

### Krok 4 – Ověřte registraci

1. Přejděte na **https://aka.ms/mysecurityinfo**.
2. Zkontrolujte, že je v sekci **Bezpečnostní údaje** uvedena alespoň jedna metoda.
3. Metoda označená jako **Výchozí** bude při každém přihlášení použita jako první.

---

## Dostupné ověřovací metody

| Metoda | Požadavky | Poznámka |
|---|---|---|
| Aplikace Microsoft Authenticator | Chytrý telefon (iOS / Android) | Doporučeno – nejbezpečnější, podporuje schválení jedním klepnutím |
| SMS | Mobilní telefon s registrovaným číslem | Jednodušší, ale méně bezpečné než aplikace |

---

## Tipy

- **Důvěryhodné zařízení:** Při přihlášení na počítači v učebně zaškrtněte *„Po dobu 14 dní se neptat"* – účet používáte celý týden, omezíte tím frekvenci výzev k ověření.
- **Offline přístup:** Aplikace Authenticator generuje 6místný rotující kód i bez mobilních dat. Klepněte na svůj účet v aplikaci pro jeho zobrazení.
- **Více metod:** Zaregistrujte alespoň dvě metody (aplikace + SMS). Zajistíte si tak přístup, i když jedna přestane být dostupná.

---

## Časté problémy

| Problém | Řešení |
|---|---|
| Nelze naskenovat QR kód | Klepněte na **Nelze naskenovat obrázek?** v aplikaci Authenticator a zadejte kód ručně. |
| SMS kód nepřišel | Ověřte, že je zaregistrováno správné číslo. Klepněte na **Znovu odeslat kód** nebo přepněte na hovorové ověření. |
| Nelze schválit požadavek v aplikaci | Přihlaste se pomocí záložní metody (SMS) a poté znovu zaregistrujte aplikaci na https://aka.ms/mysecurityinfo. |
| Žádná mobilní data | Použijte offline TOTP kód v aplikaci Authenticator (klepněte na svůj účet pro zobrazení kódu). |
| Účet je zablokován | Kontaktujte instruktora. Nikomu nesdělujte své heslo ani MFA kódy. |
| Neočekávaná výzva ke schválení MFA | **Okamžitě ji zamítněte.** Poté informujte instruktora – může se jednat o pokus o neoprávněný přístup. |

> **Bezpečnostní upozornění:** Nikdy neschvalujte výzvu MFA, kterou jste sami neinicializovali. Útočníci mohou zasílat opakované výzvy a spoléhat na to, že ji omylem schválíte (tzv. MFA fatigue útok).

---

## Stav produktu / delta

> [!WARNING] Ověřit k datu běhu — přesné texty výzev a UI registrace MFA se v M365 průběžně mění; screenshoty/kroky projít před během kurzu.
