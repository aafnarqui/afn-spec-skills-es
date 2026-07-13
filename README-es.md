# AFN Spec Skills — Guía en español

## Propósito

Este repositorio publica **skills pedagógicos** para trabajar con **SDD en AFN IDE**: el spec es el contrato; el código es consecuencia. Los skills **mapean** ritual conversacional a comandos nativos (`/sdd-spec-start`, `/sdd-wizard-approve`, `/sdd-task-run`).

## Flujo recomendado

1. **Change SDD:** `/sdd-new mi-feature` o elegir change activo.
2. **Especificar (skill `afn-spec-es`):** preguntas en bloques → borrador en `.afn/changes/<change>/spec.md` únicamente.
3. **Wizard AFN:** `/sdd-continue` → design → tasks; aprobar con `/sdd-wizard-approve spec|design|tasks <change>`.
4. **Implementar (skill `afn-spec-impl-es`):** `/sdd-task-run <change>` o `/sdd-task-run <change> --step` para pausa entre tareas.
5. **Cerrar:** `/sdd-verify`, tests según política del proyecto.

## Comandos AFN (referencia)

| Intención | Comando nativo |
|-----------|----------------|
| Estado del change | `/sdd-status <change>` |
| Aprobar fase | `/sdd-wizard-approve spec <change>` |
| Una tarea | `/sdd-task-run <change> <ref>` |
| Cola secuencial | `/sdd-task-run-all <change>` |
| Pausa entre tareas | `/sdd-task-run <change> --step` |
| Rama git sugerida | ver mensaje al iniciar task-run si `agent.sddChangeGitBranch.autoCreate` |

## Checklist antes de publicar en GitHub

- [ ] V-01: Marketplace instala vía `contentUrl`.
- [ ] V-02: Skill genera borrador en `.afn/changes/<change>/spec.md`.
- [ ] V-03: No crea `specs/` en raíz.
- [ ] V-04: Sin aprobación, skill impl no implementa.
- [ ] V-05: Tras approve, alinea con `/sdd-task-run`.
- [ ] V-06: Smoke `/sdd-status` sin regresión.
- [ ] V-07: Texto 100 % español, sin demo hardcodeado.
- [ ] V-08: Licencia MIT en repo.

## Subir a GitHub

```powershell
cd afn-spec-skills-es
git init
git add .
git commit -m "feat: pack skills SDD en español para AFN"
git remote add origin https://github.com/aafnarqui/afn-spec-skills-es.git
git push -u origin main
```

Tras el push, actualizá la URL en el Marketplace de AFN IDE (`contentUrl` → `raw.githubusercontent.com/aafnarqui/afn-spec-skills-es/main/skills/...`).
