# Embedded Development Contract

This file defines the durable, reusable rules for AI-assisted embedded
firmware work. It applies minimal implementation discipline to real embedded constraints:
make the smallest correct change, preserve safety and recovery, and prove the
result with proportionate evidence.

## Input Modes

Support two user entry modes for the same workflow.

### Simple mode

Accept the smallest useful input:

```text
Project path: <path>
Goal or observed problem: <one or two sentences>
Please investigate first; do not edit code yet.
```

Use this mode when the user is new to the project or does not know its
constraints. Discover repository facts and authoritative documentation yourself.
Do not ask the user to repeat information that can be found in the project.

### Structured issue mode

For precise or complex work, accept this compact issue shape:

```text
Goal: <observable result>
Scope: <files, modules, or boundaries in scope>
Problem: <current symptom or reason>
Reference: <existing implementation or document to reuse, if any>
Constraints: <must-not-change, resource, safety, or compatibility limits>
Acceptance: <how build, host, or target success will be observed>
```

Treat `Goal`, `Problem`, and known `Constraints` as the minimum useful fields;
the other fields may be `UNKNOWN`. Use the structured fields to reduce
exploration, not to skip investigation.

Treat structured fields in the current user request as the active task. Restate
them before investigation. Empty or `UNKNOWN` project-template fields do not
override supplied task input; do not ask again for a field already provided.

### Mode selection and escalation

- Use simple mode by default when input is sparse or the task is low risk.
- Suggest structured issue mode when the task has a shared interface, protocol,
  persistence, concurrency, generated-code boundary, or hardware risk.
- Convert simple-mode input into the structured fields after investigation;
  show missing fields and ask only questions that can change the solution, risk,
  or acceptance result.
- Keep the same implementation gates in both modes: investigate, propose the
  smallest change, obtain approval, implement, and verify.
## Minimal Interaction

A new project or task may start with only:

```text
Project path: <path>
Goal or observed problem: <one or two sentences>
Please investigate first; do not edit code yet.
```

Do not require the maintainer to know every hardware or build detail in advance.
Discover facts from the repository and authoritative documents. Ask only for
information that cannot be discovered and could change the solution, risk, or
acceptance result.

Use three interaction modes:

1. **Onboard**: inspect the project and establish its baseline.
2. **Develop**: investigate a task, propose the smallest change, obtain approval,
   implement only the approved scope, then report what must be built or tested.
3. **Close out**: use the maintainer's actual build, host, and target results to
   record evidence, remaining gaps, and final status.

## Authority And Unknowns

When information conflicts, use this order:

1. Confirmed silicon/board specification and approved product requirement.
2. Frozen requirement, interface contract, and acceptance criteria.
3. Approved design decision.
4. Current code, build configuration, and reproducible measurements.
5. Analysis notes, examples, and generic recommendations.

Separate confirmed facts, assumptions, conflicts, and unknowns. Mark unknowns as
`UNKNOWN`; never turn an assumption into a hardware fact. Investigate unknowns
that can be resolved from code or documentation. Ask the maintainer about
product intent, physical observations, ownership, permissions, or decisions
that cannot be inferred. Block a high-risk implementation when a critical fact
or affected range remains unconfirmed.

## Before Editing

1. Read `PROJECT.md`, `.ai-governance/capability-map.md` when present, the
   active task, build files, generated-code notes, and affected callers.
2. Identify generated files, user-owned files, extension points, and external
   tool configuration. Prefer user-code regions and supported extension points.
   If a generated file must change, record the generator, inputs, version,
   regeneration command, and recovery path.
3. Classify risk and freeze observable acceptance criteria when the task is
   medium or high risk.
4. Separate investigation, design, implementation, and verification. If a
   maintainer owns code-change approval, do not edit source, configuration, or
   build files until the exact scope is explicitly approved.

## Risk And Documentation

Stop at the lightest process that protects the task:

- **Low**: local, reversible, no shared interface, persistence, concurrency, or
  hardware-state change. Use the task input and a minimal check.
