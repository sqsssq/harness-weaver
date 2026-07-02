---
name: harnessweaver-init
description: Initialize a new project from the HarnessWeaver template. Use when the user asks to create, scaffold, copy, bootstrap, rehearse, or validate a HarnessWeaver-based project; generate or review init-project.env; run init-project.sh; run --template, --instance, or --strict-instance verification; or prepare a handoff for HarnessWeaver project initialization.
---

# HarnessWeaver Init

## Overview

Use this skill to create or validate a project from the HarnessWeaver template. Keep the workflow focused on scaffold initialization and verification; do not generate product code, create PRDs beyond the initialization config, or commit the target project unless the user explicitly asks.

For design rationale and scope boundaries, see `references/skill-brief.md` when planning or updating this skill.

## Required Inputs

Determine these before initializing:

- Source HarnessWeaver template path or repository.
- Target project path.
- Project name.
- Domain.
- Primary user.
- MVP focus.

If any required input is missing and cannot be inferred safely, ask a concise question before modifying files.

## Workflow

1. Locate the HarnessWeaver source template.
   - If running inside the HarnessWeaver repo, use the current repo root.
   - If the user gives a path or repo URL, use that.
   - Otherwise ask for the source template location.
2. Confirm the target path does not already contain unrelated work. If it exists and is non-empty, ask before overwriting or merging.
3. Copy the template to the target path.
   - Exclude `.git/`.
   - Exclude `skills/` unless the user explicitly wants the skill bundled into the target project.
   - Exclude local files such as `init-project.env`.
4. Create `init-project.env` in the target project from `config/init-project.example.env`.
5. Fill or help the user fill the `HW_*` values. Keep values project-specific.
6. Run:

```bash
bash scripts/verify.sh --template
bash scripts/init-project.sh --config init-project.env --dry-run
bash scripts/init-project.sh --config init-project.env
bash scripts/verify.sh --instance
bash scripts/verify.sh --strict-instance
```

7. If strict verification fails, use the output as an edit checklist. Update only project-specific files needed for readiness.
8. Provide a handoff with commands run, pass/fail results, changed files, and remaining manual decisions.

## Guardrails

- Do not create product application code.
- Do not create a real task file in `docs/tasks/` during initialization.
- Do not commit or push the target project unless the user explicitly asks.
- Do not treat the example config values as product truth.
- Do not hide failed verification. Report failed commands and the next concrete fix.

## Handoff Shape

Include:

- Target project path.
- Source template path or commit when available.
- Initialization method used, such as `--config`.
- Verification results for `--template`, `--instance`, and `--strict-instance`.
- Any files the user still needs to review, especially `docs/domain/PROJECT_RULES.md`, `docs/design.md`, and `docs/prd/`.
