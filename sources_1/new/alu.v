`timescale 1ns / 1ps
module alu(
input [31:0] a, 		//32 λ���룬������1
input [31:0] b, 		//32 λ���룬������2
input [3:0] aluc, 		//4 λ���룬���� alu �Ĳ���
output reg [31:0] r, 	//32 λ�������a��b ����aluc ָ���Ĳ�������
output reg zero, 		//0 ��־λ
output reg carry, 		// ��λ��־λ
output reg negative,	// ������־λ
output reg overflow 	// �����־λ
);

`include "parameter.v"

	always @ (a or b or aluc)
	begin 
		casex (aluc)
			ADDU:begin 			//	Addu r=a+b �޷���	0 0 0 0
				{carry,r}=a+b;
				zero=!r?1:0;
				negative=r[31];end
			ADD:begin 			//	Add r=a+b �з���	0 0 1 0
				r=a+b;
				zero=!r?1:0;
				negative=r[31];
				overflow=a[31]&b[31]&~r[31] | ~a[31]&~b[31]&r[31];end
			SUBU:begin 			//	Subu r=a-b �޷���	0 0 0 1
				{carry,r}=a-b;
				zero=!r?1:0;
				negative=r[31];end
			SUB:begin 			//	Sub r=a-b �з���	0 0 1 1
				r=a-b;
				zero=!r?1:0;
				negative=r[31];
				overflow=(a[31]&~b[31]&~r[31]) | (~a[31]&b[31]&r[31]);end
			AND:begin 			//	And r=a & b 		0 1 0 0
				r=a&b;
				zero=!r?1:0;
				negative=r[31];end
			OR:begin 			//	Or r=a | b			0 1 0 1
				r=a|b;
				zero=!r?1:0;
				negative=r[31];end
			XOR:begin 			//	Xor r=a ^ b 		0 1 1 0
				r=a^b;
				zero=!r?1:0;
				negative=r[31];end
			NOR:begin 			//	Nor r=~��a | b�� 	0 1 1 1
				r=~(a|b);
				zero=!r?1:0;
				negative=r[31];end
			LUI:begin 			//	Lui r={b[15:0],16��b0} 	1 0 0 X
				r={b[15:0],16'b0};
				zero=!r?1:0;
				negative=r[31];end
			SLT:begin 			//	Slt r=(a<b)?1:0 �з���	1 0 1 1
				r=($signed(a)<$signed(b))?1:0;
				zero=!(a-b);
				negative=r[0];end
			SLTU:begin 			//	Sltu r=(a<b)?1:0 �޷���	1 0 1 0
				r=(a<b)?1:0;
				carry=r[0];
				zero=!(a-b);
				negative=r[31];end
			SRA:begin 			//	Sra r=b>>>a 			1 1 0 0
				{r,carry}={{31{b[31]}},b,1'b0}>>a[4:0];
				zero=!r?1:0;
				negative=r[31];end
			SLL:begin			//	Sll/Slr r=b<<a 			1 1 1 X
				{carry,r}=b<<a[4:0];
				zero=!r?1:0;
				negative=r[31];end
			SRL:begin 			//	Srl r=b>>a 			1 1 0 1
				{r,carry}={b,1'b0}>>a[4:0];
				//r=b>>a;
				zero=!r?1:0;
				negative=r[31];end
		endcase
	end
	
endmodule