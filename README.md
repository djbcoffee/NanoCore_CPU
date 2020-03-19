# NanoCore_CPU
NanoCore is a processor core that is designed to be implemented with minimal logic resources. The compact, yet effective, set of 21 instructions and 5 addressing modes provides the features that any problem might require. The instruction set consists of 2 data movement operations, 9 arithmetic-logical operations, 7 branch instructions, 1 instruction that loads the direct page register, 1 instruction that increments the direct page register, and 1 instruction that decrements the direct page register.

The NanoCore CPU project page can be found [here](https://sites.google.com/view/m-chips/nanocore)

A project to build a computer based on the NanoCore CPU can be found [here](https://sites.google.com/view/m-chips/cpld-5)

## Archive content

The following files are provided:
* ABRegisters.vhd - Source code file
* Accumulator.vhd - Source code file
* AddressLowByteRegister.vhd - Source code file
* AddressRegister.vhd - Source code file
* ALU.vhd - Source code file
* AluAdd.vhd - Source code file
* AluLogic.vhd - Source code file
* CarryRegister.vhd - Source code file
* ControlUnit.vhd - Source code file
* CycleCounter.vhd - Source code file
* DirectPageRegister.vhd - Source code file
* LogicBlock.vhd - Source code file
* NanoCore.vhd - Source code file
* OpCodeRegister.vhd - Source code file
* ProgramCounter.vhd - Source code file
* Reset.vhd - Source code file
* StatusRegister.vhd - Source code file
* TwoBitLookAheadAdd.vhd - Source code file
* Universal.vhd - Source code file
* WriteEnableRegister.vhd - Source code file
* NanoCore.ucf - Configuration file
* NanoCore.jed - JEDEC Program file
* LICENSE.md - License text
* README.md - This file

### Prerequisites

Xilinx’s ISE WebPACK Design Suite version 14.7 is required to do a build and can be obtained [here](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive-ise.html)

Familiarity with the use and operation of the Xilinx ISE Design Suite is assumed and beyond the scope of this readme file.

### Installing

Place the source files into any convient location on your PC.  NOTE:  The Xilinx ISE Design Suite can not handle spaces in directory and file names.

The JEDEC Program file NanoCore.jed was created with Xilinx ISE Design Suite 14.7 WebPACK version.  This can be used to program the Xilinx XC95144XL-10TQG100C CPLD without any further setup.

Create a project called NanoCore using the XC95144XL CPLD in a TQ100 package with a speed of -10.
Set the following for the project:
Top-Level Source Type = HDL
Synthesis Tool = XST (VHDL/Verilog)
Simulator ISim (VHDL/Verilog)
Perferred Language = VHDL
VHDL Source Analysis Standard = VHDL-93

Add the source code and configuration file to the project.  NOTE:  Universal.vhd needs to set as a global file in the compile list.

Synthesis options need to be set as:  
Input File Name                    : "NanoCore.prj"  
Input Format                       : mixed  
Ignore Synthesis Constraint File   : NO  
Output File Name                   : "NanoCore"  
Output Format                      : NGC  
Target Device                      : XC9500XL CPLDs  
Top Module Name                    : NanoCore  
Automatic FSM Extraction           : YES  
FSM Encoding Algorithm             : Auto  
Safe Implementation                : No  
Mux Extraction                     : Yes  
Resource Sharing                   : YES  
Add IO Buffers                     : YES  
MACRO Preserve                     : YES  
XOR Preserve                       : YES  
Equivalent register Removal        : YES  
Optimization Goal                  : Speed  
Optimization Effort                : 1  
Keep Hierarchy                     : Yes  
Netlist Hierarchy                  : As_Optimized  
RTL Output                         : Yes  
Hierarchy Separator                : /  
Bus Delimiter                      : <>  
Case Specifier                     : Maintain  
Verilog 2001                       : YES  
Clock Enable                       : YES  
wysiwyg                            : NO  

Fitter options need to be set as:  
Device(s) Specified                         : xc95144xl-10-TQ100  
Optimization Method                         : SPEED  
Multi-Level Logic Optimization              : ON  
Ignore Timing Specifications                : OFF  
Default Register Power Up Value             : LOW  
Keep User Location Constraints              : ON  
What-You-See-Is-What-You-Get                : OFF  
Exhaustive Fitting                          : OFF  
Keep Unused Inputs                          : OFF  
Slew Rate                                   : FAST  
Power Mode                                  : STD  
Ground on Unused IOs                        : ON  
Set I/O Pin Termination                     : KEEPER  
Global Clock Optimization                   : ON  
Global Set/Reset Optimization               : ON  
Global Ouput Enable Optimization            : ON  
Input Limit                                 : 54  
Pterm Limit                                 : 50  

The design can now be implemented.

## Built With

* [Xilinx’s ISE WebPACK Design Suite version 14.7](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive-ise.html) - The development, simulation, and programming environment used

## Version History

* v1.0.0 - 2014 
	- Initial release

## Authors

* **Donald J Bartley** - *Initial work* - [djbcoffee](https://github.com/djbcoffee)

## License

This project is licensed under the GNU Public License 2 - see the [LICENSE.md](LICENSE.md) file for details
