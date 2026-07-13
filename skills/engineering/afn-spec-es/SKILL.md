---
name: afn-spec-es
description: Diseña la especificación SDD de un change en AFN IDE. Preguntas en bloques, sección por sección, solo spec.md. Usalo al iniciar una feature grande, antes de escribir código.
disable-model-invocation: true
argument-hint: 'nombre-change o descripción breve de la feature'
tags: sdd, plan, develop, especificacion, afn
---

# /afn-spec — Diseñador guiado de especificación (AFN SDD)

Este skill produce un **spec útil** para el pipeline SDD de **AFN IDE**. **No escribas código aquí.** Tu trabajo es clarificar qué se construye, preguntar cuando falte definición y redactar **solo** `spec.md` del change activo bajo `.afn/changes/`.

## Filosofía

El spec no es documentación decorativa: es el **contrato** que guía la implementación. Si el spec es vago, el código improvisa. Por eso este flujo es **lento al definir** y **rápido al escribir**.

## Artefactos AFN (obligatorio)

| Pieza | Ruta | Este skill |
|-------|------|------------|
| Spec | `.afn/changes/<change>/spec.md` | **Sí — único archivo que escribes** |
| Design | `.afn/changes/<change>/design.md` | No — usar `/sdd-continue` o wizard |
| Tasks | `.afn/changes/<change>/tasks.md` | No — wizard AFN |
| Aprobación | `meta.json` → `specApproved` | No — humano con `/sdd-wizard-approve spec <change>` |

**Prohibido:** crear `specs/NN-slug.md` en la raíz del repo. AFN usa changes, no carpetas planas.

## Flujo del comando

Seguí las cuatro fases en orden. **No saltees fases.** Si el usuario quiere ir más rápido, recordá que el costo de un mal spec se paga en código.

Respondé **siempre en español** salvo que el usuario escriba en otro idioma.

### Fase 1 — Contexto del proyecto

1. Leé `AGENTS.md` o `CLAUDE.md` si existen (políticas del repo).
2. Listá `.afn/changes/` para ver changes previos y convenciones.
3. Si hay change activo (`/sdd-status`), usalo; si no, proponé nombre de change en kebab-case.
4. Leé los dos changes más recientes (solo `spec.md`) para alinear tono y estructura.

Si `$ARGUMENTS` viene vacío, pedí una **descripción en una sola frase**. Si no cabe en una frase, sugerí dividir en dos changes.

### Fase 2 — Clarificar con preguntas

Fase más importante. **Detectá ambigüedades y preguntá**, no asumas.

- Preguntas en **bloques de 3 a 5** (no una por una).
- Tras cada bloque, esperá respuesta antes de continuar.

**Categorías a considerar:**

- **Alcance:** qué entra y qué **no** entra en este change.
- **Datos:** estructuras nuevas, nombres, persistencia.
- **Integración:** dependencias de changes previos o código existente.
- **UX y estados:** éxito, error, estados intermedios.
- **Riesgos:** qué puede romperse; caso degradado.
- **Decisiones cerradas:** qué no se reabre en este spec.

**Cuándo parar de preguntar:** cuando podés responder sin suponer:

1. ¿Qué archivos aparecen o cambian?
2. ¿Cuál es el primer paso ejecutable y cuál el último?
3. ¿Cómo verificamos que la feature está terminada?

### Fase 3 — Redactar spec sección por sección

**No generes el spec completo de una vez.** Mostrá cada sección y esperá confirmación.

Orden sugerido para `spec.md`:

1. **Objetivo** (una frase).
2. **Alcance** (incluye explícitamente lo que **no** está).
3. **Rama git** (opcional pero recomendado): una línea `**Rama git:** feature/102030` o frontmatter `branch: feature/102030`. Si no hay tag, AFN usará `sdd/<change>` al implementar.
4. **Requisitos funcionales** (numerados REQ-1, REQ-2…).
5. **Modelo / datos** (si aplica).
6. **Criterios de aceptación** (checklist verificable).
7. **Riesgos y decisiones** (si aplica).

Tras cada sección: «¿Queda así o ajustamos?»

### Fase 4 — Guardar spec

Cuando todas las secciones estén confirmadas:

1. Escribí **solo** `.afn/changes/<change>/spec.md` (bloque `writeFile` o equivalente AFN).
2. **No** modifiques `meta.json` para marcar aprobado.
3. Confirmá al usuario:
   - Ruta del archivo.
   - Siguiente paso: `/sdd-continue` o wizard para design/tasks.
   - Aprobación humana: `/sdd-wizard-approve spec <change>` cuando haya re-leído el spec.
4. **Pará aquí.** No propongas implementar ni escribir código.

## Reglas duras

- **Nunca escribas código** en este comando.
- **Nunca** marques `specApproved: true` en `meta.json`.
- **Nunca** asumas decisiones no confirmadas.
- **Nunca** generes spec + design + tasks en un solo turno salvo que el usuario pida explícitamente `/sdd-continue`.
- Si la feature es demasiado grande (más de tres áreas del sistema), proponé dividir en dos changes.

## Tono

Directo y concreto. Numerá las preguntas. Ejemplo:

> Antes del modelo de datos necesito aclarar tres cosas:
>
> 1. **Persistencia.** ¿localStorage, API, archivo en disco?
> 2. **Versionado de esquema.** ¿migración al cargar o ignorar?
> 3. **Privacidad.** ¿Datos sensibles? ¿Se borran al cerrar sesión?

## Argumentos

`/afn-spec mi-feature` sugiere change `mi-feature`; confirmá con el usuario antes de escribir.
