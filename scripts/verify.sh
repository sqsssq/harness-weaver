#!/usr/bin/env bash
set -euo pipefail

echo "HarnessWeaver verification"
echo "=========================="

required_files=(
  "AGENTS.md"
  "README.md"
  "README.zh-CN.md"
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
  "docs/harness/00-harness-overview.md"
  "docs/harness/01-verification-matrix.md"
  "docs/harness/02-agent-failure-patterns.md"
  "docs/harness/03-architecture-fitness-rules.md"
  "docs/harness/04-quality-rules.md"
  "docs/harness/05-stage-checklists.md"
  "docs/harness/stages/stage-0-framework.md"
  "docs/harness/stages/stage-1-fixture-schema.md"
  "docs/harness/stages/stage-2-logic.md"
  "docs/harness/stages/stage-3-product-ui.md"
  "docs/harness/stages/stage-4-continuous.md"
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
if grep -R -n -E "$source_terms" AGENTS.md README.md docs scripts templates; then
  echo "Found source-project-specific terms. Please review the matches above."
  exit 1
fi

echo "No source-project-specific terms found."

if [[ ! -x "scripts/verify.sh" ]]; then
  echo "scripts/verify.sh is not executable."
  exit 1
fi

echo "scripts/verify.sh is executable."
echo "Template verification passed."
