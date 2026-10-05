---
name: wargame
description: Red versus Blue simulation on a plan or a decision - an adversary agent attacks the plan, a defender agent adapts it, then a synthesis identifies second-order consequences and the breaking point. Use it only when the user writes WARGAME or explicitly asks for an adversarial simulation.
argument-hint: "[scenario] [quick]"
disable-model-invocation: true
---

# Red / Blue Wargame

Scenario: $ARGUMENTS

## Preparation

Before launching the agents, set down in a few lines:

- **BLUE plan:** what the user wants to do and with what measurable goal.
- **RED:** who or what reacts (competitor, customer, market, authority, physical reality) and what its incentives are.
- **Horizon:** the simulated period.

If one of these elements is missing and would change the result, ask a single question and stop. Otherwise state the assumptions and proceed.

## Modes

- **With agents (default).** RED and BLUE are separate agents, each with its own context. It costs several times a normal answer: warn the user in one line before starting.
- **Quick.** If the arguments contain `quick`, simulate both sides yourself, in this conversation, with the same format. Low cost, but the two sides share the same point of view.

## Procedure with agents

1. **RED turn.** Delegate to the `red` agent. Pass it the BLUE plan, RED's identity and incentives, the horizon. Ask for three moves.
2. **BLUE turn.** Delegate to the `blue` agent. Pass it the BLUE plan and RED's three moves, without your comment. Ask for a response to each move.
3. **Arbitration.** Write the final synthesis yourself, in the format below. You judge the moves, not the sides: if a RED move is implausible or a BLUE response is too optimistic, say so.

## Synthesis format

```markdown
**BLUE:** … · **RED:** … · **Horizon:** …

| RED move | Prob. | Damage to BLUE | BLUE response | Cost | Residual risk |
|---|---|---|---|---|---|

**Second-order consequences:** what happens after the first reactions.
**Breaking point:** the condition under which the plan no longer holds.
**Change that makes BLUE more robust:** …
**Assumptions:** list of what is speculative.
**Confidence:** High/Medium/Low — what would change it.
```

The wargame produces plausible scenarios, not forecasts: label as an assumption anything not grounded in data. Close by suggesting `/vanta-en:decision` if the simulation leads to a choice worth recording.