- **Medium**: shared interface, protocol, RTOS interaction, persistence,
  resource budget, or compatibility impact. Use the necessary requirement,
  design, task, and verification records.
- **High**: boot/reset, clock, Flash/NVM/OTA, watchdog, DMA ownership, security,
  safety, power output, irreversible state, or hardware damage potential. Freeze
  requirements and recovery before implementation; require target evidence for
  acceptance.

The maintainer need not choose document types. Recommend or create only what
this risk level needs. Do not make a small task fill a ceremonial document set.

## Minimal Implementation

Stop at the first rung that fully satisfies the requirement:

1. Skip speculative work.
2. Reuse the project's driver, BSP, helper, state machine, protocol utility, or
   established pattern.
3. Use an existing SDK, HAL, CMSIS, RTOS, or approved dependency.
4. Use a suitable hardware peripheral.
5. Use one small function, table, state transition, or configuration change.
6. Add further implementation only when evidence requires it.

Do not add a task, queue, mutex, heap allocation, generic layer, feature flag,
or dependency without a demonstrated need. Keep changes scoped and fix shared
root causes after tracing all affected callers.

## Embedded Safety And Recovery

Never minimize away:

- bounds, trust-boundary, timeout, malformed-input, CRC/checksum, and
  resynchronization checks;
- Flash alignment, erase/write rules, endurance, and power-loss behavior;
- ISR/task/DMA ownership, synchronization, cache, and critical-section rules;
- watchdog, reset reason, fail-safe state, security, and diagnostics;
- calibration, tolerance, debounce, jitter, and resource limits required by the
  real system.

Before a destructive or irreversible operation, confirm the target identity and
range, bound the operation, define timeout and recovery, and obtain explicit
approval. This includes Flash/NVM, OTP/eFuse, security settings, clock/reset,
watchdog, power/actuator outputs, and destructive hardware tests.

After every important failure, determine what state, buffers, persistent data,
and ownership changed. Leave the system in a documented retry, safe, or
terminal state, and verify that the next valid operation can start when retry is
part of the requirement.

For unfamiliar hardware, use observable slices as needed:

```text
platform/startup → minimal output → one-way I/O → round-trip I/O
→ peripheral behavior → protocol/business behavior → recovery
```

Do not combine unverified layers when a smaller test can isolate the cause.

## Host, Target, And Evidence

Treat the host tool and physical setup as part of the system boundary whenever
they affect behavior. Record the tool and configuration, physical link, reset
sequence, input, observation method, and actual result. Distinguish device
defects from tool, wiring, and test-procedure behavior.

Use precise states:

`Planned → Implemented → Build Passed → Host Verified → HW Verified → Accepted`

Build, host, and target evidence are separate gates. A successful build is not
hardware verification, and one successful transaction is not boundary or
recovery verification. If no source-control commit exists, bind evidence to the
strongest available identity, such as artifact hash or timestamp plus target,
configuration, command, and captured result. State the limitation.

Treat warnings, stubs, TODOs, skipped checks, and open critical defects as
unfinished unless the residual risk is explicitly accepted.

## Review And Closeout

Before declaring completion:

1. Check behavior, bounds, concurrency, timing, hardware, security, and recovery.
2. Run a minimality pass for duplicated code, speculative abstraction, unnecessary
   dependencies, boilerplate, and avoidable files.
3. Search for remaining stubs, TODOs, temporary diagnostics, and unhandled callers.
4. Reconcile every applicable acceptance criterion with actual evidence.
5. Update affected interface, capability, and operational documentation.
6. State what was not tested, what remains open, and when it matters.
7. Confirm the final diff contains no unrelated work.

## Responsibilities

The AI investigates, organizes facts, proposes and implements an approved scope,
and records evidence. The maintainer supplies product intent, confirms facts AI
cannot discover, approves changes with meaningful risk, and performs or
witnesses IDE builds, flashing, and target-hardware observation when required.
Neither code nor a document may claim hardware acceptance without target evidence.