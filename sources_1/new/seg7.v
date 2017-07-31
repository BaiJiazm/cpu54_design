`timescale 1ns / 1ps

module seg7(
    input clk,//200Hz
	input rst,
    input [31:0] data,
    output [7:0] abcdefg, 
    output [7:0] showPort
    );
	
    reg [3:0] showData;
	reg [7:0]showPort;
	reg [2:0]count;
	
    display7 inst3(.iData(showData),.oData(abcdefg));
	
	always@(posedge clk or posedge rst) begin
		if(rst)begin
			count<=32'b0;
		end
		else begin
			case (count)
				3'd0:begin showData<=data[3:0];  showPort<=8'b11111110;end
				3'd1:begin showData<=data[7:4];  showPort<=8'b11111101;end
				3'd2:begin showData<=data[11:8]; showPort<=8'b11111011;end
				3'd3:begin showData<=data[15:12];showPort<=8'b11110111;end
				3'd4:begin showData<=data[19:16];showPort<=8'b11101111;end
				3'd5:begin showData<=data[23:20];showPort<=8'b11011111;end
				3'd6:begin showData<=data[27:24];showPort<=8'b10111111;end
				3'd7:begin showData<=data[31:28];showPort<=8'b01111111;end
			endcase
			count<=count+1'b1;
		end
    end
endmodule
