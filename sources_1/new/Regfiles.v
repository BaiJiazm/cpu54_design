`timescale 1ns / 1ps
module Regfiles(
input clk, 			//寄存器组时钟信号，下降沿写入数据
input rst, 			//reset信号，高电平时全部寄存器置零
input we, 			//寄存器读写有效信号，高电平时允许寄存器写入数据，低电平时允许寄存器读出数据
input [4:0] raddr1, //所需读取的寄存器的地址
input [4:0] raddr2, //所需读取的寄存器的地址
input [4:0] waddr, 	//写寄存器的地址
input [31:0] wdata, //写寄存器数据，数据在clk下降沿时被写入
output [31:0] rdata1, 	//raddr1 所对应寄存器的输出数据
output [31:0] rdata2 	//raddr2 所对应寄存器的输出数据
);
	reg [31:0] regfiles [31:0];
	reg [31:0] i;

    assign rdata1=regfiles[raddr1];
	assign rdata2=regfiles[raddr2];
	always@(posedge rst or negedge clk)begin
		if(rst)
			for(i=0;i<=31;i=i+1)
				regfiles[i]<=32'd0;
		else if(we&&waddr)
			regfiles[waddr]<=wdata;
	end
endmodule