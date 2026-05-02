---
name: embedded-security-review
description: Detailed prompt for reviewing security of embedded firmware and systems
license: 'Complete terms in LICENSE.txt'
---

# Embedded Security Review Prompt

Use this prompt when reviewing embedded firmware for security vulnerabilities.

## Security Review Context

You are reviewing embedded firmware for security vulnerabilities:

**Fill in these details:**

- **Target Platform**: [STM32F4, ESP32, nRF52, custom MCU, etc.]
- **Application Type**: [Motor control, IoT sensor, gateway, security device, etc.]
- **Security Level**: [Non-critical, SIL1, SIL2, SIL3, Safety-critical, Security-critical]
- **External Interfaces**: [UART, CAN, Ethernet, WiFi, Bluetooth, NFC, etc.]
- **Cryptographic Use**: [None, HMAC, AES, ECC, custom crypto, etc.]
- **Authentication**: [None, pin-based, certificate-based, biometric, etc.]
- **Update Mechanism**: [None, OTA, USB DFU, JTAG, bootloader, etc.]

## Security Threat Categories

### 1. Memory Safety Vulnerabilities

Check for:

#### Buffer Overflows
```c
// VULNERABLE: No bounds checking
void process_packet(uint8_t *data, int len) {
    uint8_t buffer[16];
    memcpy(buffer, data, len);  // ← Can overflow if len > 16
}

// SECURE: Bounds checking
void process_packet(uint8_t *data, int len) {
    uint8_t buffer[16];
    if (len > sizeof(buffer)) {
        return ERROR_BUFFER_OVERFLOW;
    }
    memcpy(buffer, data, len);
}
```

**Audit Questions:**
- [ ] All buffer operations have length limits
- [ ] strcpy/sprintf avoided in favor of strncpy/snprintf
- [ ] String operations are null-terminated safe
- [ ] Array accesses are bounds-checked

#### Stack Overflow
```
Risks:
- Large local arrays in functions
- Deep recursion
- Excessive inline functions
- ISR stack usage (interrupts use main stack)
```

**Audit Questions:**
- [ ] Stack reserve margin ≥ 20% unused
- [ ] No recursion or recursion depth limited
- [ ] ISR stack usage profiled and verified
- [ ] Large allocations use heap, not stack

#### Heap Corruption
```c
// VULNERABLE: No free tracking
void *ptr = malloc(256);
use_pointer(ptr);
free(ptr);
use_pointer(ptr);  // ← Use after free

// VULNERABLE: Double free
free(ptr);
free(ptr);  // ← Double free corrupts heap
```

**Audit Questions:**
- [ ] No use-after-free patterns
- [ ] No double-free patterns
- [ ] Heap allocations are tracked
- [ ] All allocated memory is freed

### 2. Cryptographic Weaknesses

Check for:

#### Weak or Custom Cryptography
```c
// VULNERABLE: Custom crypto implementation
void custom_encrypt(uint8_t *data, uint8_t key) {
    for (int i = 0; i < 16; i++) {
        data[i] ^= key + i;  // ← Not a real encryption algorithm
    }
}

// SECURE: Use tested library (mbedTLS, libsodium, etc.)
#include "mbedtls/aes.h"
mbedtls_aes_context ctx;
mbedtls_aes_setkey_enc(&ctx, key, 256);
mbedtls_aes_crypt_ecb(&ctx, MBEDTLS_AES_ENCRYPT, plaintext, ciphertext);
```

**Audit Questions:**
- [ ] Using only standard algorithms (AES, ChaCha20, SHA256, etc.)
- [ ] Using well-tested libraries (mbedTLS, WolfSSL, etc.)
- [ ] No custom crypto implementations
- [ ] Algorithms are up-to-date (not MD5, DES, SHA1)
- [ ] Key sizes meet current standards (AES-256, ECC-P256, etc.)

#### Weak Random Number Generation
```c
// VULNERABLE: Predictable random
srand(time(NULL));
uint32_t token = rand();

// SECURE: Use hardware RNG or strong PRNG
uint32_t token;
mbedtls_ctr_drbg_random(&ctr_drbg, (uint8_t*)&token, sizeof(token));
```

**Audit Questions:**
- [ ] RNG seed is unpredictable (hardware RNG preferred)
- [ ] No use of weak RNGs (rand(), srand)
- [ ] No hardcoded random values or seeds
- [ ] RNG entropy is verified
- [ ] Sufficient output bits for use (256-bit keys need ≥ 256-bit RNG output)

#### Weak Key Management
```c
// VULNERABLE: Hardcoded keys
const uint8_t SECRET_KEY[] = {0x01, 0x02, 0x03, ...};

// VULNERABLE: Keys in source control
// secret_key = "mysecretkey123" in GitHub

// SECURE: Keys in secure storage
// Load from secure element (HSM, TPM, encrypted flash)
```

