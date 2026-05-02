---
name: embedded-testing-strategy
description: Detailed prompt for planning comprehensive testing strategies for embedded firmware
license: 'Complete terms in LICENSE.txt'
---

# Embedded Testing Strategy Prompt

Use this prompt when planning comprehensive testing for embedded firmware.

## Testing Context

You are planning tests for embedded firmware with specific requirements:

**Fill in these details:**

- **Target Platform**: [STM32F4, ESP32, nRF52, etc.]
- **Codebase Size**: [Approximate lines of code]
- **Critical Components**: [Which modules are safety-critical]
- **Hardware Available for Testing**: [Actual boards, simulators, etc.]
- **Development Team Size**: [1 person, small team, large team]
- **Target Code Coverage**: [%]
- **CI/CD Environment**: [GitHub Actions, GitLab CI, Jenkins, etc.]

## Testing Pyramid for Embedded Systems

```
                    /\
                   /  \        System/HIL Tests
                  /────\       (Real hardware or simulator)
                 /      \      [2-5% of tests, 15-30% of time]
                /        \
               /──────────\
              /            \    Integration Tests
             /              \   (Module combinations)
            /                \  [10-20% of tests, 20-40% of time]
           /──────────────────\
          /                    \
         /                      \ Unit Tests
        /________________________\ (Individual functions/modules)
                                  [70-85% of tests, 40-60% of time]
```

## Unit Testing Planning

### 1. Testable Code Structure

Identify modules that need unit tests:

```
Modules to Unit Test:
- Module 1: [Name, purpose, functions]
  - Function 1.1: [Description]
  - Function 1.2: [Description]
  
- Module 2: [Name, purpose, functions]
  - Function 2.1: [Description]
  - Function 2.2: [Description]
```

### 2. Mocking and Stubbing Strategy

For each module, identify what needs mocking:

```
Module: Motor Driver
├── Dependencies:
│   ├── HAL_GPIO_WritePin() → Mock as global function pointer
│   ├── HAL_Timer_SetPWM() → Mock with static variable capture
│   └── temperature_sensor_read() → Stub with configurable return values
└── Mocking approach:
    ├── Dependency injection for hardware calls
    ├── Function pointers for HAL functions
    └── Configuration for sensor data
```

### 3. Unit Test Coverage Strategy

For each critical function:

- **Normal Cases**: [Test successful path]
- **Boundary Cases**: [Min, max, zero values]
- **Error Cases**: [Invalid inputs, error conditions]
- **Edge Cases**: [Overflow, underflow, timeout]
- **State Transitions**: [Changing states]

Example:
```
Function: motor_speed_set(int speed_percent)

Test Cases:
✓ Normal: speed_set(50) → PWM set to 50%
✓ Boundary: speed_set(0) → Motor stops
✓ Boundary: speed_set(100) → Max PWM
✓ Error: speed_set(150) → Returns ERROR_OUT_OF_RANGE
✓ Error: speed_set(-10) → Returns ERROR_INVALID_INPUT
✓ State: speed_set(50) → speed_set(0) → Check ramping disabled
```

### 4. Test Framework Selection

Choose based on constraints:

| Framework | Language | Style | Good for |
|-----------|----------|-------|----------|
| Unity | C | Simple, light | Single test file per module |
| CMocka | C | Mocking-heavy | Complex mocking needs |
| GoogleTest | C++ | Modern, rich | Large embedded C++ projects |
| CppUTest | C/C++ | BDD-style | Team unfamiliar with unit testing |
| Catch2 | C++ | Modern, header-only | C++ embedded code |

Decision: [Framework] because [reason]

### 5. Test Infrastructure

Design how tests will run:

```
Build Configuration:
├── Host Compiler: [GCC, Clang]
├── Test Runner: [Ceedling, CMake test, Custom]
├── Coverage Tool: [gcov, lcov, Codecov]
├── Continuous Integration: [GitHub Actions, etc.]
└── Reporting: [HTML reports, coverage dashboards]

Test Execution:
1. Build firmware with test configuration
2. Run unit tests on host machine
3. Capture coverage data
4. Generate coverage reports
5. Fail CI if coverage < target
```

## Integration Testing Planning

### 1. Subsystem Integration Tests

Identify subsystems and their interactions:

```
Subsystem 1: Motor Control
├── Modules: Driver, Speed Controller, Position Tracker
├── Dependencies: ADC (analog input), Timer (PWM output)
└── Test Scenarios:
    - Speed ramp: 0 → 100% → 0
    - Position tracking with feedback
    - Error recovery

Subsystem 2: Communication
├── Modules: UART driver, Protocol handler, Command parser
├── Dependencies: None
└── Test Scenarios:
    - Valid commands
    - Malformed packets
    - Timeout conditions
```

### 2. Integration Test Scenarios

For each subsystem interaction:

```
Test: Motor speed command via UART
1. Send command: "SPEED=75\n"
2. Verify: PWM output is 75%
3. Verify: Motor feedback increases
4. Verify: Status response sent back

Test: Emergency stop
1. Motor running at 80%
2. Send emergency stop command
3. Verify: PWM immediately goes to 0
4. Verify: Position tracking stops
5. Verify: Status shows STOPPED
```

