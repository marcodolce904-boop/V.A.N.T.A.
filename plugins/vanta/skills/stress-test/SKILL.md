---
name: stress-test
description: Pre-mortem di un piano, una tesi o una decisione - assume che sia fallito e ne ricostruisce le cause, con segnali precoci e contromisure. Usala quando l'utente scrive STRESS TEST, chiede un pre-mortem, vuole sapere come potrebbe fallire un piano o chiede di trovarne i punti deboli.
argument-hint: "[piano, tesi o file] [indipendente]"
---

# Stress Test (pre-mortem)

Oggetto da testare: $ARGUMENTS

Se l'oggetto non è chiaro dagli argomenti né dalla conversazione, chiedi in una frase quale piano o tesi testare e fermati.

## Modalità

- **Standard (predefinita).** Esegui il pre-mortem tu, in questa conversazione. Costo basso. Limite: la critica nasce dallo stesso contesto che ha prodotto il piano, quindi tende a non vedere gli stessi punti ciechi.
- **Indipendente.** Se gli argomenti contengono `indipendente` (o l'utente chiede un critico esterno), delega all'agente `nemesi`. Passagli soltanto il testo del piano, il criterio di successo e i vincoli dichiarati dall'utente; non passargli il tuo ragionamento né le tue opinioni sul piano, altrimenti perde l'indipendenza. Poi riporta la sua critica e aggiungi, separato, il tuo commento su cosa condividi e cosa no. Costo più alto: avvisa l'utente in una riga.

## Procedura

1. **Riformula** il piano in una frase e il criterio di successo misurabile. Se il criterio non esiste, segnalalo: è già un primo rischio.
2. **Assumi il fallimento.** "Sono passati 12 mesi (o l'orizzonte pertinente) e il piano è fallito." Genera le cause in quattro categorie: esecuzione, mercato e avversari, risorse, assunzioni errate. Usa la checklist in `${CLAUDE_PLUGIN_ROOT}/skills/stress-test/references/bias.md` per cercare le assunzioni errate.
3. **Ordina** le cause per probabilità × impatto e tieni le prime cinque.
4. Per ciascuna indica il **segnale precoce** (cosa vedresti presto se stesse succedendo) e la **contromisura** (cosa fare adesso o quando compare il segnale).
5. **Chiudi** con la modifica al piano che riduce di più il rischio complessivo e con il caso peggiore sopportabile: se il piano fallisce, quanto si perde e si può recuperare?

## Formato

```markdown
**Piano:** …  ·  **Criterio di successo:** …

| # | Causa del fallimento | Prob. | Impatto | Segnale precoce | Contromisura |
|---|---|---|---|---|---|

**Modifica consigliata:** …
**Caso peggiore:** …
**Confidenza:** Alta/Media/Bassa — cosa la cambierebbe.
```

Probabilità e impatto si esprimono come Alta/Media/Bassa, non come percentuali inventate. Se il piano è solido su un punto, dillo: una causa di fallimento fabbricata per riempire la tabella è un errore.
