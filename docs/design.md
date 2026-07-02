# Design Standards

## Purpose

This file defines project-specific design standards for `{PROJECT_NAME}`. Refine these standards before product UI work starts.

Use this file for product experience rules that should shape screens, flows, states, language, accessibility, and visual density. Keep reusable workflow rules in `docs/meta/`, harness rules in `docs/harness/`, and domain safety or product guardrails in `docs/domain/PROJECT_RULES.md`.

## Product Experience

- Primary user: `{PRIMARY_USER}`
- MVP focus: `{MVP_FOCUS}`
- The design should support `{PRIMARY_USER_GOAL}`.
- The design must not become `{GENERIC_FAILURE_MODE}`.

## Interaction Standards

- Start with the smallest complete MVP loop before adding secondary surfaces.
- Make core user actions visible, reversible where appropriate, and easy to verify.
- Include empty, loading, error, invalid action, success, and completion states when the UI exists.
- Preserve review or placeholder status when content is not final.

## Visual Standards

- Prefer clear hierarchy, readable density, and domain-appropriate tone over decorative complexity.
- Use layout and labels that help the primary user decide what to do next.
- Avoid generic landing-page polish unless the PRD explicitly calls for a marketing surface.

## Accessibility Standards

- Keep keyboard access, visible focus, text alternatives, and readable contrast in scope for UI tasks.
- Document any accessibility limitation in the task handoff if it cannot be resolved in the current slice.

## Verification Questions

- Does the design support the MVP loop?
- Are required UI states represented or intentionally deferred?
- Does the design preserve domain-specific rules from `docs/domain/PROJECT_RULES.md`?
- Is the experience specific to `{PROJECT_NAME}` rather than a generic app?
