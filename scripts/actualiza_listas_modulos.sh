#!/usr/bin/env bash
set -euo pipefail

for mod in 0*-*/ ; do
  [ -d "$mod" ] || continue
  f="$mod/README.md"
  [ -f "$f" ] || continue

  START="<!-- LISTA_PRACTICAS_MODULO_INICIO -->"
  END="<!-- LISTA_PRACTICAS_MODULO_FIN -->"

  tmp="$(mktemp)"
  {
    echo "$START"
    echo
    if [ -d "$mod/practicas" ] && find "$mod/practicas" -mindepth 1 -maxdepth 1 -type d | grep -q .; then
      # Enlaces RELATIVOS al README del MÓDULO
      find "$mod/practicas" -mindepth 1 -maxdepth 1 -type d | sort | while read -r p; do
        name="$(basename "$p")"
        if [ -f "$p/README.md" ]; then
          # ./practicas/<name>/README.md
          echo "- [$name](./practicas/$name/README.md)"
        else
          echo "- [$name](./practicas/$name/)"
        fi
      done
    else
      echo "_(sin prácticas todavía)_"
    fi
    echo
    echo "$END"
  } > "$tmp"

  if grep -q "$START" "$f" 2>/dev/null; then
    awk -v start="$START" -v end="$END" -v TMPF="$tmp" '
      BEGIN{inside=0}
      {
        if($0 ~ start){inside=1; system("cat " TMPF); next}
        if($0 ~ end){inside=0; next}
        if(!inside) print
      }
    ' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
  else
    # Inserta justo tras "## Prácticas" o al final si no existe
    if grep -n '^## Prácticas' "$f" >/dev/null; then
      awk -v TMPF="$tmp" '
        BEGIN{done=0}
        {print}
        /^## Prácticas$/ && !done {print ""; system("cat " TMPF); print ""; done=1}
      ' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
    else
      {
        echo
        echo "## Prácticas"
        echo
        cat "$tmp"
        echo
      } >> "$f"
    fi
  fi
  rm -f "$tmp"
done

echo "Listas de prácticas actualizadas en cada módulo."

