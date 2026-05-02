---
name: create-memory-optimization-plan
description: 'Create memory optimization plans for embedded systems. Use when asked about reducing firmware size, optimizing RAM usage, minimizing memory footprint, stack overflow prevention, heap optimization, ROM usage reduction, memory-constrained devices, embedded system memory planning, code size reduction, or embedded memory budgeting for microcontrollers and firmware.'
license: 'Complete terms in LICENSE.txt'
---

# Memory Optimization Plan Skill

Create comprehensive memory optimization plans for embedded systems.

## When to Use This Skill

Activate this skill when users ask about:

- **Memory Optimization**: "How to reduce firmware size for constrained device"
- **ROM/Flash Usage**: "Optimize flash memory usage for STM32F1 with 64KB"
- **RAM Optimization**: "Minimize RAM usage for 32KB RAM device"
- **Stack Analysis**: "Analyze and optimize stack usage"
- **Heap Management**: "Design memory pooling for dynamic allocations"
- **Code Size**: "Reduce compiled code size without losing features"
- **Memory Footprint**: "Minimize overall memory footprint"
- **Memory Budget**: "Plan memory allocation for all subsystems"
- **Memory Profiling**: "Analyze memory usage and find optimization opportunities"
- **Stack Overflow**: "Prevent stack overflow with safety margins"
- **Linker Script**: "Design linker script for optimal memory layout"

## What This Skill Includes

### 1. Memory Analysis
- ROM/Flash usage breakdown
- RAM allocation analysis
- Stack usage estimation (main, ISR, worst case)
- Heap usage patterns
- Memory waste identification
- Fragmentation analysis
- Safety margin verification

### 2. Optimization Strategies
- Code size reduction techniques
- Data structure optimization
- Memory pooling and pre-allocation
- Stack usage reduction
- Heap fragmentation prevention
- ROM/RAM tradeoffs
- Compiler optimization flags
- Linker script optimization

### 3. Memory Categories
- **ROM/Flash**:
  - Code section
  - Initialized data
  - Constants
  - Overhead (bootloader, filesystem)
  
- **RAM**:
  - Static data (.bss, .data)
  - Stack (main, ISR)
  - Heap (dynamic allocations)
  - DMA buffers
  - Overhead

### 4. Output
Detailed memory optimization plan including:
- Current memory usage breakdown
- Memory constraints and targets
- Optimization opportunities with estimated savings
- Priority ranking (high/medium/low impact)
- Implementation approach
- Trade-off analysis (speed vs. size, flexibility vs. memory)
- Verification and measurement strategy
- Memory budget and allocation plan
- Risk assessment
- Success metrics

## Key Features

✅ **Comprehensive Analysis**
- Current memory usage by component
- Peak usage identification
- Bottleneck detection
- Trend analysis

✅ **Optimization Opportunities**
- Code size reduction (compiler flags, inlining strategies)
- Data structure optimization
- Memory pooling design
- Stack usage optimization
- Constant data optimization

✅ **Safety Focus**
- Stack overflow prevention
- Stack safety margins (20-30% unused)
- Heap fragmentation prevention
- Memory bounds checking

✅ **Implementation Guidance**
- Prioritized optimization steps
- Estimated resource savings
- Trade-off analysis
- Verification methods
- Testing approach

## Example Usage

```
User: "Optimize firmware for STM32F1 with 64KB flash and 20KB RAM"

Skill will generate:
├── Current memory usage:
│   ├── Flash: 58KB (90% utilization) - TOO TIGHT!
│   │   ├── Code: 45KB
│   │   ├── Constants: 10KB
│   │   └── Bootloader: 3KB
│   └── RAM: 19KB (95% utilization) - CRITICAL!
│       ├── Stack: 4KB (main) + ISR overhead
│       ├── Heap: 8KB
│       └── Globals: 7KB
│
├── Critical optimizations (MUST DO):
│   ├── Remove unused functions: -2KB flash
│   ├── Optimize string constants: -1KB flash
│   ├── Use function inlining strategically: -3KB flash
│   └── Reduce heap: Pre-allocate buffers: -2KB RAM
│
├── Medium priority:
│   ├── Compiler optimization level: -3KB flash
│   ├── Remove debug symbols in release: -1KB flash
│   └── Stack pooling for ISRs: -1KB RAM
│
├── Low priority:
│   ├── Code compression (if supported): -2KB
│   └── Extern RAM if available: +Variable
│
├── Memory budget after optimization:
│   ├── Flash: 50KB (78% utilization) - SAFE
│   └── RAM: 16KB (80% utilization) - SAFE with 20% margin
│
├── Implementation steps and timeline
├── Verification and measurement strategy
└── Risk assessment and fallback options
```

## Integration with Other Components

- Works with **embedded-planner** to design memory-efficient architecture
- Works with **testing-planner** for memory-aware test infrastructure
- Works with **se-devops-embedded** for build optimization
- Works with **se-performance-reviewer** for detailed analysis and profiling

## How to Request This Skill

```
"Create memory optimization plan for [device and constraints]"
"How to reduce firmware size to fit in [flash size]?"
"Optimize RAM usage for [application] with [available RAM]"
"Analyze and optimize memory footprint for [system]"
```

No need to explicitly invoke `@create-memory-optimization-plan`. Copilot activates this skill automatically when it recognizes your request.

## Related Resources

- [performance-optimization.instructions.md](../../instructions/performance-optimization.instructions.md) - Performance best practices
- [se-performance-reviewer.agent.md](../../agents/se-performance-reviewer.agent.md) - Performance reviewer agent
- [AGENT-COORDINATION.md](../../AGENT-COORDINATION.md) - How skills integrate with agents
