`timescale 1ns / 1ps
module Regfiles(
input clk, 			//�Ĵ�����ʱ���źţ��½���д������
input rst, 			//reset�źţ��ߵ�ƽʱȫ���Ĵ�������
input we, 			//�Ĵ�����д��Ч�źţ��ߵ�ƽʱ����Ĵ���д�����ݣ��͵�ƽʱ����Ĵ�����������
input [4:0] raddr1, //�����ȡ�ļĴ����ĵ�ַ
input [4:0] raddr2, //�����ȡ�ļĴ����ĵ�ַ
input [4:0] waddr, 	//д�Ĵ����ĵ�ַ
input [31:0] wdata, //д�Ĵ������ݣ�������clk�½���ʱ��д��
output [31:0] rdata1, 	//raddr1 ����Ӧ�Ĵ������������
output [31:0] rdata2 	//raddr2 ����Ӧ�Ĵ������������
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