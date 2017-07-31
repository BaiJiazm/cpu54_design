`timescale 1ns / 1ps
module extend 
#(parameter WIDTH = 16,parameter SIGN=1'b1)(
input [WIDTH - 1:0] in, //�������ݣ����ݿ�ȿ��Ը�����Ҫ���ж���
output [31:0] out //32 λ������ݣ�
);
	assign out={SIGN?{(32-WIDTH){in[WIDTH-1]}}:{(32-WIDTH){1'b0}},in};
endmodule