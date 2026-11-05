# Instructor notes — Microsoft 365 Agents Toolkit

## Go/no-go

- VS Code + rozšíření Agents Toolkit připravené; M365 login. `Provision`/běh **fungují i pro studenty na PAYG** (ověřeno 2026-07-17; od 2026-09 i dokumentováno v prerequisites) — může každý sám, nebo společný instruktorský běh. Re-verify před během.
- Teams admin center → *Upload custom apps* povoleno (sideloading) — jinak `Provision` selže.
- Knihovna `Runbooky` na `/sites/hr-demo` (z `New-HRAgentData.ps1 -Reseed`).
- Když čas tlačí: lab zkrátit na scaffold + editaci manifestu (části A–C), běh nechat jako jeden instruktorský run.
- **Dry-run laby přesně podle návodu (od 2026-11 jsou krok za krokem s plným JSON):** ověřit v aktuální verzi Toolkitu, že šablona *No Action* používá `"instructions": "$[file('instruction.txt')]"` a `appPackage/instruction.txt`; že po Provision je v `env/.env.dev` řádek `M365_TITLE_ID`; že Accounts ukazuje *Custom app upload enabled*; a že URL knihovny `…/sites/hr-demo/Runbooky` sedí (název knihovny ze skriptu). Kroky průvodce, *Preview your app (F5)* a `-developer on` jsou ověřené v MS docs (2026-09).
- **Connected agents ([`lab-connected-agents.md`](lab-connected-agents.md), +25–30 min, preview):** dry-run na testovacím `user.NN` — provisionovat Support Asistenta + Helpdesk Triáž s `worker_agents` a ověřit, že test 1 deleguje. MS uvádí registraci volaného agenta v **Agent 365 agent registry** — zjistit, zda ji Toolkit provisioning splní sám, nebo je nutný admin krok. Mít připravený vlastní pár agentů pro fallback. D4 je přetížený → dnes nejspíš jako demo (části A+B studenti v manifestu), hands-on v dalších bězích.

## Tripwires

- **Publikum jsou správci, ne vývojáři** — držet na úrovni „agent jako konfigurace" (JSON), ne kódování. Akci NEstavět (mimo rozsah, jen M365).
- Nosná pointa: **agent jako kód** (git, provisioning, publikace přes schválení) vs. Agent Builder = osobní klikačka bez source control.
- **`description` je rozhraní** (connected agents test 3) — nosná governance pointa: změna popisu volaného agenta tiše rozbije volajícího. Vázat na vlastnictví agentů a registr (D5).
- Mezi agenty jde jen text; Adaptive Cards volaného agenta uživatel nevidí — když se student zeptá „proč nevidím kartu".
- Když padne dotaz „proč Toolkit nedělá HR list": `list_id` = knihovna, ne list (schema 1.7 i aktuální 1.9) — tabulková data jen přes Dataverse/konektor/akci. Není slabý, je to špatný nástroj na tuhle práci.

## Vazby

- Zpět: Agent Builder a SharePoint agents (předchozí bloky), srovnání ([`../copilot-agents/comparison-agent-paths.md`](../copilot-agents/comparison-agent-paths.md)).
- Dopředu: správa agentů → D5 `copilot-admin`; analytika/low-code → D5 Copilot Studio; repo-as-code přístup → capstone.
