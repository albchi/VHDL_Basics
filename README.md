# VHDL_Basics

This is a real working example of a VHDL file that prints "HELO" to a Basys3 Xilinx FPGA board.

To duplicate this setup, you will need

1) Basys3 FPGA board, which contains a Xilinx Artix-7 FPGA, and many I/O including four 7-segment display,
   16 LEDS, 16 switches, 5 button cursor, etc...
3) Xilinx/AMD Vivado software that allows you to create a RTL design (VHDL, VERILOG), simulate with a testbench,
   synthesize to turn RTL into gate netlist, implement (same as place and route), generate bitstream, then
   program FPGA board with bitstream.
5) When in Vivado, you will need to create 1) RTL design, done in VHDL for this example 2) Xilinx Design
   Constraint (XDC) file, which will map VHDL entity ports to I/O on the board, create the clock needed by
   the FPGA.
   
![helo_netlist_vivado](https://github.com/user-attachments/assets/6f281991-0978-4ba3-aebf-85951f178a09)


![helo_fpga](https://github.com/user-attachments/assets/d0c88c84-f322-4e80-8b00-6bd8b6872314)
