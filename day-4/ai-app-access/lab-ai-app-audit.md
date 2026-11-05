# Lab · Audit přístupu aplikací a AI k datům tenantu

> Modul: ai-app-access · Odhad: 30 min (20 audit + 10 demo) · Režim: **studenti audit samostatně podle návodu (Global Reader, jen čtení) + instruktorské demo**

## Cíl

Zjistit, které aplikace mají v tenantu přístup k datům a jaký, přečíst nastavení consentu a zapsat rizika s konkrétní nápravou. V demu uvidíš `Sites.Selected` a blokovaný user consent.

## Předpoklady

- [ ] Přihlášení jako `user.NN@spdemo.online` na `https://entra.microsoft.com` — role **Global Reader** (všechno vidíš, nic nezměníš).
- [ ] Přečtený [README modulu](README.md) — delegovaná vs. aplikační oprávnění, consent.

> [!NOTE] Popisky v Entra admin centru se mění — drž se smyslu kroku. Do poznámek **nepiš** tenant ID, client ID ani jiné identifikátory (repo i sdílené poznámky jsou veřejné).

## Kroky

### Část A — nastavení consentu (5 min)

1. **Identity → Applications → Enterprise apps → Consent and permissions → User consent settings.** Zapiš, která volba je zapnutá:

   | Volba | Zapnutá? |
   |---|---|
   | Do not allow user consent | |
   | Allow user consent for apps from verified publishers, for selected permissions | |
   | Allow user consent for apps | |

2. Ve stejné sekci najdi **Admin consent settings**: je zapnutý **admin consent workflow** (uživatelé mohou požádat o schválení)? Zapiš.

### Část B — inventura Enterprise apps (10 min)

3. **Enterprise apps → All applications.** Ve filtru **Application type** zvol **Enterprise Applications** (bez aplikací Microsoftu) a zapiš počet.
4. Vyber **3 aplikace** (např. PnP aplikaci kurzu, agenta z dnešních labů, cokoli neznámého). U každé otevři:
   - **Overview** — vydavatel, zda je *verified*;
   - **Permissions** — záložky **Admin consent** a **User consent**: která oprávnění má a zda jsou **delegovaná**, nebo **aplikační**;
   - **Properties** — *Assignment required?* (smí ji použít každý, nebo jen přiřazení);
   - **Owners** — má vlastníka?

5. Vyplň tabulku (bez identifikátorů):

   | Aplikace | Vydavatel ověřený? | Oprávnění (typ) | Přístup k datům celého tenantu? | Vlastník | Riziko (nízké/střední/vysoké) |
   |---|---|---|---|---|---|
   | | | | | | |
   | | | | | | |
   | | | | | | |

   **Vodítko:** aplikační `Sites.Read.All`, `Files.Read.All`, `Sites.FullControl.All`, `Mail.Read` = přístup ke všem datům daného typu v tenantu → **vysoké** riziko, pokud nejde o vlastní, zdokumentovanou aplikaci s vlastníkem.

### Část C — agent identity (3 min)

6. V Entra admin centru hledej kartu **Agent identities** (Entra Agent ID). Jsou tam agenti z kurzu (Copilot Studio, Microsoft agenti)? Zapiš, co vidíš — nebo že karta v tenantu není.

### Část D — nápravy (2 min + do registru rizik)

7. Ke každé aplikaci s rizikem střední / vysoké napiš **jednu konkrétní nápravu**:

   | Riziko | Náprava | Kde |
   |---|---|---|
   | aplikace má `Sites.Read.All` (aplikační) | přejít na `Sites.Selected` + grant jen na potřebné weby | Entra → App registrations → API permissions; grant přes Graph / PnP |
   | aplikace bez vlastníka | určit 2 vlastníky, nebo aplikaci odstranit | Enterprise app → Owners |
   | volný user consent | přepnout na *verified publishers, selected permissions* + zapnout admin consent workflow | Consent and permissions |
   | | | |

### Instruktorské demo (10 min)

8. Instruktor ukáže:
   - registraci single-tenant aplikace s aplikačním oprávněním **`Sites.Selected`** → admin consent → aplikace **nevidí nic** → grant na jeden web → aplikace vidí jen ten web;
   - **dvojici** App registration (šablona, credentials) a Enterprise app (udělený consent) téže aplikace;
   - testovací účet zkusí odsouhlasit AI aplikaci třetí strany → user consent je zablokovaný → **žádost o admin consent** → instruktor ji v **Admin consent requests** posoudí.

## Ověření

- [ ] Zapsané nastavení user consentu a admin consent workflow.
- [ ] Tabulka 3 aplikací: typ oprávnění, rozsah, vlastník, riziko.
- [ ] Zapsaný stav karty Agent identities.
- [ ] Každé riziko střední / vysoké má konkrétní nápravu s místem provedení.
- [ ] Umíš vysvětlit, proč `Sites.Selected` po consentu nevidí nic.

## Když něco nejde

| Příznak | Příčina | Řešení |
|---|---|---|
| Položku v navigaci nevidíš | sbalená navigace / jiný popisek | rozbal **Identity → Applications**; hledej přes vyhledávání v portálu |
| Záložka **Permissions** je prázdná | aplikace nemá udělený consent (nebo jde o Microsoft aplikaci) | vyber jinou aplikaci |
| *Admin consent requests* nevidíš | žádosti vidí jen určení schvalovatelé | zapiš to; demo ukáže instruktor |
| Karta Agent identities chybí | funkce ještě není v tenantu dostupná | zapiš jako zjištění |

## Fallback

- Global Reader některou část nevidí: instruktor ji promítne; tabulky vyplníš podle plátna.

## Zdroje (Microsoft)

[Configure user consent](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/configure-user-consent) · [Review permissions granted to enterprise apps](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/manage-application-permissions) · [Admin consent workflow](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/configure-admin-consent-workflow) · [Selected permissions overview](https://learn.microsoft.com/en-us/graph/permissions-selected-overview) · [What are agent identities](https://learn.microsoft.com/en-us/entra/agent-id/what-are-agent-identities)
