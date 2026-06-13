# 4-Bit ALU — RTL Design & Functional Verification

**Author:** P. Venkatesh Sagar  
**Date:** June 2026  
**Tools:** Verilog HDL · ModelSim · Xilinx Vivado

---

## Overview

A fully synthesisable **4-bit Arithmetic Logic Unit (ALU)** implemented in Verilog HDL with opcode-based operation control. Includes a self-checking testbench with 200+ directed input vectors that automatically compares DUT output against golden expected results.

### Supported Operations

| Opcode | Operation | Description |
|--------|-----------|-------------|
| 3'b000 | ADD | result = A + B |
| 3'b001 | SUB | result = A - B |
| 3'b010 | AND | result = A & B |
| 3'b011 | OR  | result = A \| B |
| 3'b100 | XOR | result = A ^ B |
| 3'b101 | SLT | result = (A < B) ? 1 : 0 |
| 3'b110 | SLL | result = A << 1 |
| 3'b111 | SRL | result = A >> 1 |

### Output Flags
- **zero** — High when result[3:0] == 0
- **overflow** — High on ADD carry-out or SUB borrow

---

## Project Structure

```
4bit-ALU-RTL-Verification/
├── rtl/
│   └── alu_4bit.v      # ALU RTL implementation
├── tb/
│   └── alu_tb.v        # Self-checking testbench (200+ vectors)
├── sim/
│   └── (waveform screenshots)
└── README.md
```

---

## Block Diagram

```
        ┌─────────────────────┐
 A[3:0]─►                     ├──► result[4:0]
 B[3:0]─►     alu_4bit        ├──► zero
opcode ─►                     ├──► overflow
        └─────────────────────┘
```

---

## How to Simulate (ModelSim)

```tcl
vlog rtl/alu_4bit.v tb/alu_tb.v
vsim alu_tb
run -all
```

---

## How to Simulate (Xilinx Vivado)

1. Create new project → Add `rtl/alu_4bit.v`
2. Add simulation source: `tb/alu_tb.v`
3. Set `alu_tb` as top simulation module
4. Run Behavioral Simulation

---

## Testbench Results

| Test Category | Vectors | Result |
|---------------|---------|--------|
| ADD (including overflow) | 20+ | PASS |
| SUB (including underflow) | 20+ | PASS |
| AND | 15+ | PASS |
| OR  | 15+ | PASS |
| XOR | 15+ | PASS |
| SLT | 15+ | PASS |
| SLL | 15+ | PASS |
| SRL | 15+ | PASS |
| Zero flag sweep | 16 | PASS |
| ADD corner cases | 16 | PASS |
| **Total** | **200+** | **ALL PASS** |

---

## Key Verification Highlights

- Self-checking testbench — no manual waveform inspection needed
- Automatic PASS/FAIL reporting per test vector
- Caught **2 carry-logic corner-case bugs** during development
- Full zero and overflow flag coverage across all operations

---

## Skills Demonstrated

- RTL design using combinational Verilog HDL
- Opcode-based control logic
- Self-checking testbench methodology
- Functional verification with directed test vectors
- Flag behaviour analysis (zero, overflow)
