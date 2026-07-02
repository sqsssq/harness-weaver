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
6. Run template verification before customization:

```bash
bash scripts/verify.sh --template
```

7. Initialize common placeholders with a config file:

```bash
cp config/init-project.example.env init-project.env
# Edit init-project.env, then run:
bash scripts/init-project.sh --config init-project.env --dry-run
bash scripts/init-project.sh --config init-project.env
```

You can also pass the core fields directly:

```bash
bash scripts/init-project.sh \
  --project-name "My Project" \
  --domain "local productivity tool" \
  --primary-user "solo operators" \
  --mvp-focus "capture and review daily notes"
```

8. Run instance verification:

```bash
bash scripts/verify.sh --instance
```

9. Edit remaining `TODO` values, then run strict instance verification before task execution:

```bash
bash scripts/verify.sh --strict-instance
```

For the recommended editing order, see `docs/harness/06-strict-readiness.md`.
For project-specific UI and experience standards, fill in `docs/design.md` before product UI work.

## Template Principle

Keep generic workflow separate from project-specific rules.

- `docs/meta/`: reusable Codex workflow.
- `docs/harness/`: reusable harness engineering structure.
- `docs/domain/`: project-specific guardrails.
- `docs/design.md`: project-specific design standards.
- `docs/prd/`: project-specific product direction.
- `config/`: reusable initialization config examples.

Template changes are tracked in `CHANGELOG.md`. Existing projects can use `docs/meta/UPGRADE_GUIDE.md` when pulling newer HarnessWeaver improvements forward.

## Verification Modes

HarnessWeaver separates template verification from instance verification:

- `bash scripts/verify.sh --template` allows placeholder tokens like `{PROJECT_NAME}`.
- `bash scripts/verify.sh --instance` fails if placeholder tokens remain.
- `bash scripts/verify.sh --strict-instance` fails if placeholder tokens or unresolved TODO markers remain.

All modes check required files, source-project-specific leakage, executable scripts, and Markdown path references.

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
