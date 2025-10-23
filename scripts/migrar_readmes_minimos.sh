#!/usr/bin/env bash
set -euo pipefail

PREF_EXT=(java kt py ts js html css xml sql md)

detect_lang() {
  local ext="${1##*.}"
  case "$ext" in
    java) echo java ;;
    kt)   echo kotlin ;;
    py)   echo python ;;
    js)   echo javascript ;;
    ts)   echo typescript ;;
    html) echo html ;;
    css)  echo css ;;
    xml)  echo xml ;;
    sql)  echo sql ;;
    md)   echo markdown ;;
    *)    echo "" ;;
  esac
}

pick_main_file() {
  local dir="$1"
  mapfile -t files < <(find "$dir" -maxdepth 1 -type f ! -iname 'readme.md' | sort)
  if [[ ${#files[@]} -eq 1 ]]; then
    echo "${files[0]}"; return 0
  fi
  for ext in "${PREF_EXT[@]}"; do
    cand=$(find "$dir" -maxdepth 1 -type f -iname "*.${ext}" ! -iname 'readme.md' | head -n1 || true)
    if [[ -n "${cand:-}" ]]; then echo "$cand"; return 0; fi
  done
  if [[ ${#files[@]} -gt 0 ]]; then echo "${files[0]}"; return 0; fi
  echo ""; return 1
}

sanitize_author() {
  # Elimina dobles asteriscos en cualquier parte y recorta espacios
  # También elimina asteriscos de borde por si quedara "* Cesar *"
  sed -E 's/\*\*//g; s/^[[:space:]\*]+//; s/[[:space:]\*]+$//'
}

shopt -s nullglob

for dir in 0*-*/practicas/*/ ; do
  [[ -d "$dir" ]] || continue

  main_file="$(pick_main_file "$dir" || true)"
  if [[ -z "$main_file" ]]; then
    echo "⚠️  Saltando '$dir' (no hay archivo principal)."
    continue
  fi

  old_readme="$dir/README.md"
  autor="Desconocido"
  if [[ -f "$old_readme" ]]; then
    # Extrae tras "Autor/a:" (con posibles negritas), limpia ** y espacios
    extraido=$(grep -iE '^\s*\**\s*autor/a\s*:\s*' "$old_readme" | head -n1 \
      | sed -E 's/^.*[Aa]utor\/a\s*:\s*//; s/\r$//' \
      | sanitize_author || true)
    [[ -n "${extraido:-}" ]] && autor="$extraido"
  fi

  lang="$(detect_lang "$main_file")"

  {
    echo "**Autor/a:** ${autor}"
    echo
    if [[ -n "$lang" ]]; then
      echo '```'"$lang"
    else
      echo '```'
    fi
    cat "$main_file"
    echo '```'
  } > "$old_readme"

  echo "✅ Actualizado README mínimo en: $dir (autor='${autor}', archivo='$(basename "$main_file")')"
done
