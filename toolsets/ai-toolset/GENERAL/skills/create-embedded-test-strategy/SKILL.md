---
name: create-embedded-test-strategy
description: 'Create comprehensive testing strategies for embedded firmware. Use when asked about embedded testing, firmware testing, unit testing for embedded systems, hardware-in-the-loop testing, test infrastructure, test frameworks, mocking hardware in tests, CI/CD testing for firmware, real-time testing, integration testing for embedded systems, or coverage planning for microcontroller code.'
license: 'Complete terms in LICENSE.txt'
---

# Embedded Testing Strategy Skill

Create comprehensive testing strategies for embedded firmware systems.

## When to Use This Skill

Activate this skill when users ask about:

- **Testing Strategy**: "Create testing strategy for STM32F4 firmware"
- **Unit Testing**: "Plan unit tests for embedded C code with hardware mocks"
- **Hardware Testing**: "Design hardware-in-the-loop testing approach"
- **Test Infrastructure**: "Set up test framework for embedded project"
- **Coverage Goals**: "Plan code coverage strategy for firmware"
- **Integration Tests**: "Create integration test scenarios for multi-module firmware"
- **CI/CD Testing**: "Automate testing in GitHub Actions for firmware"
- **Test Tools**: "Choose testing framework for embedded systems (Unity, CMocka, GoogleTest)"
- **Mock Hardware**: "Plan mocking strategy for hardware dependencies"
- **Real-Time Testing**: "Test real-time deadline achievement"

## What This Skill Includes

### 1. Testing Pyramid for Embedded Systems
- **Unit Tests** (70-85% of tests): Individual functions with mocks
- **Integration Tests** (10-20% of tests): Module interactions
- **Hardware Tests** (2-5% of tests): Real hardware or simulator

### 2. Test Strategy Components
- Testability assessment of codebase
- Mocking and stubbing strategy
- Test framework selection
- Unit test coverage planning
- Integration test scenarios
- Hardware-in-the-loop test design
- Code coverage goals and measurement
- Test automation in CI/CD
- Test metrics and dashboards

### 3. Mocking Strategy
- Hardware abstraction for testing
- Dependency injection patterns
- Mock peripheral creation
- Stub sensor data
- Simulate error conditions
- Test isolation techniques

### 4. CI/CD Integration
- Automated unit tests on host
- Integration tests in pipeline
- Hardware tests with CI runners
- Coverage reports and trends
- Build fail on insufficient coverage
- Test result dashboards

### 5. Output
Detailed testing strategy plan including:
- Test pyramid breakdown
- Unit test requirements and mocking strategy
- Integration test scenarios
- Hardware test setup
- Test framework and tools selection
- Code coverage goals
- Test infrastructure design
- CI/CD pipeline integration
- Test timeline and milestones
- Risk mitigation for untestable code

## Key Features

✅ **Testability by Design**
- Hardware abstraction for testing
- Dependency injection patterns
- Mock-friendly code structure
- Isolation of units

✅ **Comprehensive Coverage**
- Line coverage targets
- Branch coverage targets
- Critical path 100% coverage
- Exception handling coverage

✅ **Real-Time Testing**
- Performance benchmarking
- Timing deadline validation
- Interrupt latency testing
- Context switch overhead measurement

✅ **Automation Ready**
- Framework selection guidance
- CI/CD integration patterns
- Automated test execution
- Coverage trend analysis

## Example Usage

```
User: "Create testing strategy for RTOS-based motor control firmware"

Skill will generate:
├── Unit testing approach with 3 test frameworks comparison
├── Mocking strategy for motor driver, ADC, and timer
├── Integration test scenarios:
│   ├── Speed ramp: 0 → 100% → 0
│   ├── Emergency stop
│   └── Temperature monitoring
├── Hardware-in-the-loop tests on real motor
├── Coverage goals: 80% line, 70% branch
├── Test infrastructure with CMake + Catch2
├── GitHub Actions CI/CD pipeline
├── Timeline and risk assessment
└── Performance benchmark requirements
```

## Integration with Other Components

- Works with **embedded-planner** to design testable architecture
- Works with **se-embedded-security** for security test cases
- Works with **se-performance-reviewer** for performance benchmarking
- Works with **se-devops-embedded** to automate in CI/CD

## How to Request This Skill

```
"Create testing strategy for [embedded system description]"
"Design unit tests with mocks for [firmware module]"
"Plan hardware-in-the-loop testing for [hardware component]"
```

No need to explicitly invoke `@create-embedded-test-strategy`. Copilot activates this skill automatically when it recognizes your request.

## Related Resources

- [embedded-testing.prompt.md](../../prompts/embedded-testing.prompt.md) - Detailed testing planning prompts and examples
- [testing-planner.agent.md](../../agents/testing-planner.agent.md) - Planner agent for creating testing strategies
- [AGENT-COORDINATION.md](../../AGENT-COORDINATION.md) - How skills integrate with agents
