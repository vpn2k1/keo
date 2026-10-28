# AGENTS — Rules for AI Coding Agents

## Mission

Build the KEO offline Flutter + Flame MVP described in this repo, focusing on a playable, tested vertical slice before polish. Communicate with the project owner in Vietnamese.

## Required reading

Before editing, read `README.md`, `PROMPT.md`, `GAME_DESIGN.md`, `ARCHITECTURE.md`, `PLAN.md`, `TASKS.md`, `ACCEPTANCE_TESTS.md`.

## Guardrails

1. Deliver functioning source code, not explanations alone.
2. Do not add online systems, backend, monetization or unnecessary dependencies.
3. Keep domain/game rules testable without widgets.
4. Keep UI (Flutter) separated from simulation (Flame).
5. Keep level configuration in data classes and centralized constants.
6. Use actual installed package APIs, verify SDK compatibility; never claim build success without running commands.
7. After each completed task, update `TASKS.md` and describe what was tested.
8. For ambiguous minor choices, use simplest playable default; document decisions in code comments or README.
9. Do not make scope or architecture changes silently.
10. Work in increments; avoid making a large untestable patch.

## Definition of done per task

- Implementation merged into repository.
- Appropriate test added/updated.
- Formatting/analyze/test executed if toolchain available.
- Checklist updated truthfully.

## First assignment

Start with `PLAN.md` Phase 0 → Phase 1, prioritize successful playable loop, use circles/lines placeholders.
