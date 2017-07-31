`timescale 1ns / 1ps
module ram (
input clk, 				//�洢��ʱ���źţ�������ʱ��ram �ڲ�д������
input ena, 				//�洢����Ч�źţ��ߵ�ƽʱ�洢�������У��������z
input wena, 			//�洢��д��Ч�źţ��ߵ�ƽ��Ч����enaͬʱ��Чʱ�ſ�д�洢��
input [3:0] byteEna,	//�ֽ�ʹ�ܣ����ƿ��
input [31:0] addr, 		//�����ַ��ָ�����ݶ�д�ĵ�ַ
input [31:0] data_in, 	//�洢��д������ݣ���clk������ʱ��д��
output [31:0] data_out 	//�洢�����������ݣ�
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