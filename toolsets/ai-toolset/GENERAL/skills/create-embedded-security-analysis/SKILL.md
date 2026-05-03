---
name: create-embedded-security-analysis
description: 'Analyze embedded firmware security and create security review plans. Use when asked to identify vulnerabilities in embedded code, review firmware for OWASP embedded threats, analyze buffer overflow risks, review cryptographic implementations, audit secure boot mechanisms, assess authentication security, review interrupt handler safety, analyze communication protocol security, plan security hardening for microcontroller systems, or check for side-channel attack risks.'
license: 'Complete terms in LICENSE.txt'
---

# Embedded Security Analysis Skill

Create comprehensive security analysis and reviews for embedded firmware.

## When to Use This Skill

Activate this skill when users ask about:

- **Security Review**: "Review firmware for security vulnerabilities"
- **Threat Analysis**: "Analyze security threats in embedded system"
- **Buffer Overflow**: "Check for buffer overflow vulnerabilities in C code"
- **Cryptography**: "Review cryptographic implementation for weaknesses"
- **Secure Boot**: "Audit secure boot mechanism design"
- **Authentication**: "Review authentication scheme security"
- **Interrupt Safety**: "Analyze interrupt handler safety and race conditions"
- **Protocol Security**: "Check CAN/I2C/WiFi communication security"
- **Side-Channels**: "Assess timing attack and side-channel risks"
- **Firmware Update**: "Review firmware update process security"
- **Access Control**: "Analyze privilege and access control"
- **OWASP Embedded**: "Check against OWASP embedded vulnerabilities"

## What This Skill Includes

### 1. Vulnerability Categories
- Memory safety (buffer/stack/heap overflow)
- Cryptographic weaknesses
- Weak RNG and key management
- Secure boot and attestation
- Authentication and authorization
- Communication protocol security
- Firmware update security
- Interrupt handler safety
- Side-channel attack risks
- Hardware-software boundary security

### 2. Security Analysis Approach
- Threat model identification
- Code review for vulnerabilities
- Architecture security assessment
- Cryptographic implementation review
- Protocol security analysis
- Risk categorization (CRITICAL/HIGH/MEDIUM)
- Remediation recommendations
- Prioritization guidance

### 3. Review Categories
- **Memory Safety**: Buffer/stack/heap analysis
- **Cryptography**: Algorithm, implementation, key management review
- **Secure Boot**: Boot chain, signature verification, rollback prevention
- **Authentication**: Credential management, session handling
- **Hardware Integration**: Peripheral access control, DMA safety
- **Interrupts**: Race conditions, deadlocks, reentrancy
- **Communication**: Message integrity, confidentiality, replay protection
- **Firmware Updates**: Signature verification, rollback protection
- **Privilege**: Least privilege, debug interface security
- **Side-Channels**: Timing attacks, power analysis, fault injection

### 4. Output
Detailed security review report including:
- Executive summary and risk assessment
- Vulnerability findings with severity levels
- Root cause analysis for each issue
- Impact assessment
- Remediation recommendations
- Priority guidance (must fix/should fix/nice to have)
- Compliance notes
- Risk mitigation plan
- Follow-up verification steps

## Key Features

✅ **Threat Identification**
- OWASP embedded threats
- Common embedded vulnerabilities
- Protocol-specific threats
- Hardware-specific threats

✅ **Risk Prioritization**
- Severity assessment (CRITICAL/HIGH/MEDIUM)
- Impact analysis
- Exploitability evaluation
- Prioritized remediation

✅ **Actionable Recommendations**
- Specific code fixes
- Architecture improvements
- Process changes
- Library recommendations

✅ **Compliance Ready**
- Standards mapping (IEC 62304, FIPS, etc.)
- Compliance status
- Gap analysis
- Remediation verification

## Example Usage

```
User: "Review STM32F4 firmware for security vulnerabilities"

Skill will generate:
├── Executive summary: 2 CRITICAL, 3 HIGH, 1 MEDIUM issues
├── Critical findings:
│   ├── Buffer overflow in UART handler (memcpy without bounds)
│   └── Hardcoded encryption key in firmware image
├── High findings:
│   ├── Weak RNG for session tokens
│   ├── No firmware signature verification
│   └── Race condition in ISR accessing shared counter
├── Medium findings:
│   └── Timing attack vector in password verification
├── Remediation:
│   ├── Replace memcpy with bounds-checked alternative
│   ├── Move key to secure element (HSM)
│   ├── Use proper CSPRNG for tokens
│   ├── Implement firmware signature verification
│   ├── Protect shared data with critical sections
│   └── Use constant-time comparison for passwords
├── Risk assessment: HIGH (Critical issues must be fixed)
├── Compliance: Fails OWASP embedded requirements
└── Verification: Recommend security audit after fixes
```

## Integration with Other Components

- Works with **embedded-planner** to incorporate security from architecture phase
- Works with **testing-planner** for security test case planning
- Works with **se-performance-reviewer** for side-channel optimization
- Works with **se-devops-embedded** for secure build and release process

## How to Request This Skill

```
"Review [firmware/code] for security vulnerabilities"
"Identify security threats in [embedded system]"
"Audit [component] for OWASP compliance"
"Check [code] for buffer overflow and memory safety"
```

No need to explicitly invoke `@create-embedded-security-analysis`. Copilot activates this skill automatically when it recognizes your request.

## Related Resources

- [embedded-security.prompt.md](../../prompts/embedded-security.prompt.md) - Detailed security review prompts and checklists
- [se-embedded-security.agent.md](../../agents/se-embedded-security.agent.md) - Security reviewer agent
- [OWASP](https://owasp.org) - Security standards and guidelines
- [AGENT-COORDINATION.md](../../AGENT-COORDINATION.md) - How skills integrate with agents
