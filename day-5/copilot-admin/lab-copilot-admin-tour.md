# Lab · Admin tour — Copilot, Agents a aplikace

> Modul: copilot-admin · Odhad: 30 min · Režim: **živý tenant, samostatně podle návodu** (Global Reader, read-only)

## Cíl

Projít vlastníma očima správní plochy Copilotu, agentů a aplikací v M365 admin centru a umět odpovědět, **kde se která správní otázka řeší**.

## Předpoklady

- [ ] Přihlášení jako `user.NN@spdemo.online` na `https://admin.microsoft.com`. Máš roli **Global Reader** — všechno vidíš, nic nezměníš (tlačítka pro změny jsou šedá nebo chybí).
- [ ] Máš otevřenou tabulku k vyplnění (níže) v poznámkách.

> [!NOTE] Pokud vlevo nevidíš celou navigaci, klikni dole v levém panelu na **Show all**.

## Tabulka k vyplnění

Během kroků 1–6 doplňuj:

| # | Otázka | Kde v UI (přesná cesta) | Co jsi našel |
|---|---|---|---|
| 1 | Kde se řídí web grounding Copilotu? | | |
| 2 | Kde se řídí AI subprocesoři (OpenAI, Anthropic) a nezávislí procesoři? | | |
| 3 | Kdo smí používat Cowork / Code a s jakým stropem? | | |
| 4 | Kolik agentů je v tenantu a jsou mezi nimi ownerless? | | |
| 5 | Čeká nějaký agent na schválení publikace? | | |
| 6 | Kde uvidím aplikace postavené v Code a co smí? | | |
| 7 | Kdo Copilot reálně používá? | | |

## Kroky

### Krok 1 — Copilot → Settings (5 min)

1. V levém panelu **Copilot** → **Settings**.
2. Projdi taby **User access**, **Data access**, **Copilot actions**, **Other settings**. Do tabulky zapiš řádek 1 (web search) a řádek 2 (*AI providers operating as Microsoft subprocessors* / *independent processors*).

### Krok 2 — Copilot → Cost management (5 min)

3. **Copilot** → **Cost management** → karta **Configuration** (seznam spending policies).
4. U každé policy zapiš: **scope** (kdo), **služby** (Cowork, Code, Advanced work, Copilot Managed Runtime…), **limit** (tvrdý strop) a stav **Auto-apply new services**. Řádek 3 tabulky.
5. Karta **Consumption** → pohled **Users**: najdi svou spotřebu z labů D4 (Cowork, Code).

### Krok 3 — Agents (5 min)

6. V levém panelu **Agents** → **Overview**: zapiš počet agentů a hodnotu **ownerless agents** (governance dluh — agent bez vlastníka). Řádek 4.
7. **Agents** → **All agents**: najdi své agenty z D4 (*Support Asistent NN*, *Helpdesk Triáž NN*, *HR Asistent NN*). Otevři jednoho a zapiš, jaké informace o něm admin vidí (vlastník, typ, kdo ho používá).
8. Najdi **Requests**: čeká něco na schválení? Řádek 5.

### Krok 4 — Aplikace z Code (5 min)

9. **Apps** → **All apps**: je tu tvoje aplikace *HR přehled NN* z D4 (i nepublikovaná)?
10. **Apps** → **Settings** → **Environment groups** → otevři výchozí skupinu (default group). Projdi pravidla:
    - **Connectors and MCP servers**: je povolený konektor SharePoint? Proč je akce **Send an HTTP request** blokovaná?
    - **Sharing**: smí se aplikace sdílet s hosty?
11. Vrať se do **Copilot → Cost management** a najdi policy pro službu **Copilot Managed Runtime** — kdo platí za běh aplikace? Řádek 6.

### Krok 5 — Usage report (5 min)

12. **Reports** → **Usage** → **Microsoft Copilot**. Zapiš počet aktivních uživatelů za týden kurzu. Data mají zpoždění ~48 h, detaily jsou ve výchozím stavu anonymizované. Řádek 7.
13. Najdi samostatný report **Agents** (preview), pokud je dostupný.

### Krok 6 — mapa vrstev (5 min)

14. Doplň vlastními slovy: kdy jdeš do **SAM** (SharePoint admin center), kdy do **M365 AC → Copilot**, kdy do **M365 AC → Agents**, kdy do **M365 AC → Apps** a kdy do **Power Platform admin center**. Jedna věta ke každému.

### Instruktorské demo (po labu)

15. Instruktor zablokuje testovacího agenta a ukáže, co uvidí uživatel; schválí request publikace.

## Ověření

- [ ] Tabulka má vyplněných všech 7 řádků s přesnou cestou v UI.
- [ ] Umíš odpovědět: „Chci zakázat agenta X pro všechny — kam kliknu?"
- [ ] Umíš odpovědět: „Kde uvidím a omezím aplikace, které si lidé postavili v Code?" (Apps → All apps / Environment groups; detail DLP v PPAC)
- [ ] Mapa vrstev vyplněná vlastními slovy.

## Když něco nejde

| Příznak | Příčina | Řešení |
|---|---|---|
| Položka v navigaci chybí | skrytá za **Show all** | klikni **Show all** dole v levém panelu |
| Cost management je prázdné nebo nepřístupné | preview změny / Global Reader tab nevidí | zapiš to; instruktor promítne ze svého účtu |
| Své agenty z D4 v **All agents** nevidíš | agenti z Toolkitu jsou nasazení jen pro tebe (sideload) | hledej podle názvu s tvým `NN`; zapiš, jestli tam jsou |
| **Apps** v navigaci nemáš | Copilot Managed Runtime admin experience ještě není v tenantu | zapiš to jako zjištění; řádek 6 doplň z README cowork-code |
| Usage report je prázdný | zpoždění dat ~48 h | v pořádku — zapiš „data ještě nedorazila" |

## Fallback

- Global Reader některý tab nevidí: instruktor ho promítne ze svého účtu; tabulku vyplňuješ podle plátna.

## Zdroje (Microsoft)

[Configure Copilot settings](https://learn.microsoft.com/en-us/microsoft-365/copilot/configure-copilot-admin-center) · [Usage-based billing](https://learn.microsoft.com/en-us/microsoft-365/copilot/usage-based-billing-overview-copilot-credits) · [Manage agents](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/manage-copilot-agents-integrated-apps) · [Copilot Managed Runtime — governance](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/apps/governance)
