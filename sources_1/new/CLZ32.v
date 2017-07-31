//shared-carry-propagate for 32bits
`timescale 1ns / 1ps
module CLZ32(rd,rs);
  input [31:0] rs;
  output [5:0] rd;
  
  wire [4:0] rd1,rd2;
  wire [5:0] trd;
  CLZ16 clz16_1(.rd(rd1),.rs(rs[31:16]));
  CLZ16 clz16_2(.rd(rd2),.rs(rs[15:0]));
  
  assign trd[5]=~(rd1[4]|rd2[4]);	// V
  assign trd[4]=~(rd1[4]);	// Z4
  
  assign trd[3]=~(rd1[3]|(~rd1[4]&rd2[3]));	// Z3
  assign trd[2]=~(rd1[2]|(~rd1[4]&rd2[2]));	// Z2
  assign trd[1]=~(rd1[1]|(~rd1[4]&rd2[1]));	// Z1
  assign trd[0]=~(rd1[0]|(~rd1[4]&rd2[0]));	// Z0

  assign rd=trd[5]?6'h20:trd;
endmodule
