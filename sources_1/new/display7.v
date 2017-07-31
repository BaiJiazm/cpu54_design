`timescale 1ns / 1ps
module display7(
input [3:0] iData,//四位输入D3~D0
output  reg [7:0] oData //七位译码输出g~a
);
    always @ (iData)
    begin
        case (iData)
		  4'h0 : oData <= 8'hC0;
          4'h1 : oData <= 8'hF9;
          4'h2 : oData <= 8'hA4;
          4'h3 : oData <= 8'hB0;
          4'h4 : oData <= 8'h99;
          4'h5 : oData <= 8'h92;
          4'h6 : oData <= 8'h82;
          4'h7 : oData <= 8'hF8;
          4'h8 : oData <= 8'h80;
          4'h9 : oData <= 8'h90;
          4'hA : oData <= 8'h88;
          4'hB : oData <= 8'h83;
          4'hC : oData <= 8'hC6;
          4'hD : oData <= 8'hA1;
          4'hE : oData <= 8'h86;
          4'hF : oData <= 8'h8E;
        endcase
    end 
    endmodule
