#!/usr/bin/env bash
set -e

README="README.md"
START="<!-- TABLA_PRACTICAS_INICIO -->"
END="<!-- TABLA_PRACTICAS_FIN -->"

TABLE="<h3>� Prácticas por módulo (auto)</h3>
$START
<table>
  <thead>
    <tr>
      <th style=\"text-align:left;\">Módulo</th>
      <th style=\"text-align:center;\">N.º prácticas</th>
      <th style=\"text-align:left;\">Listado</th>
    </tr>
  </thead>
  <tbody>
"

for mod in 0*-*/ ; do
  [ -d "$mod" ] || continue
  base=\"${mod%/}\"

  TITLE=$(sed -n '1s/^# //p;1q' \"$base/README.md\" 2>/dev/null)
  [ -z \"$TITLE\" ] && TITLE=\"$base\"

  MODLINK=\"<a href=\\\"$base/README.md\\\" target=\\\"_blank\\\" rel=\\\"noopener noreferrer\\\">$TITLE</a>\"

  LISTA=\"\"
  COUNT=0
  if [ -d \"$base/practicas\" ]; then
    while IFS= read -r -d '' p; do
      COUNT=$((COUNT+1))
      NAME=\"$(basename \"$p\")\"
      if [ -f \"$p/README.md\" ]; then
        LISTA+=\"- <a href=\\\"$p/README.md\\\" target=\\\"_blank\\\" rel=\\\"noopener noreferrer\\\">$NAME</a><br/>\"
      else
        LISTA+=\"- <a href=\\\"$p\\\" target=\\\"_blank\\\" rel=\\\"noopener noreferrer\\\">$NAME</a><br/>\"
      fi
    done < <(find \"$base/practicas\" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)
  fi

  [ -z \"$LISTA\" ] && LISTA=\"(sin prácticas todavía)\"

  TABLE+=\"    <tr>
      <td>$MODLINK</td>
      <td style=\\\"text-align:center;\\\">$COUNT</td>
      <td>$LISTA</td>
    </tr>
\"
done

TABLE+=\"  </tbody>
</table>
$END
\"

# Reemplaza el bloque entre marcadores (si existe) o añade al final
if grep -q \"$START\" \"$README\" 2>/dev/null; then
  awk -v start=\"$START\" -v end=\"$END\" -v repl=\"$TABLE\" '
    BEGIN{inside=0}
    {
      if($0 ~ start){inside=1; print repl; next}
      if($0 ~ end){inside=0; next}
      if(!inside) print
    }' \"$README\" > \"$README.tmp\" && mv \"$README.tmp\" \"$README\"
else
  printf \"\n%s\n\" \"$TABLE\" >> \"$README\"
fi

echo \"Tabla actualizada en $README\"
