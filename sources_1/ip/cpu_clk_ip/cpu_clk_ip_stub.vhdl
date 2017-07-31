-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
-- Date        : Fri Jul 14 15:27:57 2017
-- Host        : SeeYouAgain running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {d:/cs2/Computer
--               Composition/practice/cpu54_design/cpu54_design.srcs/sources_1/ip/cpu_clk_ip/cpu_clk_ip_stub.vhdl}
-- Design      : cpu_clk_ip
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_clk_ip is
  Port ( 
    clk_in1 : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC
  );

end cpu_clk_ip;

architecture stub of cpu_clk_ip is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_in1,clk_out1,reset,locked";
begin
end;
