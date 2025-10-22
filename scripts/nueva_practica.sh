#!/usr/bin/env bash
set -e

if [ $# -lt 2 ]; then
  echo "Uso: scripts/nueva_practica.sh <modulo> <nombre-practica>"
  exit 1
fi

MOD="$1"
NAME="$2"
DIR="$MOD/practicas/$NAME"

mkdir -p "$DIR"
cat > "$DIR/README.md" <<EOT
# $NAME

## Objetivo
Describe el objetivo de la práctica.

## Requisitos
- …

## Pasos
1. …
2. …

## Cómo ejecutar
\`\`\`bash
# comandos
\`\`\`
EOT

echo "Creada práctica en: $DIR"
git add "$DIR"
git commit -m "feat($MOD): añade práctica $NAME"
echo "Listo. Sube con: git push"
