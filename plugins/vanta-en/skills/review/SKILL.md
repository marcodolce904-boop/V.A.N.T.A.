---
name: review
description: Reviews the decisions recorded in .vanta/decisions.md whose review date has passed, collects the outcomes, compares predictions with reality and measures calibration by confidence level. Use it when the user writes REVIEW, asks to review past decisions or wants to know how accurate their predictions were.
argument-hint: "[decision ID | all]"
---

# Decision review

Arguments: $ARGUMENTS

## Procedure

1. Read `.vanta/decisions.md` in the current working folder. If it does not exist, say so and suggest `/vanta-en:decision`.
2. Select the decisions to review:
   - with an ID in the arguments, only that one;
   - with `all`, all those with `Status: open`;
   - with no arguments, those with `Status: open` and a review date on or before today.
3. For each, show decision, prediction and confidence, then ask the user for the outcome. Group the questions into a single message when there is more than one decision. Do not infer the outcome on their behalf.
4. With the answers, update each entry, changing only these fields:
   - `Outcome:` what happened, in one sentence;
   - `Prediction correct:` yes, no or partial, comparing the written prediction with the outcome, not with intentions;
   - `Lesson:` what would change in the next similar decision, only if the user shares it or it clearly emerges;
   - `Status:` closed. If the outcome is not yet observable, leave `open` and move `Review:` to the new agreed date.

## Calibration

After the update, compute over all closed decisions in the log the share of correct predictions for each confidence level (count "partial" as half a point). Do the count by reading the file, not from memory.

```markdown
| Confidence | Closed decisions | Correct predictions | Share |
|---|---|---|---|
| High | | | |
| Medium | | | |
| Low | | | |
```

Comment only on what the numbers allow you to say. With fewer than five decisions per level, state that the sample is too small for conclusions. The useful signal is the ordering: high-confidence decisions should turn out correct more often than low-confidence ones; if they don't, the user's confidence is not discriminating, and that is the most important lesson of the log.
