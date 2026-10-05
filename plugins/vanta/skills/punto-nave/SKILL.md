---
name: punto-nave
description: Fotografia dello stato del lavoro (obiettivo, vincoli, variabili, decisioni, questioni aperte, prossima azione) salvata su file e ricaricata nelle sessioni successive. Usala quando l'utente scrive PUNTO NAVE o STOP, chiede di fare il punto della situazione, oppure quando una conversazione lunga ha cambiato direzione più volte.
argument-hint: "[focus opzionale]"
---

# Punto Nave

Produci una fotografia dello stato del lavoro in questa conversazione. Se l'utente ha indicato un focus ($ARGUMENTS), limita il Punto Nave a quel tema.

## Formato

Usa esattamente queste voci, in quest'ordine. Ogni voce è breve e autosufficiente: deve essere comprensibile a chi riprende il lavoro in una nuova sessione senza aver letto la conversazione.

```markdown
# Punto Nave · AAAA-MM-GG

- **Obiettivo:** lo scopo reale, in una frase.
- **Vincoli:** limiti fissi (tempo, budget, risorse, regole).
- **Variabili chiave:** nome = valore corrente (con l'unità), una per riga se sono più di due.
- **Decisioni prese:** cosa è stato deciso e perché, in sintesi.
- **Questioni aperte:** cosa resta da decidere o verificare.
- **Rischi principali:** al massimo tre, con il segnale che li renderebbe evidenti.
- **Stato:** a che punto è il lavoro.
- **Prossima azione:** una sola azione concreta, con chi la fa.
```

Scrivi "nessuna" per le voci vuote invece di inventare contenuto. Distingui ciò che l'utente ha deciso da ciò che hai proposto tu: una tua proposta non accettata va in "Questioni aperte", non in "Decisioni prese".

## Salvataggio

Quando hai accesso al file system:

1. Se esiste già `.vanta/punto-nave.md` nella cartella di lavoro corrente, aggiungi il suo contenuto in fondo a `.vanta/punto-nave-storico.md` (crealo se manca), così le versioni precedenti restano consultabili.
2. Scrivi il nuovo Punto Nave in `.vanta/punto-nave.md`, sostituendo il precedente.
3. Mostra il Punto Nave in chat e indica in una riga dove l'hai salvato. All'avvio delle prossime sessioni in questa cartella il plugin lo ricaricherà automaticamente.

Quando non hai accesso al file system (per esempio nella chat web), mostra il Punto Nave in chat e suggerisci di salvarlo nella conoscenza del Project per riprenderlo in una nuova conversazione.

## Ripresa

Se all'inizio della sessione è stato caricato un Punto Nave precedente e l'utente riprende il lavoro, usalo come punto di partenza: verifica con lui che sia ancora valido prima di costruirci sopra.
