---
name: embedded-firmware-planning
description: Detailed prompt for planning embedded firmware architectures with real-time constraints, memory optimization, and hardware integration
license: 'Complete terms in LICENSE.txt'
---

# Embedded Firmware Planning Prompt

Use this prompt when planning firmware architecture for embedded systems.

## Planning Context

You are planning firmware for an embedded system with specific constraints:

**Fill in these details from the user's requirements:**

- **Target MCU/Processor**: [STM32H7, ARM Cortex-M4, RISC-V, etc.]
- **Available Memory**: ROM: [Size], RAM: [Size], EEPROM: [Size]
- **Peripherals**: [UART, CAN, SPI, ADC, Timer, etc.]
- **Real-Time Constraints**: [Periodic tasks with periods and deadlines]
- **Power Requirements**: [Battery-powered or mains, power budget if any]
- **Communication Protocols**: [CAN, Ethernet, Bluetooth, LoRa, etc.]
- **Safety Level**: [Non-critical, SIL1, SIL2, SIL3, Safety-critical]

## Architecture Planning Checklist

### 1. Real-Time Task Analysis

For each real-time requirement, define:

- **Task Name**: What does this task do?
- **Period**: How often does it run? (milliseconds or microseconds)
- **Deadline**: When must it complete? (relative to period)
- **Worst Case Execution Time (WCET)**: Maximum expected execution time
- **Priority**: Critical priority vs background task
- **Synchronization Needs**: Does it interact with other tasks?

Example:
```
Motor Control Task:
- Period: 1 ms
- Deadline: 0.9 ms (must complete before next period)
- Estimated WCET: 0.8 ms
- Priority: CRITICAL
- Sync: Synchronizes with ADC ISR and PWM feedback
```

### 2. Memory Layout Planning

Create a memory map:

```
ROM Layout:
┌─────────────────┐
│   Bootloader    │  [Size: ____ KB]
├─────────────────┤
│   Application   │  [Size: ____ KB]
├─────────────────┤
│   Data/Config   │  [Size: ____ KB]
├─────────────────┤
│   Free          │  [Size: ____ KB]
└─────────────────┘

RAM Layout:
┌─────────────────┐
│   .data section │  [Static variables, Size: ____ B]
├─────────────────┤
│   .bss section  │  [Zeroed variables, Size: ____ B]
├─────────────────┤
│   Heap          │  [Dynamic alloc, Size: ____ B]
├─────────────────┤
│   Stack         │  [Reserved: ____ B]
├─────────────────┤
│   Free          │  [Size: ____ B]
└─────────────────┘
```

### 3. Hardware Abstraction Layer (HAL) Design

For each peripheral:

- **Peripheral**: [UART1, ADC2, Timer3, etc.]
- **Purpose**: What does it do?
- **Configuration**: Baud rate, clock source, mode, etc.
- **Interrupt Requirements**: Does it need ISR?
- **Frequency**: Data rate, sampling rate, etc.
- **HAL Functions Needed**: List of functions to wrap

### 4. Communication Architecture

For each external communication:

- **Protocol**: [UART, CAN, I2C, SPI, Ethernet, etc.]
- **Baud Rate/Speed**: [Rate in bits/s]
- **Master/Slave**: Which side is which?
- **Message Format**: Frame structure
- **Timeout Strategy**: How to handle timeouts?
- **Error Handling**: Retry policy, error codes

### 5. Interrupt and ISR Planning

For each interrupt:

- **Source**: [Which peripheral or hardware event]
- **Priority**: [Numeric priority level]
- **ISR Name**: Function name
- **WCET**: Worst case execution time
- **Reentrancy**: Is ISR reentrant?
- **Critical Section**: Does it need locks?
- **Safety**: Any race conditions?

### 6. Boot Sequence Planning

Design the initialization sequence:

1. **Reset Handler**
   - CPU reset
   - Stack initialization
   - Vector table setup

2. **Clock Configuration**
   - PLL setup
   - Clock tree configuration
   - Peripheral clocks

3. **Peripheral Initialization**
   - GPIO configuration
   - UART setup (for debugging)
   - Timer setup
   - ADC setup
   - etc.

