# 1011 Sequence Detector Using Verilog HDL

## 📌 Project Overview

This project implements a **1011 Sequence Detector** using Verilog HDL.

A sequence detector is a digital circuit that detects a specific sequence of bits in a serial input stream.

In this project, the circuit detects the sequence:

```text
1011
```

The design uses a **Finite State Machine (FSM)** and supports **overlapping sequence detection**.

### Project Specifications

* Detected sequence: `1011`
* Design type: Finite State Machine
* Detection type: Overlapping
* Design language: Verilog HDL
* Testbench: Self-checking
* Simulation tools: Icarus Verilog and GTKWave

## 🎯 Objectives

The objectives of this project are:

* Understand sequence detector operation.
* Design an FSM using Verilog HDL.
* Detect the `1011` bit sequence.
* Implement overlapping sequence detection.
* Create a self-checking testbench.
* Verify the detector using simulation.
* Analyze the output waveform.

## 🔷 What is a Sequence Detector?

A sequence detector is a sequential circuit that monitors a stream of input bits and produces an output when a particular pattern is detected.

For this project, the required pattern is:

```text
1011
```

When the input sequence contains `1011`, the output `detected` becomes `1` for one clock cycle.

## 🔄 Overlapping Detection

This project uses **overlapping detection**.

For example:

```text
Input:    1011011
          ----    → First 1011
             ---- → Second 1011
```

The second occurrence can use bits from the first detected sequence.

## 🧠 FSM States

The detector uses five states:

| State | Meaning          |
| ----- | ---------------- |
| `S0`  | No matching bits |
| `S1`  | Detected `1`     |
| `S2`  | Detected `10`    |
| `S3`  | Detected `101`   |
| `S4`  | Detected `1011`  |

### State Flow

```text
             1
        ┌──────────┐
        ▼          │
       S0 ───────► S1
        ▲          │
        │          │0
        │          ▼
        │         S2
        │          │
        │          │1
        │          ▼
        │         S3
        │          │
        │          │1
        │          ▼
        │         S4
        │
        └────────── Detection
```

## 🔢 State Transition Concept

The important transitions are:

```text
S0 + 1 → S1
S1 + 0 → S2
S2 + 1 → S3
S3 + 1 → S4
```

When `S4` is reached, the sequence `1011` has been detected.

## 💻 Inputs and Outputs

| Signal     | Direction | Description                       |
| ---------- | --------- | --------------------------------- |
| `clk`      | Input     | Clock signal                      |
| `reset`    | Input     | Synchronous reset                 |
| `din`      | Input     | Serial input bit                  |
| `detected` | Output    | Goes HIGH when `1011` is detected |

## 🧪 Testbench

The self-checking testbench:

1. Resets the sequence detector.
2. Sends different input bit streams.
3. Checks whether `1011` is detected.
4. Tests both detection and non-detection cases.
5. Tests overlapping sequences.
6. Compares expected and actual outputs.
7. Reports `PASS` or `FAIL`.
8. Generates a VCD waveform.

## ▶️ Simulation Using Icarus Verilog

Compile the design and testbench:

```bash
iverilog -o sequence_sim sequence_detector.v sequence_detector_tb.v
```

Run the simulation:

```bash
vvp sequence_sim
```

A waveform file will be generated:

```text
sequence_detector.vcd
```

Open it using GTKWave:

```bash
gtkwave sequence_detector.vcd
```

## 📊 Expected Simulation

For input:

```text
1 0 1 1
```

the output should become:

```text
0 0 0 1
```

The final `1` completes the sequence `1011`.

### Example

```text
Input:     1  0  1  1
Detected:  0  0  0  1
```

For overlapping input:

```text
Input:     1 0 1 1 0 1 1
Detected:  0 0 0 1 0 0 1
```

The sequence is detected twice.

## 📁 Project Files

```text
1011-Sequence-Detector-Verilog/
│
├── README.md
├── sequence_detector.v
├── sequence_detector_tb.v
│
└── simulation/
    ├── simulation_results.txt
    └── waveform_description.txt
```

## 🛠️ Tools Used

* Verilog HDL
* Icarus Verilog
* GTKWave
* GitHub

## 📚 Applications

Sequence detectors are used in:

* Digital communication systems
* Serial data processing
* Protocol detection
* Pattern recognition
* Control systems
* Digital signal processing
* FSM-based controllers

## 🎓 Learning Outcomes

After completing this project, you will understand:

* Finite State Machines
* Moore/Mealy-style sequence detection
* State transitions
* Overlapping pattern detection
* Sequential Verilog design
* Self-checking testbenches
* Simulation and waveform analysis
* GitHub project organization

## ✅ Conclusion

A `1011` sequence detector was successfully designed using Verilog HDL. The FSM detects the required pattern from a serial input stream and supports overlapping sequence detection. The self-checking testbench verifies the design under multiple input conditions.
