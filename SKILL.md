---
name: embedded-project-governance
description: A lightweight, risk-scaled workflow for AI-assisted embedded firmware development. Use when onboarding an embedded project, investigating or implementing firmware changes, working around generated code, handling shared interfaces, protocols, Flash/NVM, boot, DMA, ISR/RTOS concurrency, hardware bring-up, recovery, or target verification. Supports minimal user input and structured Issue-style tasks.
---

# Embedded Project Governance

Use this skill to keep embedded firmware changes minimal, authorized, and
verifiable. It complements the project's `AGENTS.md`; it does not replace chip
specifications, project facts, hardware judgment, IDE operation, flashing, or
target-board testing.

## Start With The Smallest Useful Input

Accept either:

```text
Project path: <path>
Goal or observed problem: <one or two sentences>
Please investigate first; do not edit code yet.
```

or the structured form:

```text
Goal: <observable result>
Scope: <files, modules, or boundaries>
Problem: <current symptom or reason>
Reference: <existing implementation or document>
Constraints: <must-not-change, resource, safety, or compatibility limits>
Acceptance: <how success will be observed>
```

Do not ask the user to provide facts that can be discovered from the repository
or authoritative documents. Mark unresolved information as `UNKNOWN` and ask
only questions that can change the design, risk, or acceptance result.

Treat fields in the current user request as the active task. Restate the parsed
fields before investigation; an unfilled project template must not erase them.
Do not ask again for a field the user already provided.

## Initialize A Project When Requested

When the user explicitly asks to add the governance files to a project, run:

```powershell
.\scripts\init-project.ps1 -ProjectPath <project-path>
```

Run the script from this skill's directory. By default it preserves existing
files. Never use `-Force` unless the user explicitly approves overwriting the
listed target files. Do not initialize a project merely because this skill was
invoked; the workflow can inspect an existing project without copying files.

After initialization, read the created `AGENTS.md`, `PROJECT.md`, and capability
map before proposing changes. Treat `project-template/` as output material, not
as additional skill instructions to load into every task.

## Workflow

1. Read the project's `AGENTS.md`, `PROJECT.md`, capability map when present,
   active task, build files, and affected code.
2. Report confirmed facts, assumptions, conflicts, unknowns, existing reusable
   capabilities, generated-code boundaries, and risk.
3. Choose the lightest process that protects the task. Use the project's task,
   requirement, design, and verification templates only as needed.
4. Propose the smallest change and observable acceptance conditions. Do not edit
   source, configuration, or build files until the approved scope is explicit.
5. Implement only the approved scope, reusing existing drivers, BSP, SDK, HAL,
   RTOS, utilities, and supported generated-code extension points.
6. Ask the maintainer to build, flash, and observe the target when required.
7. Record actual evidence, skipped checks, open items, and residual risk. Do not
   call a build or a single successful transaction hardware acceptance.
8. Run a correctness review and a minimality review for unnecessary complexity.

## Risk Gates

Treat startup/reset, Flash/NVM/OTA, watchdog, DMA ownership, security, safety,
power/actuator output, and irreversible operations as high risk. Before such an
operation, confirm the target and range, bound the action, define timeout and
recovery, and obtain explicit approval. After important failures, verify the
system is retryable, safe, or explicitly terminal.

For Flash/NVM work, confirm the storage type and layout, target range, erase and
write granularity and alignment, endurance, integrity or atomicity, power-loss
recovery, ownership, and target verification method before implementation.

Use the project status ladder:

`Planned -> Implemented -> Build Passed -> Host Verified -> HW Verified -> Accepted`

Keep project-specific facts in project files and keep this workflow reusable.