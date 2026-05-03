---
description: 'Crear un nuevo hook de automatización, gobernanza o seguridad'
name: 'Crear Nuevo Hook'
---

# Crear Nuevo Hook

Utiliza este prompt para generar un nuevo hook rápidamente.

## Tarea

Necesito crear un nuevo hook con las siguientes características:

**Tipo**: [security, compliance, automation, governance]

**Propósito**: [Describe qué detecta o automatiza]

**Triggers**: [pre-commit, post-commit, on-prompt, on-push]

**Salida esperada**: [JSON status, exit codes, logs]

## Instrucciones para Copilot

1. Crear directorio `/hooks/<nombre>/`

2. Crear `hooks.json` con:
   - `name`: Nombre del hook
   - `description`: Propósito
   - `version`: SemVer inicial (1.0.0)
   - `triggers`: Objeto con triggers booleanos
   - `config`: Configuración específica

3. Crear `script.sh` que:
   - Implementa la lógica
   - Devuelve JSON válido a stdout
   - Devuelve exit code: 0=éxito, 1=fallo, 2=error
   - Logs append-only (NUNCA modificar)

4. Salida JSON DEBE incluir:
   - `status`: success/threat_detected/error
   - `hook`: nombre del hook
   - `timestamp`: ISO 8601
   - `findings`: array de resultados
   - `duration_ms`: tiempo de ejecución

5. Crear `README.md` con:
   - Descripción
   - Configuración
   - Ejemplos de salida
   - Integración con CI/CD

6. Agregar a `.gitignore`: `logs/`

## Validación

- ✅ Directory `/hooks/<nombre>/`
- ✅ `hooks.json` válido
- ✅ `script.sh` devuelve JSON + exit codes
- ✅ Logs append-only (nunca modificar)
- ✅ `README.md` documentado
- ✅ Testeable: `./hooks/<nombre>/script.sh | jq .`

## Referencia

Ver ejemplar: [hooks/governance-audit/README.md](../../hooks/governance-audit/README.md)

Guía completa: [CONTRIBUTING.md](../../CONTRIBUTING.md#para-crear-un-hook)

Standards: [hooks/README.md](../../hooks/README.md)
