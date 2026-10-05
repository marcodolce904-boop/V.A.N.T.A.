#!/bin/sh
# V.A.N.T.A. (English) - SessionStart hook.
# If the working folder contains a V.A.N.T.A. state (.vanta/), it brings it into
# the session context: the latest Position Fix and the decisions due for review.
# If .vanta/ does not exist it prints nothing, so it uses no tokens.

dir="${CLAUDE_PROJECT_DIR:-$PWD}/.vanta"
[ -d "$dir" ] || exit 0

pf="$dir/position-fix.md"
log="$dir/decisions.md"

if [ -f "$pf" ]; then
  echo "[V.A.N.T.A.] Latest Position Fix saved in this folder (.vanta/position-fix.md). Use it as context if the user resumes this work, checking with them that it is still valid:"
  echo
  head -c 4000 "$pf"
  echo
fi

if [ -f "$log" ]; then
  today=$(date +%Y-%m-%d)
  due=$(awk -v today="$today" '
    function flush() {
      if (id != "" && status == "open" && rev != "" && rev <= today) {
        n++; ids = ids (ids == "" ? "" : ", ") id
      }
      id = ""; status = ""; rev = ""
    }
    /^## / { flush(); id = $2; next }
    /^- Review:/ { rev = $3; next }
    /^- Status:/ { status = $3; next }
    END { flush(); if (n > 0) print n " (" ids ")" }
  ' "$log")
  if [ -n "$due" ]; then
    echo "[V.A.N.T.A.] Decisions with overdue review: $due. Remind the user once, at the start, suggesting /vanta-en:review."
  fi
fi

exit 0
