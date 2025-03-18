# Digital Circuit and System - Lab03: FSM-based AutoPay System

**Institute of Electronics, NYCU**  
**NYCU CERES LAB**  
**March 20, 2025**  

## Introduction
Finite State Machines (FSMs) are crucial for designing sequential circuits, controlling the flow of operations based on inputs, and managing states effectively. This lab focuses on FSM modeling by implementing an AutoPay system that simulates credit card transactions.

## Finite State Machine (FSM) Overview
- FSMs can be classified into two types:
  - **Mealy Machine**: Output depends on the current state and input signals, requiring fewer states but more hardware.
  - **Moore Machine**: Output depends solely on the current state, making it safer but requiring more states.
- FSMs transition between states based on input conditions and control signals.
- Proper FSM design separates current state, next state, and output logic.

## Project Description
The goal of this project is to design an FSM-based AutoPay system for credit card transactions. The system performs the following operations:
- Receives an initial credit balance.
- Processes three purchases, each delayed by 2–4 clock cycles.
- Deducts each item's price from the balance.
- If the balance is insufficient during any transaction, it outputs a warning signal (`9'b1_0000_0000`) and terminates further processing.
- Ensures proper synchronization and adheres to timing constraints.

## Input and Output Signals
### Input Signals
| Signal         | Bit Width | Description                           |
|--------------|----------|---------------------------------|
| `clk`        | 1        | Clock signal                    |
| `rst_n`      | 1        | Asynchronous active-low reset   |
| `credit_valid` | 1      | High when credit input is valid |
| `credit`     | 8        | Initial credit balance          |
| `price_valid` | 1      | High when price input is valid  |
| `price`      | 6        | Current item's price            |

### Output Signals
| Signal         | Bit Width | Description                                      |
|--------------|----------|------------------------------------------------|
| `out_valid`  | 1        | High when output data is valid                  |
| `out_data`   | 9        | Remaining balance after transactions or warning signal |

## Implementation Details
- The system uses an asynchronous active-low reset.
- The reset signal is applied once at the beginning of the simulation.
- All outputs synchronize with the positive clock edge.
- `out_valid` should never overlap with `in_valid`.
- No latches are allowed in the synthesized design.
- The design should meet all timing constraints without violations.

## Simulation and Testing
The project includes multiple verification steps:
- **RTL Simulation**: The RTL simulation is performed using Synopsys VCS.
- **Synthesis**: The design is synthesized using Synopsys Design Compiler with TSMC 40nm technology.
- **Gate-Level Simulation**: The synthesized design is simulated using Synopsys VCS.
- **Waveform Debugging**: Synopsys Verdi is used to inspect signals and debug the design.
