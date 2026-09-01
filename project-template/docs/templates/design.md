# DES-XXX: Implementation Design

> Use for medium/high-risk work. Do not design before reading the actual code path.

## 1. Inputs

- Requirement:
- Baseline commit:
- Relevant specifications:
- Risk level and reason:

## 2. As-Is Investigation

| Area / path | Confirmed behavior | Evidence | Reuse decision |
|---|---|---|---|
| | | | Reuse / Modify / Remove / Add |

## 3. Capability Check

- Existing project capability:
- MCU SDK / HAL / CMSIS / RTOS capability:
- Hardware peripheral option:
- Approved dependency option:
- Why new code is still necessary:

## 4. Recommended Minimum Design

- Control and data flow:
- State transitions:
- Error and recovery behavior:
- Concurrency / ISR / DMA ownership:
- Memory and timing budget:
- Persistent-data and power-loss behavior:

## 5. Alternatives Rejected

| Alternative | Reason rejected | Reconsider when |
|---|---|---|
| | | |

## 6. Impact And Compatibility

- Files / modules:
- Public interfaces:
- Persistent formats:
- Boot / update compatibility:
- Diagnostics / operations:

## 7. Risks, Signals, Recovery

| Risk | Severity | Detection / observation | Prevention | Recovery / rollback |
|---|---|---|---|---|
| | | | | |

## 8. Implementation Slices

| Step | Minimal change | Dependency | Verification / AC | Rollback point |
|---|---|---|---|---|
| 1 | | | | |

## 9. Design Gate

- [ ] Every design element maps to a requirement or constraint.
- [ ] No speculative abstraction or feature remains.
- [ ] Hardware facts and addresses are confirmed or explicitly blocked.
- [ ] Resource estimates state how they will be measured.
- [ ] High-risk failure paths have observation and recovery methods.
- [ ] Acceptance criteria map to implementation slices.
