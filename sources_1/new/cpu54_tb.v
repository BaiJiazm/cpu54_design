`timescale 1ns / 1ps
module cpu54_tb();
	reg reset;
	reg clk;

	wire [31:0] data0;
	cpu54 cpu1(reset, clk,data0);
	
	initial begin
		reset = 1;
		clk=0;
		#33 reset = 0;
		#29000 ;
	end
    
    always begin
        #10 clk = ~clk;
     end

endmodule