### 3. Mock Hardware/Simulator

Design mocks for hardware interaction:

```
Mocked ADC:
- Returns configurable values
- Can simulate sensor failures
- Can simulate noise/outliers

Mocked Timer/PWM:
- Captures PWM duty cycle values
- Can verify frequency
- Can simulate timer interrupts

Mocked UART:
- Captures transmitted data
- Can inject received data
- Can simulate communication errors
```

## Hardware-in-the-Loop (HIL) Testing

### 1. Hardware Setup

```
Test Equipment:
├── Target Board: [STM32F4 Discovery, custom board, etc.]
├── Programmer: [ST-Link, J-Link, etc.]
├── Debug Probe: [OpenOCD, GDB, vendor tool]
├── Sensors/Actuators: [Motor, temperature probe, etc.]
├── Power Supply: [Specifications]
└── Test Environment: [Ambient conditions]
```

### 2. HIL Test Scenarios

Identify real hardware tests:

```
Test 1: Motor speed response
- Setup: Motor loaded with flywheel
- Action: Command 50% speed
- Verify: Acceleration time < 100ms
- Verify: Speed reaches 50% within 5%
- Verify: No stalling or noise

Test 2: Temperature monitoring
- Setup: Heat sink near temperature sensor
- Action: Heat sensor from 25°C to 80°C
- Verify: Reading accuracy ± 2°C
- Verify: Over-temperature shutdown triggers

Test 3: Power reset resilience
- Setup: Motor running
- Action: Abruptly remove power and restore
- Verify: Motor stops safely
- Verify: No memory corruption
- Verify: Resume running correctly
```

### 3. Automated HIL Testing

Design automation:

```
Test automation with CI:
1. Flash firmware to board via OpenOCD
2. Run HIL tests via serial protocol
3. Capture measurements (ADC values, PWM frequency)
4. Verify test passed/failed
5. Report results to CI dashboard
6. Fail build if HIL tests fail
```

## Code Coverage Planning

### 1. Coverage Targets

```
Coverage Goals:
- Line coverage: 80% (minimize untested code)
- Branch coverage: 70% (verify decision points)
- Critical paths: 100% (motor control, safety functions)
- Exception paths: 90% (error handling)
```

### 2. Coverage Analysis

```
Tools:
- GCC: Use -fprofile-arcs -ftest-coverage
- Coverage reporting: lcov, gcov
- Dashboard: CodeCov, Coveralls

Metrics:
- Coverage trend over time
- Coverage per module
- Missing coverage identification
- Root cause analysis for gaps
```

## Test Plan Timeline

```
Phase 1: Unit Test Infrastructure (Week 1-2)
├── Set up test framework
├── Design mocking strategy
└── Write test utilities

Phase 2: Unit Tests (Week 2-4)
├── Test Module A: [Estimate 20 tests]
├── Test Module B: [Estimate 15 tests]
└── Test Module C: [Estimate 25 tests]

Phase 3: Integration Tests (Week 4-5)
├── Subsystem A tests
├── Subsystem B tests
└── End-to-end tests

Phase 4: HIL Tests (Week 5-6)
├── Hardware setup
├── HIL test development
└── Test execution and debugging

Phase 5: Continuous Improvement (Ongoing)
├── Coverage analysis
├── Regression testing
└── Test maintenance
```

## Test Execution in CI/CD

```
GitHub Actions Workflow:
1. On push:
   - Build firmware
   - Run unit tests on host
   - Report coverage
   - Fail if coverage < 80%
   
2. On PR:
   - Build firmware
   - Run unit tests
   - Report coverage change
   - Block merge if tests fail
   
3. Nightly:
   - Build firmware
   - Run unit + integration tests
   - Flash to hardware if available
   - Run HIL tests
   - Generate comprehensive report
```

## Test Documentation

For each test:

```markdown
### Test: Motor Speed Ramp

**Objective**: Verify motor accelerates smoothly from 0 to 100%

**Prerequisites**:
- Motor connected and calibrated
- Power supply providing 5V

**Steps**:
1. Set motor speed to 0%
2. Increment speed 10% every 100ms
3. Verify PWM output increases proportionally
4. Verify motor position feedback increases

**Expected Result**: Motor reaches 100% in < 1 second without jitter

**Actual Result**: [To be filled during testing]

**Status**: PASS / FAIL
```

## Risk Mitigation

```
Risk 1: Incomplete test coverage
- Mitigation: Automated coverage reports in CI
- Acceptance: Coverage ≥ 80% before release

Risk 2: Hardware not available for testing
- Mitigation: Simulator-based testing as fallback
- Acceptance: Unit + integration tests on simulator

Risk 3: Real-time deadline violations undetected
- Mitigation: Performance benchmarking in HIL tests
- Acceptance: Timing margin verification in all tests
```

---

See [testing-planner.agent.md](../agents/testing-planner.agent.md) for how this prompt is used in testing planning workflows.
