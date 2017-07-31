`timescale 1ns / 1ps
module extend 
#(parameter WIDTH = 16,parameter SIGN=1'b1)(
input [WIDTH - 1:0] in, //输入数据，数据宽度可以根据需要自行定义
output [31:0] out //32 位输出数据，
);
	assign out={SIGN?{(32-WIDTH){in[WIDTH-1]}}:{(32-WIDTH){1'b0}},in};
endmodule