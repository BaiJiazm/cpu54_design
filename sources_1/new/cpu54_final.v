`timescale 1ns / 1ps
module cpu54_final(
input wire Clk,
input wire Rst,
input wire [15:0] sw,
output [7:0] abcdefg, 
output [7:0] showPort
);

wire [7:0] o_seg;
wire [7:0] o_sel;
assign abcdefg=o_seg;
assign showPort=o_sel;

cpu_clk_ip cpu_clk_inst(Clk, clk, Rst, locked);
cpu54 cpu54_inst(Rst, clk,sw, o_seg, o_sel);

//clock_div clock_div_inst(.clk(clk),.clk_pulse(clk200));
//seg7 seg_inst(.clk(clk200),.rst(Rst),.data(data),.abcdefg(abcdefg),.showPort(showPort));

endmodule
