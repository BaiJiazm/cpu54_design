//位数扩展
parameter 
SIGNEXT=1'b1,
ZEROEXT=1'b0;

//异常入口地址
parameter
ExcInAddr=32'h4;

//指令操作码及函数码
parameter
addiOp	=6'h8,
addiuOp	=6'h9,
andiOp	=6'hC,
oriOp	=6'hD,
sltiuOp	=6'hB,
luiOp	=6'hF,
xoriOp	=6'hE,
sltiOp	=6'hA,
adduOp	=6'h0,	adduFunc=6'h21,
andOp	=6'h0,	andFunc	=6'h24,
beqOp	=6'h4,
bneOp	=6'h5,
jOp		=6'h2,
jalOp	=6'h3,
jrOp	=6'h0,	jrFunc	=6'h8,
lwOp	=6'h23,
xorOp	=6'h0,	xorFunc	=6'h26,
norOp	=6'h0,	norFunc	=6'h27,
orOp	=6'h0,	orFunc	=6'h25,
sllOp	=6'h0,	sllFunc	=6'h0,
sllvOp	=6'h0,	sllvFunc=6'h4,
sltuOp	=6'h0,	sltuFunc=6'h2B,
sraOp	=6'h0,	sraFunc	=6'h3,
srlOp	=6'h0,	srlFunc	=6'h2,
subuOp	=6'h0,	subuFunc=6'h23,
swOp	=6'h2B,
addOp	=6'h0,	addFunc	=6'h20,
subOp	=6'h0,	subFunc	=6'h22,
sltOp	=6'h0,	sltFunc	=6'h2A,
srlvOp	=6'h0,	srlvFunc=6'h6,
sravOp	=6'h0,	sravFunc=6'h7,
clzOp	=6'h1C,	clzFunc	=6'h20,
divuOp	=6'h0,	divuFunc=6'h1B,
eretOp	=6'h10,	eretFunc=6'h18,
jalrOp	=6'h0,	jalrFunc=6'h9,
lbOp	=6'h20,
lbuOp	=6'h24,
lhuOp	=6'h25,
sbOp	=6'h28,
shOp	=6'h29,
lhOp	=6'h21,
mfc0Op	=6'h10,	mfc0Func=6'h0,		mfc0Sp=5'h0,
mfhiOp	=6'h0,	mfhiFunc=6'h10,
mfloOp	=6'h0,	mfloFunc=6'h12,
mtc0Op	=6'h10,	mtc0Func=6'h0,		mtc0Sp=5'd4,
mthiOp	=6'h0,	mthiFunc=6'h11,
mtloOp	=6'h0,	mtloFunc=6'h13,
mulOp	=6'h1C,	mulFunc=6'h2,
multuOp	=6'h0,	multuFunc=6'h19,
syscallOp=6'h0,	syscallFunc=6'hC,
teqOp	=6'h0,	teqFunc	=6'h34,
bgezOp	=6'h1,
breakOp	=6'h0,	breakFunc=6'hD,
divOp	=6'h0,	divFunc	=6'h1A;

//ALU运算控制信号
parameter 	
ADDU=4'b0000,
ADD =4'b0010,
SUB =4'b0011,
SUBU=4'b0001,
AND =4'b0100,
OR  =4'b0101,
XOR =4'b0110,
NOR =4'b0111,
LUI =4'b1001,
SLT =4'b1011,
SLTU=4'b1010,
SRA =4'b1100,
SLL =4'b1111,
SRL =4'b1101;

//写DRAM宽度定义
parameter
SB	=4'b0001,
SH	=4'b0011,
SW	=4'b1111;

//CP0寄存器
parameter
STATUSADDR	=5'd12,
EPCADDR		=5'd14,
CAUSEADDR	=5'd13;
