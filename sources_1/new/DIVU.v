`timescale 1ns / 1ps
module DIVU(
input [31:0]dividend,	//被除数
input [31:0]divisor,	//除数
input start,			//高位启动除法运算
input clock,			//上升沿有效
input reset,			//上升沿重置
output [31:0]q,			//商
output [31:0]r,			//余数
output reg busy				//除法器忙标志位
);

reg[4:0]count;
reg[31:0]reg_q;
reg[31:0]reg_r;
reg[31:0]reg_b;
reg r_sign;
wire [32:0]sub_add=r_sign?({reg_r,q[31]}+{1'b0,reg_b}):({reg_r,q[31]}-{1'b0,reg_b});

assign r=r_sign?reg_r+reg_b:reg_r;
assign q=reg_q;

always@(negedge clock or posedge reset) begin
	if (reset==1)begin
		count<=5'b0;
		busy<=1'b0;
	end else begin
		if (start)begin
			reg_r<=32'b0;
			r_sign<=1'b0;
			reg_q<=dividend;
			reg_b<=divisor;
			count<=5'b0;
			busy<=1'b1;
		end else if (busy) begin
			reg_r<=sub_add[31:0];
			r_sign<=sub_add[32];
			reg_q<={reg_q[30:0],~sub_add[32]};
			count<=count+5'b1;
			if (count==5'h1f)
				busy<=1'b0;
		end
	end
end

endmodule
