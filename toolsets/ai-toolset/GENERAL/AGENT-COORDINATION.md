# Convenciones de Coordinación Entre Agentes

Documento de referencia para patrones de comunicación, coordinación y estado compartido entre agentes en el AI Toolset.

## Principios de Coordinación

1. **Autonomía**: Cada agente tiene herramientas específicas (menor privilegio)
2. **Composición**: Los agentes se llaman entre sí para tareas especializadas
3. **Persistencia**: El estado se almacena en archivos markdown, no en memoria
4. **Transparencia**: Cada invocación deja un rastro auditable
5. **Idempotencia**: Las invocaciones deben ser seguras de repetir

## Patrones de Invocación

### Patrón Secuencial

Usado cuando la salida de una tarea es entrada para la siguiente.

```markdown
## Mi Flujo

1. **Analizar requisitos** (yo)
2. **Generar plan** → "@planner Crear plan para [requisito]"
   - Esperar output: `/plan/feature-X.md`
3. **Revisar seguridad** → "@se-security-reviewer Revisar plan en /plan/feature-X.md"
   - Esperar output: análisis de vulnerabilidades
4. **Documentar** → "@se-technical-writer Crear docs basadas en plan"
   - Esperar output: `/docs/feature-X.md`
5. **Comunicar resultado** al usuario
```

**Timing**: Secuencial es para dependencias reales
**Ejemplo real**: Feature → Security Review → Documentation

### Patrón Paralelo

Usado cuando múltiples tareas son independientes.

```markdown
## Mi Flujo Paralelo

1. **Paralelo**: Lanzar reviews simultáneamente
   - "@se-security-reviewer Revisar feature X"
   - "@se-technical-writer Documentar feature X"
   - "@se-system-architecture-reviewer Validar arquitectura de feature X"
2. **Consolidar** resultados cuando ambos completen
3. **Comunicar** resultado consolidado
```

**Timing**: Paralelo es más rápido pero requiere manejo de concurrencia
**Ejemplo real**: Security review + Architecture review + Documentation

### Patrón Feedback Loop

Usado cuando se necesita iteración hasta convergencia.

```markdown
## Mi Flujo Iterativo

Loop hasta que security review sea "approved":
1. "@se-security-reviewer Revisar feature por vulnerabilidades"
2. Si hay issues:
   - Actualizar plan
   - "@se-security-reviewer Revisar cambios"
   - Repetir
3. Si aprobado: continuar
```

**Timing**: Se repite hasta que converja
**Ejemplo real**: Plan → Security Review → Refine Plan → Security Review (aprobado)

## Estado Compartido y Memoria Persistente

Los agentes usan archivos markdown para compartir contexto:

### Convención de Ubicaciones

```
/plan/          - Planes de implementación (creados por planner)
/docs/          - Documentación (creada por technical-writer)
/design/        - Decisiones de diseño (ADRs)
/security/      - Análisis de seguridad (creados por security-reviewer)
/logs/          - Logs de auditoría (hooks)
```

### Formato de Archivo de Coordinación

Ejemplo: `/plan/feature-oauth2-1.md`

```markdown
---
created_at: 2026-05-01T01:30:00Z
created_by: planner
status: draft
reviews:
  security: pending
  architecture: pending
  documentation: pending
---

# Plan de Implementación: OAuth2

## Resumen
...

## Tareas
1. [x] Task 1
2. [ ] Task 2

## Review Status
- Security: Pendiente (asignado: @se-security-reviewer)
- Architecture: Pendiente
- Documentation: Pendiente
```

### Marcas de Status

| Marca | Significado |
|-------|-------------|
| `pending` | Esperando acción |
| `in_progress` | Siendo procesado |
| `blocked` | Bloqueado por razón X |
| `approved` | Aprobado |
| `rejected` | Rechazado con razones |
| `draft` | En desarrollo |
| `final` | Completo y listo |

