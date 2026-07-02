# HarnessWeaver

English | [中文](README.zh-CN.md)

HarnessWeaver is a reusable Codex harness engineering template for PRD-first, task-based AI-assisted development.

It helps new projects start with a stable `AGENTS.md` entry point, PRD-first planning, small implementation tasks, verification before handoff, human review before commit, harness maturity stages, and project-specific guardrails.

HarnessWeaver is not an application framework. It does not choose your frontend stack, backend, database, deployment model, or AI provider. It gives Codex and humans a reusable operating system for making those choices deliberately.

## How To Use

1. Copy this template into a new project.
2. Replace placeholders such as `{PROJECT_NAME}`, `{DOMAIN}`, and `{PRIMARY_USER}`.
3. Fill in `docs/domain/PROJECT_RULES.md`.
4. Draft or update `docs/prd/`.
5. Create small task files under `docs/tasks/`.
6. Run:

```bash
bash scripts/verify.sh
```

## Template Principle

Keep generic workflow separate from project-specific rules.

- `docs/meta/`: reusable Codex workflow.
- `docs/harness/`: reusable harness engineering structure.
- `docs/domain/`: project-specific guardrails.
- `docs/prd/`: project-specific product direction.

## Harness Stages

HarnessWeaver uses staged gates so a project can start before product development and grow its harness over time:

- Stage 0: Framework Harness. Complete before product code exists.
- Stage 1: Fixture or Schema Harness. Trigger when structured content, data, or workflow fixtures appear.
- Stage 2: Logic Harness. Trigger when paths, states, rules, or outcomes can be simulated.
- Stage 3: Product UI Harness. Trigger when user-facing UI exists.
- Stage 4: Continuous Harness. Trigger when project tooling and CI can run stable checks.

Detailed stage gates live in:

- `docs/harness/stages/stage-0-framework.md`
- `docs/harness/stages/stage-1-fixture-schema.md`
- `docs/harness/stages/stage-2-logic.md`
- `docs/harness/stages/stage-3-product-ui.md`
- `docs/harness/stages/stage-4-continuous.md`
