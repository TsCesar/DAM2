#!/usr/bin/env bash
set -euo pipefail

# Preferencias de extensiones para escoger archivo principal
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
  # 1) si solo hay un archivo no-README, úsalo
  mapfile -t files < <(find "$dir" -maxdepth 1 -type f ! -iname 'readme.md' | sort)
  if [[ ${#files[@]} -eq 1 ]]; then
    echo "${files[0]}"
    return 0
  fi
  # 2) por preferencia de extensiones
  for ext in "${PREF_EXT[@]}"; do
    cand=$(find "$dir" -maxdepth 1 -type f -iname "*.${ext}" ! -iname 'readme.md' | head -n1 || true)
    if [[ -n "${cand:-}" ]]; then
      echo "$cand"
      return 0
    fi
  done
  # 3) cualquiera
  if [[ ${#files[@]} -gt 0 ]]; then
    echo "${files[0]}"
    return 0
  fi
  # 4) nada
  echo ""
  return 1
}

shopt -s nullglob

# Recorre todos los directorios de prácticas: 0*-*/practicas/*/
for dir in 0*-*/practicas/*/ ; do
  [[ -d "$dir" ]] || continue

  main_file="$(pick_main_file "$dir" || true)"
  if [[ -z "$main_file" ]]; then
    echo "⚠️  Saltando '$dir' (no hay archivo principal)."
    continue
  fi

  # Intenta recuperar autor del README antiguo si lo tuviera
  old_readme="$dir/README.md"
  autor="Desconocido"
  if [[ -f "$old_readme" ]]; then
    extraido=$(grep -iE '^\s*\**\s*autor/a\s*:\s*' "$old_readme" | head -n1 | sed -E 's/^.*autor\/a\s*:\s*//I' || true)
    [[ -n "$extraido" ]] && autor="$extraido"
  fi

  lang="$(detect_lang "$main_file")"

  # Escribe el README mínimo (autor + bloque con el código)
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
