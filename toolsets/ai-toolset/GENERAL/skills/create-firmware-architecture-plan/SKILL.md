---
name: create-firmware-architecture-plan
description: 'Create detailed firmware architecture plans for embedded systems. Use when asked to plan embedded system design, firmware architecture, microcontroller architecture, real-time systems architecture, hardware integration planning, RTOS design, memory layout planning, or embedded software design strategies for firmware, microcontrollers, STM32, ARM Cortex, or real-time embedded systems.'
license: 'Complete terms in LICENSE.txt'
---

# Firmware Architecture Plan Skill

Create comprehensive firmware architecture plans for embedded systems.

## When to Use This Skill

Activate this skill when users ask about:

- **Architecture Planning**: "Plan architecture for STM32H7 motor control system"
- **Firmware Design**: "Design firmware for real-time temperature controller"
- **Real-Time Systems**: "Architecture for RTOS-based system with hard deadlines"
- **Hardware Integration**: "Plan how to integrate ADC, CAN, and PWM in firmware"
- **Memory Planning**: "Memory layout for flash-constrained microcontroller"
- **Embedded Systems**: "Design embedded system for IoT device with WiFi"
- **Task Scheduling**: "Design task hierarchy for multi-task firmware"
- **Hardware Abstraction**: "Plan HAL for mixed peripheral firmware"

## What This Skill Includes

### 1. Planning Approach
- Analyze MCU constraints and capabilities
- Identify real-time requirements and deadlines
- Design task hierarchy and scheduling
- Plan memory layout and allocation
- Design hardware abstraction layer

### 2. Architecture Components
- Real-time task analysis
- Hardware constraint assessment
- Memory map design
- Interrupt and ISR planning
- Boot sequence design
- Module breakdown and dependencies
- Communication architecture

### 3. Output
Detailed firmware architecture plan in markdown format including:
- System overview and block diagrams
- Hardware constraints and specifications
- Real-time task definitions with deadlines
- Memory layout (ROM and RAM)
- Interrupt hierarchy and ISR planning
- Module specifications
- Implementation steps
- Risk assessment

## Key Features

✅ **Real-Time Analysis**
- Task period and deadline definition
- Worst-case execution time estimation
- Deadline satisfaction verification
- Scheduler design

✅ **Memory Optimization**
- ROM/Flash layout planning
- RAM allocation strategy
- Stack usage estimation
- Heap management strategy
- Memory footprint analysis

✅ **Hardware Integration**
- Peripheral mapping and configuration
- Clock tree design
- Power management strategy
- Interrupt priority assignment
- HAL design for testability

✅ **Embedded Best Practices**
- Watchdog and safety mechanism design
- Boot sequence planning
- Error handling strategy
- Performance considerations
- Power consumption optimization

## Example Usage

```
User: "Plan architecture for STM32F4 that controls a stepper motor with CAN communication"

Skill will generate:
├── System overview with block diagram
├── Hardware constraints (STM32F4 specifications)
├── Real-time requirements (motor control 1ms, CAN communication 10ms)
├── Memory layout (ROM: code/data, RAM: stack/heap)
├── Interrupt hierarchy
├── Module breakdown (Motor Driver, CAN Handler, Main Controller)
├── Task specifications
├── Boot sequence
└── Implementation steps
```

## Integration with Other Components

- Works with **testing-planner** to design testable architecture
- Works with **se-embedded-security** to address security from architecture level
- Works with **se-performance-reviewer** to optimize memory and timing
- Works with **se-devops-embedded** to plan build and deployment

## How to Request This Skill

```
"Create a firmware architecture plan for [embedded system description]"
"Plan the architecture for [MCU type] with [constraints]"
"Design a real-time system architecture for [application]"
```

No need to explicitly invoke `@create-firmware-architecture-plan`. Copilot activates this skill automatically when it recognizes your request.

## Related Resources

- [embedded-planning.prompt.md](../../prompts/embedded-planning.prompt.md) - Detailed planning prompts and examples
- [embedded-planner.agent.md](../../agents/embedded-planner.agent.md) - Planner agent for creating architecture plans
- [AGENT-COORDINATION.md](../../AGENT-COORDINATION.md) - How skills integrate with agents
