`timescale 1ns / 1ps
module DIV(
input [31:0]dividend,	//������
input [31:0]divisor,	//����
input start,			//��λ������������
input clock,			//��������Ч
input reset,			//����������
output [31:0]q,			//��
output [31:0]r,			//����
output busy				//������æ��־λ
);

wire [31:0] udividend=dividend[31]?(~dividend+1):dividend;
wire [31:0] udivisor=divisor[31]?(~divisor+1):divisor;
wire [31:0]	ur;
wire [31:0]	uq;

DIVU divu_inst(.dividend(udividend),.divisor(udivisor),.start(start),.clock(clock),.reset(reset),.q(uq),.r(ur),.busy(busy));

assign q=~(dividend[31]^divisor[31])?uq:(~uq+1);
assign r=dividend[31]?(~ur+1):ur;

endmodule
