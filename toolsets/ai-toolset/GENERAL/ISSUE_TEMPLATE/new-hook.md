---
name: Nuevo Hook
description: Proponer un nuevo hook de gobernanza, seguridad o automatización
title: "[HOOK] "
labels: ["enhancement", "hook"]
---

## Descripción

¿Qué automatización o validación realizaría este hook?

## Tipo

¿Qué tipo de hook es?

- [ ] Seguridad (threat detection, secrets scanning)
- [ ] Cumplimiento (licenses, policies)
- [ ] Automatización (auto-commit, logging)
- [ ] Gobernanza (governance, audit)

## Triggers

¿Cuándo se ejecutaría?

- [ ] pre-commit
- [ ] post-commit
- [ ] on-prompt
- [ ] on-push

## Propósito

Describe el propósito específico del hook.

## Lógica

¿Qué detecta o valida?

- Punto 1
- Punto 2
- Punto 3

## Salida Esperada

¿Qué devolvería el hook?

```json
{
  "status": "success",
  "hook": "nombre",
  "findings": []
}
```

## Configuración

¿Qué se configuraría?

- Parámetro 1
- Parámetro 2

## Integración

¿Cómo se integraría con CI/CD?

- [ ] GitHub Actions workflow
- [ ] Pre-commit hook
- [ ] Otro: [especificar]

## Checklist

- [ ] Nombre propuesto en minúsculas-guiones
- [ ] Tipo claramente definido
- [ ] Triggers especificados
- [ ] Salida JSON definida
- [ ] Exit codes claros (0=éxito, 1=fallo)
- [ ] Logs append-only

## Referencias

Link a instrucciones: [Crear Nuevo Hook](https://github.com/user/repo/blob/main/CONTRIBUTING.md#para-crear-un-hook)

Link a ejemplar: [governance-audit](https://github.com/user/repo/blob/main/hooks/governance-audit/README.md)
