#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  bash scripts/init-project.sh \
    --project-name "Project Name" \
    --domain "project domain" \
    --primary-user "primary user" \
    --mvp-focus "MVP focus"

Optional:
  --generic-failure-mode "generic app drift"
  --primary-user-goal "primary user goal"
  --content-review-status-rule "review status rule"
  --feedback-reasoning-rule "feedback reasoning rule"

This script replaces common HarnessWeaver placeholders in-place.
Run `bash scripts/verify.sh --instance` after customization.
EOF
}

project_name=""
domain=""
primary_user=""
mvp_focus=""
generic_failure_mode="a generic app"
primary_user_goal=""
content_review_status_rule="explicit review status"
feedback_reasoning_rule="why the result or recommendation matters"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project-name)
      project_name="${2:-}"
      shift 2
      ;;
    --domain)
      domain="${2:-}"
      shift 2
      ;;
    --primary-user)
      primary_user="${2:-}"
      shift 2
      ;;
    --mvp-focus)
      mvp_focus="${2:-}"
      shift 2
      ;;
    --generic-failure-mode)
      generic_failure_mode="${2:-}"
      shift 2
      ;;
    --primary-user-goal)
      primary_user_goal="${2:-}"
      shift 2
      ;;
    --content-review-status-rule)
      content_review_status_rule="${2:-}"
      shift 2
      ;;
    --feedback-reasoning-rule)
      feedback_reasoning_rule="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1"
      usage
      exit 1
      ;;
  esac
done

if [[ -z "$project_name" || -z "$domain" || -z "$primary_user" || -z "$mvp_focus" ]]; then
  echo "Missing required arguments."
  usage
  exit 1
fi

if [[ -z "$primary_user_goal" ]]; then
  primary_user_goal="$mvp_focus"
fi

export HW_PROJECT_NAME="$project_name"
export HW_DOMAIN="$domain"
export HW_PRIMARY_USER="$primary_user"
export HW_MVP_FOCUS="$mvp_focus"
export HW_NON_GOALS="TODO: define explicit non-goals"
export HW_PROJECT_SUMMARY="$project_name is a $domain project."
export HW_PRIMARY_USER_PROBLEM="TODO: define the primary user problem"
export HW_PRODUCT_PROMISE="TODO: define the product promise"
export HW_SUCCESS_CRITERION_1="TODO: define success criterion 1"
export HW_SUCCESS_CRITERION_2="TODO: define success criterion 2"
export HW_SUCCESS_CRITERION_3="TODO: define success criterion 3"
export HW_IN_SCOPE_1="TODO: define in-scope item 1"
export HW_IN_SCOPE_2="TODO: define in-scope item 2"
export HW_IN_SCOPE_3="TODO: define in-scope item 3"
export HW_OUT_OF_SCOPE_1="TODO: define out-of-scope item 1"
export HW_OUT_OF_SCOPE_2="TODO: define out-of-scope item 2"
export HW_OUT_OF_SCOPE_3="TODO: define out-of-scope item 3"
export HW_MVP_LOOP_STEP_1="TODO: define MVP loop step 1"
export HW_MVP_LOOP_STEP_2="TODO: define MVP loop step 2"
export HW_MVP_LOOP_STEP_3="TODO: define MVP loop step 3"
export HW_MVP_LOOP_STEP_4="TODO: define MVP loop step 4"
export HW_PRIMARY_FLOW_STEP_1="TODO: define primary flow step 1"
export HW_PRIMARY_FLOW_STEP_2="TODO: define primary flow step 2"
export HW_PRIMARY_FLOW_STEP_3="TODO: define primary flow step 3"
export HW_PRIMARY_FLOW_STEP_4="TODO: define primary flow step 4"
export HW_EDGE_FLOW_1="TODO: define edge flow 1"
export HW_EDGE_FLOW_2="TODO: define edge flow 2"
export HW_EDGE_FLOW_3="TODO: define edge flow 3"
export HW_CORE_LOOP_STEP_1="TODO: define core loop step 1"
export HW_CORE_LOOP_STEP_2="TODO: define core loop step 2"
export HW_CORE_LOOP_STEP_3="TODO: define core loop step 3"
export HW_CORE_LOOP_STEP_4="TODO: define core loop step 4"
export HW_FEATURE_PRINCIPLE_1="TODO: define feature principle 1"
export HW_FEATURE_PRINCIPLE_2="TODO: define feature principle 2"
export HW_FEATURE_PRINCIPLE_3="TODO: define feature principle 3"
export HW_FIELD_1="fieldOne"
export HW_FIELD_2="fieldTwo"
export HW_FIELD_3="fieldThree"
export HW_PRODUCT_QUESTION_1="TODO: define product question 1"
export HW_PRODUCT_QUESTION_2="TODO: define product question 2"
export HW_PRODUCT_QUESTION_3="TODO: define product question 3"
export HW_TECHNICAL_QUESTION_1="TODO: define technical question 1"
export HW_TECHNICAL_QUESTION_2="TODO: define technical question 2"
export HW_TECHNICAL_QUESTION_3="TODO: define technical question 3"
export HW_GENERIC_FAILURE_MODE="$generic_failure_mode"
export HW_PRIMARY_USER_GOAL="$primary_user_goal"
export HW_CONTENT_REVIEW_STATUS_RULE="$content_review_status_rule"
export HW_FEEDBACK_REASONING_RULE="$feedback_reasoning_rule"

