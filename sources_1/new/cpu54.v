`timescale 1ns / 1ps
module cpu54(
input wire rst, 
input wire clk,
input wire [15:0] inputSw,
output [7:0] o_seg,
output [7:0] o_sel
);

`include "parameter.v"

//定义名字类型
wire lb,lbu,lh,lhu,lw;
wire sb,sh,sw;
wire add,addu,sub,subu,mul,multu,div,divu,sll,srl,sra,sllv,srlv,srav,slt,sltu,andd,orr,xorr,norr,clz;
wire addi,addiu,andi,ori,xori,lui,slti,sltiu;
wire beq,bne,bgez;
wire j,jal,jalr,jr;
wire mfhi,mflo,mthi,mtlo;
wire eret,mfc0,mtc0;
wire breakk,syscall,teq;

wire [31:0]Instruction;

wire RegfilesW;
wire [4:0]Rsc,Rtc,Rdc;
wire [31:0]Rd,Rt,Rs;

wire [31:0] ALUAIn,ALUBIn,ALUOut;
wire [3:0]aluc;
wire zero,carry,negative,overflow;

wire DMemEna,DMemWEna;
wire [3:0] byteEna;
wire [31:0]DMemAddr;
wire [31:0]DMemDataIn;
wire [31:0]DMemOut,DMemOutExt8,DMemOutZeroExt8,DMemOutExt16,DMemOutZeroExt16;

wire [63:0]MultOut;
wire [31:0]MultOut63_32,MultOut31_0;

wire [63:0]MultUOut;
wire [31:0]MultUOut63_32,MultUOut31_0;

wire start,busy1,busy2;
wire [31:0]DivOutQ,DivOutR;

wire [31:0]DivUOutQ,DivUOutR;

reg [31:0]HignReg,LowReg;
wire HignWEna,LowWEna;
wire [31:0] HignWData,LowWData;

wire [31:0] ClzOut;
wire [5:0]	clzOut;

wire exception;
wire [4:0] cause;
wire [31:0] CP0RData,CP0ExtAddr,CP0Status;

/*
 ******************************指令计数器
*/

wire [31:0]nextPC,NPC;
wire [31:0]JumpII,BranchAddr;
wire [31:0]Ext18;
reg [31:0] PC;

