#!/usr/bin/env bash
set -euo pipefail

REPO_SLUG="TsCesar/DAM2"  # si cambias el repo, ajusta esto

for dir in 01-acceso-datos 02-computacion-descentralizada-blockchain 03-desarrollo-interfaces 04-programacion-servicios-procesos 05-programacion-multimedia-moviles 06-sistemas-gestion-empresarial; do
  f="$dir/README.md"
  [ -f "$f" ] || continue

  # botón (badge) que abre el Issue Form en nueva pestaña
  btn='<p><a href="https://github.com/'"$REPO_SLUG"'/issues/new?template=nueva_practica.yml&labels=nueva-practica&title=%5B'"${dir%%-*}"'%5D%20Nueva%20pr%C3%A1ctica%3A%20pXX-nombre" target="_blank" rel="noopener noreferrer"><img src="https://img.shields.io/badge/%E2%9E%95%20A%C3%B1adir%20pr%C3%A1ctica-1f883d?style=for-the-badge" alt="Añadir práctica"/></a></p>'

  # inserta SOLO si no existe
  if ! grep -q "Añadir práctica" "$f"; then
    awk -v BTN="$btn" '
      BEGIN{added=0}
      {print}
      /^## Prácticas$/ && !added {print ""; print BTN; print ""; added=1}
    ' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
  fi
done

echo "✔ Botón insertado donde faltaba."
