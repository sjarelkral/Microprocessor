# 8-Bit Microprocessor
* [Project Overview](https://github.com/sjarelkral/Microprocessor/blob/master/README.md#project-overview)
* [Microprocessor Design](https://github.com/sjarelkral/Microprocessor/blob/master/README.md#microprocessor-design)
    * [Data Path](https://github.com/sjarelkral/Microprocessor/blob/master/README.md#data-path)
    * [Instruction Set Architecture](https://github.com/sjarelkral/Microprocessor/blob/master/README.md#instruction-set-architecture)
        * [Formats of the entire instruction set](https://github.com/sjarelkral/Microprocessor/blob/master/README.md#formats-of-the-entire-instruction-set)
        * [Control Signal Table](https://github.com/sjarelkral/Microprocessor/blob/master/README.md#control-signal-table)
    * [Interface of Microprocessor components](https://github.com/sjarelkral/Microprocessor/blob/master/README.md#interface-of-microprocessor-components)
* [Example test set: Input/Output](https://github.com/sjarelkral/Microprocessor/blob/master/README.md#example-test-set-inputoutput)
* [Test Environment](https://github.com/sjarelkral/Microprocessor/blob/master/README.md#test-environment)

## Project Overview
* Implementation of a **simple Microprocessor** in verilog for **FPGA** implementation consisting of an *ALU, a control unit, a system memory, registers*, and so on.
* An on-board 50MHz clock oscillator is used to create 1Hz clock for the microprocessor.
* Specifications:
   * 8-bit Microprocessor
   * Instruction size : 8-bit
   * Type of instructions : 4 (`add`, `load`, `store`, `jump`)
   * Register size : 8-bit
   * Number of registers : 4
 * Input : Instruction codes from external memory (IMEM Module)
   * IMEM implemented on a separate FPGA chip and connected using an 8-bit bus.
   * Additional input: *reset, frequency selectors(0.5Hz, 0.25Hz) using tactile switches*
 * Output: Current value of Reg Write Data, extra optional features e.g 1Hz clock tick LED.
   * **Hexadecimal** on 7-segment displays
   * Additional output: *PC value & RegWrite register number on 7-segment displays, opcode,operating clock, MemRead, MemWrite, RegWrite on (LED lights)*
 
## Microprocessor Design

### Data Path
### Instruction Set Architecture
#### Formats of the entire instruction set
#### Control Signal Table
### Interface of Microprocessor components
## Example test set: Input/Output
## Test Environment
