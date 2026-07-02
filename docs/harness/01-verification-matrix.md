# Verification Matrix

## Framework Documentation

| Requirement | Evidence |
| --- | --- |
| Required files exist | `bash scripts/verify.sh` |
| Paths are internally consistent | Markdown path reference check in `scripts/verify.sh` |
| No source-project-specific terms remain | source-term search |
| Template placeholders are handled correctly | `--template` allows placeholders; `--instance` rejects them |
| No product code added during framework-only work | inspect new files and top-level directories |
| Verify script is executable | `test -x scripts/verify.sh` |
| Harness stage can be assessed | `docs/harness/05-stage-checklists.md` |

## Future Fixture or Content Checks

| Requirement | Future Sensor |
| --- | --- |
| Core entity has required fields | schema check |
| Review status is present when needed | schema check |
| Placeholder content is not marked final | quality check |
| Domain-specific quality rules are represented | domain check |