assign Ext18={{14{Instruction[15]}},Instruction[15:0],2'b00};

assign NPC=PC+32'd4;
assign JumpII={PC[31:28],Instruction[25:0],2'b00};
assign BranchAddr=Ext18+NPC;

assign nextPC=		//busy?nextPC:
					jr|jalr?Rs:
					(beq&zero)|(bne&~zero)|(bgez&!negative)?BranchAddr:
					j|jal?JumpII:
					eret?CP0ExtAddr:
					exception?ExcInAddr:
					NPC;
					
always @(posedge rst or posedge clk)
	if(rst)
		PC<=32'h00400000;
	else if(~busy)
		PC<=nextPC;
		

/*
 ******************************指令寄存器
*/		

/* wire [31:0]Instruction; */

//自定义	IMem
/* wire IMemEna=1'b1;
wire [31:0] IMPC =rst?32'h00400000:nextPC;
iram IMem_inst(
.addr(PC),.data_out(Instruction)); */

//IP核	IMem
wire [10:0] IPPC =PC[12:2];
dist_mem_gen_0 IMem_inst(.a(IPPC),.spo(Instruction));

wire [5:0]Op,Func;
/* wire lb,lbu,lh,lhu,lw;
wire sb,sh,sw;
wire add,addu,sub,subu,mul,multu,div,divu,sll,srl,sra,sllv,srlv,srav,slt,sltu,andd,orr,xorr,norr,clz;
wire addi,addiu,andi,ori,xori,lui,slti,sltiu;
wire beq,bne,bgez;
wire j,jal,jalr,jr;
wire mfhi,mflo,mthi,mtlo;
wire eret,mfc0,mtc0;
wire breakk,syscall,teq; */

assign Op=Instruction[31:26];
assign Func=Instruction[5:0];

assign addi	=Op==addiOp	;
assign addiu=Op==addiuOp;
assign andi	=Op==andiOp	;
assign ori	=Op==oriOp	;
assign sltiu=Op==sltiuOp;
assign lui	=Op==luiOp	;
assign xori	=Op==xoriOp	;
assign slti	=Op==sltiOp	;
assign addu	=Op==adduOp	&&Func==adduFunc;
assign andd	=Op==andOp	&&Func==andFunc	;
assign beq	=Op==beqOp	;
assign bne	=Op==bneOp	;
assign j	=Op==jOp	;
assign jal	=Op==jalOp	;
assign jr	=Op==jrOp	&&Func==jrFunc	;
assign lw	=Op==lwOp	;
assign xorr	=Op==xorOp	&&Func==xorFunc	;
assign norr	=Op==norOp	&&Func==norFunc	;
assign orr	=Op==orOp	&&Func==orFunc	;
assign sll	=Op==sllOp	&&Func==sllFunc	;
assign sllv	=Op==sllvOp	&&Func==sllvFunc;
assign sltu	=Op==sltuOp	&&Func==sltuFunc;
assign sra	=Op==sraOp	&&Func==sraFunc	;
assign srl	=Op==srlOp	&&Func==srlFunc	;
assign subu	=Op==subuOp	&&Func==subuFunc;
assign sw	=Op==swOp	;
assign add	=Op==addOp	&&Func==addFunc	;
assign sub	=Op==subOp	&&Func==subFunc	;
assign slt	=Op==sltOp	&&Func==sltFunc	;
assign srlv	=Op==srlvOp	&&Func==srlvFunc;
assign srav	=Op==sravOp	&&Func==sravFunc;
assign clz	=Op==clzOp	&&Func==clzFunc	;
assign divu	=Op==divuOp	&&Func==divuFunc;
assign eret	=Op==eretOp	&&Func==eretFunc;
assign jalr	=Op==jalrOp	&&Func==jalrFunc;
assign lb	=Op==lbOp	;
assign lbu	=Op==lbuOp	;
assign lhu	=Op==lhuOp	;
assign sb	=Op==sbOp	;
assign sh	=Op==shOp	;
assign lh	=Op==lhOp	;
assign mfc0	=Op==mfc0Op	&&Func==mfc0Func&&(Instruction[25:21]==mfc0Sp);
assign mfhi	=Op==mfhiOp	&&Func==mfhiFunc;
assign mflo	=Op==mfloOp	&&Func==mfloFunc;
assign mtc0	=Op==mtc0Op	&&Func==mtc0Func&&(Instruction[25:21]==mtc0Sp);
assign mthi	=Op==mthiOp	&&Func==mthiFunc;
assign mtlo	=Op==mtloOp	&&Func==mtloFunc;
assign mul	=Op==mulOp	&&Func==mulFunc;
assign multu=Op==multuOp&&Func==multuFunc;
assign syscall=Op==syscallOp&&Func==syscallFunc;
assign teq	=Op==teqOp	&&Func==teqFunc	;
assign bgez	=Op==bgezOp	;
assign breakk=Op==breakOp&&Func==breakFunc;
assign div	=Op==divOp	&&Func==divFunc	;


/*
 ******************************寄存器堆
*/

/* wire RegfilesW;
wire [4:0]Rsc,Rtc,Rdc;
wire [31:0]Rd,Rt,Rs; */

assign Rsc=	Instruction[25:21];
assign Rtc=	Instruction[20:16];
assign Rdc=	jal?5'd31:
			(lb|lbu|lh|lhu|lw|addi|addiu|andi|ori|xori|lui|slti|sltiu|mfc0)? Instruction[20:16]:
			Instruction[15:11];
assign Rd=	lb?DMemOutExt8:
			lbu?DMemOutZeroExt8:
			lh?DMemOutExt16:
			lhu?DMemOutZeroExt16:
			lw?DMemOut:
			(jal|jalr)?NPC:
			mfhi?HignReg:
			mflo?LowReg:
			mfc0?CP0RData:
			clz?ClzOut:
			mul?MultOut31_0:
			ALUOut;
			
assign RegfilesW=	lb|lbu|lh|lhu|lw|
					add|addu|sub|subu|sll|srl|sra|sllv|srlv|srav|slt|sltu|mul|
					andd|orr|xorr|norr|clz|
					addi|addiu|andi|ori|xori|slti|sltiu|lui|
					jal|jalr|
					mfhi|mflo|mfc0;

Regfiles regfiles_inst (.clk(clk),.rst(rst),.we(RegfilesW),.raddr1(Rsc),.raddr2(Rtc),.waddr(Rdc),.wdata(Rd),.rdata1(Rs),.rdata2(Rt));

/*
 ******************************ALU模块
*/
wire [15:0] offset	=Instruction[15:0];
wire [4:0] shamt	=Instruction[10:6];

wire [31:0] Ext5,Ext16,ZeroExt16;
extend #(.WIDTH(5),.SIGN(ZEROEXT)) Ext5_inst(.in(shamt),.out(Ext5));
extend #(.WIDTH(16),.SIGN(SIGNEXT)) Ext16_inst(.in(offset),.out(Ext16));
extend #(.WIDTH(16),.SIGN(ZEROEXT)) ZeroExt16_inst(.in(offset),.out(ZeroExt16));

/* wire [31:0] ALUAIn,ALUBIn,ALUOut;
wire [3:0]aluc;
wire zero,carry,negative,overflow; */

assign ALUAIn	=sll|srl|sra?Ext5:Rs;
assign ALUBIn	=(andi|ori|xori|lui)?ZeroExt16:
				(lb|lbu|lh|lhu|lw|sb|sh|sw|addi|addiu|slti|sltiu)?Ext16:
				bgez?32'd0:
				Rt;

assign aluc=	(lb|lbu|lh|lhu|lw|sb|sh|sw|add|addi)?ADD:
				(addu|addiu)?ADDU:
				(sub)?SUB:
				(subu)?SUBU:
				(sll|sllv)?SLL:
				(srl|srlv)?SRL:
				(sra|srav)?SRA:
				(andd|andi)?AND:
				(orr|ori)?OR:
				(xorr|xori)?XOR:
				(norr)?NOR:
				lui?LUI:
				(sltu|sltiu)?SLTU:
				SLT;
				
alu alu_inst(.a(ALUAIn),.b(ALUBIn),.aluc(aluc),.r(ALUOut),.zero(zero),.negative(negative),.carry(carry),.overflow(overflow));


/*
 ******************************数据存储器
*/

/* wire DMemEna,DMemWEna;
wire [3:0] byteEna;
wire [31:0]DMemAddr;
wire [31:0]DMemDataIn;
wire [31:0]DMemOut,DMemOutExt8,DMemOutZeroExt8,DMemOutExt16,DMemOutZeroExt16; */

assign DMemEna	=lb|lbu|lh|lhu|lw|sb|sh|sw;
assign DMemWEna	=sb|sh|sw;
assign DMemAddr	=ALUOut;
assign DMemDataIn=Rt;
assign byteEna	=sb?SB:sh?SH:SW;

wire [31:0] DMemOutXX;
ram Dram_inst(.clk(clk),.ena(DMemEna),.wena(DMemWEna),.byteEna(byteEna),.addr(DMemAddr),.data_in(DMemDataIn),.data_out(DMemOutXX));

assign DMemOutExt8		={{24{DMemOut[7]}},DMemOut[7:0]};
assign DMemOutZeroExt8	={{24{1'b0}},DMemOut[7:0]};
assign DMemOutExt16		={{16{DMemOut[15]}},DMemOut[15:0]};
assign DMemOutZeroExt16	={{16{1'b0}},DMemOut[15:0]};


//助教外部接口
wire seg7_cs,switch_cs;
wire [31:0] switch_cs32={31'b0,switch_cs};

seg7x16 seg7( .clk(clk), .reset(rst), .cs(seg7_cs), .i_data(DMemDataIn), .o_seg(o_seg), .o_sel(o_sel));

sw_mem_sel sw_mem(.switch_cs(switch_cs32),.sw(inputSw), .data(DMemOutXX), .data_sel(DMemOut));

io_sel io_mem(.addr(DMemAddr), .cs(DMemEna), .sig_w(DMemWEna), .sig_r(~DMemWEna), .seg7_cs(seg7_cs), .switch_cs(switch_cs));


/*
 ******************************乘法器
*/
/* wire [63:0]MultOut;
wire [31:0]MultOut63_32,MultOut31_0; */
assign {MultOut63_32,MultOut31_0}=MultOut;
MULT mult_inst(.clk(clk),.reset(rst),.a(Rs),.b(Rt),.z(MultOut));

/* wire [63:0]MultUOut;
wire [31:0]MultUOut63_32,MultUOut31_0; */
assign {MultUOut63_32,MultUOut31_0}=MultUOut;
MULTU multu_inst(.clk(clk),.reset(rst),.a(Rs),.b(Rt),.z(MultUOut));


/*
 ******************************除法器
*/
/* wire start,busy1,busy2;
wire [31:0]DivOutQ,DivOutR; */
assign start=(div|divu)&~busy;
assign busy=busy1|busy2;
DIV div_inst(.dividend(Rs),.divisor(Rt),.start(start),.clock(clk),.reset(rst),.q(DivOutQ),.r(DivOutR),.busy(busy1));

/* wire [31:0]DivUOutQ,DivUOutR; */
DIVU divu_inst(.dividend(Rs),.divisor(Rt),.start(start),.clock(clk),.reset(rst),.q(DivUOutQ),.r(DivUOutR),.busy(busy2));


/*
 ******************************Hign Low 寄存器
*/
/* reg [31:0]HignReg,LowReg;
wire HignWEna,LowWEna;
wire [31:0] HignWData,LowWData; */

assign HignWEna	=mul|multu|div|divu|mthi;
assign LowWEna	=mul|multu|div|divu|mtlo;
assign HignWData=mul?MultOut63_32:
				 multu?MultUOut63_32:
				 div?DivOutR:
				 divu?DivUOutR:
				 Rs;
assign LowWData= mul?MultOut31_0:
				 multu?MultUOut31_0:
				 div?DivOutQ:
				 divu?DivUOutQ:
				 Rs;

always @(posedge clk or posedge rst)begin
	if(rst)
		HignReg<=32'd0;
	else if(HignWEna)
		HignReg<=HignWData;
end

always @(posedge clk or posedge rst)begin
	if(rst)
		LowReg<=32'd0;
	else if(LowWEna)
		LowReg<=LowWData;
end


/*
 ******************************CLZ
*/
/* wire [31:0] ClzOut
wire [5:0]	clzOut; */

CLZ32 clz32_inst (.rs(Rs),.rd(clzOut));
assign ClzOut={26'd0,clzOut};


/*
 ******************************CP0
*/

/* wire exception;
wire [4:0] cause;
wire [31:0] CP0RData,CP0ExtAddr,CP0Status; */

wire instr=1'b0;
assign exception=breakk|teq|syscall|instr;
assign cause=	syscall?5'b01000:
				breakk?5'b01001:
				teq?5'b01101:
				instr?5'd0:
				5'h1f;
				
CP0 cp0_inst(.clk(clk),.rst(rst),.mfc0(mfc0),.mtc0(mtc0),.eret(eret),.exception(exception),.cause(cause),.addr(Instruction[15:11]),.data(Rt),.pc(PC),.rdata(CP0RData),.status(CP0Status),.exc_addr(CP0ExtAddr));

endmodule