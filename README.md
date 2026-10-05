# V.A.N.T.A.

**Italiano** · [English](README.en.md)

Plugin per Claude Code e per l'app desktop di Claude che trasforma Claude in un consulente analitico per decisioni: controlla le premesse, cerca l'obiezione più forte, dichiara la confidenza, mette sotto stress i piani e tiene traccia di ciò che hai deciso per confrontarlo, più avanti, con ciò che è successo davvero.

Il repository contiene due versioni dello stesso plugin, con contenuti equivalenti:

| Versione | Cartella | Nome del plugin | Comandi |
|---|---|---|---|
| Italiano | [`plugins/vanta`](plugins/vanta) | `vanta` | `/vanta:metodo`, `/vanta:punto-nave`, … |
| English | [`plugins/vanta-en`](plugins/vanta-en) | `vanta-en` | `/vanta-en:method`, `/vanta-en:position-fix`, … |

Installane **una sola**: entrambe hanno un hook di avvio e usano la stessa cartella `.vanta/`, quindi installate insieme farebbero il lavoro due volte.

> Stato: versione 0.1.0, sperimentale. Il metodo segue le raccomandazioni attuali di Anthropic sul prompting e la letteratura su persona, brevità e autocorrezione, ma non è ancora stato misurato sul campo. La sezione [Verificare che funzioni](#verificare-che-funzioni) spiega come farlo.

## Cosa contiene

| Componente | Comando | A cosa serve |
|---|---|---|
| Skill `metodo` | `/vanta:metodo` | Analisi critica con priorità esplicite (accuratezza > utilità > forma), checklist di ragionamento, confidenza Alta/Media/Bassa |
| Skill `punto-nave` | `/vanta:punto-nave` | Fotografia dello stato del lavoro, salvata in `.vanta/punto-nave.md` |
| Skill `stress-test` | `/vanta:stress-test [piano] [indipendente]` | Pre-mortem: cinque cause di fallimento con segnali precoci e contromisure |
| Skill `wargame` | `/vanta:wargame [scenario] [rapido]` | Simulazione Rosso contro Blu con agenti separati e sintesi finale |
| Skill `decisione` | `/vanta:decisione [scelta]` | Registro decisioni con previsione verificabile e data di revisione |
| Skill `revisione` | `/vanta:revisione [ID \| tutte]` | Confronto tra previsioni ed esiti, con calibrazione per livello di confidenza |
| Agente `nemesi` (Opus) | — | Critico indipendente a contesto pulito |
| Agenti `rosso` e `blu` (Sonnet) | — | Avversario e difensore nel wargame |
| Stile di output `V.A.N.T.A.` | `/config` → Output style | Il tono asciutto e le priorità del metodo in ogni risposta, attivabile a scelta |
| Hook di avvio | automatico | Ricarica l'ultimo Punto Nave e ricorda le decisioni da rivedere |

Nella chat puoi anche attivare le skill scrivendo la parola chiave all'inizio del messaggio: `V.A.N.T.A.`, `PUNTO NAVE` (o `STOP`), `STRESS TEST`, `WARGAME`, `DECISIONE`, `REVISIONE`.

## Vantaggi rispetto a un prompt incollato

- **Memoria reale.** Punto Nave e registro decisioni sono file nella cartella del progetto. All'avvio di ogni sessione il plugin li ricarica da solo: niente da ricopiare, niente che si perde chiudendo la chat.
- **Critica davvero indipendente.** L'autocritica nella stessa conversazione è debole, perché il modello rilegge il proprio ragionamento con gli stessi punti ciechi. `nemesi` lavora in un contesto separato e vede solo il piano, non come ci sei arrivato.
- **Avversario vero nel wargame.** Rosso e Blu sono agenti distinti, con istruzioni e obiettivi opposti. Le due parti non condividono il punto di vista, come invece succede quando un solo modello le interpreta entrambe.
- **Calibrazione misurabile.** Il registro decisioni confronta ciò che prevedevi con ciò che è successo e calcola quanto spesso hai ragione a ciascun livello di confidenza. È l'unico modo di sapere se la tua sicurezza è affidabile, e nessun prompt da solo può farlo.
- **Costi sotto controllo.** Le skill entrano nel contesto solo quando servono (prima viene caricata solo la descrizione). Il wargame parte solo su richiesta esplicita, e stress test e wargame hanno una modalità economica. L'hook non stampa nulla nelle cartelle senza `.vanta/`.
- **Modelli giusti per ruolo.** Opus dove la qualità del ragionamento pesa di più (la critica), Sonnet per le simulazioni.
- **Metodo basato su evidenze.** Niente persona decorative, divieti assoluti o percentuali di confidenza inventate: la sezione [Scelte di progetto](#scelte-di-progetto) spiega cosa è stato tenuto e cosa no.
- **Versionabile e condivisibile.** Si installa con due comandi, si aggiorna da GitHub e il registro decisioni può stare sotto controllo di versione insieme al progetto.

## Installazione

### Da GitHub

In Claude Code:

```
/plugin marketplace add marcodolce904-boop/V.A.N.T.A.
/plugin install vanta@vanta
```

Per la versione inglese, al secondo comando usa `/plugin install vanta-en@vanta`.

### In locale, per provarlo

```bash
claude --plugin-dir ./plugins/vanta
```

Per verificare la struttura prima di pubblicare:

```bash
claude plugin validate ./plugins/vanta
claude plugin details ./plugins/vanta
```

### App desktop

Il plugin non contiene eseguibili in `bin/`, quindi è compatibile con l'installazione nell'app desktop. Le skill funzionano ovunque il plugin sia installato; agenti, hook e stile di output dipendono dal supporto dell'ambiente.

## Uso

1. **Attiva lo stile (facoltativo).** `/config` → Output style → `V.A.N.T.A.`, oppure in `settings.json` `"outputStyle": "vanta:V.A.N.T.A."`. Da quel momento ogni risposta segue le priorità del metodo. Se preferisci attivarlo solo quando serve, usa `/vanta:metodo`.
2. **Lavora normalmente.** Quando una conversazione si allunga o cambia direzione, scrivi `/vanta:punto-nave`.
3. **Prima di una scelta importante**, `/vanta:stress-test` (pre-mortem) e, se la posta è alta, `/vanta:wargame`.
4. **Quando decidi**, `/vanta:decisione`, con una previsione misurabile e una data.
5. **Alla scadenza** il plugin te lo ricorda all'avvio: `/vanta:revisione`.

Non serve usare tutto ogni volta: per una scelta piccola bastano metodo e decisione. Stress test e wargame hanno senso per le scelte difficili da disfare.

### File creati nel progetto

```
.vanta/
├── punto-nave.md          stato corrente
├── punto-nave-storico.md  versioni precedenti
└── decisioni.md           registro decisioni
```

Nella versione inglese i file si chiamano `position-fix.md`, `position-fix-history.md` e `decisions.md`. Se il registro contiene informazioni personali o riservate, aggiungi `.vanta/` al `.gitignore` del progetto.

## Costi indicativi

| Azione | Costo rispetto a una risposta normale |
|---|---|
| Metodo, Punto Nave, decisione, revisione | circa 1x |
| Stress test standard | circa 1x |
| Stress test indipendente | circa 2-3x (una chiamata Opus in più) |
| Wargame rapido | circa 1-2x |
| Wargame con agenti | circa 3-6x |

Sono stime da verificare con l'uso: `/cost` in Claude Code mostra il consumo reale della sessione.

## Scelte di progetto

Il plugin nasce dalla revisione di un prompt di sistema più lungo (V.A.N.T.A. v3.0). Cosa è cambiato e perché:

- **Niente identità decorativa.** Le persona nel prompt non migliorano l'accuratezza dei modelli (Zheng et al., 2024; Wharton Generative AI Labs, 2025). Restano le regole operative.
- **Moduli trasformati in checklist.** Nomi come Sophia, Nemesi e Kairos sono diventati domande di controllo concrete.
- **Brevità subordinata all'accuratezza.** Le istruzioni di concisione aumentano le risposte errate quando la domanda contiene una premessa falsa (Giskard, benchmark Phare, 2025).
- **Confidenza a livelli, non in percentuale.** Le percentuali verbalizzate dai modelli sono sistematicamente sovrastimate (Xiong et al., ICLR 2024).
- **Critica separata dall'autore.** Senza un segnale esterno l'autocorrezione è poco affidabile (Huang et al., ICLR 2024): da qui l'agente `nemesi` a contesto pulito.
- **Multi-agente solo su richiesta.** I sistemi multi-agente consumano molti più token di una chat (Anthropic, *How we built our multi-agent research system*, 2025) e il dibattito tra agenti non batte in modo affidabile metodi più semplici: per questo è riservato al wargame, dove serve un vero punto di vista avversario.
- **Pre-mortem.** La tecnica di Gary Klein si basa sulla ricerca sulla "prospective hindsight" (Mitchell, Russo e Pennington, 1989). L'evidenza riguarda il numero di cause individuate più che la loro qualità.

## Verificare che funzioni

Ogni versione contiene sei casi di prova in `evals/` (premessa falsa, obiezione forzata, utente sotto pressione, dati sconosciuti, insistenza senza argomenti, Punto Nave). Si eseguono con:

```bash
claude plugin eval ./plugins/vanta
```

Il comando confronta le risposte con e senza il plugin e assegna un punteggio con un modello giudice. Ogni caso viene eseguito più volte, quindi consuma crediti: per un primo giro usa `--runs 1`, oppure scegli un solo caso con `--case premessa-falsa`.

## Struttura del repository

```
.claude-plugin/marketplace.json   elenca le due versioni
plugins/
├── vanta/      versione italiana
└── vanta-en/   versione inglese
```

## Nome

"Vanta" è anche il nome di un'azienda software nota. Per uso personale non è un problema; per una diffusione ampia valuta di rinominare il plugin (campo `name` in `plugin.json` e `marketplace.json`).

## Licenza

MIT. Vedi [LICENSE](LICENSE).
