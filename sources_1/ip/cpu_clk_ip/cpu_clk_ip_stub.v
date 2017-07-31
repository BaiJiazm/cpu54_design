// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Fri Jul 14 15:27:57 2017
// Host        : SeeYouAgain running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {d:/cs2/Computer
//               Composition/practice/cpu54_design/cpu54_design.srcs/sources_1/ip/cpu_clk_ip/cpu_clk_ip_stub.v}
// Design      : cpu_clk_ip
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module cpu_clk_ip(clk_in1, clk_out1, reset, locked)
/* synthesis syn_black_box black_box_pad_pin="clk_in1,clk_out1,reset,locked" */;
  input clk_in1;
  output clk_out1;
  input reset;
  output locked;
endmodule
