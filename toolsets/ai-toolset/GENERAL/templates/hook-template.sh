#!/bin/bash

# Hook: [nombre del hook]
# Descripción: [qué hace]
# Triggers: [pre-commit, post-commit, on-prompt]

set -euo pipefail

# Validar entrada
if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <input>"
  exit 2
fi

input="$1"

# Lógica del hook
result=$(verificar_condicion "$input")

# Generar salida JSON
cat <<EOF
{
  "status": "success",
  "hook": "mi-hook",
  "timestamp": "$(date -Iseconds)",
  "input": "$input",
  "result": "$result",
  "duration_ms": 123
}
EOF

exit 0
