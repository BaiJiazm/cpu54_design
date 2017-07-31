`timescale 1ns / 1ps
module MULT(
input clk,		// 乘法器时钟信号
input reset,
input [31:0] a, // 输入 a(被乘数)
input [31:0] b, // 输入 b(乘数)
output [63:0] z // 乘积输出 z
) ;
	wire [31:0]aa=a[31]?(~a+1):a;
	wire [31:0]bb=b[31]?(~b+1):b;
	wire [63:0]tem;
	
	MULTU multu_inst(.clk(clk),.reset(reset),.a(aa),.b(bb),.z(tem));
	
	assign z=a[31]==b[31]?tem:(~tem+1);
	
endmodule