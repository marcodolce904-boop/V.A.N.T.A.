# V.A.N.T.A.

[Italiano](README.md) · **English**

A plugin for Claude Code and the Claude desktop app that turns Claude into an analytical decision advisor: it checks premises, looks for the strongest objection, states its confidence, stress-tests plans and keeps track of what you decided so you can later compare it with what actually happened.

This repository contains two versions of the same plugin, with equivalent content:

| Version | Folder | Plugin name | Commands |
|---|---|---|---|
| English | [`plugins/vanta-en`](plugins/vanta-en) | `vanta-en` | `/vanta-en:method`, `/vanta-en:position-fix`, … |
| Italiano | [`plugins/vanta`](plugins/vanta) | `vanta` | `/vanta:metodo`, `/vanta:punto-nave`, … |

Install **only one**: both have a startup hook and use the same `.vanta/` folder, so installed together they would do the work twice.

> Status: version 0.1.0, experimental. The method follows Anthropic's current prompting recommendations and the research on personas, brevity and self-correction, but it has not yet been measured in the field. The [Checking that it works](#checking-that-it-works) section explains how to do that.

## What it contains

| Component | Command | Purpose |
|---|---|---|
| `method` skill | `/vanta-en:method` | Critical analysis with explicit priorities (accuracy > usefulness > form), reasoning checklist, High/Medium/Low confidence |
| `position-fix` skill | `/vanta-en:position-fix` | Snapshot of the work status, saved to `.vanta/position-fix.md` |
| `stress-test` skill | `/vanta-en:stress-test [plan] [independent]` | Pre-mortem: five causes of failure with early signals and countermeasures |
| `wargame` skill | `/vanta-en:wargame [scenario] [quick]` | Red versus Blue simulation with separate agents and a final synthesis |
| `decision` skill | `/vanta-en:decision [choice]` | Decision log with a verifiable prediction and a review date |
| `review` skill | `/vanta-en:review [ID \| all]` | Compares predictions with outcomes, with calibration by confidence level |
| `nemesis` agent (Opus) | — | Independent critic with a clean context |
| `red` and `blue` agents (Sonnet) | — | Adversary and defender in the wargame |
| `V.A.N.T.A.` output style | `/config` → Output style | The method's dry tone and priorities in every answer, opt-in |
| Startup hook | automatic | Reloads the latest Position Fix and reminds you of decisions due for review |

In chat you can also trigger the skills by starting your message with a keyword: `V.A.N.T.A.`, `POSITION FIX` (or `STOP`), `STRESS TEST`, `WARGAME`, `DECISION`, `REVIEW`.

## Why a plugin instead of a pasted prompt

