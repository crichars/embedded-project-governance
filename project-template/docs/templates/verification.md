# VER-XXX: Verification Record

## Identity

- Requirement / task:
- Git commit:
- Date and operator:
- MCU / silicon revision:
- Board / revision / serial:
- Toolchain and version:
- Build configuration and command:
- Test equipment and setup:
- Host tool/version/configuration and physical link:
- Evidence identity when no Git commit exists:

## Requirement Trace

| Requirement / AC | Test / analysis | Expected | Actual evidence | Result |
|---|---|---|---|---|
| | | | | PASS / FAIL / SKIP |

## Resource And Timing Evidence

| Metric | Limit | Method / command | Actual | Result |
|---|---:|---|---:|---|
| Flash | | | | |
| RAM / BSS / data | | | | |
| Stack peak | | | | |
| CPU / WCET / latency | | | | |
| Power | | | | |

## Failure And Boundary Evidence

- Invalid / minimum / maximum input:
- Timeout / disconnect / malformed frame:
- Reset / watchdog / power interruption:
- Flash/NVM corruption or full condition:
- ISR/task/DMA race or stress:
- Calibration / tolerance / temperature condition:
- Recovery and next-valid-operation check:

## Defects

| ID | Severity | Description | Status | Retest evidence |
|---|---|---|---|---|
| | | | | |

## Skipped Checks And Residual Risk

| Check / risk | Why skipped or unresolved | Consequence | Owner / trigger to revisit |
|---|---|---|---|
| | | | |

## Acceptance

- Final state: Build Passed / Host Verified / HW Verified / Accepted / Rejected
- Accepted by:
- [ ] Every PASS has reproducible evidence.
- [ ] Every SKIP has an explicit residual risk.
- [ ] Evidence matches this exact commit, target, and configuration.
