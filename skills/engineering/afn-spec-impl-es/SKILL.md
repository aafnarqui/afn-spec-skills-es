---
name: afn-spec-impl-es
description: Implementa un change SDD aprobado en AFN IDE, tarea por tarea, con pausa para revisar diffs. Valida gates del wizard antes de codear. Usalo tras /sdd-wizard-approve.
disable-model-invocation: true
argument-hint: '<change> [--step]'
tags: sdd, develop, implementar, afn, task-run
---

# /afn-spec-impl — Implementación guiada (AFN SDD)

Implementá un change **ya especificado y aprobado** en AFN IDE. Este skill **delega** al pipeline nativo; no inventa un flujo paralelo.

## Precondiciones (obligatorio verificar)

Antes de escribir código, comprobá en `.afn/changes/<change>/meta.json` (vía contexto o `/sdd-status`):

| Gate | Campo wizard | Comando si falta |
|------|--------------|------------------|
| Spec aprobado | `specApproved: true` | `/sdd-wizard-approve spec <change>` |
| Design aprobado | `designApproved: true` | `/sdd-wizard-approve design <change>` |
| Tasks aprobado | `tasksApproved: true` | `/sdd-wizard-approve tasks <change>` |

Si `evaluateSddWizardImplementGate` fallaría, **no implementes**. Mostrá el mensaje de gate y el comando `/sdd-wizard-approve` requerido.

## Comandos AFN a usar

| Modo | Comando | Comportamiento |
|------|---------|----------------|
| Una tarea | `/sdd-task-run <change> <ref>` | Un turno /develop por tarea |
| Cola automática | `/sdd-task-run-all <change>` | Encadena tareas pendientes |
| **Pausa entre tareas** | `/sdd-task-run <change> --step` | Tras cada `[x]`, espera revisión humana |
| Popover guiado | `/sdd-task-run` (sin args) | Elegir change + tarea en UI |

**No uses** carpeta `specs/` ni branches mágicas sin confirmación del usuario.

## Flujo recomendado

### 1. Confirmar change y cola

1. Leé `tasks.md` del change.
2. Listá tareas pendientes (`[ ]`).
3. Confirmá con el usuario si arranca por la primera pendiente o por una ref concreta.

### 2. Rama git (opcional)

Si el proyecto tiene git y la política lo permite (`agent.sddChangeGitBranch` en `.afn/context.json`), sugerí rama `sdd/<change>`. **No** ejecutes `git checkout` sin que el usuario lo pida o apruebe en terminal.

### 3. Implementar tarea por tarea

Por cada tarea:

1. Invocá `/sdd-task-run <change> <ref>` (AFN adjunta spec, design, tasks).
2. Implementá **solo esa tarea** en /develop.
3. Marcá `[x]` en `tasks.md` cuando la evidencia lo justifique.
4. **Modo `--step`:** pará y pedí al usuario que revise el diff antes de la siguiente.
5. **Modo cola:** AFN encadena la siguiente tarea automáticamente.

### 4. Cierre

Cuando no queden tareas `[ ]`:

- Sugerí `/sdd-verify <change>` y tests del stack del proyecto.
- Recordá `/validar` si hay servicios locales.

## Reglas duras

- **Una tarea por turno** salvo que el usuario pida explícitamente cola completa.
- **No** modifiques `spec.md` ni `design.md` durante implementación salvo bug crítico documentado en notas.
- **No** desactives gates del wizard.
- **No** hardcodees nombres de producto demo ajenos al proyecto abierto.
- Si una tarea falla evidencia/tests, **no** marques `[x]`; proponé fix o subdivisión en `tasks.md` vía `/sdd-continue`.

## Mensajes al usuario (español)

Al bloquear por gate:

> Implementación bloqueada: falta aprobar **Tasks** en el change `X`. Ejecutá `/sdd-wizard-approve tasks X` y repetí `/sdd-task-run X`.

Al pausar (--step):

> Tarea `t2` completada. Revisá el diff. Cuando estés listo: `/sdd-task-run X --step` o `/sdd-task-run X t3`.

## Argumentos

- `/afn-spec-impl creditos-mvp` → change `creditos-mvp`, primera tarea pendiente.
- `/afn-spec-impl creditos-mvp --step` → misma cola con pausa entre tareas.
- `/implementar-espec mi-change t1` → tarea concreta `t1`.
