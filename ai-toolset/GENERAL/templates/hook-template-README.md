# Hook: [Nombre del Hook]

Breve descripción de qué hace este hook.

## Propósito

Descripción más detallada del propósito y la funcionalidad.

## Triggers

| Trigger | Habilitado | Descripción |
|---------|-----------|-------------|
| `pre-commit` | ✅/❌ | Se ejecuta antes de commit |
| `post-commit` | ✅/❌ | Se ejecuta después de commit |
| `on-prompt` | ✅/❌ | Se ejecuta al recibir prompt |
| `on-push` | ✅/❌ | Se ejecuta al hacer push |

## Configuración

```json
{
  "governance_level": "standard",
  "log_path": "logs/hook-events.jsonl",
  "enabled": true
}
```

### Niveles de Gobernanza

- `open`: Solo auditoría, nunca bloquea
- `standard`: Auditoría + bloquea si se configura
- `strict`: Auditoría + bloquea amenazas
- `locked`: Bloquea todo detectado

## Instalación

```bash
# Copiar a .github/
cp -r hooks/mi-hook .github/hooks/

# Hacer ejecutable
chmod +x .github/hooks/mi-hook/script.sh

# Crear directorio de logs
mkdir -p logs/hook-events
echo "logs/" >> .gitignore
```

## Uso

```bash
# Ejecutar directamente
./hooks/mi-hook/script.sh

# Ver output JSON
./hooks/mi-hook/script.sh | jq .

# Verificar exit code
echo $?
```

## Salida

```json
{
  "status": "success",
  "hook": "mi-hook",
  "timestamp": "2026-05-01T01:30:00Z",
  "findings": [],
  "duration_ms": 123
}
```

## Ejemplos

### Ejecución Exitosa

```bash
$ ./hooks/mi-hook/script.sh input
{"status": "success", "hook": "mi-hook", ...}
$ echo $?
0
```

### Detección de Amenaza

```bash
$ ./hooks/mi-hook/script.sh malicious_input
{"status": "threat_detected", "threat_category": "...", ...}
$ echo $?
1
```

## Integración CI/CD

En `.github/workflows/security.yml`:

```yaml
- name: Run mi-hook
  run: ./hooks/mi-hook/script.sh
  continue-on-error: false
```

## Logs

Append-only logs en `logs/hook-events.jsonl`:

```bash
# Ver logs
cat logs/hook-events.jsonl | jq .

# Últimas 10 líneas
tail -10 logs/hook-events.jsonl | jq .
```

## Troubleshooting

### El hook no se ejecuta
- ✅ Verificar que `enabled: true` en `hooks.json`
- ✅ Verificar permisos: `chmod +x script.sh`
- ✅ Verificar trigger está habilitado

### JSON inválido
- ✅ Validar: `./hooks/mi-hook/script.sh | jq .`
- ✅ Revisar formato en `script.sh`

### Logs no aparecen
- ✅ Crear directorio: `mkdir -p logs/`
- ✅ Verificar path en `hooks.json`

## Recursos Relacionados

- [Instrucciones de hooks](../../instructions/agent-safety.instructions.md)
- [Guía de hooks](../../hooks/README.md)
- [Best practices](../../BEST-PRACTICES.md)