## Invocación de Subagentes

### Sintaxis

```markdown
"@nombre-agente Descripción clara de tarea"
```

### Ejemplos Reales

```markdown
"@planner Crear plan de implementación para: Agregar autenticación OAuth2 con Google y GitHub"

"@se-security-reviewer Revisar plan en /plan/feature-oauth2-1.md por vulnerabilidades OWASP"

"@se-technical-writer Documentar flujo de OAuth2 basado en plan en /plan/feature-oauth2-1.md"
```

### Input Recomendado

- Referencia a archivo específico (si existe): `/plan/feature-X.md`
- Contexto de la tarea
- Limitaciones o restricciones
- Formato esperado de output

### Output Esperado

Todo subagente DEBE devolver:

1. **Archivo creado**: En ubicación estándar (`/plan/`, `/docs/`, etc.)
2. **Resumen**: Explicación breve de resultados
3. **Status**: draft/approved/rejected
4. **Próximos pasos**: Qué sigue

## Manejo de Errores y Bloques

### Si un Subagente Falla

```markdown
## Decisión Tomada

@planner No pudo generar plan debido a:
- Requisitos incompletos: Aclarar [punto X]

Acción: Refinar requisitos y reintentar
```

### Escalación

```markdown
## Escalación

Si @se-security-reviewer detecta amenaza crítica:
- Status: blocked
- Razón: Critical vulnerability in [component]
- Acción requerida: Manual review necesario
```

## Auditoría y Trazabilidad

Cada invocación DEBE ser rastreable:

```markdown
## Coordinación Log

| Timestamp | Agente | Tarea | Status | Output |
|-----------|--------|-------|--------|--------|
| 2026-05-01 01:30 | planner | create-plan | approved | /plan/oauth2-1.md |
| 2026-05-01 01:32 | se-security-reviewer | review-plan | blocked | Security issues in auth flow |
| 2026-05-01 01:35 | planner | update-plan | approved | /plan/oauth2-1.md (v2) |
| 2026-05-01 01:36 | se-security-reviewer | review-plan | approved | OK |
```

## Mejores Prácticas

1. **Sé específico en invocaciones**: Incluir archivos, contexto, restricciones
2. **Usa referencias a archivos**: `@agent Revisar /plan/feature-X.md`
3. **Asigna status**: Mark tasks como pending/in_progress/approved
4. **Rastreat cambios**: Versioning (v1, v2, v3) en archivos importantes
5. **Documenta por qué**: Comentar en archivos si hay cambios inesperados
6. **Evita loops infinitos**: Establecer máximo de iteraciones (ej: máximo 3 re-reviews)
7. **Valida output**: Verificar que el subagente hizo lo esperado

## Casos de Uso Comunes

### Implementación de Feature Nueva

```
1. principal-engineer (yo)
2. @planner → /plan/feature-X.md
3. @se-security-reviewer → análisis
4. Si blocked: volver a 2
5. Si aprobado: @se-technical-writer → /docs/feature-X.md
6. Implementar basado en plan
7. Communicar resultado
```

### Refactoring Complejo

```
1. principal-engineer (yo)
2. @se-system-architecture-reviewer → análisis de impacto
3. @planner → plan de refactoring
4. @se-security-reviewer → validar no introduce vulnerabilidades
5. Ejecutar refactoring
6. @se-technical-writer → documentar cambios
```

### Review de Seguridad

```
1. principal-engineer (yo)
2. @se-security-reviewer → análisis
3. Si issues: crear plan de fixes
4. @se-security-reviewer → re-review fixes
5. Comunicar resultado
```

## Recursos Relacionados

- [.github/copilot-instructions.md](../.github/copilot-instructions.md#interacción-entre-agentes-y-subagentes)
- [agents/principal-software-engineer.agent.md](agents/principal-software-engineer.agent.md)
- [instructions/agent-safety.instructions.md](instructions/agent-safety.instructions.md)
