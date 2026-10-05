---
name: wargame
description: Simulazione Rosso contro Blu su un piano o una decisione - un agente avversario attacca il piano, un agente difensore lo adatta, poi una sintesi indica conseguenze di secondo ordine e punto di rottura. Usala solo quando l'utente scrive WARGAME o chiede esplicitamente una simulazione avversaria.
argument-hint: "[scenario] [rapido]"
disable-model-invocation: true
---

# Wargame Rosso / Blu

Scenario: $ARGUMENTS

## Preparazione

Prima di lanciare gli agenti, fissa in poche righe:

- **Piano BLU:** cosa vuole fare l'utente e con quale obiettivo misurabile.
- **ROSSO:** chi o cosa reagisce (concorrente, cliente, mercato, ente, la realtà fisica) e quali sono i suoi incentivi.
- **Orizzonte:** il periodo simulato.

Se uno di questi elementi manca e cambierebbe il risultato, fai una sola domanda e fermati. Altrimenti esplicita le assunzioni e procedi.

## Modalità

- **Con agenti (predefinita).** ROSSO e BLU sono agenti separati, ciascuno con il proprio contesto. Costa diverse volte una risposta normale: avvisa l'utente in una riga prima di partire.
- **Rapida.** Se gli argomenti contengono `rapido`, simula entrambe le parti tu, in questa conversazione, con lo stesso formato. Costo basso, ma le due parti condividono lo stesso punto di vista.

## Procedura con agenti

1. **Turno ROSSO.** Delega all'agente `rosso`. Passagli il piano BLU, l'identità e gli incentivi di ROSSO, l'orizzonte. Chiedi tre mosse.
2. **Turno BLU.** Delega all'agente `blu`. Passagli il piano BLU e le tre mosse di ROSSO, senza il tuo commento. Chiedi una risposta per ogni mossa.
3. **Arbitraggio.** Fai tu la sintesi finale, con il formato sotto. Valuti le mosse, non le parti: se una mossa di ROSSO è poco plausibile o una risposta di BLU è troppo ottimista, dillo.

## Formato della sintesi

```markdown
**BLU:** … · **ROSSO:** … · **Orizzonte:** …

| Mossa ROSSO | Prob. | Danno per BLU | Risposta BLU | Costo | Rischio residuo |
|---|---|---|---|---|---|

**Conseguenze di secondo ordine:** cosa succede dopo le prime reazioni.
**Punto di rottura:** la condizione in cui il piano non regge più.
**Modifica che rende BLU più robusto:** …
**Ipotesi:** elenco di ciò che è speculativo.
**Confidenza:** Alta/Media/Bassa — cosa la cambierebbe.
```

Il wargame produce scenari plausibili, non previsioni: etichetta come ipotesi tutto ciò che non poggia su dati. Chiudi proponendo `/vanta:decisione` se dalla simulazione esce una scelta da registrare.
