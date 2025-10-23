#!/usr/bin/env bash
set -euo pipefail

README="README.md"
START="<!-- TABLA_PRACTICAS_INICIO -->"
END="<!-- TABLA_PRACTICAS_FIN -->"

TMP="$(mktemp)"

cat > "$TMP" <<'HTML'
<h3>?? Prácticas por módulo (auto)</h3>
<!-- TABLA_PRACTICAS_INICIO -->
<table>
  <thead>
    <tr>
      <th style="text-align:left;">Módulo</th>
      <th style="text-align:center;">N.º prácticas</th>
      <th style="text-align:left;">Listado</th>
    </tr>
  </thead>
  <tbody>
HTML

for mod in 0*-*/ ; do
  [ -d "$mod" ] || continue
  base="${mod%/}"

  title=""
  if [ -f "$base/README.md" ]; then
    title="$(sed -n '1s/^# //p;1q' "$base/README.md")"
  fi
  [ -n "$title" ] || title="$base"

  count=0
  list=""

  if [ -d "$base/practicas" ]; then
    while IFS= read -r -d '' p; do
      count=$((count+1))
      name="$(basename "$p")"
      if [ -f "$p/README.md" ]; then
        list+="- <a href=\"$p/README.md\" target=\"_blank\" rel=\"noopener noreferrer\">$name</a><br/>"$'\n'
      else
        list+="- <a href=\"$p\" target=\"_blank\" rel=\"noopener noreferrer\">$name</a><br/>"$'\n'
      fi
    done < <(find "$base/practicas" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)
  fi

  [ -n "$list" ] || list="(sin prácticas todavía)"

  {
    printf '    <tr>\n'
    printf '      <td><a href="%s/README.md" target="_blank" rel="noopener noreferrer">%s</a></td>\n' "$base" "$title"
    printf '      <td style="text-align:center;">%s</td>\n' "$count"
    printf '      <td>%s</td>\n' "$list"
    printf '    </tr>\n'
  } >> "$TMP"
done

cat >> "$TMP" <<'HTML'
  </tbody>
</table>
<!-- TABLA_PRACTICAS_FIN -->
HTML

if grep -q "$START" "$README" 2>/dev/null; then
  awk -v start="$START" -v end="$END" -v TMPF="$TMP" '
    BEGIN{inside=0}
    {
      if($0 ~ start){inside=1; system("cat " TMPF); next}
      if($0 ~ end){inside=0; next}
      if(!inside) print
    }
  ' "$README" > "$README.tmp" && mv "$README.tmp" "$README"
else
  printf "\n" >> "$README"
  cat "$TMP" >> "$README"
fi

rm -f "$TMP"
echo "Tabla actualizada en $README"