**Audit Questions:**
- [ ] No hardcoded secrets in source code
- [ ] Keys never stored in plaintext in flash/EEPROM
- [ ] Key derivation used if sharing master key
- [ ] Keys protected from side-channel attacks
- [ ] Key rotation policy exists

### 3. Secure Boot & Authentication

Check for:

#### Firmware Signature Verification
```
Secure boot process:
1. Bootloader verifies signature of application using public key
2. Application runs only if signature is valid
3. Signature uses asymmetric crypto (RSA, ECDSA)
```

**Audit Questions:**
- [ ] Bootloader verifies firmware signature before execution
- [ ] Public key cannot be modified after manufacturing
- [ ] Signature algorithm is strong (ECDSA-P256, RSA-2048 min)
- [ ] Downgrade attacks prevented (version rollback checks)
- [ ] Rollback protection enabled on all deployments

#### Authentication Mechanisms
```
For external communication:
- Mutual authentication (device authenticates server, server authenticates device)
- Session keys derived from authentication
- Token expiration and rotation
```

**Audit Questions:**
- [ ] Authentication is mutual (bidirectional)
- [ ] Credentials/tokens are not hardcoded
- [ ] Session keys are derived properly (HKDF, KDF)
- [ ] Tokens have expiration
- [ ] Token revocation is possible
- [ ] No credential reuse across different servers

### 4. Hardware-Software Security Boundary

Check for:

#### Peripheral Abuse
```c
// VULNERABLE: Unvalidated writes to hardware registers
void set_output_voltage(uint16_t millivolts) {
    uint16_t dac_value = (millivolts * 4096) / 3300;
    DAC_CTRL = dac_value;  // No bounds check on DAC_CTRL
}

// SECURE: Validate and limit register access
void set_output_voltage(uint16_t millivolts) {
    if (millivolts < 0 || millivolts > 3300) {
        return ERROR_OUT_OF_RANGE;
    }
    uint16_t dac_value = (millivolts * 4096) / 3300;
    DAC_CTRL = dac_value;
}
```

**Audit Questions:**
- [ ] Hardware register writes are validated
- [ ] DMA access is bounds-checked
- [ ] Peripheral modes are validated
- [ ] Clock settings cannot crash system
- [ ] Reset mechanisms are protected

#### Timing Attacks
```
Vulnerability: Time taken to verify password/token reveals information
Example: Loop comparing password byte-by-byte exits early on mismatch
- Attacker can measure timing to deduce correct bytes

Solution: Constant-time comparison
```

```c
// VULNERABLE: Early exit reveals information
int verify_token(const uint8_t *received, const uint8_t *expected) {
    for (int i = 0; i < 16; i++) {
        if (received[i] != expected[i]) {
            return 0;  // ← Early exit based on data
        }
    }
    return 1;
}

// SECURE: Constant-time comparison
int verify_token_constant_time(const uint8_t *received, const uint8_t *expected) {
    uint8_t diff = 0;
    for (int i = 0; i < 16; i++) {
        diff |= (received[i] ^ expected[i]);  // XOR, always runs N iterations
    }
    return (diff == 0);
}
```

**Audit Questions:**
- [ ] Authentication/verification uses constant-time comparison
- [ ] No timing-based information leakage in critical paths
- [ ] Encryption/decryption is constant-time or protected

#### Side-Channel Resistance (Advanced)
```
Physical side-channels:
- Power analysis: Current consumption reveals operations
- EM analysis: Electromagnetic emissions reveal operations
- Timing analysis: Execution time reveals data
- Fault injection: Inducing errors to skip code
```

**Audit Questions for security-critical devices:**
- [ ] Countermeasures for power analysis exist
- [ ] Masking/blinding used in crypto
- [ ] Execution time is constant (for critical operations)
- [ ] Fault detection mechanisms exist
- [ ] Redundancy for critical computations

### 5. Interrupt Handler Safety

Check for:

#### Race Conditions in ISRs
```c
// VULNERABLE: Race condition between main and ISR
uint16_t counter = 0;

void main() {
    while (1) {
        counter++;  // ← Can be interrupted mid-increment
        use_counter(counter);
    }
}

void ISR_handler() {
    counter++;  // ← ISR modifies during main's increment
}

// SECURE: Proper synchronization
volatile uint16_t counter = 0;

void main() {
    while (1) {
        __disable_irq();  // Disable interrupts
        uint16_t local_counter = counter;
        __enable_irq();   // Re-enable interrupts
        use_counter(local_counter);
    }
}

void ISR_handler() {
    counter++;
}
```

**Audit Questions:**
- [ ] ISRs don't directly modify main task variables
- [ ] Shared data protected with critical sections
- [ ] No unbounded operations in ISRs
- [ ] ISRs have WCET ≤ acceptable latency
- [ ] Reentrancy is considered (what if ISR calls itself?)

