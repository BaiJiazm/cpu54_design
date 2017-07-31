//shared-carry-propagate for 16bits
`timescale 1ns / 1ps
module CLZ16(rd,rs);
  input [15:0] rs;
  output [4:0] rd;
  
  wire [7:0] or0;
  wire [3:0] or1,scmc1,scmc2;
  wire [1:0] or2;
  
  // OR tree
  assign or0[7]=rs[15]|rs[14];
  assign or0[6]=rs[13]|rs[12];
  assign or0[5]=rs[11]|rs[10];
  assign or0[4]=rs[9]|rs[8];
  assign or0[3]=rs[7]|rs[6];
  assign or0[2]=rs[5]|rs[4];
  assign or0[1]=rs[3]|rs[2];
  assign or0[0]=rs[1]|rs[0];
  
  assign or1[3]=or0[7]|or0[6];
  assign or1[2]=or0[5]|or0[4];
  assign or1[1]=or0[3]|or0[2];
  assign or1[0]=or0[1]|or0[0];
  
  assign or2[1]=or1[3]|or1[2];
  assign or2[0]=or1[1]|or1[0];
  
  assign rd[4]=or2[1]|or2[0];	// V
  assign rd[3]=or2[1];	// Z3
  
  //simplified carry merge cell tree
  assign scmc1[3]=rs[15]|(~or0[7]&rs[13]);
  assign scmc1[2]=rs[11]|(~or0[5]&rs[9]);
  assign scmc1[1]=rs[7]|(~or0[3]&rs[5]);
  assign scmc1[0]=rs[3]|(~or0[1]&rs[1]);
  
  assign scmc2[3]=scmc1[3]|(~or1[3]&scmc1[2]);
  assign scmc2[2]=or0[7]|(~or1[3]&or0[5]);
  assign scmc2[1]=scmc1[1]|(~or1[1]&scmc1[0]);
  assign scmc2[0]=or0[3]|(~or1[1]&or0[1]);
  
  assign rd[2]=or1[3]|(~or2[1]&or1[1]);	// Z2
  assign rd[1]=scmc2[2]|(~or2[1]&scmc2[0]);	// Z1
  assign rd[0]=scmc2[3]|(~or2[1]&scmc2[1]);	// Z0
  
endmodule