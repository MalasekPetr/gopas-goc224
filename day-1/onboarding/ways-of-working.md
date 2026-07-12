# Pravidla způsobu práce (ways of working)

Governance ground-rules kurzu. Zavádí se tady a pozdější moduly se na ně odkazují (nit celého kurzu).

## Prostor a role
- Každý student je **Owner vlastního webu** (site-per-student dle `user.NN`) a má **Global Reader** na celý týden. Site-level laby dělá sám; tenant-wide operace jsou instruktorské demo (viz `../../environment.md`).
- Sdílený obsah se needituje bez domluvy.

## Datové hranice
- **EU data boundary** — rámec, ve kterém tenant běží.
- **Subprocessor Anthropic (Claude)** je pro EU/UK **default-off**; povoluje jej admin explicitně. Pro tenhle kurz relevantní jako konkrétní governance rozhodnutí.

## Přístupový princip
- **Permission-trimming**: Copilot / agent nikdy nezmíní obsah, na který student nemá právo. Grounding respektuje SharePoint permissions.
- **Licence vs. permissions** — viz `../../GLOSSARY.md`.

## PAYG chování v učebně
- AI je metrovaná (Copilot Credits). Neopakovat zbytečně dotazy „pro efekt" — každá interakce stojí kredity a nemá tvrdý strop.

## Zodpovědná AI
- Ověřovat výstupy AI, neposílat citlivá data mimo tenant, respektovat sensitivity labels.