4. **Memory Setup**
   - Copy .data section (ROM → RAM)
   - Zero .bss section
   - Initialize heap

5. **Task/OS Initialization**
   - Initialize scheduler
   - Create tasks
   - Start OS scheduler

### 7. RTOS/Scheduler Design (if applicable)

If using an RTOS (FreeRTOS, Zephyr, etc.):

- **Scheduler Type**: [Preemptive, Cooperative]
- **Tick Rate**: [Frequency in Hz]
- **Context Switch Time**: [Estimate in microseconds]
- **Task Priorities**: [Assignment strategy]
- **Synchronization Primitives**: [Mutexes, semaphores, etc.]

### 8. Power Management

If power-constrained:

- **Sleep Modes**: [Supported by MCU]
- **Wake-up Sources**: [Interrupts that wake the MCU]
- **Clock Gating Strategy**: [Which peripherals can be disabled]
- **Power Domains**: [If multiple power domains]
- **Estimated Power Consumption**: [mA for each mode]

### 9. Safety & Reliability

- **Watchdog Strategy**: [Timeout, reset behavior]
- **Error Handling**: [Graceful degradation strategy]
- **Fault Detection**: [Brown-out, over-temperature, etc.]
- **Recovery Strategy**: [Auto-recovery, restart, etc.]
- **Logging**: [Where and how to log errors]

### 10. Module Breakdown

List all major modules and their responsibilities:

- **Module 1**: [Name, purpose, dependencies]
- **Module 2**: [Name, purpose, dependencies]
- **etc.**

Create a dependency graph showing how modules interact.

## Output Format

Structure your plan with:

1. **System Overview** - High-level block diagram
2. **Hardware Constraints** - MCU specs, memory limits, peripherals
3. **Real-Time Analysis** - Task list with timing guarantees
4. **Memory Map** - Detailed layout of ROM and RAM
5. **Architecture** - Module breakdown and data flow
6. **Boot Sequence** - Initialization order
7. **Interrupt Strategy** - ISR priorities and scheduling
8. **Module Specifications** - Details for each major component
9. **Implementation Steps** - Ordered task list
10. **Risk Assessment** - Known challenges

## Key Considerations

✅ **DO:**
- Plan for interrupt safety and reentrancy
- Reserve stack margin (20-30% unused)
- Use static allocation for critical systems
- Plan for debugging capabilities (UART, JTAG)
- Design for testability (mock-friendly HAL)
- Document real-time deadlines clearly
- Plan for clock tree optimization
- Consider power consumption from the start

❌ **DON'T:**
- Assume unlimited stack (embedded systems have limited RAM)
- Mix interrupt and task-level memory access without protection
- Rely on floating point in interrupt handlers (if not FPU-enabled)
- Use dynamic allocation in interrupt handlers
- Forget about timing analysis
- Skip planning for boot failures
- Ignore watchdog and timeout requirements
- Optimize prematurely (plan first, optimize after profiling)

## Example: Motor Control Firmware Plan

**System**: Stepper motor control on STM32F4 with speed control

```
Task 1: Motor Control Task
- Period: 1 ms
- Deadline: 0.9 ms
- WCET: 0.8 ms
- Priority: CRITICAL
- Responsibilities: Read position feedback, compute next step, update PWM

Task 2: Communication Task
- Period: 10 ms
- Deadline: 5 ms
- WCET: 2 ms
- Priority: NORMAL
- Responsibilities: UART communication with PC

Task 3: Monitoring Task
- Period: 100 ms
- Deadline: 100 ms
- WCET: 10 ms
- Priority: LOW
- Responsibilities: Temperature monitoring, error detection

Memory:
- ROM: 1 MB (Code: 200 KB, Data: 50 KB, Free: 750 KB)
- RAM: 192 KB (Stack: 8 KB, Heap: 32 KB, Globals: 20 KB, Free: 132 KB)

Peripherals:
- UART1: 115200 baud (debug output)
- Timer2: PWM for motor control (1 kHz)
- Timer3: Motor position capture
- ADC1: Temperature and current sensing
```

---

See [embedded-planner.agent.md](../agents/embedded-planner.agent.md) for how this prompt is used in planning workflows.
