---
description: 'Crear un nuevo agente Copilot especializado con herramientas y capacidades definidas'
name: 'Crear Nuevo Agente'
---

# Crear Nuevo Agente

Utiliza este prompt para generar un nuevo agente rápidamente.

## Tarea

Necesito crear un nuevo agente Copilot con las siguientes características:

**Propósito**: [Describe brevemente qué hará este agente]

**Especialidad**: [ej: security-reviewer, technical-writer, planner, etc.]

**Herramientas requeridas**: [ej: search, edit, githubRepo, usages]

**Casos de uso principales**:
- Caso 1
- Caso 2
- Caso 3

## Instrucciones para Copilot

1. Crear archivo `/agents/<especialidad>-<funcion>.agent.md`
2. Generar frontmatter YAML con:
   - `description`: Propósito accionable (50-150 caracteres)
   - `name`: Nombre legible en UI
   - `tools`: Array MÍNIMO de herramientas necesarias (principio: menor privilegio)
   - `model`: Claude Sonnet 4.5
   - `target`: vscode

3. Crear secciones de instrucciones:
   - ¿Qué hago?
   - Cuándo usarme
   - Capacidades
   - Limitaciones
   - Ejemplos de invocación

4. Incluir indicaciones de seguridad (NUNCA hacer X)

5. Documentar herramientas permitidas

6. NO incluir hardcoded credentials

## Validación

- ✅ Archivo en `/agents/` con nombre minúsculas-guiones
- ✅ Frontmatter YAML válido
- ✅ Array `tools` es MÍNIMO necesario
- ✅ Description clara y accionable
- ✅ Incluye ejemplos del codebase
- ✅ No acceso a herramientas innecesarias

## Referencia

Ver ejemplar: [agents/principal-software-engineer.agent.md](../../agents/principal-software-engineer.agent.md)

Guía completa: [CONTRIBUTING.md](../../CONTRIBUTING.md#para-crear-un-agente)
