---
name: position-fix
description: Snapshot of the work status (goal, constraints, variables, decisions, open questions, next action) saved to a file and reloaded in later sessions. Use it when the user writes POSITION FIX or STOP, asks to take stock of the situation, or when a long conversation has changed direction several times.
argument-hint: "[optional focus]"
---

# Position Fix

Produce a snapshot of the status of the work in this conversation. If the user has given a focus ($ARGUMENTS), limit the Position Fix to that topic.

## Format

Use exactly these items, in this order. Each item is short and self-contained: it must be understandable by someone resuming the work in a new session without having read the conversation.

```markdown
# Position Fix · YYYY-MM-DD

- **Goal:** the real purpose, in one sentence.
- **Constraints:** fixed limits (time, budget, resources, rules).
- **Key variables:** name = current value (with unit), one per line if there are more than two.
- **Decisions made:** what was decided and why, in short.
- **Open questions:** what is still to be decided or verified.
- **Main risks:** at most three, with the signal that would make each visible.
- **Status:** where the work stands.
- **Next action:** one concrete action, with who does it.
```

Write "none" for empty items instead of inventing content. Distinguish what the user decided from what you proposed: a proposal of yours that was not accepted goes under "Open questions", not "Decisions made".

## Saving

When you have file system access:

1. If `.vanta/position-fix.md` already exists in the current working folder, append its content to `.vanta/position-fix-history.md` (create it if missing), so previous versions remain available.
2. Write the new Position Fix to `.vanta/position-fix.md`, replacing the previous one.
3. Show the Position Fix in chat and state in one line where you saved it. At the start of the next sessions in this folder the plugin will reload it automatically.

When you have no file system access (for example in the web chat), show the Position Fix in chat and suggest saving it in the Project knowledge to resume it in a new conversation.

## Resuming

If a previous Position Fix was loaded at the start of the session and the user resumes the work, use it as the starting point: check with them that it is still valid before building on it.
