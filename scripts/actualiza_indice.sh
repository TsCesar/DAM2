#!/usr/bin/env bash
set -e

OUT="<!-- Archivo generado automáticamente. Edita las prácticas en sus carpetas. -->\n"
OUT+="# Índice de prácticas\n\n"
OUT+="_Actualizado: $(date +"%Y-%m-%d %H:%M:%S")_\n\n"

for mod in 0*-*/ ; do
  [ -d "$mod/practicas" ] || continue
  title="$(sed -n '1s/^# //p;1q' "$mod/README.md" 2>/dev/null)"
  [ -z "$title" ] && title="${mod%/}"
  OUT+="## ${title}\n\n"
  empty=1
  for p in "$mod"/practicas/* ; do
    [ -d "$p" ] || continue
    empty=0
    pname="$(basename "$p")"
    if [ -f "$p/README.md" ]; then
      OUT+="- [$pname]($p/README.md)\n"
    else
      OUT+="- [$pname]($p)\n"
    fi
  done
  [ "$empty" -eq 1 ] && OUT+="*(sin prácticas todavía)*\n"
  OUT+="\n"
done

printf "%b" "$OUT" > docs/INDICE.md
