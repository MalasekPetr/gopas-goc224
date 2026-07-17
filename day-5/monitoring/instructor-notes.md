# Instructor notes — Monitoring

## Timing

- 40 min výklad + 35 min lab. Audit hands-on je „wow" moment (studenti vidí vlastní stopu) — nechat mu prostor.

## Go/no-go

- **Ověřit, jak studenti dostanou audit search**: Global Reader na Purview Audit nestačí vždy — otestovat; případně dočasně View-Only Audit Logs role, jinak fallback (promítání).
- Audit eventy mají zpoždění — interakce z D1–D4 budou vidět, ranní z D5 nemusí. Neplánovat lab na „co jsi dělal před hodinou".

## Tripwires

- Alert policies ukazovat v **Defender portálu** — kdo je zná z Purview compliance portálu, hledá je špatně (přestěhováno).
- `JailbreakDetected` a `BingWebSearch` v záznamu — zmínit, výborný teaching point (co všechno stopa nese), ale nedemonstrovat jailbreak!
- Usage report ≠ audit — MS to říká explicitně, opřít se o to.
- Runbook je deliverable dle osnovy — nenechat sklouznout jen k prohlížení auditu.

## Vazby

- Zpět: celotýdenní signály (PAYG D2, DAG D3, backup drill D4, agent dashboard D5 `copilot-admin`) se potkávají v runbooku; eSignature audit (D3).
- Dopředu: runbook = sekce capstone blueprintu (D5); po tomto bloku **go/no-go na opt-orchestry**.
