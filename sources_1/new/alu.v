`timescale 1ns / 1ps
module alu(
input [31:0] a, 		//32 位输入，操作数1
input [31:0] b, 		//32 位输入，操作数2
input [3:0] aluc, 		//4 位输入，控制 alu 的操作
output reg [31:0] r, 	//32 位输出，由a、b 经过aluc 指定的操作生成
output reg zero, 		//0 标志位
output reg carry, 		// 进位标志位
output reg negative,	// 负数标志位
output reg overflow 	// 溢出标志位
);

`include "parameter.v"

	always @ (a or b or aluc)
	begin 
		casex (aluc)
			ADDU:begin 			//	Addu r=a+b 无符号	0 0 0 0
				{carry,r}=a+b;
				zero=!r?1:0;
				negative=r[31];end
			ADD:begin 			//	Add r=a+b 有符号	0 0 1 0
				r=a+b;
				zero=!r?1:0;
				negative=r[31];
				overflow=a[31]&b[31]&~r[31] | ~a[31]&~b[31]&r[31];end
			SUBU:begin 			//	Subu r=a-b 无符号	0 0 0 1
				{carry,r}=a-b;
				zero=!r?1:0;
				negative=r[31];end
			SUB:begin 			//	Sub r=a-b 有符号	0 0 1 1
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
			NOR:begin 			//	Nor r=~（a | b） 	0 1 1 1
				r=~(a|b);
				zero=!r?1:0;
				negative=r[31];end
			LUI:begin 			//	Lui r={b[15:0],16’b0} 	1 0 0 X
				r={b[15:0],16'b0};
				zero=!r?1:0;
				negative=r[31];end
			SLT:begin 			//	Slt r=(a<b)?1:0 有符号	1 0 1 1
				r=($signed(a)<$signed(b))?1:0;
				zero=!(a-b);
				negative=r[0];end
			SLTU:begin 			//	Sltu r=(a<b)?1:0 无符号	1 0 1 0
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