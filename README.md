# AFN Spec Skills (Español)

Pack de **skills** para [AFN IDE](https://github.com/afnarqui99/notions) y agentes compatibles con formato `SKILL.md`. Enseña y refuerza **desarrollo guiado por especificación (SDD)** usando el pipeline nativo de AFN (`.afn/changes/`), **sin** un segundo motor paralelo.

## Skills incluidos

| Skill | Comando sugerido | Rol |
|-------|------------------|-----|
| `afn-spec-es` | `/afn-spec`, `/espec` | Redactar `spec.md` del change con preguntas en bloques |
| `afn-spec-impl-es` | `/afn-spec-impl`, `/implementar-espec` | Implementar vía `/sdd-task-run` tras aprobación del wizard |

## Instalación

### Marketplace AFN

Instalá **Especificación SDD (ES)** y **Implementar spec aprobado (ES)** desde el Marketplace del IDE (pestaña Skills).

### Manual

```powershell
git clone https://github.com/aafnarqui/afn-spec-skills-es.git
cd afn-spec-skills-es
./scripts/install-to-afn.ps1 -ProjectRoot "C:\ruta\a\tu\proyecto"
```

Copia los `SKILL.md` a `.afn/skills/` del proyecto abierto.

## Requisitos del proyecto

- Carpeta `.afn/` con SDD activo (`.afn/changes/<change>/spec.md`, `design.md`, `tasks.md`, `meta.json`).
- Constitución opcional: `.afn/prompts/sdd-constitution.md`.

## Qué **no** hace este pack

- No crea `specs/` en la raíz del repo (AFN usa `.afn/changes/`).
- No altera gates de `/sdd-wizard-approve` ni `/sdd-verify`.
- No reemplaza `/sdd-run`, `/sdd-continue` ni el orquestador nativo.

## Licencia

MIT — ver [LICENSE](./LICENSE).

## Relacionado en AFN IDE

- Viabilidad e integración: `src/components/IA/afnIAFullscreen/README_VIABILIDAD_AFNSKILLS_FERNANDO_SDD.md` (repo notions).
- Mejoras SDD opt-in: modo `--step` en task-run y rama git sugerida por change (`afnSddTaskRunStepPause.js`, `afnSddChangeGitBranch.js`).
