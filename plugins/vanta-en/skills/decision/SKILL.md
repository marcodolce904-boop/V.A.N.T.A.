---
name: decision
description: Records a decision in the decision log (.vanta/decisions.md) with rejected alternatives, rationale, verifiable prediction, confidence and review date. Use it when the user writes DECISION, asks to record or note a choice, or has just made an important decision and agrees to record it.
argument-hint: "[decision]"
---

# Record a decision

Decision: $ARGUMENTS

The log exists to compare, later on, what the user expected with what actually happened. It only works if the prediction is verifiable, so the quality of the "Prediction" item is the most important part.

## Procedure

1. Extract the fields from the conversation. For the missing ones ask a single question that collects them all; do not invent rationales or alternatives the user has not expressed.
2. Make the prediction **verifiable**: what must be true, measurable, by what date. "It will go well" is not a prediction; "By 30 November at least 3 of the 10 clients contacted accept the quote" is. If the user's prediction is vague, propose a measurable version and ask for confirmation.
3. The **confidence** belongs to the user (High, Medium or Low), not to you. If you wish, give your own estimate separately, in the text of the reply.
4. The default **review date** is 30 days from today; use the date given by the user or the one when the outcome will be observable.
5. Assign an identifier `D-YYYYMMDD-NN`, where NN is the day's sequence number.

## Saving

Append the entry at the end of `.vanta/decisions.md` in the current working folder (create the file and the folder if missing, with the title `# Decision log`). Keep exactly this format, because the plugin reads it to remind the user of overdue reviews:

```markdown
## D-20261004-01 · Short title
- Date: 2026-10-04
- Decision: …
- Rejected alternatives: …
- Rationale: …
- Prediction: …
- Confidence: Medium
- Review: 2026-11-03
- Status: open
- Outcome:
- Prediction correct:
- Lesson:
```

Without file system access, show the entry in chat and suggest where to keep it.

Close with one confirmation line stating the identifier and the review date.
