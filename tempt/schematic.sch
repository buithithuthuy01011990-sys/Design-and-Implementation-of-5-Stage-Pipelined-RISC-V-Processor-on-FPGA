# File saved with Nlview 7.0.19  2019-03-26 bk=1.5019 VDI=41 GEI=35 GUI=JA:9.0 non-TLS-threadsafe
# 
# non-default properties - (restore without -noprops)
property attrcolor #000000
property attrfontsize 8
property autobundle 1
property backgroundcolor #ffffff
property boxcolor0 #000000
property boxcolor1 #000000
property boxcolor2 #000000
property boxinstcolor #000000
property boxpincolor #000000
property buscolor #008000
property closeenough 5
property createnetattrdsp 2048
property decorate 1
property elidetext 40
property fillcolor1 #ffffcc
property fillcolor2 #dfebf8
property fillcolor3 #f0f0f0
property gatecellname 2
property instattrmax 30
property instdrag 15
property instorder 1
property marksize 12
property maxfontsize 18
property maxzoom 7.5
property netcolor #19b400
property objecthighlight0 #ff00ff
property objecthighlight1 #ffff00
property objecthighlight2 #00ff00
property objecthighlight3 #ff6666
property objecthighlight4 #0000ff
property objecthighlight5 #ffc800
property objecthighlight7 #00ffff
property objecthighlight8 #ff00ff
property objecthighlight9 #ccccff
property objecthighlight10 #0ead00
property objecthighlight11 #cefc00
property objecthighlight12 #9e2dbe
property objecthighlight13 #ba6a29
property objecthighlight14 #fc0188
property objecthighlight15 #02f990
property objecthighlight16 #f1b0fb
property objecthighlight17 #fec004
property objecthighlight18 #149bff
property objecthighlight19 #eb591b
property overlapcolor #19b400
property pbuscolor #000000
property pbusnamecolor #000000
property pinattrmax 20
property pinorder 2
property pinpermute 0
property portcolor #000000
property portnamecolor #000000
property ripindexfontsize 8
property rippercolor #000000
property rubberbandcolor #000000
property rubberbandfontsize 18
property selectattr 0
property selectionappearance 2
property selectioncolor #0000ff
property sheetheight 44
property sheetwidth 68
property showmarks 1
property shownetname 0
property showpagenumbers 1
property showripindex 4
property timelimit 1
#
module new tb_decode work:tb_decode:NOFILE -nosplit
load symbol RTL_INV work INV pin I0 input pin O output fillcolor 1
load symbol decode_cycle work:decode_cycle:NOFILE HIERBOX pin ALUSrcE output.right pin BranchE output.right pin JumpE output.right pin MemWriteE output.right pin RegWriteE output.right pin RegWriteW input.left pin clk input.left pin reset input.left pinBus ALUControlE output.right [2:0] pinBus Imm_Ext_E output.right [31:0] pinBus InstrD input.left [31:0] pinBus PCD input.left [31:0] pinBus PCE output.right [31:0] pinBus PCPlus4D input.left [31:0] pinBus PCPlus4E output.right [31:0] pinBus RD1_E output.right [31:0] pinBus RD2_E output.right [31:0] pinBus RDW input.left [4:0] pinBus RD_E output.right [4:0] pinBus RS1_E output.right [4:0] pinBus RS2_E output.right [4:0] pinBus ResultSrcE output.right [1:0] pinBus ResultW input.left [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol RTL_REG_ASYNC__BREG_1 workCLR GEN pin C input.clk.left pin CLR input.neg.top pin D input.left pin Q output.right fillcolor 1
load symbol Control_Unit_Top work:Control_Unit_Top:NOFILE HIERBOX pin ALUSrc output.right pin Branch output.right pin Jump output.right pin MemWrite output.right pin RegWrite output.right pinBus ALUControl output.right [2:0] pinBus ImmSrc output.right [1:0] pinBus Op input.left [6:0] pinBus ResultSrc output.right [1:0] pinBus funct3 input.left [2:0] pinBus funct7 input.left [6:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol extend work:extend:NOFILE HIERBOX pinBus ImmSrc input.left [1:0] pinBus Imm_Ext output.right [31:0] pinBus In input.left [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol Register_File work:Register_File:NOFILE HIERBOX pin WE3 input.left pin clk input.left pin reset input.left pinBus A1 input.left [4:0] pinBus A2 input.left [4:0] pinBus A3 input.left [4:0] pinBus RD1 output.right [31:0] pinBus RD2 output.right [31:0] pinBus WD3 input.left [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol RTL_REG_ASYNC__BREG_1 workCLR[2:0]ssww GEN pin C input.clk.left pin CLR input.neg.top pinBus D input.left [2:0] pinBus Q output.right [2:0] fillcolor 1 sandwich 3 prop @bundle 3
load symbol RTL_REG_ASYNC__BREG_1 workCLR[1:0]ssww GEN pin C input.clk.left pin CLR input.neg.top pinBus D input.left [1:0] pinBus Q output.right [1:0] fillcolor 1 sandwich 3 prop @bundle 2
load symbol RTL_REG_ASYNC__BREG_1 workCLR[4:0]ssww GEN pin C input.clk.left pin CLR input.neg.top pinBus D input.left [4:0] pinBus Q output.right [4:0] fillcolor 1 sandwich 3 prop @bundle 5
load symbol RTL_REG_ASYNC__BREG_1 workCLR[31:0]ssww GEN pin C input.clk.left pin CLR input.neg.top pinBus D input.left [31:0] pinBus Q output.right [31:0] fillcolor 1 sandwich 3 prop @bundle 32
load symbol ALU_Decoder work:ALU_Decoder:NOFILE HIERBOX pinBus ALUControl output.right [2:0] pinBus ALUOp input.left [1:0] pinBus Op input.left [6:0] pinBus funct3 input.left [2:0] pinBus funct7 input.left [6:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol Main_Decoder work:Main_Decoder:NOFILE HIERBOX pin ALUSrc output.right pin Branch output.right pin Jump output.right pin MemWrite output.right pin RegWrite output.right pinBus ALUOp output.right [1:0] pinBus ImmSrc output.right [1:0] pinBus Op input.left [6:0] pinBus ResultSrc output.right [1:0] boxcolor 1 fillcolor 2 minwidth 13%
load inst RTL_INV RTL_INV work -attr @cell(#000000) RTL_INV -pg 1 -lvl 1 -x 240 -y 2098
load inst uut decode_cycle work:decode_cycle:NOFILE -autohide -attr @cell(#000000) decode_cycle -attr @fillcolor #fafafa -pinAttr ALUSrcE @attr n/c -pinAttr BranchE @attr n/c -pinAttr JumpE @attr n/c -pinAttr MemWriteE @attr n/c -pinAttr RegWriteE @attr n/c -pinBusAttr ALUControlE @name ALUControlE[2:0] -pinBusAttr ALUControlE @attr n/c -pinBusAttr Imm_Ext_E @name Imm_Ext_E[31:0] -pinBusAttr Imm_Ext_E @attr n/c -pinBusAttr InstrD @name InstrD[31:0] -pinBusAttr PCD @name PCD[31:0] -pinBusAttr PCE @name PCE[31:0] -pinBusAttr PCE @attr n/c -pinBusAttr PCPlus4D @name PCPlus4D[31:0] -pinBusAttr PCPlus4D @attr V=X\"00000004\" -pinBusAttr PCPlus4E @name PCPlus4E[31:0] -pinBusAttr PCPlus4E @attr n/c -pinBusAttr RD1_E @name RD1_E[31:0] -pinBusAttr RD1_E @attr n/c -pinBusAttr RD2_E @name RD2_E[31:0] -pinBusAttr RD2_E @attr n/c -pinBusAttr RDW @name RDW[4:0] -pinBusAttr RD_E @name RD_E[4:0] -pinBusAttr RD_E @attr n/c -pinBusAttr RS1_E @name RS1_E[4:0] -pinBusAttr RS1_E @attr n/c -pinBusAttr RS2_E @name RS2_E[4:0] -pinBusAttr RS2_E @attr n/c -pinBusAttr ResultSrcE @name ResultSrcE[1:0] -pinBusAttr ResultSrcE @attr n/c -pinBusAttr ResultW @name ResultW[31:0] -pg 1 -lvl 1 -x 240 -y 68
load inst uut|ALUSrcD_r_reg RTL_REG_ASYNC__BREG_1 workCLR -hier uut -attr @cell(#000000) RTL_REG_ASYNC -attr @name ALUSrcD_r_reg -pg 1 -lvl 3 -x 1670 -y 108
load inst uut|BranchD_r_reg RTL_REG_ASYNC__BREG_1 workCLR -hier uut -attr @cell(#000000) RTL_REG_ASYNC -attr @name BranchD_r_reg -pg 1 -lvl 3 -x 1670 -y 228
load inst uut|JumpD_r_reg RTL_REG_ASYNC__BREG_1 workCLR -hier uut -attr @cell(#000000) RTL_REG_ASYNC -attr @name JumpD_r_reg -pg 1 -lvl 3 -x 1670 -y 608
load inst uut|MemWriteD_r_reg RTL_REG_ASYNC__BREG_1 workCLR -hier uut -attr @cell(#000000) RTL_REG_ASYNC -attr @name MemWriteD_r_reg -pg 1 -lvl 3 -x 1670 -y 728
load inst uut|RegWriteD_r_reg RTL_REG_ASYNC__BREG_1 workCLR -hier uut -attr @cell(#000000) RTL_REG_ASYNC -attr @name RegWriteD_r_reg -pg 1 -lvl 3 -x 1670 -y 848
load inst uut|control Control_Unit_Top work:Control_Unit_Top:NOFILE -hier uut -autohide -attr @cell(#000000) Control_Unit_Top -attr @name control -attr @fillcolor #fafafa -pinBusAttr ALUControl @name ALUControl[2:0] -pinBusAttr ImmSrc @name ImmSrc[1:0] -pinBusAttr Op @name Op[6:0] -pinBusAttr ResultSrc @name ResultSrc[1:0] -pinBusAttr funct3 @name funct3[2:0] -pinBusAttr funct7 @name funct7[6:0] -pg 1 -lvl 1 -x 360 -y 536
load inst uut|extension extend work:extend:NOFILE -hier uut -autohide -attr @cell(#000000) extend -attr @name extension -pinBusAttr ImmSrc @name ImmSrc[1:0] -pinBusAttr Imm_Ext @name Imm_Ext[31:0] -pinBusAttr In @name In[31:0] -pg 1 -lvl 2 -x 1310 -y 688
load inst uut|rf Register_File work:Register_File:NOFILE -hier uut -autohide -attr @cell(#000000) Register_File -attr @name rf -pinBusAttr A1 @name A1[4:0] -pinBusAttr A2 @name A2[4:0] -pinBusAttr A3 @name A3[4:0] -pinBusAttr RD1 @name RD1[31:0] -pinBusAttr RD2 @name RD2[31:0] -pinBusAttr WD3 @name WD3[31:0] -pg 1 -lvl 2 -x 1310 -y 1698
load inst uut|ALUControlD_r_reg[2:0] RTL_REG_ASYNC__BREG_1 workCLR[2:0]ssww -hier uut -attr @cell(#000000) RTL_REG_ASYNC -attr @name ALUControlD_r_reg[2:0] -pg 1 -lvl 3 -x 1670 -y 478
load inst uut|ResultSrcD_r_reg[1:0] RTL_REG_ASYNC__BREG_1 workCLR[1:0]ssww -hier uut -attr @cell(#000000) RTL_REG_ASYNC -attr @name ResultSrcD_r_reg[1:0] -pg 1 -lvl 3 -x 1670 -y 1358
load inst uut|RS2_D_r_reg[4:0] RTL_REG_ASYNC__BREG_1 workCLR[4:0]ssww -hier uut -attr @cell(#000000) RTL_REG_ASYNC -attr @name RS2_D_r_reg[4:0] -pg 1 -lvl 3 -x 1670 -y 1618
load inst uut|RS1_D_r_reg[4:0] RTL_REG_ASYNC__BREG_1 workCLR[4:0]ssww -hier uut -attr @cell(#000000) RTL_REG_ASYNC -attr @name RS1_D_r_reg[4:0] -pg 1 -lvl 3 -x 1670 -y 1488
load inst uut|RD2_D_r_reg[31:0] RTL_REG_ASYNC__BREG_1 workCLR[31:0]ssww -hier uut -attr @cell(#000000) RTL_REG_ASYNC -attr @name RD2_D_r_reg[31:0] -pg 1 -lvl 3 -x 1670 -y 1878
load inst uut|RD1_D_r_reg[31:0] RTL_REG_ASYNC__BREG_1 workCLR[31:0]ssww -hier uut -attr @cell(#000000) RTL_REG_ASYNC -attr @name RD1_D_r_reg[31:0] -pg 1 -lvl 3 -x 1670 -y 1748
load inst uut|RD_D_r_reg[4:0] RTL_REG_ASYNC__BREG_1 workCLR[4:0]ssww -hier uut -attr @cell(#000000) RTL_REG_ASYNC -attr @name RD_D_r_reg[4:0] -pg 1 -lvl 3 -x 1670 -y 1228
load inst uut|PCPlus4D_r_reg[31:0] RTL_REG_ASYNC__BREG_1 workCLR[31:0]ssww -hier uut -attr @cell(#000000) RTL_REG_ASYNC -attr @name PCPlus4D_r_reg[31:0] -pg 1 -lvl 3 -x 1670 -y 1098
load inst uut|PCD_r_reg[31:0] RTL_REG_ASYNC__BREG_1 workCLR[31:0]ssww -hier uut -attr @cell(#000000) RTL_REG_ASYNC -attr @name PCD_r_reg[31:0] -pg 1 -lvl 3 -x 1670 -y 968
load inst uut|Imm_Ext_D_r_reg[31:0] RTL_REG_ASYNC__BREG_1 workCLR[31:0]ssww -hier uut -attr @cell(#000000) RTL_REG_ASYNC -attr @name Imm_Ext_D_r_reg[31:0] -pg 1 -lvl 3 -x 1670 -y 348
load inst uut|control|ALU_Decoder ALU_Decoder work:ALU_Decoder:NOFILE -hier uut|control -autohide -attr @cell(#000000) ALU_Decoder -attr @name ALU_Decoder -pinBusAttr ALUControl @name ALUControl[2:0] -pinBusAttr ALUOp @name ALUOp[1:0] -pinBusAttr Op @name Op[6:0] -pinBusAttr funct3 @name funct3[2:0] -pinBusAttr funct7 @name funct7[6:0] -pg 1 -lvl 2 -x 740 -y 556
load inst uut|control|Main_Decoder Main_Decoder work:Main_Decoder:NOFILE -hier uut|control -autohide -attr @cell(#000000) Main_Decoder -attr @name Main_Decoder -pinBusAttr ALUOp @name ALUOp[1:0] -pinBusAttr ImmSrc @name ImmSrc[1:0] -pinBusAttr Op @name Op[6:0] -pinBusAttr ResultSrc @name ResultSrc[1:0] -pg 1 -lvl 1 -x 470 -y 676
load net <const0> -ground -pin uut RegWriteW -pin uut reset -pin uut InstrD[31] -pin uut InstrD[30] -pin uut InstrD[29] -pin uut InstrD[28] -pin uut InstrD[27] -pin uut InstrD[26] -pin uut InstrD[25] -pin uut InstrD[24] -pin uut InstrD[23] -pin uut InstrD[22] -pin uut InstrD[21] -pin uut InstrD[20] -pin uut InstrD[19] -pin uut InstrD[18] -pin uut InstrD[17] -pin uut InstrD[16] -pin uut InstrD[15] -pin uut InstrD[14] -pin uut InstrD[13] -pin uut InstrD[12] -pin uut InstrD[11] -pin uut InstrD[10] -pin uut InstrD[9] -pin uut InstrD[8] -pin uut InstrD[7] -pin uut InstrD[6] -pin uut InstrD[5] -pin uut InstrD[4] -pin uut InstrD[3] -pin uut InstrD[2] -pin uut InstrD[1] -pin uut InstrD[0] -pin uut PCD[31] -pin uut PCD[30] -pin uut PCD[29] -pin uut PCD[28] -pin uut PCD[27] -pin uut PCD[26] -pin uut PCD[25] -pin uut PCD[24] -pin uut PCD[23] -pin uut PCD[22] -pin uut PCD[21] -pin uut PCD[20] -pin uut PCD[19] -pin uut PCD[18] -pin uut PCD[17] -pin uut PCD[16] -pin uut PCD[15] -pin uut PCD[14] -pin uut PCD[13] -pin uut PCD[12] -pin uut PCD[11] -pin uut PCD[10] -pin uut PCD[9] -pin uut PCD[8] -pin uut PCD[7] -pin uut PCD[6] -pin uut PCD[5] -pin uut PCD[4] -pin uut PCD[3] -pin uut PCD[2] -pin uut PCD[1] -pin uut PCD[0] -pin uut PCPlus4D[31] -pin uut PCPlus4D[30] -pin uut PCPlus4D[29] -pin uut PCPlus4D[28] -pin uut PCPlus4D[27] -pin uut PCPlus4D[26] -pin uut PCPlus4D[25] -pin uut PCPlus4D[24] -pin uut PCPlus4D[23] -pin uut PCPlus4D[22] -pin uut PCPlus4D[21] -pin uut PCPlus4D[20] -pin uut PCPlus4D[19] -pin uut PCPlus4D[18] -pin uut PCPlus4D[17] -pin uut PCPlus4D[16] -pin uut PCPlus4D[15] -pin uut PCPlus4D[14] -pin uut PCPlus4D[13] -pin uut PCPlus4D[12] -pin uut PCPlus4D[11] -pin uut PCPlus4D[10] -pin uut PCPlus4D[9] -pin uut PCPlus4D[8] -pin uut PCPlus4D[7] -pin uut PCPlus4D[6] -pin uut PCPlus4D[5] -pin uut PCPlus4D[4] -pin uut PCPlus4D[3] -pin uut PCPlus4D[1] -pin uut PCPlus4D[0] -pin uut RDW[4] -pin uut RDW[3] -pin uut RDW[2] -pin uut RDW[1] -pin uut RDW[0] -pin uut ResultW[31] -pin uut ResultW[30] -pin uut ResultW[29] -pin uut ResultW[28] -pin uut ResultW[27] -pin uut ResultW[26] -pin uut ResultW[25] -pin uut ResultW[24] -pin uut ResultW[23] -pin uut ResultW[22] -pin uut ResultW[21] -pin uut ResultW[20] -pin uut ResultW[19] -pin uut ResultW[18] -pin uut ResultW[17] -pin uut ResultW[16] -pin uut ResultW[15] -pin uut ResultW[14] -pin uut ResultW[13] -pin uut ResultW[12] -pin uut ResultW[11] -pin uut ResultW[10] -pin uut ResultW[9] -pin uut ResultW[8] -pin uut ResultW[7] -pin uut ResultW[6] -pin uut ResultW[5] -pin uut ResultW[4] -pin uut ResultW[3] -pin uut ResultW[2] -pin uut ResultW[1] -pin uut ResultW[0]
load net <const1> -power -attr @rip 2 -pin uut PCPlus4D[2]
load net clk_reg -pin RTL_INV I0 -pin RTL_INV O -pin uut clk
netloc clk_reg 1 0 2 -60 2138 2150
load net uut|ALUControlD[0] -attr @rip(#000000) ALUControl[0] -attr @name ALUControlD[0] -pin uut|ALUControlD_r_reg[2:0] D[0] -pin uut|control ALUControl[0]
load net uut|ALUControlD[1] -attr @rip(#000000) ALUControl[1] -attr @name ALUControlD[1] -pin uut|ALUControlD_r_reg[2:0] D[1] -pin uut|control ALUControl[1]
load net uut|ALUControlD[2] -attr @rip(#000000) ALUControl[2] -attr @name ALUControlD[2] -pin uut|ALUControlD_r_reg[2:0] D[2] -pin uut|control ALUControl[2]
load net uut|ALUControlE[0] -attr @rip(#000000) 0 -attr @name ALUControlE[0] -hierPin uut ALUControlE[0] -pin uut|ALUControlD_r_reg[2:0] Q[0]
load net uut|ALUControlE[1] -attr @rip(#000000) 1 -attr @name ALUControlE[1] -hierPin uut ALUControlE[1] -pin uut|ALUControlD_r_reg[2:0] Q[1]
load net uut|ALUControlE[2] -attr @rip(#000000) 2 -attr @name ALUControlE[2] -hierPin uut ALUControlE[2] -pin uut|ALUControlD_r_reg[2:0] Q[2]
load net uut|ALUSrcD -attr @name ALUSrcD -pin uut|ALUSrcD_r_reg D -pin uut|control ALUSrc
netloc uut|ALUSrcD 1 1 2 1070J 558 1500
load net uut|ALUSrcE -attr @name ALUSrcE -hierPin uut ALUSrcE -pin uut|ALUSrcD_r_reg Q
netloc uut|ALUSrcE 1 3 1 1910 108n
load net uut|BranchD -attr @name BranchD -pin uut|BranchD_r_reg D -pin uut|control Branch
netloc uut|BranchD 1 1 2 1090J 578 1540
load net uut|BranchE -attr @name BranchE -hierPin uut BranchE -pin uut|BranchD_r_reg Q
netloc uut|BranchE 1 3 1 N 228
load net uut|ImmSrcD[0] -attr @rip(#000000) ImmSrc[0] -attr @name ImmSrcD[0] -pin uut|control ImmSrc[0] -pin uut|extension ImmSrc[0]
load net uut|ImmSrcD[1] -attr @rip(#000000) ImmSrc[1] -attr @name ImmSrcD[1] -pin uut|control ImmSrc[1] -pin uut|extension ImmSrc[1]
load net uut|Imm_Ext_D[0] -attr @rip(#000000) Imm_Ext[0] -attr @name Imm_Ext_D[0] -pin uut|Imm_Ext_D_r_reg[31:0] D[0] -pin uut|extension Imm_Ext[0]
load net uut|Imm_Ext_D[10] -attr @rip(#000000) Imm_Ext[10] -attr @name Imm_Ext_D[10] -pin uut|Imm_Ext_D_r_reg[31:0] D[10] -pin uut|extension Imm_Ext[10]
load net uut|Imm_Ext_D[11] -attr @rip(#000000) Imm_Ext[11] -attr @name Imm_Ext_D[11] -pin uut|Imm_Ext_D_r_reg[31:0] D[11] -pin uut|extension Imm_Ext[11]
load net uut|Imm_Ext_D[12] -attr @rip(#000000) Imm_Ext[12] -attr @name Imm_Ext_D[12] -pin uut|Imm_Ext_D_r_reg[31:0] D[12] -pin uut|extension Imm_Ext[12]
load net uut|Imm_Ext_D[13] -attr @rip(#000000) Imm_Ext[13] -attr @name Imm_Ext_D[13] -pin uut|Imm_Ext_D_r_reg[31:0] D[13] -pin uut|extension Imm_Ext[13]
load net uut|Imm_Ext_D[14] -attr @rip(#000000) Imm_Ext[14] -attr @name Imm_Ext_D[14] -pin uut|Imm_Ext_D_r_reg[31:0] D[14] -pin uut|extension Imm_Ext[14]
load net uut|Imm_Ext_D[15] -attr @rip(#000000) Imm_Ext[15] -attr @name Imm_Ext_D[15] -pin uut|Imm_Ext_D_r_reg[31:0] D[15] -pin uut|extension Imm_Ext[15]
load net uut|Imm_Ext_D[16] -attr @rip(#000000) Imm_Ext[16] -attr @name Imm_Ext_D[16] -pin uut|Imm_Ext_D_r_reg[31:0] D[16] -pin uut|extension Imm_Ext[16]
load net uut|Imm_Ext_D[17] -attr @rip(#000000) Imm_Ext[17] -attr @name Imm_Ext_D[17] -pin uut|Imm_Ext_D_r_reg[31:0] D[17] -pin uut|extension Imm_Ext[17]
load net uut|Imm_Ext_D[18] -attr @rip(#000000) Imm_Ext[18] -attr @name Imm_Ext_D[18] -pin uut|Imm_Ext_D_r_reg[31:0] D[18] -pin uut|extension Imm_Ext[18]
load net uut|Imm_Ext_D[19] -attr @rip(#000000) Imm_Ext[19] -attr @name Imm_Ext_D[19] -pin uut|Imm_Ext_D_r_reg[31:0] D[19] -pin uut|extension Imm_Ext[19]
load net uut|Imm_Ext_D[1] -attr @rip(#000000) Imm_Ext[1] -attr @name Imm_Ext_D[1] -pin uut|Imm_Ext_D_r_reg[31:0] D[1] -pin uut|extension Imm_Ext[1]
load net uut|Imm_Ext_D[20] -attr @rip(#000000) Imm_Ext[20] -attr @name Imm_Ext_D[20] -pin uut|Imm_Ext_D_r_reg[31:0] D[20] -pin uut|extension Imm_Ext[20]
load net uut|Imm_Ext_D[21] -attr @rip(#000000) Imm_Ext[21] -attr @name Imm_Ext_D[21] -pin uut|Imm_Ext_D_r_reg[31:0] D[21] -pin uut|extension Imm_Ext[21]
load net uut|Imm_Ext_D[22] -attr @rip(#000000) Imm_Ext[22] -attr @name Imm_Ext_D[22] -pin uut|Imm_Ext_D_r_reg[31:0] D[22] -pin uut|extension Imm_Ext[22]
load net uut|Imm_Ext_D[23] -attr @rip(#000000) Imm_Ext[23] -attr @name Imm_Ext_D[23] -pin uut|Imm_Ext_D_r_reg[31:0] D[23] -pin uut|extension Imm_Ext[23]
load net uut|Imm_Ext_D[24] -attr @rip(#000000) Imm_Ext[24] -attr @name Imm_Ext_D[24] -pin uut|Imm_Ext_D_r_reg[31:0] D[24] -pin uut|extension Imm_Ext[24]
load net uut|Imm_Ext_D[25] -attr @rip(#000000) Imm_Ext[25] -attr @name Imm_Ext_D[25] -pin uut|Imm_Ext_D_r_reg[31:0] D[25] -pin uut|extension Imm_Ext[25]
load net uut|Imm_Ext_D[26] -attr @rip(#000000) Imm_Ext[26] -attr @name Imm_Ext_D[26] -pin uut|Imm_Ext_D_r_reg[31:0] D[26] -pin uut|extension Imm_Ext[26]
load net uut|Imm_Ext_D[27] -attr @rip(#000000) Imm_Ext[27] -attr @name Imm_Ext_D[27] -pin uut|Imm_Ext_D_r_reg[31:0] D[27] -pin uut|extension Imm_Ext[27]
load net uut|Imm_Ext_D[28] -attr @rip(#000000) Imm_Ext[28] -attr @name Imm_Ext_D[28] -pin uut|Imm_Ext_D_r_reg[31:0] D[28] -pin uut|extension Imm_Ext[28]
load net uut|Imm_Ext_D[29] -attr @rip(#000000) Imm_Ext[29] -attr @name Imm_Ext_D[29] -pin uut|Imm_Ext_D_r_reg[31:0] D[29] -pin uut|extension Imm_Ext[29]
load net uut|Imm_Ext_D[2] -attr @rip(#000000) Imm_Ext[2] -attr @name Imm_Ext_D[2] -pin uut|Imm_Ext_D_r_reg[31:0] D[2] -pin uut|extension Imm_Ext[2]
load net uut|Imm_Ext_D[30] -attr @rip(#000000) Imm_Ext[30] -attr @name Imm_Ext_D[30] -pin uut|Imm_Ext_D_r_reg[31:0] D[30] -pin uut|extension Imm_Ext[30]
load net uut|Imm_Ext_D[31] -attr @rip(#000000) Imm_Ext[31] -attr @name Imm_Ext_D[31] -pin uut|Imm_Ext_D_r_reg[31:0] D[31] -pin uut|extension Imm_Ext[31]
load net uut|Imm_Ext_D[3] -attr @rip(#000000) Imm_Ext[3] -attr @name Imm_Ext_D[3] -pin uut|Imm_Ext_D_r_reg[31:0] D[3] -pin uut|extension Imm_Ext[3]
load net uut|Imm_Ext_D[4] -attr @rip(#000000) Imm_Ext[4] -attr @name Imm_Ext_D[4] -pin uut|Imm_Ext_D_r_reg[31:0] D[4] -pin uut|extension Imm_Ext[4]
load net uut|Imm_Ext_D[5] -attr @rip(#000000) Imm_Ext[5] -attr @name Imm_Ext_D[5] -pin uut|Imm_Ext_D_r_reg[31:0] D[5] -pin uut|extension Imm_Ext[5]
load net uut|Imm_Ext_D[6] -attr @rip(#000000) Imm_Ext[6] -attr @name Imm_Ext_D[6] -pin uut|Imm_Ext_D_r_reg[31:0] D[6] -pin uut|extension Imm_Ext[6]
load net uut|Imm_Ext_D[7] -attr @rip(#000000) Imm_Ext[7] -attr @name Imm_Ext_D[7] -pin uut|Imm_Ext_D_r_reg[31:0] D[7] -pin uut|extension Imm_Ext[7]
load net uut|Imm_Ext_D[8] -attr @rip(#000000) Imm_Ext[8] -attr @name Imm_Ext_D[8] -pin uut|Imm_Ext_D_r_reg[31:0] D[8] -pin uut|extension Imm_Ext[8]
load net uut|Imm_Ext_D[9] -attr @rip(#000000) Imm_Ext[9] -attr @name Imm_Ext_D[9] -pin uut|Imm_Ext_D_r_reg[31:0] D[9] -pin uut|extension Imm_Ext[9]
load net uut|Imm_Ext_E[0] -attr @rip(#000000) 0 -attr @name Imm_Ext_E[0] -hierPin uut Imm_Ext_E[0] -pin uut|Imm_Ext_D_r_reg[31:0] Q[0]
load net uut|Imm_Ext_E[10] -attr @rip(#000000) 10 -attr @name Imm_Ext_E[10] -hierPin uut Imm_Ext_E[10] -pin uut|Imm_Ext_D_r_reg[31:0] Q[10]
load net uut|Imm_Ext_E[11] -attr @rip(#000000) 11 -attr @name Imm_Ext_E[11] -hierPin uut Imm_Ext_E[11] -pin uut|Imm_Ext_D_r_reg[31:0] Q[11]
load net uut|Imm_Ext_E[12] -attr @rip(#000000) 12 -attr @name Imm_Ext_E[12] -hierPin uut Imm_Ext_E[12] -pin uut|Imm_Ext_D_r_reg[31:0] Q[12]
load net uut|Imm_Ext_E[13] -attr @rip(#000000) 13 -attr @name Imm_Ext_E[13] -hierPin uut Imm_Ext_E[13] -pin uut|Imm_Ext_D_r_reg[31:0] Q[13]
load net uut|Imm_Ext_E[14] -attr @rip(#000000) 14 -attr @name Imm_Ext_E[14] -hierPin uut Imm_Ext_E[14] -pin uut|Imm_Ext_D_r_reg[31:0] Q[14]
load net uut|Imm_Ext_E[15] -attr @rip(#000000) 15 -attr @name Imm_Ext_E[15] -hierPin uut Imm_Ext_E[15] -pin uut|Imm_Ext_D_r_reg[31:0] Q[15]
load net uut|Imm_Ext_E[16] -attr @rip(#000000) 16 -attr @name Imm_Ext_E[16] -hierPin uut Imm_Ext_E[16] -pin uut|Imm_Ext_D_r_reg[31:0] Q[16]
load net uut|Imm_Ext_E[17] -attr @rip(#000000) 17 -attr @name Imm_Ext_E[17] -hierPin uut Imm_Ext_E[17] -pin uut|Imm_Ext_D_r_reg[31:0] Q[17]
load net uut|Imm_Ext_E[18] -attr @rip(#000000) 18 -attr @name Imm_Ext_E[18] -hierPin uut Imm_Ext_E[18] -pin uut|Imm_Ext_D_r_reg[31:0] Q[18]
load net uut|Imm_Ext_E[19] -attr @rip(#000000) 19 -attr @name Imm_Ext_E[19] -hierPin uut Imm_Ext_E[19] -pin uut|Imm_Ext_D_r_reg[31:0] Q[19]
load net uut|Imm_Ext_E[1] -attr @rip(#000000) 1 -attr @name Imm_Ext_E[1] -hierPin uut Imm_Ext_E[1] -pin uut|Imm_Ext_D_r_reg[31:0] Q[1]
load net uut|Imm_Ext_E[20] -attr @rip(#000000) 20 -attr @name Imm_Ext_E[20] -hierPin uut Imm_Ext_E[20] -pin uut|Imm_Ext_D_r_reg[31:0] Q[20]
load net uut|Imm_Ext_E[21] -attr @rip(#000000) 21 -attr @name Imm_Ext_E[21] -hierPin uut Imm_Ext_E[21] -pin uut|Imm_Ext_D_r_reg[31:0] Q[21]
load net uut|Imm_Ext_E[22] -attr @rip(#000000) 22 -attr @name Imm_Ext_E[22] -hierPin uut Imm_Ext_E[22] -pin uut|Imm_Ext_D_r_reg[31:0] Q[22]
load net uut|Imm_Ext_E[23] -attr @rip(#000000) 23 -attr @name Imm_Ext_E[23] -hierPin uut Imm_Ext_E[23] -pin uut|Imm_Ext_D_r_reg[31:0] Q[23]
load net uut|Imm_Ext_E[24] -attr @rip(#000000) 24 -attr @name Imm_Ext_E[24] -hierPin uut Imm_Ext_E[24] -pin uut|Imm_Ext_D_r_reg[31:0] Q[24]
load net uut|Imm_Ext_E[25] -attr @rip(#000000) 25 -attr @name Imm_Ext_E[25] -hierPin uut Imm_Ext_E[25] -pin uut|Imm_Ext_D_r_reg[31:0] Q[25]
load net uut|Imm_Ext_E[26] -attr @rip(#000000) 26 -attr @name Imm_Ext_E[26] -hierPin uut Imm_Ext_E[26] -pin uut|Imm_Ext_D_r_reg[31:0] Q[26]
load net uut|Imm_Ext_E[27] -attr @rip(#000000) 27 -attr @name Imm_Ext_E[27] -hierPin uut Imm_Ext_E[27] -pin uut|Imm_Ext_D_r_reg[31:0] Q[27]
load net uut|Imm_Ext_E[28] -attr @rip(#000000) 28 -attr @name Imm_Ext_E[28] -hierPin uut Imm_Ext_E[28] -pin uut|Imm_Ext_D_r_reg[31:0] Q[28]
load net uut|Imm_Ext_E[29] -attr @rip(#000000) 29 -attr @name Imm_Ext_E[29] -hierPin uut Imm_Ext_E[29] -pin uut|Imm_Ext_D_r_reg[31:0] Q[29]
load net uut|Imm_Ext_E[2] -attr @rip(#000000) 2 -attr @name Imm_Ext_E[2] -hierPin uut Imm_Ext_E[2] -pin uut|Imm_Ext_D_r_reg[31:0] Q[2]
load net uut|Imm_Ext_E[30] -attr @rip(#000000) 30 -attr @name Imm_Ext_E[30] -hierPin uut Imm_Ext_E[30] -pin uut|Imm_Ext_D_r_reg[31:0] Q[30]
load net uut|Imm_Ext_E[31] -attr @rip(#000000) 31 -attr @name Imm_Ext_E[31] -hierPin uut Imm_Ext_E[31] -pin uut|Imm_Ext_D_r_reg[31:0] Q[31]
load net uut|Imm_Ext_E[3] -attr @rip(#000000) 3 -attr @name Imm_Ext_E[3] -hierPin uut Imm_Ext_E[3] -pin uut|Imm_Ext_D_r_reg[31:0] Q[3]
load net uut|Imm_Ext_E[4] -attr @rip(#000000) 4 -attr @name Imm_Ext_E[4] -hierPin uut Imm_Ext_E[4] -pin uut|Imm_Ext_D_r_reg[31:0] Q[4]
load net uut|Imm_Ext_E[5] -attr @rip(#000000) 5 -attr @name Imm_Ext_E[5] -hierPin uut Imm_Ext_E[5] -pin uut|Imm_Ext_D_r_reg[31:0] Q[5]
load net uut|Imm_Ext_E[6] -attr @rip(#000000) 6 -attr @name Imm_Ext_E[6] -hierPin uut Imm_Ext_E[6] -pin uut|Imm_Ext_D_r_reg[31:0] Q[6]
load net uut|Imm_Ext_E[7] -attr @rip(#000000) 7 -attr @name Imm_Ext_E[7] -hierPin uut Imm_Ext_E[7] -pin uut|Imm_Ext_D_r_reg[31:0] Q[7]
load net uut|Imm_Ext_E[8] -attr @rip(#000000) 8 -attr @name Imm_Ext_E[8] -hierPin uut Imm_Ext_E[8] -pin uut|Imm_Ext_D_r_reg[31:0] Q[8]
load net uut|Imm_Ext_E[9] -attr @rip(#000000) 9 -attr @name Imm_Ext_E[9] -hierPin uut Imm_Ext_E[9] -pin uut|Imm_Ext_D_r_reg[31:0] Q[9]
load net uut|InstrD[0] -attr @rip(#000000) InstrD[0] -attr @name InstrD[0] -hierPin uut InstrD[0] -pin uut|control Op[0] -pin uut|extension In[0]
load net uut|InstrD[10] -attr @rip(#000000) InstrD[10] -attr @name InstrD[10] -hierPin uut InstrD[10] -pin uut|RD_D_r_reg[4:0] D[3] -pin uut|extension In[10]
load net uut|InstrD[11] -attr @rip(#000000) InstrD[11] -attr @name InstrD[11] -hierPin uut InstrD[11] -pin uut|RD_D_r_reg[4:0] D[4] -pin uut|extension In[11]
load net uut|InstrD[12] -attr @rip(#000000) InstrD[12] -attr @name InstrD[12] -hierPin uut InstrD[12] -pin uut|control funct3[0] -pin uut|extension In[12]
load net uut|InstrD[13] -attr @rip(#000000) InstrD[13] -attr @name InstrD[13] -hierPin uut InstrD[13] -pin uut|control funct3[1] -pin uut|extension In[13]
load net uut|InstrD[14] -attr @rip(#000000) InstrD[14] -attr @name InstrD[14] -hierPin uut InstrD[14] -pin uut|control funct3[2] -pin uut|extension In[14]
load net uut|InstrD[15] -attr @rip(#000000) InstrD[15] -attr @name InstrD[15] -hierPin uut InstrD[15] -pin uut|RS1_D_r_reg[4:0] D[0] -pin uut|extension In[15] -pin uut|rf A1[0]
load net uut|InstrD[16] -attr @rip(#000000) InstrD[16] -attr @name InstrD[16] -hierPin uut InstrD[16] -pin uut|RS1_D_r_reg[4:0] D[1] -pin uut|extension In[16] -pin uut|rf A1[1]
load net uut|InstrD[17] -attr @rip(#000000) InstrD[17] -attr @name InstrD[17] -hierPin uut InstrD[17] -pin uut|RS1_D_r_reg[4:0] D[2] -pin uut|extension In[17] -pin uut|rf A1[2]
load net uut|InstrD[18] -attr @rip(#000000) InstrD[18] -attr @name InstrD[18] -hierPin uut InstrD[18] -pin uut|RS1_D_r_reg[4:0] D[3] -pin uut|extension In[18] -pin uut|rf A1[3]
load net uut|InstrD[19] -attr @rip(#000000) InstrD[19] -attr @name InstrD[19] -hierPin uut InstrD[19] -pin uut|RS1_D_r_reg[4:0] D[4] -pin uut|extension In[19] -pin uut|rf A1[4]
load net uut|InstrD[1] -attr @rip(#000000) InstrD[1] -attr @name InstrD[1] -hierPin uut InstrD[1] -pin uut|control Op[1] -pin uut|extension In[1]
load net uut|InstrD[20] -attr @rip(#000000) InstrD[20] -attr @name InstrD[20] -hierPin uut InstrD[20] -pin uut|RS2_D_r_reg[4:0] D[0] -pin uut|extension In[20] -pin uut|rf A2[0]
load net uut|InstrD[21] -attr @rip(#000000) InstrD[21] -attr @name InstrD[21] -hierPin uut InstrD[21] -pin uut|RS2_D_r_reg[4:0] D[1] -pin uut|extension In[21] -pin uut|rf A2[1]
load net uut|InstrD[22] -attr @rip(#000000) InstrD[22] -attr @name InstrD[22] -hierPin uut InstrD[22] -pin uut|RS2_D_r_reg[4:0] D[2] -pin uut|extension In[22] -pin uut|rf A2[2]
load net uut|InstrD[23] -attr @rip(#000000) InstrD[23] -attr @name InstrD[23] -hierPin uut InstrD[23] -pin uut|RS2_D_r_reg[4:0] D[3] -pin uut|extension In[23] -pin uut|rf A2[3]
load net uut|InstrD[24] -attr @rip(#000000) InstrD[24] -attr @name InstrD[24] -hierPin uut InstrD[24] -pin uut|RS2_D_r_reg[4:0] D[4] -pin uut|extension In[24] -pin uut|rf A2[4]
load net uut|InstrD[25] -attr @rip(#000000) InstrD[25] -attr @name InstrD[25] -hierPin uut InstrD[25] -pin uut|control funct7[0] -pin uut|extension In[25]
load net uut|InstrD[26] -attr @rip(#000000) InstrD[26] -attr @name InstrD[26] -hierPin uut InstrD[26] -pin uut|control funct7[1] -pin uut|extension In[26]
load net uut|InstrD[27] -attr @rip(#000000) InstrD[27] -attr @name InstrD[27] -hierPin uut InstrD[27] -pin uut|control funct7[2] -pin uut|extension In[27]
load net uut|InstrD[28] -attr @rip(#000000) InstrD[28] -attr @name InstrD[28] -hierPin uut InstrD[28] -pin uut|control funct7[3] -pin uut|extension In[28]
load net uut|InstrD[29] -attr @rip(#000000) InstrD[29] -attr @name InstrD[29] -hierPin uut InstrD[29] -pin uut|control funct7[4] -pin uut|extension In[29]
load net uut|InstrD[2] -attr @rip(#000000) InstrD[2] -attr @name InstrD[2] -hierPin uut InstrD[2] -pin uut|control Op[2] -pin uut|extension In[2]
load net uut|InstrD[30] -attr @rip(#000000) InstrD[30] -attr @name InstrD[30] -hierPin uut InstrD[30] -pin uut|control funct7[5] -pin uut|extension In[30]
load net uut|InstrD[31] -attr @rip(#000000) InstrD[31] -attr @name InstrD[31] -hierPin uut InstrD[31] -pin uut|control funct7[6] -pin uut|extension In[31]
load net uut|InstrD[3] -attr @rip(#000000) InstrD[3] -attr @name InstrD[3] -hierPin uut InstrD[3] -pin uut|control Op[3] -pin uut|extension In[3]
load net uut|InstrD[4] -attr @rip(#000000) InstrD[4] -attr @name InstrD[4] -hierPin uut InstrD[4] -pin uut|control Op[4] -pin uut|extension In[4]
load net uut|InstrD[5] -attr @rip(#000000) InstrD[5] -attr @name InstrD[5] -hierPin uut InstrD[5] -pin uut|control Op[5] -pin uut|extension In[5]
load net uut|InstrD[6] -attr @rip(#000000) InstrD[6] -attr @name InstrD[6] -hierPin uut InstrD[6] -pin uut|control Op[6] -pin uut|extension In[6]
load net uut|InstrD[7] -attr @rip(#000000) InstrD[7] -attr @name InstrD[7] -hierPin uut InstrD[7] -pin uut|RD_D_r_reg[4:0] D[0] -pin uut|extension In[7]
load net uut|InstrD[8] -attr @rip(#000000) InstrD[8] -attr @name InstrD[8] -hierPin uut InstrD[8] -pin uut|RD_D_r_reg[4:0] D[1] -pin uut|extension In[8]
load net uut|InstrD[9] -attr @rip(#000000) InstrD[9] -attr @name InstrD[9] -hierPin uut InstrD[9] -pin uut|RD_D_r_reg[4:0] D[2] -pin uut|extension In[9]
load net uut|JumpD -attr @name JumpD -pin uut|JumpD_r_reg D -pin uut|control Jump
netloc uut|JumpD 1 1 2 1110J 618 N
load net uut|JumpE -attr @name JumpE -hierPin uut JumpE -pin uut|JumpD_r_reg Q
netloc uut|JumpE 1 3 1 N 608
load net uut|MemWriteD -attr @name MemWriteD -pin uut|MemWriteD_r_reg D -pin uut|control MemWrite
netloc uut|MemWriteD 1 1 2 1150J 638 1620
load net uut|MemWriteE -attr @name MemWriteE -hierPin uut MemWriteE -pin uut|MemWriteD_r_reg Q
netloc uut|MemWriteE 1 3 1 N 728
load net uut|PCD[0] -attr @rip(#000000) PCD[0] -attr @name PCD[0] -hierPin uut PCD[0] -pin uut|PCD_r_reg[31:0] D[0]
load net uut|PCD[10] -attr @rip(#000000) PCD[10] -attr @name PCD[10] -hierPin uut PCD[10] -pin uut|PCD_r_reg[31:0] D[10]
load net uut|PCD[11] -attr @rip(#000000) PCD[11] -attr @name PCD[11] -hierPin uut PCD[11] -pin uut|PCD_r_reg[31:0] D[11]
load net uut|PCD[12] -attr @rip(#000000) PCD[12] -attr @name PCD[12] -hierPin uut PCD[12] -pin uut|PCD_r_reg[31:0] D[12]
load net uut|PCD[13] -attr @rip(#000000) PCD[13] -attr @name PCD[13] -hierPin uut PCD[13] -pin uut|PCD_r_reg[31:0] D[13]
load net uut|PCD[14] -attr @rip(#000000) PCD[14] -attr @name PCD[14] -hierPin uut PCD[14] -pin uut|PCD_r_reg[31:0] D[14]
load net uut|PCD[15] -attr @rip(#000000) PCD[15] -attr @name PCD[15] -hierPin uut PCD[15] -pin uut|PCD_r_reg[31:0] D[15]
load net uut|PCD[16] -attr @rip(#000000) PCD[16] -attr @name PCD[16] -hierPin uut PCD[16] -pin uut|PCD_r_reg[31:0] D[16]
load net uut|PCD[17] -attr @rip(#000000) PCD[17] -attr @name PCD[17] -hierPin uut PCD[17] -pin uut|PCD_r_reg[31:0] D[17]
load net uut|PCD[18] -attr @rip(#000000) PCD[18] -attr @name PCD[18] -hierPin uut PCD[18] -pin uut|PCD_r_reg[31:0] D[18]
load net uut|PCD[19] -attr @rip(#000000) PCD[19] -attr @name PCD[19] -hierPin uut PCD[19] -pin uut|PCD_r_reg[31:0] D[19]
load net uut|PCD[1] -attr @rip(#000000) PCD[1] -attr @name PCD[1] -hierPin uut PCD[1] -pin uut|PCD_r_reg[31:0] D[1]
load net uut|PCD[20] -attr @rip(#000000) PCD[20] -attr @name PCD[20] -hierPin uut PCD[20] -pin uut|PCD_r_reg[31:0] D[20]
load net uut|PCD[21] -attr @rip(#000000) PCD[21] -attr @name PCD[21] -hierPin uut PCD[21] -pin uut|PCD_r_reg[31:0] D[21]
load net uut|PCD[22] -attr @rip(#000000) PCD[22] -attr @name PCD[22] -hierPin uut PCD[22] -pin uut|PCD_r_reg[31:0] D[22]
load net uut|PCD[23] -attr @rip(#000000) PCD[23] -attr @name PCD[23] -hierPin uut PCD[23] -pin uut|PCD_r_reg[31:0] D[23]
load net uut|PCD[24] -attr @rip(#000000) PCD[24] -attr @name PCD[24] -hierPin uut PCD[24] -pin uut|PCD_r_reg[31:0] D[24]
load net uut|PCD[25] -attr @rip(#000000) PCD[25] -attr @name PCD[25] -hierPin uut PCD[25] -pin uut|PCD_r_reg[31:0] D[25]
load net uut|PCD[26] -attr @rip(#000000) PCD[26] -attr @name PCD[26] -hierPin uut PCD[26] -pin uut|PCD_r_reg[31:0] D[26]
load net uut|PCD[27] -attr @rip(#000000) PCD[27] -attr @name PCD[27] -hierPin uut PCD[27] -pin uut|PCD_r_reg[31:0] D[27]
load net uut|PCD[28] -attr @rip(#000000) PCD[28] -attr @name PCD[28] -hierPin uut PCD[28] -pin uut|PCD_r_reg[31:0] D[28]
load net uut|PCD[29] -attr @rip(#000000) PCD[29] -attr @name PCD[29] -hierPin uut PCD[29] -pin uut|PCD_r_reg[31:0] D[29]
load net uut|PCD[2] -attr @rip(#000000) PCD[2] -attr @name PCD[2] -hierPin uut PCD[2] -pin uut|PCD_r_reg[31:0] D[2]
load net uut|PCD[30] -attr @rip(#000000) PCD[30] -attr @name PCD[30] -hierPin uut PCD[30] -pin uut|PCD_r_reg[31:0] D[30]
load net uut|PCD[31] -attr @rip(#000000) PCD[31] -attr @name PCD[31] -hierPin uut PCD[31] -pin uut|PCD_r_reg[31:0] D[31]
load net uut|PCD[3] -attr @rip(#000000) PCD[3] -attr @name PCD[3] -hierPin uut PCD[3] -pin uut|PCD_r_reg[31:0] D[3]
load net uut|PCD[4] -attr @rip(#000000) PCD[4] -attr @name PCD[4] -hierPin uut PCD[4] -pin uut|PCD_r_reg[31:0] D[4]
load net uut|PCD[5] -attr @rip(#000000) PCD[5] -attr @name PCD[5] -hierPin uut PCD[5] -pin uut|PCD_r_reg[31:0] D[5]
load net uut|PCD[6] -attr @rip(#000000) PCD[6] -attr @name PCD[6] -hierPin uut PCD[6] -pin uut|PCD_r_reg[31:0] D[6]
load net uut|PCD[7] -attr @rip(#000000) PCD[7] -attr @name PCD[7] -hierPin uut PCD[7] -pin uut|PCD_r_reg[31:0] D[7]
load net uut|PCD[8] -attr @rip(#000000) PCD[8] -attr @name PCD[8] -hierPin uut PCD[8] -pin uut|PCD_r_reg[31:0] D[8]
load net uut|PCD[9] -attr @rip(#000000) PCD[9] -attr @name PCD[9] -hierPin uut PCD[9] -pin uut|PCD_r_reg[31:0] D[9]
load net uut|PCE[0] -attr @rip(#000000) 0 -attr @name PCE[0] -hierPin uut PCE[0] -pin uut|PCD_r_reg[31:0] Q[0]
load net uut|PCE[10] -attr @rip(#000000) 10 -attr @name PCE[10] -hierPin uut PCE[10] -pin uut|PCD_r_reg[31:0] Q[10]
load net uut|PCE[11] -attr @rip(#000000) 11 -attr @name PCE[11] -hierPin uut PCE[11] -pin uut|PCD_r_reg[31:0] Q[11]
load net uut|PCE[12] -attr @rip(#000000) 12 -attr @name PCE[12] -hierPin uut PCE[12] -pin uut|PCD_r_reg[31:0] Q[12]
load net uut|PCE[13] -attr @rip(#000000) 13 -attr @name PCE[13] -hierPin uut PCE[13] -pin uut|PCD_r_reg[31:0] Q[13]
load net uut|PCE[14] -attr @rip(#000000) 14 -attr @name PCE[14] -hierPin uut PCE[14] -pin uut|PCD_r_reg[31:0] Q[14]
load net uut|PCE[15] -attr @rip(#000000) 15 -attr @name PCE[15] -hierPin uut PCE[15] -pin uut|PCD_r_reg[31:0] Q[15]
load net uut|PCE[16] -attr @rip(#000000) 16 -attr @name PCE[16] -hierPin uut PCE[16] -pin uut|PCD_r_reg[31:0] Q[16]
load net uut|PCE[17] -attr @rip(#000000) 17 -attr @name PCE[17] -hierPin uut PCE[17] -pin uut|PCD_r_reg[31:0] Q[17]
load net uut|PCE[18] -attr @rip(#000000) 18 -attr @name PCE[18] -hierPin uut PCE[18] -pin uut|PCD_r_reg[31:0] Q[18]
load net uut|PCE[19] -attr @rip(#000000) 19 -attr @name PCE[19] -hierPin uut PCE[19] -pin uut|PCD_r_reg[31:0] Q[19]
load net uut|PCE[1] -attr @rip(#000000) 1 -attr @name PCE[1] -hierPin uut PCE[1] -pin uut|PCD_r_reg[31:0] Q[1]
load net uut|PCE[20] -attr @rip(#000000) 20 -attr @name PCE[20] -hierPin uut PCE[20] -pin uut|PCD_r_reg[31:0] Q[20]
load net uut|PCE[21] -attr @rip(#000000) 21 -attr @name PCE[21] -hierPin uut PCE[21] -pin uut|PCD_r_reg[31:0] Q[21]
load net uut|PCE[22] -attr @rip(#000000) 22 -attr @name PCE[22] -hierPin uut PCE[22] -pin uut|PCD_r_reg[31:0] Q[22]
load net uut|PCE[23] -attr @rip(#000000) 23 -attr @name PCE[23] -hierPin uut PCE[23] -pin uut|PCD_r_reg[31:0] Q[23]
load net uut|PCE[24] -attr @rip(#000000) 24 -attr @name PCE[24] -hierPin uut PCE[24] -pin uut|PCD_r_reg[31:0] Q[24]
load net uut|PCE[25] -attr @rip(#000000) 25 -attr @name PCE[25] -hierPin uut PCE[25] -pin uut|PCD_r_reg[31:0] Q[25]
load net uut|PCE[26] -attr @rip(#000000) 26 -attr @name PCE[26] -hierPin uut PCE[26] -pin uut|PCD_r_reg[31:0] Q[26]
load net uut|PCE[27] -attr @rip(#000000) 27 -attr @name PCE[27] -hierPin uut PCE[27] -pin uut|PCD_r_reg[31:0] Q[27]
load net uut|PCE[28] -attr @rip(#000000) 28 -attr @name PCE[28] -hierPin uut PCE[28] -pin uut|PCD_r_reg[31:0] Q[28]
load net uut|PCE[29] -attr @rip(#000000) 29 -attr @name PCE[29] -hierPin uut PCE[29] -pin uut|PCD_r_reg[31:0] Q[29]
load net uut|PCE[2] -attr @rip(#000000) 2 -attr @name PCE[2] -hierPin uut PCE[2] -pin uut|PCD_r_reg[31:0] Q[2]
load net uut|PCE[30] -attr @rip(#000000) 30 -attr @name PCE[30] -hierPin uut PCE[30] -pin uut|PCD_r_reg[31:0] Q[30]
load net uut|PCE[31] -attr @rip(#000000) 31 -attr @name PCE[31] -hierPin uut PCE[31] -pin uut|PCD_r_reg[31:0] Q[31]
load net uut|PCE[3] -attr @rip(#000000) 3 -attr @name PCE[3] -hierPin uut PCE[3] -pin uut|PCD_r_reg[31:0] Q[3]
load net uut|PCE[4] -attr @rip(#000000) 4 -attr @name PCE[4] -hierPin uut PCE[4] -pin uut|PCD_r_reg[31:0] Q[4]
load net uut|PCE[5] -attr @rip(#000000) 5 -attr @name PCE[5] -hierPin uut PCE[5] -pin uut|PCD_r_reg[31:0] Q[5]
load net uut|PCE[6] -attr @rip(#000000) 6 -attr @name PCE[6] -hierPin uut PCE[6] -pin uut|PCD_r_reg[31:0] Q[6]
load net uut|PCE[7] -attr @rip(#000000) 7 -attr @name PCE[7] -hierPin uut PCE[7] -pin uut|PCD_r_reg[31:0] Q[7]
load net uut|PCE[8] -attr @rip(#000000) 8 -attr @name PCE[8] -hierPin uut PCE[8] -pin uut|PCD_r_reg[31:0] Q[8]
load net uut|PCE[9] -attr @rip(#000000) 9 -attr @name PCE[9] -hierPin uut PCE[9] -pin uut|PCD_r_reg[31:0] Q[9]
load net uut|PCPlus4D[0] -attr @rip(#000000) PCPlus4D[0] -attr @name PCPlus4D[0] -hierPin uut PCPlus4D[0] -pin uut|PCPlus4D_r_reg[31:0] D[0]
load net uut|PCPlus4D[10] -attr @rip(#000000) PCPlus4D[10] -attr @name PCPlus4D[10] -hierPin uut PCPlus4D[10] -pin uut|PCPlus4D_r_reg[31:0] D[10]
load net uut|PCPlus4D[11] -attr @rip(#000000) PCPlus4D[11] -attr @name PCPlus4D[11] -hierPin uut PCPlus4D[11] -pin uut|PCPlus4D_r_reg[31:0] D[11]
load net uut|PCPlus4D[12] -attr @rip(#000000) PCPlus4D[12] -attr @name PCPlus4D[12] -hierPin uut PCPlus4D[12] -pin uut|PCPlus4D_r_reg[31:0] D[12]
load net uut|PCPlus4D[13] -attr @rip(#000000) PCPlus4D[13] -attr @name PCPlus4D[13] -hierPin uut PCPlus4D[13] -pin uut|PCPlus4D_r_reg[31:0] D[13]
load net uut|PCPlus4D[14] -attr @rip(#000000) PCPlus4D[14] -attr @name PCPlus4D[14] -hierPin uut PCPlus4D[14] -pin uut|PCPlus4D_r_reg[31:0] D[14]
load net uut|PCPlus4D[15] -attr @rip(#000000) PCPlus4D[15] -attr @name PCPlus4D[15] -hierPin uut PCPlus4D[15] -pin uut|PCPlus4D_r_reg[31:0] D[15]
load net uut|PCPlus4D[16] -attr @rip(#000000) PCPlus4D[16] -attr @name PCPlus4D[16] -hierPin uut PCPlus4D[16] -pin uut|PCPlus4D_r_reg[31:0] D[16]
load net uut|PCPlus4D[17] -attr @rip(#000000) PCPlus4D[17] -attr @name PCPlus4D[17] -hierPin uut PCPlus4D[17] -pin uut|PCPlus4D_r_reg[31:0] D[17]
load net uut|PCPlus4D[18] -attr @rip(#000000) PCPlus4D[18] -attr @name PCPlus4D[18] -hierPin uut PCPlus4D[18] -pin uut|PCPlus4D_r_reg[31:0] D[18]
load net uut|PCPlus4D[19] -attr @rip(#000000) PCPlus4D[19] -attr @name PCPlus4D[19] -hierPin uut PCPlus4D[19] -pin uut|PCPlus4D_r_reg[31:0] D[19]
load net uut|PCPlus4D[1] -attr @rip(#000000) PCPlus4D[1] -attr @name PCPlus4D[1] -hierPin uut PCPlus4D[1] -pin uut|PCPlus4D_r_reg[31:0] D[1]
load net uut|PCPlus4D[20] -attr @rip(#000000) PCPlus4D[20] -attr @name PCPlus4D[20] -hierPin uut PCPlus4D[20] -pin uut|PCPlus4D_r_reg[31:0] D[20]
load net uut|PCPlus4D[21] -attr @rip(#000000) PCPlus4D[21] -attr @name PCPlus4D[21] -hierPin uut PCPlus4D[21] -pin uut|PCPlus4D_r_reg[31:0] D[21]
load net uut|PCPlus4D[22] -attr @rip(#000000) PCPlus4D[22] -attr @name PCPlus4D[22] -hierPin uut PCPlus4D[22] -pin uut|PCPlus4D_r_reg[31:0] D[22]
load net uut|PCPlus4D[23] -attr @rip(#000000) PCPlus4D[23] -attr @name PCPlus4D[23] -hierPin uut PCPlus4D[23] -pin uut|PCPlus4D_r_reg[31:0] D[23]
load net uut|PCPlus4D[24] -attr @rip(#000000) PCPlus4D[24] -attr @name PCPlus4D[24] -hierPin uut PCPlus4D[24] -pin uut|PCPlus4D_r_reg[31:0] D[24]
load net uut|PCPlus4D[25] -attr @rip(#000000) PCPlus4D[25] -attr @name PCPlus4D[25] -hierPin uut PCPlus4D[25] -pin uut|PCPlus4D_r_reg[31:0] D[25]
load net uut|PCPlus4D[26] -attr @rip(#000000) PCPlus4D[26] -attr @name PCPlus4D[26] -hierPin uut PCPlus4D[26] -pin uut|PCPlus4D_r_reg[31:0] D[26]
load net uut|PCPlus4D[27] -attr @rip(#000000) PCPlus4D[27] -attr @name PCPlus4D[27] -hierPin uut PCPlus4D[27] -pin uut|PCPlus4D_r_reg[31:0] D[27]
load net uut|PCPlus4D[28] -attr @rip(#000000) PCPlus4D[28] -attr @name PCPlus4D[28] -hierPin uut PCPlus4D[28] -pin uut|PCPlus4D_r_reg[31:0] D[28]
load net uut|PCPlus4D[29] -attr @rip(#000000) PCPlus4D[29] -attr @name PCPlus4D[29] -hierPin uut PCPlus4D[29] -pin uut|PCPlus4D_r_reg[31:0] D[29]
load net uut|PCPlus4D[2] -attr @rip(#000000) PCPlus4D[2] -attr @name PCPlus4D[2] -hierPin uut PCPlus4D[2] -pin uut|PCPlus4D_r_reg[31:0] D[2]
load net uut|PCPlus4D[30] -attr @rip(#000000) PCPlus4D[30] -attr @name PCPlus4D[30] -hierPin uut PCPlus4D[30] -pin uut|PCPlus4D_r_reg[31:0] D[30]
load net uut|PCPlus4D[31] -attr @rip(#000000) PCPlus4D[31] -attr @name PCPlus4D[31] -hierPin uut PCPlus4D[31] -pin uut|PCPlus4D_r_reg[31:0] D[31]
load net uut|PCPlus4D[3] -attr @rip(#000000) PCPlus4D[3] -attr @name PCPlus4D[3] -hierPin uut PCPlus4D[3] -pin uut|PCPlus4D_r_reg[31:0] D[3]
load net uut|PCPlus4D[4] -attr @rip(#000000) PCPlus4D[4] -attr @name PCPlus4D[4] -hierPin uut PCPlus4D[4] -pin uut|PCPlus4D_r_reg[31:0] D[4]
load net uut|PCPlus4D[5] -attr @rip(#000000) PCPlus4D[5] -attr @name PCPlus4D[5] -hierPin uut PCPlus4D[5] -pin uut|PCPlus4D_r_reg[31:0] D[5]
load net uut|PCPlus4D[6] -attr @rip(#000000) PCPlus4D[6] -attr @name PCPlus4D[6] -hierPin uut PCPlus4D[6] -pin uut|PCPlus4D_r_reg[31:0] D[6]
load net uut|PCPlus4D[7] -attr @rip(#000000) PCPlus4D[7] -attr @name PCPlus4D[7] -hierPin uut PCPlus4D[7] -pin uut|PCPlus4D_r_reg[31:0] D[7]
load net uut|PCPlus4D[8] -attr @rip(#000000) PCPlus4D[8] -attr @name PCPlus4D[8] -hierPin uut PCPlus4D[8] -pin uut|PCPlus4D_r_reg[31:0] D[8]
load net uut|PCPlus4D[9] -attr @rip(#000000) PCPlus4D[9] -attr @name PCPlus4D[9] -hierPin uut PCPlus4D[9] -pin uut|PCPlus4D_r_reg[31:0] D[9]
load net uut|PCPlus4E[0] -attr @rip(#000000) 0 -attr @name PCPlus4E[0] -hierPin uut PCPlus4E[0] -pin uut|PCPlus4D_r_reg[31:0] Q[0]
load net uut|PCPlus4E[10] -attr @rip(#000000) 10 -attr @name PCPlus4E[10] -hierPin uut PCPlus4E[10] -pin uut|PCPlus4D_r_reg[31:0] Q[10]
load net uut|PCPlus4E[11] -attr @rip(#000000) 11 -attr @name PCPlus4E[11] -hierPin uut PCPlus4E[11] -pin uut|PCPlus4D_r_reg[31:0] Q[11]
load net uut|PCPlus4E[12] -attr @rip(#000000) 12 -attr @name PCPlus4E[12] -hierPin uut PCPlus4E[12] -pin uut|PCPlus4D_r_reg[31:0] Q[12]
load net uut|PCPlus4E[13] -attr @rip(#000000) 13 -attr @name PCPlus4E[13] -hierPin uut PCPlus4E[13] -pin uut|PCPlus4D_r_reg[31:0] Q[13]
load net uut|PCPlus4E[14] -attr @rip(#000000) 14 -attr @name PCPlus4E[14] -hierPin uut PCPlus4E[14] -pin uut|PCPlus4D_r_reg[31:0] Q[14]
load net uut|PCPlus4E[15] -attr @rip(#000000) 15 -attr @name PCPlus4E[15] -hierPin uut PCPlus4E[15] -pin uut|PCPlus4D_r_reg[31:0] Q[15]
load net uut|PCPlus4E[16] -attr @rip(#000000) 16 -attr @name PCPlus4E[16] -hierPin uut PCPlus4E[16] -pin uut|PCPlus4D_r_reg[31:0] Q[16]
load net uut|PCPlus4E[17] -attr @rip(#000000) 17 -attr @name PCPlus4E[17] -hierPin uut PCPlus4E[17] -pin uut|PCPlus4D_r_reg[31:0] Q[17]
load net uut|PCPlus4E[18] -attr @rip(#000000) 18 -attr @name PCPlus4E[18] -hierPin uut PCPlus4E[18] -pin uut|PCPlus4D_r_reg[31:0] Q[18]
load net uut|PCPlus4E[19] -attr @rip(#000000) 19 -attr @name PCPlus4E[19] -hierPin uut PCPlus4E[19] -pin uut|PCPlus4D_r_reg[31:0] Q[19]
load net uut|PCPlus4E[1] -attr @rip(#000000) 1 -attr @name PCPlus4E[1] -hierPin uut PCPlus4E[1] -pin uut|PCPlus4D_r_reg[31:0] Q[1]
load net uut|PCPlus4E[20] -attr @rip(#000000) 20 -attr @name PCPlus4E[20] -hierPin uut PCPlus4E[20] -pin uut|PCPlus4D_r_reg[31:0] Q[20]
load net uut|PCPlus4E[21] -attr @rip(#000000) 21 -attr @name PCPlus4E[21] -hierPin uut PCPlus4E[21] -pin uut|PCPlus4D_r_reg[31:0] Q[21]
load net uut|PCPlus4E[22] -attr @rip(#000000) 22 -attr @name PCPlus4E[22] -hierPin uut PCPlus4E[22] -pin uut|PCPlus4D_r_reg[31:0] Q[22]
load net uut|PCPlus4E[23] -attr @rip(#000000) 23 -attr @name PCPlus4E[23] -hierPin uut PCPlus4E[23] -pin uut|PCPlus4D_r_reg[31:0] Q[23]
load net uut|PCPlus4E[24] -attr @rip(#000000) 24 -attr @name PCPlus4E[24] -hierPin uut PCPlus4E[24] -pin uut|PCPlus4D_r_reg[31:0] Q[24]
load net uut|PCPlus4E[25] -attr @rip(#000000) 25 -attr @name PCPlus4E[25] -hierPin uut PCPlus4E[25] -pin uut|PCPlus4D_r_reg[31:0] Q[25]
load net uut|PCPlus4E[26] -attr @rip(#000000) 26 -attr @name PCPlus4E[26] -hierPin uut PCPlus4E[26] -pin uut|PCPlus4D_r_reg[31:0] Q[26]
load net uut|PCPlus4E[27] -attr @rip(#000000) 27 -attr @name PCPlus4E[27] -hierPin uut PCPlus4E[27] -pin uut|PCPlus4D_r_reg[31:0] Q[27]
load net uut|PCPlus4E[28] -attr @rip(#000000) 28 -attr @name PCPlus4E[28] -hierPin uut PCPlus4E[28] -pin uut|PCPlus4D_r_reg[31:0] Q[28]
load net uut|PCPlus4E[29] -attr @rip(#000000) 29 -attr @name PCPlus4E[29] -hierPin uut PCPlus4E[29] -pin uut|PCPlus4D_r_reg[31:0] Q[29]
load net uut|PCPlus4E[2] -attr @rip(#000000) 2 -attr @name PCPlus4E[2] -hierPin uut PCPlus4E[2] -pin uut|PCPlus4D_r_reg[31:0] Q[2]
load net uut|PCPlus4E[30] -attr @rip(#000000) 30 -attr @name PCPlus4E[30] -hierPin uut PCPlus4E[30] -pin uut|PCPlus4D_r_reg[31:0] Q[30]
load net uut|PCPlus4E[31] -attr @rip(#000000) 31 -attr @name PCPlus4E[31] -hierPin uut PCPlus4E[31] -pin uut|PCPlus4D_r_reg[31:0] Q[31]
load net uut|PCPlus4E[3] -attr @rip(#000000) 3 -attr @name PCPlus4E[3] -hierPin uut PCPlus4E[3] -pin uut|PCPlus4D_r_reg[31:0] Q[3]
load net uut|PCPlus4E[4] -attr @rip(#000000) 4 -attr @name PCPlus4E[4] -hierPin uut PCPlus4E[4] -pin uut|PCPlus4D_r_reg[31:0] Q[4]
load net uut|PCPlus4E[5] -attr @rip(#000000) 5 -attr @name PCPlus4E[5] -hierPin uut PCPlus4E[5] -pin uut|PCPlus4D_r_reg[31:0] Q[5]
load net uut|PCPlus4E[6] -attr @rip(#000000) 6 -attr @name PCPlus4E[6] -hierPin uut PCPlus4E[6] -pin uut|PCPlus4D_r_reg[31:0] Q[6]
load net uut|PCPlus4E[7] -attr @rip(#000000) 7 -attr @name PCPlus4E[7] -hierPin uut PCPlus4E[7] -pin uut|PCPlus4D_r_reg[31:0] Q[7]
load net uut|PCPlus4E[8] -attr @rip(#000000) 8 -attr @name PCPlus4E[8] -hierPin uut PCPlus4E[8] -pin uut|PCPlus4D_r_reg[31:0] Q[8]
load net uut|PCPlus4E[9] -attr @rip(#000000) 9 -attr @name PCPlus4E[9] -hierPin uut PCPlus4E[9] -pin uut|PCPlus4D_r_reg[31:0] Q[9]
load net uut|RD1_D[0] -attr @rip(#000000) RD1[0] -attr @name RD1_D[0] -pin uut|RD1_D_r_reg[31:0] D[0] -pin uut|rf RD1[0]
load net uut|RD1_D[10] -attr @rip(#000000) RD1[10] -attr @name RD1_D[10] -pin uut|RD1_D_r_reg[31:0] D[10] -pin uut|rf RD1[10]
load net uut|RD1_D[11] -attr @rip(#000000) RD1[11] -attr @name RD1_D[11] -pin uut|RD1_D_r_reg[31:0] D[11] -pin uut|rf RD1[11]
load net uut|RD1_D[12] -attr @rip(#000000) RD1[12] -attr @name RD1_D[12] -pin uut|RD1_D_r_reg[31:0] D[12] -pin uut|rf RD1[12]
load net uut|RD1_D[13] -attr @rip(#000000) RD1[13] -attr @name RD1_D[13] -pin uut|RD1_D_r_reg[31:0] D[13] -pin uut|rf RD1[13]
load net uut|RD1_D[14] -attr @rip(#000000) RD1[14] -attr @name RD1_D[14] -pin uut|RD1_D_r_reg[31:0] D[14] -pin uut|rf RD1[14]
load net uut|RD1_D[15] -attr @rip(#000000) RD1[15] -attr @name RD1_D[15] -pin uut|RD1_D_r_reg[31:0] D[15] -pin uut|rf RD1[15]
load net uut|RD1_D[16] -attr @rip(#000000) RD1[16] -attr @name RD1_D[16] -pin uut|RD1_D_r_reg[31:0] D[16] -pin uut|rf RD1[16]
load net uut|RD1_D[17] -attr @rip(#000000) RD1[17] -attr @name RD1_D[17] -pin uut|RD1_D_r_reg[31:0] D[17] -pin uut|rf RD1[17]
load net uut|RD1_D[18] -attr @rip(#000000) RD1[18] -attr @name RD1_D[18] -pin uut|RD1_D_r_reg[31:0] D[18] -pin uut|rf RD1[18]
load net uut|RD1_D[19] -attr @rip(#000000) RD1[19] -attr @name RD1_D[19] -pin uut|RD1_D_r_reg[31:0] D[19] -pin uut|rf RD1[19]
load net uut|RD1_D[1] -attr @rip(#000000) RD1[1] -attr @name RD1_D[1] -pin uut|RD1_D_r_reg[31:0] D[1] -pin uut|rf RD1[1]
load net uut|RD1_D[20] -attr @rip(#000000) RD1[20] -attr @name RD1_D[20] -pin uut|RD1_D_r_reg[31:0] D[20] -pin uut|rf RD1[20]
load net uut|RD1_D[21] -attr @rip(#000000) RD1[21] -attr @name RD1_D[21] -pin uut|RD1_D_r_reg[31:0] D[21] -pin uut|rf RD1[21]
load net uut|RD1_D[22] -attr @rip(#000000) RD1[22] -attr @name RD1_D[22] -pin uut|RD1_D_r_reg[31:0] D[22] -pin uut|rf RD1[22]
load net uut|RD1_D[23] -attr @rip(#000000) RD1[23] -attr @name RD1_D[23] -pin uut|RD1_D_r_reg[31:0] D[23] -pin uut|rf RD1[23]
load net uut|RD1_D[24] -attr @rip(#000000) RD1[24] -attr @name RD1_D[24] -pin uut|RD1_D_r_reg[31:0] D[24] -pin uut|rf RD1[24]
load net uut|RD1_D[25] -attr @rip(#000000) RD1[25] -attr @name RD1_D[25] -pin uut|RD1_D_r_reg[31:0] D[25] -pin uut|rf RD1[25]
load net uut|RD1_D[26] -attr @rip(#000000) RD1[26] -attr @name RD1_D[26] -pin uut|RD1_D_r_reg[31:0] D[26] -pin uut|rf RD1[26]
load net uut|RD1_D[27] -attr @rip(#000000) RD1[27] -attr @name RD1_D[27] -pin uut|RD1_D_r_reg[31:0] D[27] -pin uut|rf RD1[27]
load net uut|RD1_D[28] -attr @rip(#000000) RD1[28] -attr @name RD1_D[28] -pin uut|RD1_D_r_reg[31:0] D[28] -pin uut|rf RD1[28]
load net uut|RD1_D[29] -attr @rip(#000000) RD1[29] -attr @name RD1_D[29] -pin uut|RD1_D_r_reg[31:0] D[29] -pin uut|rf RD1[29]
load net uut|RD1_D[2] -attr @rip(#000000) RD1[2] -attr @name RD1_D[2] -pin uut|RD1_D_r_reg[31:0] D[2] -pin uut|rf RD1[2]
load net uut|RD1_D[30] -attr @rip(#000000) RD1[30] -attr @name RD1_D[30] -pin uut|RD1_D_r_reg[31:0] D[30] -pin uut|rf RD1[30]
load net uut|RD1_D[31] -attr @rip(#000000) RD1[31] -attr @name RD1_D[31] -pin uut|RD1_D_r_reg[31:0] D[31] -pin uut|rf RD1[31]
load net uut|RD1_D[3] -attr @rip(#000000) RD1[3] -attr @name RD1_D[3] -pin uut|RD1_D_r_reg[31:0] D[3] -pin uut|rf RD1[3]
load net uut|RD1_D[4] -attr @rip(#000000) RD1[4] -attr @name RD1_D[4] -pin uut|RD1_D_r_reg[31:0] D[4] -pin uut|rf RD1[4]
load net uut|RD1_D[5] -attr @rip(#000000) RD1[5] -attr @name RD1_D[5] -pin uut|RD1_D_r_reg[31:0] D[5] -pin uut|rf RD1[5]
load net uut|RD1_D[6] -attr @rip(#000000) RD1[6] -attr @name RD1_D[6] -pin uut|RD1_D_r_reg[31:0] D[6] -pin uut|rf RD1[6]
load net uut|RD1_D[7] -attr @rip(#000000) RD1[7] -attr @name RD1_D[7] -pin uut|RD1_D_r_reg[31:0] D[7] -pin uut|rf RD1[7]
load net uut|RD1_D[8] -attr @rip(#000000) RD1[8] -attr @name RD1_D[8] -pin uut|RD1_D_r_reg[31:0] D[8] -pin uut|rf RD1[8]
load net uut|RD1_D[9] -attr @rip(#000000) RD1[9] -attr @name RD1_D[9] -pin uut|RD1_D_r_reg[31:0] D[9] -pin uut|rf RD1[9]
load net uut|RD1_E[0] -attr @rip(#000000) 0 -attr @name RD1_E[0] -hierPin uut RD1_E[0] -pin uut|RD1_D_r_reg[31:0] Q[0]
load net uut|RD1_E[10] -attr @rip(#000000) 10 -attr @name RD1_E[10] -hierPin uut RD1_E[10] -pin uut|RD1_D_r_reg[31:0] Q[10]
load net uut|RD1_E[11] -attr @rip(#000000) 11 -attr @name RD1_E[11] -hierPin uut RD1_E[11] -pin uut|RD1_D_r_reg[31:0] Q[11]
load net uut|RD1_E[12] -attr @rip(#000000) 12 -attr @name RD1_E[12] -hierPin uut RD1_E[12] -pin uut|RD1_D_r_reg[31:0] Q[12]
load net uut|RD1_E[13] -attr @rip(#000000) 13 -attr @name RD1_E[13] -hierPin uut RD1_E[13] -pin uut|RD1_D_r_reg[31:0] Q[13]
load net uut|RD1_E[14] -attr @rip(#000000) 14 -attr @name RD1_E[14] -hierPin uut RD1_E[14] -pin uut|RD1_D_r_reg[31:0] Q[14]
load net uut|RD1_E[15] -attr @rip(#000000) 15 -attr @name RD1_E[15] -hierPin uut RD1_E[15] -pin uut|RD1_D_r_reg[31:0] Q[15]
load net uut|RD1_E[16] -attr @rip(#000000) 16 -attr @name RD1_E[16] -hierPin uut RD1_E[16] -pin uut|RD1_D_r_reg[31:0] Q[16]
load net uut|RD1_E[17] -attr @rip(#000000) 17 -attr @name RD1_E[17] -hierPin uut RD1_E[17] -pin uut|RD1_D_r_reg[31:0] Q[17]
load net uut|RD1_E[18] -attr @rip(#000000) 18 -attr @name RD1_E[18] -hierPin uut RD1_E[18] -pin uut|RD1_D_r_reg[31:0] Q[18]
load net uut|RD1_E[19] -attr @rip(#000000) 19 -attr @name RD1_E[19] -hierPin uut RD1_E[19] -pin uut|RD1_D_r_reg[31:0] Q[19]
load net uut|RD1_E[1] -attr @rip(#000000) 1 -attr @name RD1_E[1] -hierPin uut RD1_E[1] -pin uut|RD1_D_r_reg[31:0] Q[1]
load net uut|RD1_E[20] -attr @rip(#000000) 20 -attr @name RD1_E[20] -hierPin uut RD1_E[20] -pin uut|RD1_D_r_reg[31:0] Q[20]
load net uut|RD1_E[21] -attr @rip(#000000) 21 -attr @name RD1_E[21] -hierPin uut RD1_E[21] -pin uut|RD1_D_r_reg[31:0] Q[21]
load net uut|RD1_E[22] -attr @rip(#000000) 22 -attr @name RD1_E[22] -hierPin uut RD1_E[22] -pin uut|RD1_D_r_reg[31:0] Q[22]
load net uut|RD1_E[23] -attr @rip(#000000) 23 -attr @name RD1_E[23] -hierPin uut RD1_E[23] -pin uut|RD1_D_r_reg[31:0] Q[23]
load net uut|RD1_E[24] -attr @rip(#000000) 24 -attr @name RD1_E[24] -hierPin uut RD1_E[24] -pin uut|RD1_D_r_reg[31:0] Q[24]
load net uut|RD1_E[25] -attr @rip(#000000) 25 -attr @name RD1_E[25] -hierPin uut RD1_E[25] -pin uut|RD1_D_r_reg[31:0] Q[25]
load net uut|RD1_E[26] -attr @rip(#000000) 26 -attr @name RD1_E[26] -hierPin uut RD1_E[26] -pin uut|RD1_D_r_reg[31:0] Q[26]
load net uut|RD1_E[27] -attr @rip(#000000) 27 -attr @name RD1_E[27] -hierPin uut RD1_E[27] -pin uut|RD1_D_r_reg[31:0] Q[27]
load net uut|RD1_E[28] -attr @rip(#000000) 28 -attr @name RD1_E[28] -hierPin uut RD1_E[28] -pin uut|RD1_D_r_reg[31:0] Q[28]
load net uut|RD1_E[29] -attr @rip(#000000) 29 -attr @name RD1_E[29] -hierPin uut RD1_E[29] -pin uut|RD1_D_r_reg[31:0] Q[29]
load net uut|RD1_E[2] -attr @rip(#000000) 2 -attr @name RD1_E[2] -hierPin uut RD1_E[2] -pin uut|RD1_D_r_reg[31:0] Q[2]
load net uut|RD1_E[30] -attr @rip(#000000) 30 -attr @name RD1_E[30] -hierPin uut RD1_E[30] -pin uut|RD1_D_r_reg[31:0] Q[30]
load net uut|RD1_E[31] -attr @rip(#000000) 31 -attr @name RD1_E[31] -hierPin uut RD1_E[31] -pin uut|RD1_D_r_reg[31:0] Q[31]
load net uut|RD1_E[3] -attr @rip(#000000) 3 -attr @name RD1_E[3] -hierPin uut RD1_E[3] -pin uut|RD1_D_r_reg[31:0] Q[3]
load net uut|RD1_E[4] -attr @rip(#000000) 4 -attr @name RD1_E[4] -hierPin uut RD1_E[4] -pin uut|RD1_D_r_reg[31:0] Q[4]
load net uut|RD1_E[5] -attr @rip(#000000) 5 -attr @name RD1_E[5] -hierPin uut RD1_E[5] -pin uut|RD1_D_r_reg[31:0] Q[5]
load net uut|RD1_E[6] -attr @rip(#000000) 6 -attr @name RD1_E[6] -hierPin uut RD1_E[6] -pin uut|RD1_D_r_reg[31:0] Q[6]
load net uut|RD1_E[7] -attr @rip(#000000) 7 -attr @name RD1_E[7] -hierPin uut RD1_E[7] -pin uut|RD1_D_r_reg[31:0] Q[7]
load net uut|RD1_E[8] -attr @rip(#000000) 8 -attr @name RD1_E[8] -hierPin uut RD1_E[8] -pin uut|RD1_D_r_reg[31:0] Q[8]
load net uut|RD1_E[9] -attr @rip(#000000) 9 -attr @name RD1_E[9] -hierPin uut RD1_E[9] -pin uut|RD1_D_r_reg[31:0] Q[9]
load net uut|RD2_D[0] -attr @rip(#000000) RD2[0] -attr @name RD2_D[0] -pin uut|RD2_D_r_reg[31:0] D[0] -pin uut|rf RD2[0]
load net uut|RD2_D[10] -attr @rip(#000000) RD2[10] -attr @name RD2_D[10] -pin uut|RD2_D_r_reg[31:0] D[10] -pin uut|rf RD2[10]
load net uut|RD2_D[11] -attr @rip(#000000) RD2[11] -attr @name RD2_D[11] -pin uut|RD2_D_r_reg[31:0] D[11] -pin uut|rf RD2[11]
load net uut|RD2_D[12] -attr @rip(#000000) RD2[12] -attr @name RD2_D[12] -pin uut|RD2_D_r_reg[31:0] D[12] -pin uut|rf RD2[12]
load net uut|RD2_D[13] -attr @rip(#000000) RD2[13] -attr @name RD2_D[13] -pin uut|RD2_D_r_reg[31:0] D[13] -pin uut|rf RD2[13]
load net uut|RD2_D[14] -attr @rip(#000000) RD2[14] -attr @name RD2_D[14] -pin uut|RD2_D_r_reg[31:0] D[14] -pin uut|rf RD2[14]
load net uut|RD2_D[15] -attr @rip(#000000) RD2[15] -attr @name RD2_D[15] -pin uut|RD2_D_r_reg[31:0] D[15] -pin uut|rf RD2[15]
load net uut|RD2_D[16] -attr @rip(#000000) RD2[16] -attr @name RD2_D[16] -pin uut|RD2_D_r_reg[31:0] D[16] -pin uut|rf RD2[16]
load net uut|RD2_D[17] -attr @rip(#000000) RD2[17] -attr @name RD2_D[17] -pin uut|RD2_D_r_reg[31:0] D[17] -pin uut|rf RD2[17]
load net uut|RD2_D[18] -attr @rip(#000000) RD2[18] -attr @name RD2_D[18] -pin uut|RD2_D_r_reg[31:0] D[18] -pin uut|rf RD2[18]
load net uut|RD2_D[19] -attr @rip(#000000) RD2[19] -attr @name RD2_D[19] -pin uut|RD2_D_r_reg[31:0] D[19] -pin uut|rf RD2[19]
load net uut|RD2_D[1] -attr @rip(#000000) RD2[1] -attr @name RD2_D[1] -pin uut|RD2_D_r_reg[31:0] D[1] -pin uut|rf RD2[1]
load net uut|RD2_D[20] -attr @rip(#000000) RD2[20] -attr @name RD2_D[20] -pin uut|RD2_D_r_reg[31:0] D[20] -pin uut|rf RD2[20]
load net uut|RD2_D[21] -attr @rip(#000000) RD2[21] -attr @name RD2_D[21] -pin uut|RD2_D_r_reg[31:0] D[21] -pin uut|rf RD2[21]
load net uut|RD2_D[22] -attr @rip(#000000) RD2[22] -attr @name RD2_D[22] -pin uut|RD2_D_r_reg[31:0] D[22] -pin uut|rf RD2[22]
load net uut|RD2_D[23] -attr @rip(#000000) RD2[23] -attr @name RD2_D[23] -pin uut|RD2_D_r_reg[31:0] D[23] -pin uut|rf RD2[23]
load net uut|RD2_D[24] -attr @rip(#000000) RD2[24] -attr @name RD2_D[24] -pin uut|RD2_D_r_reg[31:0] D[24] -pin uut|rf RD2[24]
load net uut|RD2_D[25] -attr @rip(#000000) RD2[25] -attr @name RD2_D[25] -pin uut|RD2_D_r_reg[31:0] D[25] -pin uut|rf RD2[25]
load net uut|RD2_D[26] -attr @rip(#000000) RD2[26] -attr @name RD2_D[26] -pin uut|RD2_D_r_reg[31:0] D[26] -pin uut|rf RD2[26]
load net uut|RD2_D[27] -attr @rip(#000000) RD2[27] -attr @name RD2_D[27] -pin uut|RD2_D_r_reg[31:0] D[27] -pin uut|rf RD2[27]
load net uut|RD2_D[28] -attr @rip(#000000) RD2[28] -attr @name RD2_D[28] -pin uut|RD2_D_r_reg[31:0] D[28] -pin uut|rf RD2[28]
load net uut|RD2_D[29] -attr @rip(#000000) RD2[29] -attr @name RD2_D[29] -pin uut|RD2_D_r_reg[31:0] D[29] -pin uut|rf RD2[29]
load net uut|RD2_D[2] -attr @rip(#000000) RD2[2] -attr @name RD2_D[2] -pin uut|RD2_D_r_reg[31:0] D[2] -pin uut|rf RD2[2]
load net uut|RD2_D[30] -attr @rip(#000000) RD2[30] -attr @name RD2_D[30] -pin uut|RD2_D_r_reg[31:0] D[30] -pin uut|rf RD2[30]
load net uut|RD2_D[31] -attr @rip(#000000) RD2[31] -attr @name RD2_D[31] -pin uut|RD2_D_r_reg[31:0] D[31] -pin uut|rf RD2[31]
load net uut|RD2_D[3] -attr @rip(#000000) RD2[3] -attr @name RD2_D[3] -pin uut|RD2_D_r_reg[31:0] D[3] -pin uut|rf RD2[3]
load net uut|RD2_D[4] -attr @rip(#000000) RD2[4] -attr @name RD2_D[4] -pin uut|RD2_D_r_reg[31:0] D[4] -pin uut|rf RD2[4]
load net uut|RD2_D[5] -attr @rip(#000000) RD2[5] -attr @name RD2_D[5] -pin uut|RD2_D_r_reg[31:0] D[5] -pin uut|rf RD2[5]
load net uut|RD2_D[6] -attr @rip(#000000) RD2[6] -attr @name RD2_D[6] -pin uut|RD2_D_r_reg[31:0] D[6] -pin uut|rf RD2[6]
load net uut|RD2_D[7] -attr @rip(#000000) RD2[7] -attr @name RD2_D[7] -pin uut|RD2_D_r_reg[31:0] D[7] -pin uut|rf RD2[7]
load net uut|RD2_D[8] -attr @rip(#000000) RD2[8] -attr @name RD2_D[8] -pin uut|RD2_D_r_reg[31:0] D[8] -pin uut|rf RD2[8]
load net uut|RD2_D[9] -attr @rip(#000000) RD2[9] -attr @name RD2_D[9] -pin uut|RD2_D_r_reg[31:0] D[9] -pin uut|rf RD2[9]
load net uut|RD2_E[0] -attr @rip(#000000) 0 -attr @name RD2_E[0] -hierPin uut RD2_E[0] -pin uut|RD2_D_r_reg[31:0] Q[0]
load net uut|RD2_E[10] -attr @rip(#000000) 10 -attr @name RD2_E[10] -hierPin uut RD2_E[10] -pin uut|RD2_D_r_reg[31:0] Q[10]
load net uut|RD2_E[11] -attr @rip(#000000) 11 -attr @name RD2_E[11] -hierPin uut RD2_E[11] -pin uut|RD2_D_r_reg[31:0] Q[11]
load net uut|RD2_E[12] -attr @rip(#000000) 12 -attr @name RD2_E[12] -hierPin uut RD2_E[12] -pin uut|RD2_D_r_reg[31:0] Q[12]
load net uut|RD2_E[13] -attr @rip(#000000) 13 -attr @name RD2_E[13] -hierPin uut RD2_E[13] -pin uut|RD2_D_r_reg[31:0] Q[13]
load net uut|RD2_E[14] -attr @rip(#000000) 14 -attr @name RD2_E[14] -hierPin uut RD2_E[14] -pin uut|RD2_D_r_reg[31:0] Q[14]
load net uut|RD2_E[15] -attr @rip(#000000) 15 -attr @name RD2_E[15] -hierPin uut RD2_E[15] -pin uut|RD2_D_r_reg[31:0] Q[15]
load net uut|RD2_E[16] -attr @rip(#000000) 16 -attr @name RD2_E[16] -hierPin uut RD2_E[16] -pin uut|RD2_D_r_reg[31:0] Q[16]
load net uut|RD2_E[17] -attr @rip(#000000) 17 -attr @name RD2_E[17] -hierPin uut RD2_E[17] -pin uut|RD2_D_r_reg[31:0] Q[17]
load net uut|RD2_E[18] -attr @rip(#000000) 18 -attr @name RD2_E[18] -hierPin uut RD2_E[18] -pin uut|RD2_D_r_reg[31:0] Q[18]
load net uut|RD2_E[19] -attr @rip(#000000) 19 -attr @name RD2_E[19] -hierPin uut RD2_E[19] -pin uut|RD2_D_r_reg[31:0] Q[19]
load net uut|RD2_E[1] -attr @rip(#000000) 1 -attr @name RD2_E[1] -hierPin uut RD2_E[1] -pin uut|RD2_D_r_reg[31:0] Q[1]
load net uut|RD2_E[20] -attr @rip(#000000) 20 -attr @name RD2_E[20] -hierPin uut RD2_E[20] -pin uut|RD2_D_r_reg[31:0] Q[20]
load net uut|RD2_E[21] -attr @rip(#000000) 21 -attr @name RD2_E[21] -hierPin uut RD2_E[21] -pin uut|RD2_D_r_reg[31:0] Q[21]
load net uut|RD2_E[22] -attr @rip(#000000) 22 -attr @name RD2_E[22] -hierPin uut RD2_E[22] -pin uut|RD2_D_r_reg[31:0] Q[22]
load net uut|RD2_E[23] -attr @rip(#000000) 23 -attr @name RD2_E[23] -hierPin uut RD2_E[23] -pin uut|RD2_D_r_reg[31:0] Q[23]
load net uut|RD2_E[24] -attr @rip(#000000) 24 -attr @name RD2_E[24] -hierPin uut RD2_E[24] -pin uut|RD2_D_r_reg[31:0] Q[24]
load net uut|RD2_E[25] -attr @rip(#000000) 25 -attr @name RD2_E[25] -hierPin uut RD2_E[25] -pin uut|RD2_D_r_reg[31:0] Q[25]
load net uut|RD2_E[26] -attr @rip(#000000) 26 -attr @name RD2_E[26] -hierPin uut RD2_E[26] -pin uut|RD2_D_r_reg[31:0] Q[26]
load net uut|RD2_E[27] -attr @rip(#000000) 27 -attr @name RD2_E[27] -hierPin uut RD2_E[27] -pin uut|RD2_D_r_reg[31:0] Q[27]
load net uut|RD2_E[28] -attr @rip(#000000) 28 -attr @name RD2_E[28] -hierPin uut RD2_E[28] -pin uut|RD2_D_r_reg[31:0] Q[28]
load net uut|RD2_E[29] -attr @rip(#000000) 29 -attr @name RD2_E[29] -hierPin uut RD2_E[29] -pin uut|RD2_D_r_reg[31:0] Q[29]
load net uut|RD2_E[2] -attr @rip(#000000) 2 -attr @name RD2_E[2] -hierPin uut RD2_E[2] -pin uut|RD2_D_r_reg[31:0] Q[2]
load net uut|RD2_E[30] -attr @rip(#000000) 30 -attr @name RD2_E[30] -hierPin uut RD2_E[30] -pin uut|RD2_D_r_reg[31:0] Q[30]
load net uut|RD2_E[31] -attr @rip(#000000) 31 -attr @name RD2_E[31] -hierPin uut RD2_E[31] -pin uut|RD2_D_r_reg[31:0] Q[31]
load net uut|RD2_E[3] -attr @rip(#000000) 3 -attr @name RD2_E[3] -hierPin uut RD2_E[3] -pin uut|RD2_D_r_reg[31:0] Q[3]
load net uut|RD2_E[4] -attr @rip(#000000) 4 -attr @name RD2_E[4] -hierPin uut RD2_E[4] -pin uut|RD2_D_r_reg[31:0] Q[4]
load net uut|RD2_E[5] -attr @rip(#000000) 5 -attr @name RD2_E[5] -hierPin uut RD2_E[5] -pin uut|RD2_D_r_reg[31:0] Q[5]
load net uut|RD2_E[6] -attr @rip(#000000) 6 -attr @name RD2_E[6] -hierPin uut RD2_E[6] -pin uut|RD2_D_r_reg[31:0] Q[6]
load net uut|RD2_E[7] -attr @rip(#000000) 7 -attr @name RD2_E[7] -hierPin uut RD2_E[7] -pin uut|RD2_D_r_reg[31:0] Q[7]
load net uut|RD2_E[8] -attr @rip(#000000) 8 -attr @name RD2_E[8] -hierPin uut RD2_E[8] -pin uut|RD2_D_r_reg[31:0] Q[8]
load net uut|RD2_E[9] -attr @rip(#000000) 9 -attr @name RD2_E[9] -hierPin uut RD2_E[9] -pin uut|RD2_D_r_reg[31:0] Q[9]
load net uut|RDW[0] -attr @rip(#000000) RDW[0] -attr @name RDW[0] -hierPin uut RDW[0] -pin uut|rf A3[0]
load net uut|RDW[1] -attr @rip(#000000) RDW[1] -attr @name RDW[1] -hierPin uut RDW[1] -pin uut|rf A3[1]
load net uut|RDW[2] -attr @rip(#000000) RDW[2] -attr @name RDW[2] -hierPin uut RDW[2] -pin uut|rf A3[2]
load net uut|RDW[3] -attr @rip(#000000) RDW[3] -attr @name RDW[3] -hierPin uut RDW[3] -pin uut|rf A3[3]
load net uut|RDW[4] -attr @rip(#000000) RDW[4] -attr @name RDW[4] -hierPin uut RDW[4] -pin uut|rf A3[4]
load net uut|RD_E[0] -attr @rip(#000000) 0 -attr @name RD_E[0] -hierPin uut RD_E[0] -pin uut|RD_D_r_reg[4:0] Q[0]
load net uut|RD_E[1] -attr @rip(#000000) 1 -attr @name RD_E[1] -hierPin uut RD_E[1] -pin uut|RD_D_r_reg[4:0] Q[1]
load net uut|RD_E[2] -attr @rip(#000000) 2 -attr @name RD_E[2] -hierPin uut RD_E[2] -pin uut|RD_D_r_reg[4:0] Q[2]
load net uut|RD_E[3] -attr @rip(#000000) 3 -attr @name RD_E[3] -hierPin uut RD_E[3] -pin uut|RD_D_r_reg[4:0] Q[3]
load net uut|RD_E[4] -attr @rip(#000000) 4 -attr @name RD_E[4] -hierPin uut RD_E[4] -pin uut|RD_D_r_reg[4:0] Q[4]
load net uut|RS1_E[0] -attr @rip(#000000) 0 -attr @name RS1_E[0] -hierPin uut RS1_E[0] -pin uut|RS1_D_r_reg[4:0] Q[0]
load net uut|RS1_E[1] -attr @rip(#000000) 1 -attr @name RS1_E[1] -hierPin uut RS1_E[1] -pin uut|RS1_D_r_reg[4:0] Q[1]
load net uut|RS1_E[2] -attr @rip(#000000) 2 -attr @name RS1_E[2] -hierPin uut RS1_E[2] -pin uut|RS1_D_r_reg[4:0] Q[2]
load net uut|RS1_E[3] -attr @rip(#000000) 3 -attr @name RS1_E[3] -hierPin uut RS1_E[3] -pin uut|RS1_D_r_reg[4:0] Q[3]
load net uut|RS1_E[4] -attr @rip(#000000) 4 -attr @name RS1_E[4] -hierPin uut RS1_E[4] -pin uut|RS1_D_r_reg[4:0] Q[4]
load net uut|RS2_E[0] -attr @rip(#000000) 0 -attr @name RS2_E[0] -hierPin uut RS2_E[0] -pin uut|RS2_D_r_reg[4:0] Q[0]
load net uut|RS2_E[1] -attr @rip(#000000) 1 -attr @name RS2_E[1] -hierPin uut RS2_E[1] -pin uut|RS2_D_r_reg[4:0] Q[1]
load net uut|RS2_E[2] -attr @rip(#000000) 2 -attr @name RS2_E[2] -hierPin uut RS2_E[2] -pin uut|RS2_D_r_reg[4:0] Q[2]
load net uut|RS2_E[3] -attr @rip(#000000) 3 -attr @name RS2_E[3] -hierPin uut RS2_E[3] -pin uut|RS2_D_r_reg[4:0] Q[3]
load net uut|RS2_E[4] -attr @rip(#000000) 4 -attr @name RS2_E[4] -hierPin uut RS2_E[4] -pin uut|RS2_D_r_reg[4:0] Q[4]
load net uut|RegWriteD -attr @name RegWriteD -pin uut|RegWriteD_r_reg D -pin uut|control RegWrite
netloc uut|RegWriteD 1 1 2 1170J 758 1620
load net uut|RegWriteE -attr @name RegWriteE -hierPin uut RegWriteE -pin uut|RegWriteD_r_reg Q
netloc uut|RegWriteE 1 3 1 1910 848n
load net uut|RegWriteW -attr @name RegWriteW -hierPin uut RegWriteW -pin uut|rf WE3
netloc uut|RegWriteW 1 0 2 250J 1946 1110
load net uut|ResultSrcD[0] -attr @rip(#000000) ResultSrc[0] -attr @name ResultSrcD[0] -pin uut|ResultSrcD_r_reg[1:0] D[0] -pin uut|control ResultSrc[0]
load net uut|ResultSrcD[1] -attr @rip(#000000) ResultSrc[1] -attr @name ResultSrcD[1] -pin uut|ResultSrcD_r_reg[1:0] D[1] -pin uut|control ResultSrc[1]
load net uut|ResultSrcE[0] -attr @rip(#000000) 0 -attr @name ResultSrcE[0] -hierPin uut ResultSrcE[0] -pin uut|ResultSrcD_r_reg[1:0] Q[0]
load net uut|ResultSrcE[1] -attr @rip(#000000) 1 -attr @name ResultSrcE[1] -hierPin uut ResultSrcE[1] -pin uut|ResultSrcD_r_reg[1:0] Q[1]
load net uut|ResultW[0] -attr @rip(#000000) ResultW[0] -attr @name ResultW[0] -hierPin uut ResultW[0] -pin uut|rf WD3[0]
load net uut|ResultW[10] -attr @rip(#000000) ResultW[10] -attr @name ResultW[10] -hierPin uut ResultW[10] -pin uut|rf WD3[10]
load net uut|ResultW[11] -attr @rip(#000000) ResultW[11] -attr @name ResultW[11] -hierPin uut ResultW[11] -pin uut|rf WD3[11]
load net uut|ResultW[12] -attr @rip(#000000) ResultW[12] -attr @name ResultW[12] -hierPin uut ResultW[12] -pin uut|rf WD3[12]
load net uut|ResultW[13] -attr @rip(#000000) ResultW[13] -attr @name ResultW[13] -hierPin uut ResultW[13] -pin uut|rf WD3[13]
load net uut|ResultW[14] -attr @rip(#000000) ResultW[14] -attr @name ResultW[14] -hierPin uut ResultW[14] -pin uut|rf WD3[14]
load net uut|ResultW[15] -attr @rip(#000000) ResultW[15] -attr @name ResultW[15] -hierPin uut ResultW[15] -pin uut|rf WD3[15]
load net uut|ResultW[16] -attr @rip(#000000) ResultW[16] -attr @name ResultW[16] -hierPin uut ResultW[16] -pin uut|rf WD3[16]
load net uut|ResultW[17] -attr @rip(#000000) ResultW[17] -attr @name ResultW[17] -hierPin uut ResultW[17] -pin uut|rf WD3[17]
load net uut|ResultW[18] -attr @rip(#000000) ResultW[18] -attr @name ResultW[18] -hierPin uut ResultW[18] -pin uut|rf WD3[18]
load net uut|ResultW[19] -attr @rip(#000000) ResultW[19] -attr @name ResultW[19] -hierPin uut ResultW[19] -pin uut|rf WD3[19]
load net uut|ResultW[1] -attr @rip(#000000) ResultW[1] -attr @name ResultW[1] -hierPin uut ResultW[1] -pin uut|rf WD3[1]
load net uut|ResultW[20] -attr @rip(#000000) ResultW[20] -attr @name ResultW[20] -hierPin uut ResultW[20] -pin uut|rf WD3[20]
load net uut|ResultW[21] -attr @rip(#000000) ResultW[21] -attr @name ResultW[21] -hierPin uut ResultW[21] -pin uut|rf WD3[21]
load net uut|ResultW[22] -attr @rip(#000000) ResultW[22] -attr @name ResultW[22] -hierPin uut ResultW[22] -pin uut|rf WD3[22]
load net uut|ResultW[23] -attr @rip(#000000) ResultW[23] -attr @name ResultW[23] -hierPin uut ResultW[23] -pin uut|rf WD3[23]
load net uut|ResultW[24] -attr @rip(#000000) ResultW[24] -attr @name ResultW[24] -hierPin uut ResultW[24] -pin uut|rf WD3[24]
load net uut|ResultW[25] -attr @rip(#000000) ResultW[25] -attr @name ResultW[25] -hierPin uut ResultW[25] -pin uut|rf WD3[25]
load net uut|ResultW[26] -attr @rip(#000000) ResultW[26] -attr @name ResultW[26] -hierPin uut ResultW[26] -pin uut|rf WD3[26]
load net uut|ResultW[27] -attr @rip(#000000) ResultW[27] -attr @name ResultW[27] -hierPin uut ResultW[27] -pin uut|rf WD3[27]
load net uut|ResultW[28] -attr @rip(#000000) ResultW[28] -attr @name ResultW[28] -hierPin uut ResultW[28] -pin uut|rf WD3[28]
load net uut|ResultW[29] -attr @rip(#000000) ResultW[29] -attr @name ResultW[29] -hierPin uut ResultW[29] -pin uut|rf WD3[29]
load net uut|ResultW[2] -attr @rip(#000000) ResultW[2] -attr @name ResultW[2] -hierPin uut ResultW[2] -pin uut|rf WD3[2]
load net uut|ResultW[30] -attr @rip(#000000) ResultW[30] -attr @name ResultW[30] -hierPin uut ResultW[30] -pin uut|rf WD3[30]
load net uut|ResultW[31] -attr @rip(#000000) ResultW[31] -attr @name ResultW[31] -hierPin uut ResultW[31] -pin uut|rf WD3[31]
load net uut|ResultW[3] -attr @rip(#000000) ResultW[3] -attr @name ResultW[3] -hierPin uut ResultW[3] -pin uut|rf WD3[3]
load net uut|ResultW[4] -attr @rip(#000000) ResultW[4] -attr @name ResultW[4] -hierPin uut ResultW[4] -pin uut|rf WD3[4]
load net uut|ResultW[5] -attr @rip(#000000) ResultW[5] -attr @name ResultW[5] -hierPin uut ResultW[5] -pin uut|rf WD3[5]
load net uut|ResultW[6] -attr @rip(#000000) ResultW[6] -attr @name ResultW[6] -hierPin uut ResultW[6] -pin uut|rf WD3[6]
load net uut|ResultW[7] -attr @rip(#000000) ResultW[7] -attr @name ResultW[7] -hierPin uut ResultW[7] -pin uut|rf WD3[7]
load net uut|ResultW[8] -attr @rip(#000000) ResultW[8] -attr @name ResultW[8] -hierPin uut ResultW[8] -pin uut|rf WD3[8]
load net uut|ResultW[9] -attr @rip(#000000) ResultW[9] -attr @name ResultW[9] -hierPin uut ResultW[9] -pin uut|rf WD3[9]
load net uut|clk -attr @name clk -hierPin uut clk -pin uut|ALUControlD_r_reg[2:0] C -pin uut|ALUSrcD_r_reg C -pin uut|BranchD_r_reg C -pin uut|Imm_Ext_D_r_reg[31:0] C -pin uut|JumpD_r_reg C -pin uut|MemWriteD_r_reg C -pin uut|PCD_r_reg[31:0] C -pin uut|PCPlus4D_r_reg[31:0] C -pin uut|RD1_D_r_reg[31:0] C -pin uut|RD2_D_r_reg[31:0] C -pin uut|RD_D_r_reg[4:0] C -pin uut|RS1_D_r_reg[4:0] C -pin uut|RS2_D_r_reg[4:0] C -pin uut|RegWriteD_r_reg C -pin uut|ResultSrcD_r_reg[1:0] C -pin uut|rf clk
netloc uut|clk 1 0 3 210J 1986 1150 1868 1580
load net uut|reset -attr @name reset -hierPin uut reset -pin uut|ALUControlD_r_reg[2:0] CLR -pin uut|ALUSrcD_r_reg CLR -pin uut|BranchD_r_reg CLR -pin uut|Imm_Ext_D_r_reg[31:0] CLR -pin uut|JumpD_r_reg CLR -pin uut|MemWriteD_r_reg CLR -pin uut|PCD_r_reg[31:0] CLR -pin uut|PCPlus4D_r_reg[31:0] CLR -pin uut|RD1_D_r_reg[31:0] CLR -pin uut|RD2_D_r_reg[31:0] CLR -pin uut|RD_D_r_reg[4:0] CLR -pin uut|RS1_D_r_reg[4:0] CLR -pin uut|RS2_D_r_reg[4:0] CLR -pin uut|RegWriteD_r_reg CLR -pin uut|ResultSrcD_r_reg[1:0] CLR -pin uut|rf reset
netloc uut|reset 1 0 3 190J 2006 1190 1888 1520
load net uut|control|ALUControl[0] -attr @rip ALUControl[0] -attr @name ALUControl[0] -hierPin uut|control ALUControl[0] -pin uut|control|ALU_Decoder ALUControl[0]
load net uut|control|ALUControl[1] -attr @rip ALUControl[1] -attr @name ALUControl[1] -hierPin uut|control ALUControl[1] -pin uut|control|ALU_Decoder ALUControl[1]
load net uut|control|ALUControl[2] -attr @rip ALUControl[2] -attr @name ALUControl[2] -hierPin uut|control ALUControl[2] -pin uut|control|ALU_Decoder ALUControl[2]
load net uut|control|ALUOp[0] -attr @rip ALUOp[0] -attr @name ALUOp[0] -pin uut|control|ALU_Decoder ALUOp[0] -pin uut|control|Main_Decoder ALUOp[0]
load net uut|control|ALUOp[1] -attr @rip ALUOp[1] -attr @name ALUOp[1] -pin uut|control|ALU_Decoder ALUOp[1] -pin uut|control|Main_Decoder ALUOp[1]
load net uut|control|ALUSrc -attr @name ALUSrc -hierPin uut|control ALUSrc -pin uut|control|Main_Decoder ALUSrc
netloc uut|control|ALUSrc 1 1 2 N 706 NJ
load net uut|control|Branch -attr @name Branch -hierPin uut|control Branch -pin uut|control|Main_Decoder Branch
netloc uut|control|Branch 1 1 2 N 726 NJ
load net uut|control|ImmSrc[0] -attr @rip ImmSrc[0] -attr @name ImmSrc[0] -hierPin uut|control ImmSrc[0] -pin uut|control|Main_Decoder ImmSrc[0]
load net uut|control|ImmSrc[1] -attr @rip ImmSrc[1] -attr @name ImmSrc[1] -hierPin uut|control ImmSrc[1] -pin uut|control|Main_Decoder ImmSrc[1]
load net uut|control|Jump -attr @name Jump -hierPin uut|control Jump -pin uut|control|Main_Decoder Jump
netloc uut|control|Jump 1 1 2 N 766 NJ
load net uut|control|MemWrite -attr @name MemWrite -hierPin uut|control MemWrite -pin uut|control|Main_Decoder MemWrite
netloc uut|control|MemWrite 1 1 2 N 786 NJ
load net uut|control|Op[0] -attr @rip Op[0] -attr @name Op[0] -hierPin uut|control Op[0] -pin uut|control|ALU_Decoder Op[0] -pin uut|control|Main_Decoder Op[0]
load net uut|control|Op[1] -attr @rip Op[1] -attr @name Op[1] -hierPin uut|control Op[1] -pin uut|control|ALU_Decoder Op[1] -pin uut|control|Main_Decoder Op[1]
load net uut|control|Op[2] -attr @rip Op[2] -attr @name Op[2] -hierPin uut|control Op[2] -pin uut|control|ALU_Decoder Op[2] -pin uut|control|Main_Decoder Op[2]
load net uut|control|Op[3] -attr @rip Op[3] -attr @name Op[3] -hierPin uut|control Op[3] -pin uut|control|ALU_Decoder Op[3] -pin uut|control|Main_Decoder Op[3]
load net uut|control|Op[4] -attr @rip Op[4] -attr @name Op[4] -hierPin uut|control Op[4] -pin uut|control|ALU_Decoder Op[4] -pin uut|control|Main_Decoder Op[4]
load net uut|control|Op[5] -attr @rip Op[5] -attr @name Op[5] -hierPin uut|control Op[5] -pin uut|control|ALU_Decoder Op[5] -pin uut|control|Main_Decoder Op[5]
load net uut|control|Op[6] -attr @rip Op[6] -attr @name Op[6] -hierPin uut|control Op[6] -pin uut|control|ALU_Decoder Op[6] -pin uut|control|Main_Decoder Op[6]
load net uut|control|RegWrite -attr @name RegWrite -hierPin uut|control RegWrite -pin uut|control|Main_Decoder RegWrite
netloc uut|control|RegWrite 1 1 2 N 806 NJ
load net uut|control|ResultSrc[0] -attr @rip ResultSrc[0] -attr @name ResultSrc[0] -hierPin uut|control ResultSrc[0] -pin uut|control|Main_Decoder ResultSrc[0]
load net uut|control|ResultSrc[1] -attr @rip ResultSrc[1] -attr @name ResultSrc[1] -hierPin uut|control ResultSrc[1] -pin uut|control|Main_Decoder ResultSrc[1]
load net uut|control|funct3[0] -attr @rip funct3[0] -attr @name funct3[0] -hierPin uut|control funct3[0] -pin uut|control|ALU_Decoder funct3[0]
load net uut|control|funct3[1] -attr @rip funct3[1] -attr @name funct3[1] -hierPin uut|control funct3[1] -pin uut|control|ALU_Decoder funct3[1]
load net uut|control|funct3[2] -attr @rip funct3[2] -attr @name funct3[2] -hierPin uut|control funct3[2] -pin uut|control|ALU_Decoder funct3[2]
load net uut|control|funct7[0] -attr @rip funct7[0] -attr @name funct7[0] -hierPin uut|control funct7[0] -pin uut|control|ALU_Decoder funct7[0]
load net uut|control|funct7[1] -attr @rip funct7[1] -attr @name funct7[1] -hierPin uut|control funct7[1] -pin uut|control|ALU_Decoder funct7[1]
load net uut|control|funct7[2] -attr @rip funct7[2] -attr @name funct7[2] -hierPin uut|control funct7[2] -pin uut|control|ALU_Decoder funct7[2]
load net uut|control|funct7[3] -attr @rip funct7[3] -attr @name funct7[3] -hierPin uut|control funct7[3] -pin uut|control|ALU_Decoder funct7[3]
load net uut|control|funct7[4] -attr @rip funct7[4] -attr @name funct7[4] -hierPin uut|control funct7[4] -pin uut|control|ALU_Decoder funct7[4]
load net uut|control|funct7[5] -attr @rip funct7[5] -attr @name funct7[5] -hierPin uut|control funct7[5] -pin uut|control|ALU_Decoder funct7[5]
load net uut|control|funct7[6] -attr @rip funct7[6] -attr @name funct7[6] -hierPin uut|control funct7[6] -pin uut|control|ALU_Decoder funct7[6]
load netBundle @uut|control|Op 7 uut|control|Op[6] uut|control|Op[5] uut|control|Op[4] uut|control|Op[3] uut|control|Op[2] uut|control|Op[1] uut|control|Op[0] -autobundled
netbloc @uut|control|Op 1 0 2 390 586 N
load netBundle @uut|control|funct3 3 uut|control|funct3[2] uut|control|funct3[1] uut|control|funct3[0] -autobundled
netbloc @uut|control|funct3 1 0 2 NJ 606 N
load netBundle @uut|control|funct7 7 uut|control|funct7[6] uut|control|funct7[5] uut|control|funct7[4] uut|control|funct7[3] uut|control|funct7[2] uut|control|funct7[1] uut|control|funct7[0] -autobundled
netbloc @uut|control|funct7 1 0 2 NJ 626 N
load netBundle @uut|control|ALUControl 3 uut|control|ALUControl[2] uut|control|ALUControl[1] uut|control|ALUControl[0] -autobundled
netbloc @uut|control|ALUControl 1 2 1 N 586
load netBundle @uut|control|ALUOp 2 uut|control|ALUOp[1] uut|control|ALUOp[0] -autobundled
netbloc @uut|control|ALUOp 1 1 1 640 566n
load netBundle @uut|control|ImmSrc 2 uut|control|ImmSrc[1] uut|control|ImmSrc[0] -autobundled
netbloc @uut|control|ImmSrc 1 1 2 N 746 NJ
load netBundle @uut|control|ResultSrc 2 uut|control|ResultSrc[1] uut|control|ResultSrc[0] -autobundled
netbloc @uut|control|ResultSrc 1 1 2 N 826 NJ
load netBundle @uut|InstrD 32 uut|InstrD[31] uut|InstrD[30] uut|InstrD[29] uut|InstrD[28] uut|InstrD[27] uut|InstrD[26] uut|InstrD[25] uut|InstrD[24] uut|InstrD[23] uut|InstrD[22] uut|InstrD[21] uut|InstrD[20] uut|InstrD[19] uut|InstrD[18] uut|InstrD[17] uut|InstrD[16] uut|InstrD[15] uut|InstrD[14] uut|InstrD[13] uut|InstrD[12] uut|InstrD[11] uut|InstrD[10] uut|InstrD[9] uut|InstrD[8] uut|InstrD[7] uut|InstrD[6] uut|InstrD[5] uut|InstrD[4] uut|InstrD[3] uut|InstrD[2] uut|InstrD[1] uut|InstrD[0] -autobundled
netbloc @uut|InstrD 1 0 3 270 896 1210 1568 1500
load netBundle @uut|PCD 32 uut|PCD[31] uut|PCD[30] uut|PCD[29] uut|PCD[28] uut|PCD[27] uut|PCD[26] uut|PCD[25] uut|PCD[24] uut|PCD[23] uut|PCD[22] uut|PCD[21] uut|PCD[20] uut|PCD[19] uut|PCD[18] uut|PCD[17] uut|PCD[16] uut|PCD[15] uut|PCD[14] uut|PCD[13] uut|PCD[12] uut|PCD[11] uut|PCD[10] uut|PCD[9] uut|PCD[8] uut|PCD[7] uut|PCD[6] uut|PCD[5] uut|PCD[4] uut|PCD[3] uut|PCD[2] uut|PCD[1] uut|PCD[0] -autobundled
netbloc @uut|PCD 1 0 3 270J 1156 1090J 978 N
load netBundle @uut|PCPlus4D 32 uut|PCPlus4D[31] uut|PCPlus4D[30] uut|PCPlus4D[29] uut|PCPlus4D[28] uut|PCPlus4D[27] uut|PCPlus4D[26] uut|PCPlus4D[25] uut|PCPlus4D[24] uut|PCPlus4D[23] uut|PCPlus4D[22] uut|PCPlus4D[21] uut|PCPlus4D[20] uut|PCPlus4D[19] uut|PCPlus4D[18] uut|PCPlus4D[17] uut|PCPlus4D[16] uut|PCPlus4D[15] uut|PCPlus4D[14] uut|PCPlus4D[13] uut|PCPlus4D[12] uut|PCPlus4D[11] uut|PCPlus4D[10] uut|PCPlus4D[9] uut|PCPlus4D[8] uut|PCPlus4D[7] uut|PCPlus4D[6] uut|PCPlus4D[5] uut|PCPlus4D[4] uut|PCPlus4D[3] uut|PCPlus4D[2] uut|PCPlus4D[1] uut|PCPlus4D[0] -autobundled
netbloc @uut|PCPlus4D 1 0 3 190J 1286 1170J 1108 N
load netBundle @uut|RDW 5 uut|RDW[4] uut|RDW[3] uut|RDW[2] uut|RDW[1] uut|RDW[0] -autobundled
netbloc @uut|RDW 1 0 2 270J 1926 1070
load netBundle @uut|ResultW 32 uut|ResultW[31] uut|ResultW[30] uut|ResultW[29] uut|ResultW[28] uut|ResultW[27] uut|ResultW[26] uut|ResultW[25] uut|ResultW[24] uut|ResultW[23] uut|ResultW[22] uut|ResultW[21] uut|ResultW[20] uut|ResultW[19] uut|ResultW[18] uut|ResultW[17] uut|ResultW[16] uut|ResultW[15] uut|ResultW[14] uut|ResultW[13] uut|ResultW[12] uut|ResultW[11] uut|ResultW[10] uut|ResultW[9] uut|ResultW[8] uut|ResultW[7] uut|ResultW[6] uut|ResultW[5] uut|ResultW[4] uut|ResultW[3] uut|ResultW[2] uut|ResultW[1] uut|ResultW[0] -autobundled
netbloc @uut|ResultW 1 0 2 230J 1966 1090
load netBundle @uut|ALUControlD 3 uut|ALUControlD[2] uut|ALUControlD[1] uut|ALUControlD[0] -autobundled
netbloc @uut|ALUControlD 1 1 2 1050J 538 1480
load netBundle @uut|ImmSrcD 2 uut|ImmSrcD[1] uut|ImmSrcD[0] -autobundled
netbloc @uut|ImmSrcD 1 1 1 1130 698n
load netBundle @uut|ResultSrcD 2 uut|ResultSrcD[1] uut|ResultSrcD[0] -autobundled
netbloc @uut|ResultSrcD 1 1 2 1190J 778 1480
load netBundle @uut|Imm_Ext_D 32 uut|Imm_Ext_D[31] uut|Imm_Ext_D[30] uut|Imm_Ext_D[29] uut|Imm_Ext_D[28] uut|Imm_Ext_D[27] uut|Imm_Ext_D[26] uut|Imm_Ext_D[25] uut|Imm_Ext_D[24] uut|Imm_Ext_D[23] uut|Imm_Ext_D[22] uut|Imm_Ext_D[21] uut|Imm_Ext_D[20] uut|Imm_Ext_D[19] uut|Imm_Ext_D[18] uut|Imm_Ext_D[17] uut|Imm_Ext_D[16] uut|Imm_Ext_D[15] uut|Imm_Ext_D[14] uut|Imm_Ext_D[13] uut|Imm_Ext_D[12] uut|Imm_Ext_D[11] uut|Imm_Ext_D[10] uut|Imm_Ext_D[9] uut|Imm_Ext_D[8] uut|Imm_Ext_D[7] uut|Imm_Ext_D[6] uut|Imm_Ext_D[5] uut|Imm_Ext_D[4] uut|Imm_Ext_D[3] uut|Imm_Ext_D[2] uut|Imm_Ext_D[1] uut|Imm_Ext_D[0] -autobundled
netbloc @uut|Imm_Ext_D 1 2 1 1600 358n
load netBundle @uut|RD1_D 32 uut|RD1_D[31] uut|RD1_D[30] uut|RD1_D[29] uut|RD1_D[28] uut|RD1_D[27] uut|RD1_D[26] uut|RD1_D[25] uut|RD1_D[24] uut|RD1_D[23] uut|RD1_D[22] uut|RD1_D[21] uut|RD1_D[20] uut|RD1_D[19] uut|RD1_D[18] uut|RD1_D[17] uut|RD1_D[16] uut|RD1_D[15] uut|RD1_D[14] uut|RD1_D[13] uut|RD1_D[12] uut|RD1_D[11] uut|RD1_D[10] uut|RD1_D[9] uut|RD1_D[8] uut|RD1_D[7] uut|RD1_D[6] uut|RD1_D[5] uut|RD1_D[4] uut|RD1_D[3] uut|RD1_D[2] uut|RD1_D[1] uut|RD1_D[0] -autobundled
netbloc @uut|RD1_D 1 2 1 1560 1748n
load netBundle @uut|RD2_D 32 uut|RD2_D[31] uut|RD2_D[30] uut|RD2_D[29] uut|RD2_D[28] uut|RD2_D[27] uut|RD2_D[26] uut|RD2_D[25] uut|RD2_D[24] uut|RD2_D[23] uut|RD2_D[22] uut|RD2_D[21] uut|RD2_D[20] uut|RD2_D[19] uut|RD2_D[18] uut|RD2_D[17] uut|RD2_D[16] uut|RD2_D[15] uut|RD2_D[14] uut|RD2_D[13] uut|RD2_D[12] uut|RD2_D[11] uut|RD2_D[10] uut|RD2_D[9] uut|RD2_D[8] uut|RD2_D[7] uut|RD2_D[6] uut|RD2_D[5] uut|RD2_D[4] uut|RD2_D[3] uut|RD2_D[2] uut|RD2_D[1] uut|RD2_D[0] -autobundled
netbloc @uut|RD2_D 1 2 1 1540 1768n
load netBundle @uut|ALUControlE 3 uut|ALUControlE[2] uut|ALUControlE[1] uut|ALUControlE[0] -autobundled
netbloc @uut|ALUControlE 1 3 1 1890 188n
load netBundle @uut|ResultSrcE 2 uut|ResultSrcE[1] uut|ResultSrcE[0] -autobundled
netbloc @uut|ResultSrcE 1 3 1 1890 1358n
load netBundle @uut|RS2_E 5 uut|RS2_E[4] uut|RS2_E[3] uut|RS2_E[2] uut|RS2_E[1] uut|RS2_E[0] -autobundled
netbloc @uut|RS2_E 1 3 1 1950 1508n
load netBundle @uut|RS1_E 5 uut|RS1_E[4] uut|RS1_E[3] uut|RS1_E[2] uut|RS1_E[1] uut|RS1_E[0] -autobundled
netbloc @uut|RS1_E 1 3 1 N 1488
load netBundle @uut|RD2_E 32 uut|RD2_E[31] uut|RD2_E[30] uut|RD2_E[29] uut|RD2_E[28] uut|RD2_E[27] uut|RD2_E[26] uut|RD2_E[25] uut|RD2_E[24] uut|RD2_E[23] uut|RD2_E[22] uut|RD2_E[21] uut|RD2_E[20] uut|RD2_E[19] uut|RD2_E[18] uut|RD2_E[17] uut|RD2_E[16] uut|RD2_E[15] uut|RD2_E[14] uut|RD2_E[13] uut|RD2_E[12] uut|RD2_E[11] uut|RD2_E[10] uut|RD2_E[9] uut|RD2_E[8] uut|RD2_E[7] uut|RD2_E[6] uut|RD2_E[5] uut|RD2_E[4] uut|RD2_E[3] uut|RD2_E[2] uut|RD2_E[1] uut|RD2_E[0] -autobundled
netbloc @uut|RD2_E 1 3 1 1970 1468n
load netBundle @uut|RD1_E 32 uut|RD1_E[31] uut|RD1_E[30] uut|RD1_E[29] uut|RD1_E[28] uut|RD1_E[27] uut|RD1_E[26] uut|RD1_E[25] uut|RD1_E[24] uut|RD1_E[23] uut|RD1_E[22] uut|RD1_E[21] uut|RD1_E[20] uut|RD1_E[19] uut|RD1_E[18] uut|RD1_E[17] uut|RD1_E[16] uut|RD1_E[15] uut|RD1_E[14] uut|RD1_E[13] uut|RD1_E[12] uut|RD1_E[11] uut|RD1_E[10] uut|RD1_E[9] uut|RD1_E[8] uut|RD1_E[7] uut|RD1_E[6] uut|RD1_E[5] uut|RD1_E[4] uut|RD1_E[3] uut|RD1_E[2] uut|RD1_E[1] uut|RD1_E[0] -autobundled
netbloc @uut|RD1_E 1 3 1 1930 1448n
load netBundle @uut|RD_E 5 uut|RD_E[4] uut|RD_E[3] uut|RD_E[2] uut|RD_E[1] uut|RD_E[0] -autobundled
netbloc @uut|RD_E 1 3 1 N 1228
load netBundle @uut|PCPlus4E 32 uut|PCPlus4E[31] uut|PCPlus4E[30] uut|PCPlus4E[29] uut|PCPlus4E[28] uut|PCPlus4E[27] uut|PCPlus4E[26] uut|PCPlus4E[25] uut|PCPlus4E[24] uut|PCPlus4E[23] uut|PCPlus4E[22] uut|PCPlus4E[21] uut|PCPlus4E[20] uut|PCPlus4E[19] uut|PCPlus4E[18] uut|PCPlus4E[17] uut|PCPlus4E[16] uut|PCPlus4E[15] uut|PCPlus4E[14] uut|PCPlus4E[13] uut|PCPlus4E[12] uut|PCPlus4E[11] uut|PCPlus4E[10] uut|PCPlus4E[9] uut|PCPlus4E[8] uut|PCPlus4E[7] uut|PCPlus4E[6] uut|PCPlus4E[5] uut|PCPlus4E[4] uut|PCPlus4E[3] uut|PCPlus4E[2] uut|PCPlus4E[1] uut|PCPlus4E[0] -autobundled
netbloc @uut|PCPlus4E 1 3 1 N 1098
load netBundle @uut|PCE 32 uut|PCE[31] uut|PCE[30] uut|PCE[29] uut|PCE[28] uut|PCE[27] uut|PCE[26] uut|PCE[25] uut|PCE[24] uut|PCE[23] uut|PCE[22] uut|PCE[21] uut|PCE[20] uut|PCE[19] uut|PCE[18] uut|PCE[17] uut|PCE[16] uut|PCE[15] uut|PCE[14] uut|PCE[13] uut|PCE[12] uut|PCE[11] uut|PCE[10] uut|PCE[9] uut|PCE[8] uut|PCE[7] uut|PCE[6] uut|PCE[5] uut|PCE[4] uut|PCE[3] uut|PCE[2] uut|PCE[1] uut|PCE[0] -autobundled
netbloc @uut|PCE 1 3 1 N 968
load netBundle @uut|Imm_Ext_E 32 uut|Imm_Ext_E[31] uut|Imm_Ext_E[30] uut|Imm_Ext_E[29] uut|Imm_Ext_E[28] uut|Imm_Ext_E[27] uut|Imm_Ext_E[26] uut|Imm_Ext_E[25] uut|Imm_Ext_E[24] uut|Imm_Ext_E[23] uut|Imm_Ext_E[22] uut|Imm_Ext_E[21] uut|Imm_Ext_E[20] uut|Imm_Ext_E[19] uut|Imm_Ext_E[18] uut|Imm_Ext_E[17] uut|Imm_Ext_E[16] uut|Imm_Ext_E[15] uut|Imm_Ext_E[14] uut|Imm_Ext_E[13] uut|Imm_Ext_E[12] uut|Imm_Ext_E[11] uut|Imm_Ext_E[10] uut|Imm_Ext_E[9] uut|Imm_Ext_E[8] uut|Imm_Ext_E[7] uut|Imm_Ext_E[6] uut|Imm_Ext_E[5] uut|Imm_Ext_E[4] uut|Imm_Ext_E[3] uut|Imm_Ext_E[2] uut|Imm_Ext_E[1] uut|Imm_Ext_E[0] -autobundled
netbloc @uut|Imm_Ext_E 1 3 1 N 348
levelinfo -pg 1 -80 240 2170
levelinfo -hier uut * 360 1310 1670 *
levelinfo -hier uut|control * 470 740 *
pagesize -pg 1 -db -bbox -sgen -80 -10 2170 2150
pagesize -hier uut -db -bbox -sgen 160 38 2000 2018
pagesize -hier uut|control -db -bbox -sgen 360 506 930 866
show
zoom 0.961646
scrollpos 411 385
#
# initialize ictrl to current module tb_decode work:tb_decode:NOFILE
ictrl init topinfo |
