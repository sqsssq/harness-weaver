# Changelog

All notable HarnessWeaver template changes should be recorded here.

This project follows semantic versioning once tagged releases begin. Until then, keep new work under `Unreleased`.

## Unreleased

### Added

- Config-based initialization via `config/init-project.example.env` and `scripts/init-project.sh --config`.
- Initialization preview via `scripts/init-project.sh --dry-run`.
- Project-specific design standards entry point at `docs/design.md`.
- Strict instance readiness guide at `docs/harness/06-strict-readiness.md`.
- Local initialization config ignore rule for `init-project.env`.
- Optional Codex skill scaffold at `skills/harness-weaver/` for HarnessWeaver project initialization.
- Repository identity cleanup with root `AGENTS.md` for HarnessWeaver itself and generated-project `AGENTS.md` at `templates/base/AGENTS.md`.
- MIT license.
- Recommended use cases in README.

### Changed

- Optional Codex skill renamed from `harnessweaver-init` to `harness-weaver`.
- `scripts/verify.sh` now requires the initialization config example, design standards, strict readiness guide, and `.gitignore`.
- Strict instance verification now prints a grouped TODO summary when readiness markers remain.
- Product summary wording was adjusted to avoid duplicated "is" text after initialization.

## Versioning Notes

- Use `MAJOR` for incompatible template structure or workflow changes.
- Use `MINOR` for new reusable template capabilities.
- Use `PATCH` for fixes, wording improvements, and verification refinements.
