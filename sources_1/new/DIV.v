`timescale 1ns / 1ps
module DIV(
input [31:0]dividend,	//被除数
input [31:0]divisor,	//除数
input start,			//高位启动除法运算
input clock,			//上升沿有效
input reset,			//上升沿重置
output [31:0]q,			//商
output [31:0]r,			//余数
output busy				//除法器忙标志位
);

wire [31:0] udividend=dividend[31]?(~dividend+1):dividend;
wire [31:0] udivisor=divisor[31]?(~divisor+1):divisor;
wire [31:0]	ur;
wire [31:0]	uq;

DIVU divu_inst(.dividend(udividend),.divisor(udivisor),.start(start),.clock(clock),.reset(reset),.q(uq),.r(ur),.busy(busy));

assign q=~(dividend[31]^divisor[31])?uq:(~uq+1);
assign r=dividend[31]?(~ur+1):ur;

endmodule
