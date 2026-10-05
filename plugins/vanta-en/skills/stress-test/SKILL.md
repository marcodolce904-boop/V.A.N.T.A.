---
name: stress-test
description: Pre-mortem of a plan, a thesis or a decision - assumes it has failed and reconstructs the causes, with early signals and countermeasures. Use it when the user writes STRESS TEST, asks for a pre-mortem, wants to know how a plan could fail or asks to find its weak spots.
argument-hint: "[plan, thesis or file] [independent]"
---

# Stress Test (pre-mortem)

Object to test: $ARGUMENTS

If the object is not clear from the arguments or the conversation, ask in one sentence which plan or thesis to test and stop.

## Modes

- **Standard (default).** Run the pre-mortem yourself, in this conversation. Low cost. Limitation: the critique comes from the same context that produced the plan, so it tends to miss the same blind spots.
- **Independent.** If the arguments contain `independent` (or the user asks for an external critic), delegate to the `nemesis` agent. Pass it only the text of the plan, the success criterion and the constraints stated by the user; do not pass it your reasoning or your opinions on the plan, or it loses its independence. Then report its critique and add, separately, your comment on what you agree with and what you don't. Higher cost: warn the user in one line.

## Procedure

1. **Restate** the plan in one sentence and the measurable success criterion. If there is no criterion, flag it: that is already a first risk.
2. **Assume failure.** "12 months (or the relevant horizon) have passed and the plan has failed." Generate causes in four categories: execution, market and adversaries, resources, wrong assumptions. Use the checklist in `${CLAUDE_PLUGIN_ROOT}/skills/stress-test/references/biases.md` to look for wrong assumptions.
3. **Rank** the causes by probability × impact and keep the top five.
4. For each, give the **early signal** (what you would see soon if it were happening) and the **countermeasure** (what to do now or when the signal appears).
5. **Close** with the change to the plan that most reduces overall risk and with the worst bearable case: if the plan fails, how much is lost and can it be recovered?

## Format

```markdown
**Plan:** …  ·  **Success criterion:** …

| # | Cause of failure | Prob. | Impact | Early signal | Countermeasure |
|---|---|---|---|---|---|

**Recommended change:** …
**Worst case:** …
**Confidence:** High/Medium/Low — what would change it.
```

Probability and impact are expressed as High/Medium/Low, not as invented percentages. If the plan is solid on a point, say so: a cause of failure made up to fill the table is an error.