- **Real memory.** The Position Fix and the decision log are files in the project folder. At the start of every session the plugin reloads them by itself: nothing to copy back in, nothing lost when you close the chat.
- **Truly independent critique.** Self-critique within the same conversation is weak, because the model rereads its own reasoning with the same blind spots. `nemesis` works in a separate context and sees only the plan, not how you got there.
- **A real adversary in the wargame.** Red and Blue are separate agents, with opposite instructions and goals. The two sides don't share a point of view, as they do when a single model plays both.
- **Measurable calibration.** The decision log compares what you predicted with what happened and computes how often you are right at each confidence level. It is the only way to know whether your confidence is reliable, and no prompt alone can do it.
- **Costs under control.** Skills enter the context only when needed (only their description is loaded up front). The wargame starts only on explicit request, and stress test and wargame have a cheap mode. The hook prints nothing in folders without `.vanta/`.
- **The right model for each role.** Opus where reasoning quality matters most (the critique), Sonnet for the simulations.
- **Evidence-based method.** No decorative personas, absolute bans or invented confidence percentages: the [Design choices](#design-choices) section explains what was kept and what wasn't.
- **Versionable and shareable.** It installs with two commands, updates from GitHub, and the decision log can live under version control alongside the project.

## Installation

### From GitHub

In Claude Code:

```
/plugin marketplace add marcodolce904-boop/V.A.N.T.A.
/plugin install vanta-en@vanta
```

For the Italian version, use `/plugin install vanta@vanta` as the second command.

### Locally, to try it out

```bash
claude --plugin-dir ./plugins/vanta-en
```

To check the structure before publishing:

```bash
claude plugin validate ./plugins/vanta-en
claude plugin details ./plugins/vanta-en
```

### Desktop app

The plugin contains no executables in `bin/`, so it can be installed in the desktop app. Skills work wherever the plugin is installed; agents, hooks and the output style depend on what the environment supports.

## Usage

1. **Turn on the style (optional).** `/config` → Output style → `V.A.N.T.A.`, or in `settings.json` `"outputStyle": "vanta-en:V.A.N.T.A."`. From then on every answer follows the method's priorities. If you'd rather use it only when needed, use `/vanta-en:method`.
2. **Work as usual.** When a conversation gets long or changes direction, type `/vanta-en:position-fix`.
3. **Before an important choice**, `/vanta-en:stress-test` (pre-mortem) and, if the stakes are high, `/vanta-en:wargame`.
4. **When you decide**, `/vanta-en:decision`, with a measurable prediction and a date.
5. **When it's due**, the plugin reminds you at startup: `/vanta-en:review`.

You don't need everything every time: for a small choice, method and decision are enough. Stress test and wargame make sense for choices that are hard to undo.

### Files created in the project

```
.vanta/
├── position-fix.md          current status
├── position-fix-history.md  previous versions
└── decisions.md             decision log
```

If the log contains personal or confidential information, add `.vanta/` to the project's `.gitignore`.

## Indicative costs

| Action | Cost compared with a normal answer |
|---|---|
| Method, Position Fix, decision, review | about 1x |
| Standard stress test | about 1x |
| Independent stress test | about 2-3x (one extra Opus call) |
| Quick wargame | about 1-2x |
| Wargame with agents | about 3-6x |

These are estimates to be checked in use: `/cost` in Claude Code shows the session's real usage.

## Design choices

The plugin comes from a revision of a longer system prompt (V.A.N.T.A. v3.0). What changed and why:

- **No decorative identity.** Personas in the prompt do not improve model accuracy (Zheng et al., 2024; Wharton Generative AI Labs, 2025). The operating rules remain.
- **Modules turned into checklists.** Names such as Sophia, Nemesis and Kairos became concrete check questions.
- **Brevity subordinate to accuracy.** Conciseness instructions increase wrong answers when the question contains a false premise (Giskard, Phare benchmark, 2025).
- **Confidence in levels, not percentages.** Percentages verbalised by models are systematically overconfident (Xiong et al., ICLR 2024).
- **Critique separate from the author.** Without an external signal, self-correction is unreliable (Huang et al., ICLR 2024): hence the clean-context `nemesis` agent.
- **Multi-agent only on request.** Multi-agent systems use far more tokens than a chat (Anthropic, *How we built our multi-agent research system*, 2025) and agent debate does not reliably beat simpler methods: so it is reserved for the wargame, where a genuine adversarial point of view is needed.
- **Pre-mortem.** Gary Klein's technique rests on research into "prospective hindsight" (Mitchell, Russo and Pennington, 1989). The evidence concerns the number of causes identified more than their quality.

## Checking that it works

Each version contains six test cases in `evals/` (false premise, forced objection, user under pressure, unknown data, insistence without arguments, Position Fix). Run them with:

```bash
claude plugin eval ./plugins/vanta-en
```

The command compares answers with and without the plugin and scores them with a judge model. Each case runs several times, so it uses credits: for a first pass use `--runs 1`, or pick a single case with `--case false-premise`.

## Repository layout

```
.claude-plugin/marketplace.json   lists both versions
plugins/
├── vanta/      Italian version
└── vanta-en/   English version
```

## Name

"Vanta" is also the name of a well-known software company. For personal use this is not a problem; for wide distribution consider renaming the plugin (`name` field in `plugin.json` and `marketplace.json`).

## License

MIT. See [LICENSE](LICENSE).
