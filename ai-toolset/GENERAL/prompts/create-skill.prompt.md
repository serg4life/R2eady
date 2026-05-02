---
description: 'Crear una nueva habilidad Copilot auto-descubierta y portátil'
name: 'Crear Nueva Habilidad'
---

# Crear Nueva Habilidad

Utiliza este prompt para generar una nueva habilidad reutilizable.

## Tarea

Necesito crear una nueva habilidad Copilot con las siguientes características:

**Propósito**: [Describe brevemente qué capacidades ofrecerá]

**Nombre**: [minúsculas-guiones, ej: create-test-runner]

**Palabras clave de activación**: [Términos que el usuario podría mencionar]

**Capacidades principales**:
- Capacidad 1
- Capacidad 2
- Capacidad 3

**Recursos necesarios**:
- Scripts
- Templates
- Ejemplos

## Instrucciones para Copilot

1. Crear directorio `/skills/<nombre>/`

2. Crear `SKILL.md` con frontmatter:
   - `name`: Minúsculas-guiones
   - `description`: CRÍTICO - Incluir QUÉ, CUÁNDO, PALABRAS CLAVE
   - `license`: Complete terms in LICENSE.txt

3. Campo description DEBE incluir:
   - Capacidades concretas (QUÉ: "Kit para...")
   - Disparadores específicos (CUÁNDO: "Usar cuando se pida...")
   - Palabras clave de búsqueda (términos relevantes)
   - Máximo 1024 caracteres

4. Crear secciones en SKILL.md:
   - ¿Cuándo usar?
   - Capacidades
   - Flujo de uso
   - Ejemplos

5. Agregar recursos bundle:
   - Scripts útiles
   - Templates
   - Configuraciones de ejemplo

6. NO confiar en memory - todo debe estar self-contained

## Validación - CRÍTICO

- ✅ Directory `/skills/<nombre>/`
- ✅ SKILL.md con frontmatter válido
- ✅ Description incluye QUÉ, CUÁNDO, PALABRAS CLAVE
- ✅ Nombres minúsculas-guiones
- ✅ Recursos bundle en el directorio
- ✅ Sin dependencias externas

## Referencia

Ver ejemplar: [skills/create-implementation-plan/SKILL.md](../../skills/create-implementation-plan/SKILL.md)

Guía completa: [CONTRIBUTING.md](../../CONTRIBUTING.md#para-crear-una-habilidad)

Mechanism crítico: [skills/README.md](../../skills/README.md#mecanismo-de-descubrimiento-de-habilidades)