find AGENTS.md README.md README.zh-CN.md docs -type f -name '*.md' -print0 |
  xargs -0 perl -0pi -e '
    s/\{PROJECT_NAME\}/$ENV{HW_PROJECT_NAME}/g;
    s/\{DOMAIN\}/$ENV{HW_DOMAIN}/g;
    s/\{PRIMARY_USER\}/$ENV{HW_PRIMARY_USER}/g;
    s/\{MVP_FOCUS\}/$ENV{HW_MVP_FOCUS}/g;
    s/\{NON_GOALS\}/$ENV{HW_NON_GOALS}/g;
    s/\{PROJECT_SUMMARY\}/$ENV{HW_PROJECT_SUMMARY}/g;
    s/\{PRIMARY_USER_PROBLEM\}/$ENV{HW_PRIMARY_USER_PROBLEM}/g;
    s/\{PRODUCT_PROMISE\}/$ENV{HW_PRODUCT_PROMISE}/g;
    s/\{SUCCESS_CRITERION_1\}/$ENV{HW_SUCCESS_CRITERION_1}/g;
    s/\{SUCCESS_CRITERION_2\}/$ENV{HW_SUCCESS_CRITERION_2}/g;
    s/\{SUCCESS_CRITERION_3\}/$ENV{HW_SUCCESS_CRITERION_3}/g;
    s/\{IN_SCOPE_1\}/$ENV{HW_IN_SCOPE_1}/g;
    s/\{IN_SCOPE_2\}/$ENV{HW_IN_SCOPE_2}/g;
    s/\{IN_SCOPE_3\}/$ENV{HW_IN_SCOPE_3}/g;
    s/\{OUT_OF_SCOPE_1\}/$ENV{HW_OUT_OF_SCOPE_1}/g;
    s/\{OUT_OF_SCOPE_2\}/$ENV{HW_OUT_OF_SCOPE_2}/g;
    s/\{OUT_OF_SCOPE_3\}/$ENV{HW_OUT_OF_SCOPE_3}/g;
    s/\{MVP_LOOP_STEP_1\}/$ENV{HW_MVP_LOOP_STEP_1}/g;
    s/\{MVP_LOOP_STEP_2\}/$ENV{HW_MVP_LOOP_STEP_2}/g;
    s/\{MVP_LOOP_STEP_3\}/$ENV{HW_MVP_LOOP_STEP_3}/g;
    s/\{MVP_LOOP_STEP_4\}/$ENV{HW_MVP_LOOP_STEP_4}/g;
    s/\{PRIMARY_FLOW_STEP_1\}/$ENV{HW_PRIMARY_FLOW_STEP_1}/g;
    s/\{PRIMARY_FLOW_STEP_2\}/$ENV{HW_PRIMARY_FLOW_STEP_2}/g;
    s/\{PRIMARY_FLOW_STEP_3\}/$ENV{HW_PRIMARY_FLOW_STEP_3}/g;
    s/\{PRIMARY_FLOW_STEP_4\}/$ENV{HW_PRIMARY_FLOW_STEP_4}/g;
    s/\{EDGE_FLOW_1\}/$ENV{HW_EDGE_FLOW_1}/g;
    s/\{EDGE_FLOW_2\}/$ENV{HW_EDGE_FLOW_2}/g;
    s/\{EDGE_FLOW_3\}/$ENV{HW_EDGE_FLOW_3}/g;
    s/\{CORE_LOOP_STEP_1\}/$ENV{HW_CORE_LOOP_STEP_1}/g;
    s/\{CORE_LOOP_STEP_2\}/$ENV{HW_CORE_LOOP_STEP_2}/g;
    s/\{CORE_LOOP_STEP_3\}/$ENV{HW_CORE_LOOP_STEP_3}/g;
    s/\{CORE_LOOP_STEP_4\}/$ENV{HW_CORE_LOOP_STEP_4}/g;
    s/\{FEATURE_PRINCIPLE_1\}/$ENV{HW_FEATURE_PRINCIPLE_1}/g;
    s/\{FEATURE_PRINCIPLE_2\}/$ENV{HW_FEATURE_PRINCIPLE_2}/g;
    s/\{FEATURE_PRINCIPLE_3\}/$ENV{HW_FEATURE_PRINCIPLE_3}/g;
    s/\{FIELD_1\}/$ENV{HW_FIELD_1}/g;
    s/\{FIELD_2\}/$ENV{HW_FIELD_2}/g;
    s/\{FIELD_3\}/$ENV{HW_FIELD_3}/g;
    s/\{PRODUCT_QUESTION_1\}/$ENV{HW_PRODUCT_QUESTION_1}/g;
    s/\{PRODUCT_QUESTION_2\}/$ENV{HW_PRODUCT_QUESTION_2}/g;
    s/\{PRODUCT_QUESTION_3\}/$ENV{HW_PRODUCT_QUESTION_3}/g;
    s/\{TECHNICAL_QUESTION_1\}/$ENV{HW_TECHNICAL_QUESTION_1}/g;
    s/\{TECHNICAL_QUESTION_2\}/$ENV{HW_TECHNICAL_QUESTION_2}/g;
    s/\{TECHNICAL_QUESTION_3\}/$ENV{HW_TECHNICAL_QUESTION_3}/g;
    s/\{GENERIC_FAILURE_MODE\}/$ENV{HW_GENERIC_FAILURE_MODE}/g;
    s/\{PRIMARY_USER_GOAL\}/$ENV{HW_PRIMARY_USER_GOAL}/g;
    s/\{CONTENT_REVIEW_STATUS_RULE\}/$ENV{HW_CONTENT_REVIEW_STATUS_RULE}/g;
    s/\{FEEDBACK_REASONING_RULE\}/$ENV{HW_FEEDBACK_REASONING_RULE}/g;
  '

echo "Replaced common HarnessWeaver placeholders."
echo "Next: edit TODO values, then run: bash scripts/verify.sh --instance"
