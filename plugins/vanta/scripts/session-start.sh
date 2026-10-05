#!/bin/sh
# V.A.N.T.A. - SessionStart hook.
# Se la cartella di lavoro contiene uno stato V.A.N.T.A. (.vanta/), lo porta nel
# contesto della sessione: l'ultimo Punto Nave e le decisioni da rivedere.
# Se .vanta/ non esiste non stampa nulla, quindi non consuma token.

dir="${CLAUDE_PROJECT_DIR:-$PWD}/.vanta"
[ -d "$dir" ] || exit 0

pn="$dir/punto-nave.md"
reg="$dir/decisioni.md"

if [ -f "$pn" ]; then
  echo "[V.A.N.T.A.] Ultimo Punto Nave salvato in questa cartella (.vanta/punto-nave.md). Usalo come contesto se l'utente riprende questo lavoro, verificando con lui che sia ancora valido:"
  echo
  head -c 4000 "$pn"
  echo
fi

if [ -f "$reg" ]; then
  today=$(date +%Y-%m-%d)
  due=$(awk -v today="$today" '
    function flush() {
      if (id != "" && stato == "aperta" && rev != "" && rev <= today) {
        n++; ids = ids (ids == "" ? "" : ", ") id
      }
      id = ""; stato = ""; rev = ""
    }
    /^## / { flush(); id = $2; next }
    /^- Revisione:/ { rev = $3; next }
    /^- Stato:/ { stato = $3; next }
    END { flush(); if (n > 0) print n " (" ids ")" }
  ' "$reg")
  if [ -n "$due" ]; then
    echo "[V.A.N.T.A.] Decisioni con revisione scaduta: $due. Ricordalo all'utente una sola volta, all'inizio, proponendo /vanta:revisione."
  fi
fi

exit 0
