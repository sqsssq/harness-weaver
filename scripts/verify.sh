#!/usr/bin/env bash
set -euo pipefail

mode="template"

usage() {
  cat <<'EOF'
Usage: bash scripts/verify.sh [--template|--instance|--strict-instance]

Modes:
  --template          Verify this repository as a reusable template. Placeholder tokens are allowed.
  --instance          Verify a copied project instance. Placeholder tokens like {PROJECT_NAME} fail.
  --strict-instance   Verify an implementation-ready instance. Placeholder tokens and TODO markers fail.

Default: --template
EOF
}

for arg in "$@"; do
  case "$arg" in
    --template)
      mode="template"
      ;;
    --instance)
      mode="instance"
      ;;
    --strict-instance)
      mode="strict-instance"
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $arg"
      usage
      exit 1
      ;;
  esac
done

echo "HarnessWeaver verification"
echo "=========================="
echo "Mode: $mode"

required_files=(
  "AGENTS.md"
  ".gitignore"
  "CHANGELOG.md"
  "README.md"
  "README.zh-CN.md"
  "config/init-project.example.env"
  "docs/design.md"
  "docs/domain/PROJECT_RULES.md"
  "docs/prd/00-product-brief.md"
  "docs/prd/01-mvp-scope.md"
  "docs/prd/02-user-flows.md"
  "docs/prd/03-feature-design.md"
  "docs/prd/04-content-model.md"
  "docs/prd/05-ui-states.md"
  "docs/prd/06-acceptance-criteria.md"
  "docs/prd/07-task-breakdown.md"
  "docs/prd/08-open-questions.md"
  "docs/prd/09-decision-log.md"
  "docs/tasks/README.md"
  "docs/tasks/TASK_TEMPLATE.md"
  "docs/meta/PRD_GENERATOR.md"
  "docs/meta/TASK_BREAKDOWN_GUIDE.md"
  "docs/meta/TASK_EXECUTION_GUIDE.md"
  "docs/meta/CHANGE_REQUEST_GUIDE.md"
  "docs/meta/VERIFICATION_GUIDE.md"
  "docs/meta/DIFF_REVIEW_GUIDE.md"
  "docs/meta/HUMAN_HANDOFF_GUIDE.md"
  "docs/meta/COMMIT_GUIDE.md"
  "docs/meta/UPGRADE_GUIDE.md"
  "docs/harness/00-harness-overview.md"
  "docs/harness/01-verification-matrix.md"
  "docs/harness/02-agent-failure-patterns.md"
  "docs/harness/03-architecture-fitness-rules.md"
  "docs/harness/04-quality-rules.md"
  "docs/harness/05-stage-checklists.md"
  "docs/harness/06-strict-readiness.md"
  "docs/harness/stages/stage-0-framework.md"
  "docs/harness/stages/stage-1-fixture-schema.md"
  "docs/harness/stages/stage-2-logic.md"
  "docs/harness/stages/stage-3-product-ui.md"
  "docs/harness/stages/stage-4-continuous.md"
  "scripts/init-project.sh"
)

missing=0
for file in "${required_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Missing required file: $file"
    missing=1
  fi
done

if [[ "$missing" -ne 0 ]]; then
  exit 1
fi

echo "Required template files exist."

source_terms="BioQues[t]|QuestLa[b]|QuestWeave[r]|R[B]M|P[r]oposal Analytic[s]|P[S] recommendation"
if grep -R -n -E "$source_terms" AGENTS.md README.md README.zh-CN.md config docs scripts; then
  echo "Found source-project-specific terms. Please review the matches above."
  exit 1
fi

echo "No source-project-specific terms found."

for executable in scripts/verify.sh scripts/init-project.sh; do
  if [[ ! -x "$executable" ]]; then
    echo "$executable is not executable."
    exit 1
  fi
done

echo "Required scripts are executable."

placeholder_pattern='\{[A-Z][A-Z0-9_]*\}'
if [[ "$mode" == "instance" || "$mode" == "strict-instance" ]]; then
  if grep -R -n -E "$placeholder_pattern" AGENTS.md README.md README.zh-CN.md docs; then
    echo "Instance mode does not allow unresolved placeholder tokens."
    exit 1
  fi
  echo "No unresolved placeholder tokens found."
else
  placeholder_count=$(grep -R -h -E -o "$placeholder_pattern" AGENTS.md README.md README.zh-CN.md docs | wc -l | tr -d ' ')
  echo "Template placeholder tokens allowed: $placeholder_count found."
fi

if [[ "$mode" == "strict-instance" ]]; then
  todo_matches="$(mktemp)"
  if grep -R -n -E 'TODO:' AGENTS.md README.md README.zh-CN.md docs > "$todo_matches"; then
    cat "$todo_matches"
    echo
    echo "Strict instance TODO summary:"
    cut -d ':' -f 1 "$todo_matches" | sort | uniq -c | awk '{print "- " $2 ": " $1}'
    rm -f "$todo_matches"
    echo "Strict instance mode does not allow TODO markers."
    exit 1
  fi
  rm -f "$todo_matches"
  echo "No TODO markers found."
fi

path_failed=0
while IFS= read -r ref; do
  [[ -z "$ref" ]] && continue
  [[ "$ref" == *"..."* ]] && continue
  [[ "$ref" == *"*"* ]] && continue
  [[ "$ref" == *"{"* ]] && continue
  [[ "$ref" == *" "* ]] && continue
  if [[ "$ref" == */ ]]; then
    if [[ ! -d "${ref%/}" ]]; then
      echo "Referenced directory does not exist: $ref"
      path_failed=1
    fi
  else
    if [[ ! -e "$ref" ]]; then
      echo "Referenced file does not exist: $ref"
      path_failed=1
    fi
  fi
done < <(
  grep -R -h -E -o '`(AGENTS\.md|README[^`]*\.md|config/[^`]+|docs/[^`]+|scripts/[^`]+)`' AGENTS.md README.md README.zh-CN.md docs |
    sed 's/^`//; s/`$//' |
    sort -u
)

if [[ "$path_failed" -ne 0 ]]; then
  echo "Markdown path reference check failed."
  exit 1
fi

echo "Markdown path references are valid."
echo "HarnessWeaver $mode verification passed."
