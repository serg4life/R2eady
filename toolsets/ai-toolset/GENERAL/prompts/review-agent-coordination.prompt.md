---
description: 'Revisar y validar coordinación entre agentes para detectar problemas de flujo'
name: 'Revisar Coordinación de Agentes'
---

# Revisar Coordinación de Agentes

Utiliza este prompt para revisar que la coordinación entre agentes sea correcta.

## Tarea

Necesito revisar la coordinación de un flujo de agentes:

**Escenario**: [Describe el flujo: qué usuario pide, qué agentes se invocan, qué resultado esperado]

**Agentes involucrados**: [lista de agentes participantes]

**Flujo propuesto**:
```
Usuario: [solicitud]
    ↓
[Agente A]
├─ Invoca: @agente-b
├─ Invoca: @agente-c
└─ Resultado final
```

## Instrucciones para Copilot

1. Validar patrón de coordinación:
   - ¿Es secuencial, paralelo o feedback loop?
   - ¿Es el patrón correcto para este caso?
   - ¿Hay alternativas más eficientes?

2. Verificar invocaciones de subagentes:
   - Sintaxis: `@agente-nombre Descripción clara`
   - ¿Incluye referencia a archivos específicos?
   - ¿Output esperado es claro?

3. Revisar gestión de estado:
   - ¿Se guardan archivos en ubicaciones estándar? (`/plan/`, `/docs/`, `/security/`)
   - ¿Hay versionado si es necesario?
   - ¿Status está marcado? (pending, in_progress, approved, blocked)

4. Detectar problemas:
   - ¿Hay loops infinitos?
   - ¿Herramientas requeridas están permitidas?
   - ¿Faltan reviews o validaciones?
   - ¿Security review es necesario?

5. Sugerir mejoras:
   - Paralelización donde sea posible
   - Simplificación de flujos
   - Mejor gestión de errores/bloques

## Validación

- ✅ Patrón claro (secuencial/paralelo/feedback)
- ✅ Invocaciones bien formadas
- ✅ Estado compartido claro
- ✅ Sin loops infinitos
- ✅ Todos los agentes tienen tools necesarias
- ✅ Auditoría posible

## Referencia

Patrones de coordinación: [AGENT-COORDINATION.md](../../AGENT-COORDINATION.md)

Ejemplos: [.github/copilot-instructions.md](../copilot-instructions.md#interacción-entre-agentes-y-subagentes)

Guía completa: [AGENT-COORDINATION.md](../../AGENT-COORDINATION.md#patrones-de-invocación)
