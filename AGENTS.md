# AGENTS.md

HarnessWeaver is a reusable Codex harness engineering template and optional skill for initializing PRD-first, task-based AI-assisted development projects.

This repository develops the HarnessWeaver template itself. Do not treat the root `AGENTS.md` as the file copied into generated projects. The generated-project version lives at `templates/base/AGENTS.md`.

## Project Context

- Project name: `HarnessWeaver`
- Domain: reusable Codex harness engineering templates
- Primary user: project creators who want PRD-first, task-based AI-assisted development
- Current MVP focus: reusable project initialization, strict readiness verification, and optional Codex skill support
- Explicit non-goals: choosing an application stack, generating product code by default, or replacing project-specific human review

## Repository Map

```text
AGENTS.md                 HarnessWeaver repo maintenance rules
templates/base/AGENTS.md  generated-project AGENTS.md template
config/                   initialization config examples
docs/meta/                reusable Codex workflow
docs/harness/             harness maturity, sensors, and failure patterns
docs/domain/              project-specific guardrail template
docs/design.md            project-specific design standards template
docs/prd/                 product direction and MVP boundary templates
docs/tasks/               task workflow templates
scripts/                  verification and initialization entry points
skills/                   optional Codex skills for HarnessWeaver workflows
```

## Working Agreements

- Keep generated-project template files generic and placeholder-driven.
- Keep HarnessWeaver repo maintenance rules in this root `AGENTS.md`.
- Keep generated-project rules in `templates/base/AGENTS.md` and copied template docs.
- Do not add real project task files to `docs/tasks/`; keep only reusable task workflow templates.
- Do not add product application code to this repository.
- Run `bash scripts/verify.sh --template` before handoff.
- For reuse changes, test a copied project with `--instance` and `--strict-instance`.
- Commit and push only after the relevant verification passes and the user has approved or requested it.

## Before Template Changes

Before changing the template, read:

1. `README.md`
2. `docs/domain/PROJECT_RULES.md`
3. Relevant files under `docs/harness/`
4. Relevant files under `docs/meta/`
5. `templates/base/AGENTS.md` when generated-project behavior is affected
6. `skills/harness-weaver/SKILL.md` when skill behavior is affected

## Verification

Prefer:

```bash
bash scripts/verify.sh --template
```

For initialization or generated-project changes, also copy the template to a temporary project and run:

```bash
bash scripts/init-project.sh --config init-project.env --dry-run
bash scripts/init-project.sh --config init-project.env
bash scripts/verify.sh --instance
bash scripts/verify.sh --strict-instance
```

Do not claim verification passed unless it actually ran.
