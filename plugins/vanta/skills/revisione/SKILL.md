---
name: revisione
description: Rivede le decisioni registrate in .vanta/decisioni.md la cui data di revisione è passata, raccoglie gli esiti, confronta previsioni e realtà e misura la calibrazione per livello di confidenza. Usala quando l'utente scrive REVISIONE, chiede di rivedere le decisioni passate o di sapere quanto sono state accurate le sue previsioni.
argument-hint: "[ID decisione | tutte]"
---

# Revisione delle decisioni

Argomenti: $ARGUMENTS

## Procedura

1. Leggi `.vanta/decisioni.md` nella cartella di lavoro corrente. Se non esiste, dillo e proponi `/vanta:decisione`.
2. Seleziona le decisioni da rivedere:
   - con un ID negli argomenti, solo quella;
   - con `tutte`, tutte quelle con `Stato: aperta`;
   - senza argomenti, quelle con `Stato: aperta` e data di revisione uguale o precedente a oggi.
3. Per ciascuna mostra decisione, previsione e confidenza, poi chiedi all'utente l'esito. Raggruppa le domande in un unico messaggio quando le decisioni sono più di una. Non dedurre l'esito al posto suo.
4. Con le risposte aggiorna ogni voce, modificando solo questi campi:
   - `Esito:` cosa è successo, in una frase;
   - `Previsione corretta:` sì, no oppure parziale, confrontando la previsione scritta con l'esito, non con le intenzioni;
   - `Lezione:` cosa cambierebbe nella prossima decisione simile, solo se l'utente la condivide o se emerge con chiarezza;
   - `Stato:` chiusa. Se l'esito non è ancora osservabile, lascia `aperta` e sposta `Revisione:` alla nuova data concordata.

## Calibrazione

Dopo l'aggiornamento, calcola su tutte le decisioni chiuse del registro la quota di previsioni corrette per ciascun livello di confidenza (conta "parziale" come mezzo punto). Esegui il conteggio leggendo il file, non a memoria.

```markdown
| Confidenza | Decisioni chiuse | Previsioni corrette | Quota |
|---|---|---|---|
| Alta | | | |
| Media | | | |
| Bassa | | | |
```

Commenta solo ciò che i numeri permettono di dire. Con meno di cinque decisioni per livello, scrivi che il campione è troppo piccolo per conclusioni. Il segnale utile è l'ordine: le decisioni ad alta confidenza dovrebbero risultare corrette più spesso di quelle a bassa confidenza; se non succede, la fiducia dell'utente non sta discriminando, ed è la lezione più importante del registro.
