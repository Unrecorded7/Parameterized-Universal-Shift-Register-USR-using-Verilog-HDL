# Universal Shift Register (Verilog)

## Overview

This project implements a **parameterized Universal Shift Register (USR)** using Verilog HDL.

The design supports:

- Parallel data loading
- Left shift
- Right shift
- Synchronous reset
- Enable control
- Hold operation
- Configurable data width

## Features

| Control            | Function                              |
| ------------------ | ------------------------------------- |
| `clr = 1`          | Synchronous reset; clears output to 0 |
| `load = 1`         | Loads parallel input data             |
| `en = 1, hold = 0` | Enables shifting                      |
| `lr = 0`           | Left shift; `lin` enters LSB          |
| `lr = 1`           | Right shift; `rin` enters MSB         |
| `hold = 1`         | Maintains the previous state          |
| `en = 0`           | Maintains the previous state          |

### Control Priority

The design follows this priority:

1. Clear
2. Parallel Load
3. Shift
4. Hold

## Module Interface

| Signal   | Direction | Description                   |
| -------- | --------- | ----------------------------- |
| `clk`    | Input     | Clock signal                  |
| `clr`    | Input     | Active-high synchronous clear |
| `en`     | Input     | Shift enable                  |
| `hold`   | Input     | Hold control                  |
| `load`   | Input     | Parallel load enable          |
| `lr`     | Input     | Shift direction               |
| `lin`    | Input     | Serial input for left shift   |
| `rin`    | Input     | Serial input for right shift  |
| `p_load` | Input     | Parallel data input           |
| `q`      | Output    | Register output               |

**Parameter:**

- `width`: Configurable register width (default = 8).

## Project Structure

```text
BiDirec_Shift_Register/
│
├── UniSR.v
├── UniSR_tb.v
└── README.md
```

## Simulation

The design can be simulated using **Icarus Verilog** and waveforms can be viewed using **GTKWave**.

### 1. Compile

```bash
iverilog -g2012 -o output UniSR.v UniSR_tb.v
```

### 2. Run Simulation

```bash
vvp output
```

### 3. View Waveforms

```bash
gtkwave UniSR.vcd
```

## Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave

## Concepts Demonstrated

- Sequential circuit design
- Parameterized RTL
- Non-blocking assignments
- Shift register architecture
- Control signal prioritization
- Testbench development
- Functional simulation and waveform analysis

---