#### ISR Deadlocks
```c
// VULNERABLE: Potential deadlock
Mutex lock;

void main() {
    lock.acquire();
    do_something();
    // Interrupt here!
    lock.release();
}

void ISR_handler() {
    lock.acquire();  // ← Deadlock! Lock already held by main
    do_isr_thing();
    lock.release();
}

// SECURE: Use critical sections instead
void main() {
    critical_section_enter();
    do_something();
    critical_section_exit();
}

void ISR_handler() {
    // ISRs run in critical section automatically
    do_isr_thing();
}
```

**Audit Questions:**
- [ ] ISRs don't acquire mutexes/locks
- [ ] ISRs don't call blocking functions
- [ ] Critical sections are kept short
- [ ] No potential for deadlock in ISRs

### 6. Communication Protocol Security

Check for:

#### Message Integrity
```
Requirements:
- Messages cannot be modified in transit
- Modifications are detected
```

**Audit Questions:**
- [ ] Message authentication code (MAC) or signature on all messages
- [ ] Hash algorithms used are strong (SHA-256, not CRC)
- [ ] Message sequence numbers prevent replay attacks
- [ ] Out-of-order messages are detected
- [ ] Duplicate messages are rejected

#### Message Confidentiality
```
Requirements:
- Messages cannot be eavesdropped
- Encryption protects sensitive data
```

**Audit Questions:**
- [ ] Encryption used for sensitive data
- [ ] Symmetric key is fresh (derived per session)
- [ ] IV/nonce is unique and random
- [ ] Encryption mode is secure (CTR, GCM, not ECB)
- [ ] Decryption validates authenticity (AEAD modes)

#### Protocol-Specific (CAN, I2C, SPI, Ethernet, WiFi, BLE)

**CAN Security:**
- [ ] CAN messages are signed/authenticated (if sensitive)
- [ ] Message filtering protects against injection
- [ ] Timing attacks on message parsing prevented

**WiFi/BLE Security:**
- [ ] TLS/SSL used for all connections
- [ ] Certificate validation performed
- [ ] No deprecated crypto (WEP, SSL 3.0)
- [ ] No hardcoded WiFi passwords

### 7. Firmware Update Security

Check for:

#### Update Integrity
```
Requirements:
- Updates are authentic (from legitimate source)
- Updates are complete (not corrupted)
- Updates are not downgraded
```

**Audit Questions:**
- [ ] Update image is signed by manufacturer
- [ ] Signature is verified before installation
- [ ] Update rollback is prevented
- [ ] Update corruption is detected
- [ ] Update process is atomic (no partial updates)

#### Update Rollout Security
```
Requirements:
- Updates can be deployed safely
- Failed updates can be recovered
- Rollback is controlled
```

**Audit Questions:**
- [ ] Staged rollout possible (test on small subset first)
- [ ] Rollback disabled for security-critical updates
- [ ] Update can be aborted safely
- [ ] Fallback firmware exists (dual-boot strategy)

### 8. Privilege and Access Control

Check for:

#### Least Privilege
```
Principle: Each component has only the minimum access needed
```

**Audit Questions:**
- [ ] Debug interface disabled in production
- [ ] JTAG access locked in production
- [ ] Bootloader cannot be disabled
- [ ] Security-critical code is protected
- [ ] Test modes disabled in production

#### Secure Element / Hardware Security Module Usage
```
If used:
- Keys stored in SE, never in main memory
- All operations on keys done in SE
- Authentication of commands to SE
```

**Audit Questions:**
- [ ] Keys never leave secure element
- [ ] SE authentication validated
- [ ] SE lifecycle managed properly
- [ ] Fallback if SE unavailable (graceful degradation)

## Security Review Checklist

### Critical Issues (Must fix before release)
- [ ] Buffer overflows found
- [ ] Custom crypto implementations
- [ ] Hardcoded secrets in code
- [ ] Unsigned firmware updates
- [ ] No authentication on external interfaces
- [ ] Known vulnerable libraries

### Important Issues (Should fix before release)
- [ ] Use-after-free patterns
- [ ] Weak RNG
- [ ] Timing attack vectors in auth code
- [ ] Unvalidated inputs from external sources
- [ ] Debug enabled in production builds

### Nice-to-Have (Consider for future)
- [ ] Side-channel resistance hardening
- [ ] Fault injection detection
- [ ] Advanced penetration testing
- [ ] Hardware security module integration

## Security Assessment Report Structure

```markdown
# Security Assessment Report: [Component/System]

## Executive Summary
[Overall risk level: LOW/MEDIUM/HIGH/CRITICAL]
[Key findings and remediation items]

## Scope
- Code reviewed: [Files, modules]
- Reviewers: [Names]
- Review date: [Date]

## Findings

### Critical Issues: [N]
1. [Issue description, location, impact, remediation]

### Important Issues: [N]
1. [Issue description, location, impact, remediation]

### Recommendations: [N]
1. [Recommended action]

## Conclusion
[Overall assessment and approval status]
```

---

See [se-embedded-security.agent.md](../agents/se-embedded-security.agent.md) for how this prompt is used in security review workflows.
