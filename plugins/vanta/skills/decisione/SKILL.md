---
name: decisione
description: Registra una decisione nel registro decisioni (.vanta/decisioni.md) con alternative scartate, motivazione, previsione verificabile, confidenza e data di revisione. Usala quando l'utente scrive DECISIONE, chiede di registrare o annotare una scelta, oppure ha appena preso una decisione importante e accetta di registrarla.
argument-hint: "[decisione]"
---

# Registra una decisione

Decisione: $ARGUMENTS

Il registro serve a confrontare in seguito ciò che l'utente si aspettava con ciò che è successo. Funziona solo se la previsione è verificabile, quindi la qualità della voce "Previsione" è il punto più importante.

## Procedura

1. Ricava i campi dalla conversazione. Per quelli mancanti fai una sola domanda che li raccolga tutti; non inventare motivazioni o alternative che l'utente non ha espresso.
2. Rendi la previsione **verificabile**: cosa deve essere vero, misurabile, entro quale data. "Andrà bene" non è una previsione; "Entro il 30 novembre almeno 3 clienti su 10 contattati accettano il preventivo" lo è. Se la previsione dell'utente è vaga, proponi una versione misurabile e chiedi conferma.
3. La **confidenza** è dell'utente (Alta, Media o Bassa), non tua. Se vuoi, dai la tua stima separatamente, nel testo della risposta.
4. La **data di revisione** predefinita è a 30 giorni da oggi; usa quella indicata dall'utente o quella in cui l'esito sarà osservabile.
5. Assegna un identificativo `D-AAAAMMGG-NN`, dove NN è il progressivo del giorno.

## Salvataggio

Aggiungi la voce in fondo a `.vanta/decisioni.md` nella cartella di lavoro corrente (crea il file e la cartella se mancano, con il titolo `# Registro decisioni`). Mantieni esattamente questo formato, perché il plugin lo legge per ricordare le revisioni scadute:

```markdown
## D-20261004-01 · Titolo breve
- Data: 2026-10-04
- Decisione: …
- Alternative scartate: …
- Motivazione: …
- Previsione: …
- Confidenza: Media
- Revisione: 2026-11-03
- Stato: aperta
- Esito:
- Previsione corretta:
- Lezione:
```

Senza accesso al file system, mostra la voce in chat e suggerisci dove conservarla.

Chiudi con una riga di conferma che indica l'identificativo e la data di revisione.
