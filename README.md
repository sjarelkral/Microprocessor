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
A Verilog implementation of a Simple Microprocessor programmed on an FPGA board.
* **Clock** : Clocks are generated from on-board 50Hz oscillator. Provided clock speeds are *1Hz (Base clock), 0.5Hz* and *0.25 Hz*. Frequency selectors are used to switch to the lower frequencies.
* **Specification** : 8-bit Microprocessor
  * Instruction size : 8-bit
  * Instruction Set : 4 (add, load, store, jump)
  * Register size : 8-bit
  * Number of registers : 4
  * Memory size : 8-bit word size, 8-bit memory address, 32 memory address locations
* **Input** :
   * 8-bit `instruction` from external memory
   * `reset` button
   * 0.25Hz ans 0.5Hz frequency selectors: `frequency_4` and `frequency_2`
* **Output** :
   * Current value of `RegWriteData` in Hexadecimal
   * Register to which `RegWriteData` is written
   * Value of `pc` i.e *next instruction to be executed*
   * Value of `MemRead`, `MemWrite`, `RegWrite`, `op` and `clock`
* **Modules** :
   * The ALU, control unit, system memory, frequency divider, pc and registers are condensed into a behavioural description of `Microprocessor` module.
   * `IMEM` module is a testbench for the microprocessor.
   * `Console` module is a 4-bit Hexadecimal to 7-segment display converter.
 
## Microprocessor Design
### Data Path
Insert the full diagram
### Instruction Set Architecture

   
#### Formats of the entire instruction set
#### Control Signal Table
### Interface of Microprocessor components
## Example test set: Input/Output
## Test Environment
