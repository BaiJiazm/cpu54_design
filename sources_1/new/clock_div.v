`timescale 1ns / 1ps

module clock_div(
    input clk,            		//100MHz
    output reg clk_pulse       //200Hz
    );
    reg [20:0]  div_counter = 0;
    
    always @(posedge clk) begin
      if(div_counter>=50000) begin     
          clk_pulse<=1'b1;
          div_counter<= 20'd0;
        end else begin
          clk_pulse<=1'b0;
          div_counter <= div_counter + 1;
        end
end

endmodule