`timescale 1ns / 1ps
module ram (
input clk, 				//存储器时钟信号，上升沿时向ram 内部写入数据
input ena, 				//存储器有效信号，高电平时存储器才运行，否则输出z
input wena, 			//存储器写有效信号，高电平有效，与ena同时有效时才可写存储器
input [3:0] byteEna,	//字节使能，控制宽度
input [31:0] addr, 		//输入地址，指定数据读写的地址
input [31:0] data_in, 	//存储器写入的数据，在clk上升沿时被写入
output [31:0] data_out 	//存储器读出的数据，
);
	
	wire [31:0]logicAddr=addr-32'h10010000;
	wire [8:0]taddr0=logicAddr[8:0];
	wire [8:0]taddr1=taddr0+9'd1;
	wire [8:0]taddr2=taddr0+9'd2;
	wire [8:0]taddr3=taddr0+9'd3;
	
	reg [7:0] ramReg[640:0];
	
	wire [7:0] writeByte0=byteEna[0]?data_in[7:0]:ramReg[taddr0];
	wire [7:0] writeByte1=byteEna[1]?data_in[15:8]:ramReg[taddr1];
	wire [7:0] writeByte2=byteEna[2]?data_in[23:16]:ramReg[taddr2];
	wire [7:0] writeByte3=byteEna[3]?data_in[31:24]:ramReg[taddr3];
	
    always@(posedge clk)
            if (ena&wena) begin
                ramReg[taddr0]<=writeByte0;
				ramReg[taddr1]<=writeByte1;
				ramReg[taddr2]<=writeByte2;
				ramReg[taddr3]<=writeByte3;
			end
    assign data_out=ena&~wena?{ramReg[taddr3],ramReg[taddr2],ramReg[taddr1],ramReg[taddr0]}:32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;

endmodule