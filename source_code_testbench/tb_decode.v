`timescale 1ns/1ps

module tb_decode_cycle;


    reg         clk;
    reg         reset;
    reg  [31:0] InstrD;
    reg  [31:0] PCD;
    reg  [31:0] PCPlus4D;
    reg  [31:0] ResultW;
    reg         RegWriteW;
    reg  [4:0]  RDW;

    wire        RegWriteE;
    wire        ALUSrcE;
    wire        MemWriteE;
    wire        BranchE;
    wire        JumpE;
    wire [1:0]  ResultSrcE;
    wire [3:0]  ALUControlE;
    wire [31:0] RD1_E;
    wire [31:0] RD2_E;
    wire [31:0] Imm_Ext_E;
    wire [4:0]  RD_E;
    wire [4:0]  RS1_E;
    wire [4:0]  RS2_E;
    wire [31:0] PCE;
    wire [31:0] PCPlus4E;
    wire [4:0]  Rs1_D_out;
    wire [4:0]  Rs2_D_out;


    decode_cycle dut (
        .clk        (clk),
        .reset      (reset),
        .InstrD     (InstrD),
        .PCD        (PCD),
        .PCPlus4D   (PCPlus4D),
        .RegWriteW  (RegWriteW),
        .RDW        (RDW),
        .ResultW    (ResultW),
        .RegWriteE  (RegWriteE),
        .ALUSrcE    (ALUSrcE),
        .MemWriteE  (MemWriteE),
        .ResultSrcE (ResultSrcE),
        .BranchE    (BranchE),
        .JumpE      (JumpE),
        .ALUControlE(ALUControlE),
        .RD1_E      (RD1_E),
        .RD2_E      (RD2_E),
        .Imm_Ext_E  (Imm_Ext_E),
        .RD_E       (RD_E),
        .PCE        (PCE),
        .PCPlus4E   (PCPlus4E),
        .RS1_E      (RS1_E),
        .RS2_E      (RS2_E),
        .Rs1_D_out  (Rs1_D_out),
        .Rs2_D_out  (Rs2_D_out)
    );

    initial clk = 1'b0;
    always  #5 clk = ~clk;


    integer pass_cnt;
    integer fail_cnt;

   
    task chk1;
        input [79:0] sig;
        input        got;
        input        exp;
        begin
            if (got !== exp) begin
                $display("  FAIL %0s : nhan=%b  mong=%b", sig, got, exp);
                fail_cnt = fail_cnt + 1;
            end else
                pass_cnt = pass_cnt + 1;
        end
    endtask

    task chk2;
        input [79:0] sig;
        input [1:0]  got;
        input [1:0]  exp;
        begin
            if (got !== exp) begin
                $display("  FAIL %0s : nhan=%02b  mong=%02b", sig, got, exp);
                fail_cnt = fail_cnt + 1;
            end else
                pass_cnt = pass_cnt + 1;
        end
    endtask

    task chk4;
        input [79:0] sig;
        input [3:0]  got;
        input [3:0]  exp;
        begin
            if (got !== exp) begin
                $display("  FAIL %0s : nhan=%04b  mong=%04b", sig, got, exp);
                fail_cnt = fail_cnt + 1;
            end else
                pass_cnt = pass_cnt + 1;
        end
    endtask

    task chk32;
        input [79:0]  sig;
        input [31:0]  got;
        input [31:0]  exp;
        begin
            if (got !== exp) begin
                $display("  FAIL %0s : nhan=%h  mong=%h", sig, got, exp);
                fail_cnt = fail_cnt + 1;
            end else
                pass_cnt = pass_cnt + 1;
        end
    endtask


    initial begin
        $dumpfile("tb_decode_cycle.vcd");
        $dumpvars(0, tb_decode_cycle);

        pass_cnt  = 0;
        fail_cnt  = 0;

    
        // RESET
    
        reset     = 1'b1;
        InstrD    = 32'h0000_0013;   
        PCD       = 32'h0;
        PCPlus4D  = 32'h4;
        RegWriteW = 1'b0;
        RDW       = 5'h0;
        ResultW   = 32'h0;

        repeat(3) @(posedge clk); #1;
        reset = 1'b0;

     
        // Nan truoc Register File:  x1=0xABCD_1234  x2=0x0000_0010
      
        @(negedge clk);
        RegWriteW = 1'b1; RDW = 5'd1; ResultW = 32'hABCD_1234;
        InstrD = 32'h0000_0013;
        @(posedge clk); #1;

        @(negedge clk);
        RDW = 5'd2; ResultW = 32'h0000_0010;
        @(posedge clk); #1;

        @(negedge clk);
        RegWriteW = 1'b0; RDW = 5'h0; ResultW = 32'h0;

        
        // TC1 : R-type ADD - add x3, x1, x2
     
        $display("\n TC1: ADD (add x3, x1, x2)");
        @(negedge clk);
        InstrD   = 32'b0000000_00010_00001_000_00011_0110011;
        PCD      = 32'h0000_0004;
        PCPlus4D = 32'h0000_0008;
        
        #1;
        chk32("Rs1_D_out", {27'b0, Rs1_D_out}, 32'h0000_0001);
        chk32("Rs2_D_out", {27'b0, Rs2_D_out}, 32'h0000_0002);
        
        
        // chot qua pipeline
        @(posedge clk); #1;
        chk1 ("RegWriteE",  RegWriteE,  1'b1);
        chk1 ("ALUSrcE",    ALUSrcE,    1'b0);
        chk1 ("MemWriteE",  MemWriteE,  1'b0);
        chk1 ("BranchE",    BranchE,    1'b0);
        chk1 ("JumpE",      JumpE,      1'b0);
        chk2 ("ResultSrcE", ResultSrcE, 2'b00);
        chk4 ("ALUCtrlE",   ALUControlE,4'b0000);
        chk32("Imm_Ext_E",  Imm_Ext_E,  32'h0000_0002);
        chk32("PCE",        PCE,         32'h0000_0004);
        chk32("PCPlus4E",   PCPlus4E,    32'h0000_0008);
        chk32("RS1_E",      {27'b0,RS1_E}, 32'h0000_0001);
        chk32("RS2_E",      {27'b0,RS2_E}, 32'h0000_0002);
        chk32("RD_E",       {27'b0,RD_E},  32'h0000_0003);

      
        // TC2 : R-type SUB - sub x5, x1, x2
      
        $display("\n TC2: SUB (sub x5, x1, x2) ");
        @(negedge clk);
        InstrD   = 32'b0100000_00010_00001_000_00101_0110011;
        PCD      = 32'h0000_0008;
        PCPlus4D = 32'h0000_000C;
        @(posedge clk); #1;
        chk1 ("RegWriteE",  RegWriteE,  1'b1);
        chk1 ("ALUSrcE",    ALUSrcE,    1'b0);
        chk1 ("MemWriteE",  MemWriteE,  1'b0);
        chk1 ("BranchE",    BranchE,    1'b0);
        chk1 ("JumpE",      JumpE,      1'b0);
        chk2 ("ResultSrcE", ResultSrcE, 2'b00);
        chk4 ("ALUCtrlE",   ALUControlE,4'b0001);
        chk32("Imm_Ext_E",  Imm_Ext_E,  32'h0000_0402);
        chk32("PCE",        PCE,         32'h0000_0008);
        chk32("PCPlus4E",   PCPlus4E,    32'h0000_000C);

       
        // TC3 : R-type AND - and x6, x1, x2
       
      
        $display("\n TC3: AND (and x6, x1, x2) ");
        @(negedge clk);
        InstrD   = 32'b0000000_00010_00001_111_00110_0110011;
        PCD      = 32'h0000_000C;
        PCPlus4D = 32'h0000_0010;
        @(posedge clk); #1;
        chk1 ("RegWriteE",  RegWriteE,  1'b1);
        chk1 ("ALUSrcE",    ALUSrcE,    1'b0);
        chk4 ("ALUCtrlE",   ALUControlE,4'b0010);

       
        // TC4 : R-type OR - or x7, x1, x2
     
        $display("\n TC4: OR (or x7, x1, x2) ");
        @(negedge clk);
        InstrD   = 32'b0000000_00010_00001_110_00111_0110011;
        PCD      = 32'h0000_0010;
        PCPlus4D = 32'h0000_0014;
        @(posedge clk); #1;
        chk1 ("RegWriteE",  RegWriteE,  1'b1);
        chk1 ("ALUSrcE",    ALUSrcE,    1'b0);
        chk4 ("ALUCtrlE",   ALUControlE,4'b0011);

  
        // TC5 : R-type XOR - xor x8, x1, x2
      
        $display("\n TC5: XOR (xor x8, x1, x2) ");
        @(negedge clk);
        InstrD   = 32'b0000000_00010_00001_100_01000_0110011;
        PCD      = 32'h0000_0014;
        PCPlus4D = 32'h0000_0018;
        @(posedge clk); #1;
        chk1 ("RegWriteE",  RegWriteE,  1'b1);
        chk1 ("ALUSrcE",    ALUSrcE,    1'b0);
        chk4 ("ALUCtrlE",   ALUControlE,4'b0100);

      
        // TC6 : I-type ADDI - addi x9, x1, 12
       
        $display("\n TC6: ADDI (addi x9, x1, 12) ");
        @(negedge clk);
        InstrD   = 32'b000000001100_00001_000_01001_0010011;
        PCD      = 32'h0000_0018;
        PCPlus4D = 32'h0000_001C;
        @(posedge clk); #1;
        chk1 ("RegWriteE",  RegWriteE,  1'b1);
        chk1 ("ALUSrcE",    ALUSrcE,    1'b1);
        chk1 ("MemWriteE",  MemWriteE,  1'b0);
        chk1 ("BranchE",    BranchE,    1'b0);
        chk1 ("JumpE",      JumpE,      1'b0);
        chk2 ("ResultSrcE", ResultSrcE, 2'b00);
        chk4 ("ALUCtrlE",   ALUControlE,4'b0000);
        chk32("Imm_Ext_E",  Imm_Ext_E,  32'h0000_000C);
        chk32("PCE",        PCE,         32'h0000_0018);
        chk32("PCPlus4E",   PCPlus4E,    32'h0000_001C);

       
        // TC7 : I-type XORI - xori x10, x1, -1
       
        $display("\nTC7: XORI (xori x10, x1, -1) ");
        @(negedge clk);
        InstrD   = 32'b111111111111_00001_100_01010_0010011;
        PCD      = 32'h0000_001C;
        PCPlus4D = 32'h0000_0020;
        @(posedge clk); #1;
        chk1 ("RegWriteE",  RegWriteE,  1'b1);
        chk1 ("ALUSrcE",    ALUSrcE,    1'b1);
        chk4 ("ALUCtrlE",   ALUControlE,4'b0100);
        chk32("Imm_Ext_E",  Imm_Ext_E,  32'hFFFF_FFFF);

     
        // TC8 : I-type ORI - ori x11, x1, 255
   
        $display("\n TC8: ORI (ori x11, x1, 255) ");
        @(negedge clk);
        InstrD   = 32'b000011111111_00001_110_01011_0010011;
        PCD      = 32'h0000_0020;
        PCPlus4D = 32'h0000_0024;
        @(posedge clk); #1;
        chk1 ("RegWriteE",  RegWriteE,  1'b1);
        chk1 ("ALUSrcE",    ALUSrcE,    1'b1);
        chk4 ("ALUCtrlE",   ALUControlE,4'b0011);
        chk32("Imm_Ext_E",  Imm_Ext_E,  32'h0000_00FF);


        // TC9 : Load Word - lw x12, 16(x1)
      
        $display("\n TC9: LW (lw x12, 16(x1)) ");
        @(negedge clk);
        InstrD   = 32'b000000010000_00001_010_01100_0000011;
        PCD      = 32'h0000_0024;
        PCPlus4D = 32'h0000_0028;
        @(posedge clk); #1;
        chk1 ("RegWriteE",  RegWriteE,  1'b1);
        chk1 ("ALUSrcE",    ALUSrcE,    1'b1);
        chk1 ("MemWriteE",  MemWriteE,  1'b0);
        chk1 ("BranchE",    BranchE,    1'b0);
        chk1 ("JumpE",      JumpE,      1'b0);
        chk2 ("ResultSrcE", ResultSrcE, 2'b01);
        chk4 ("ALUCtrlE",   ALUControlE,4'b0000);
        chk32("Imm_Ext_E",  Imm_Ext_E,  32'h0000_0010);

 
        // TC10 : LW voi immediate am - lw x13, -4(x1)
      
        $display("\n TC10: LW immediate am (lw x13, -4(x1)) ");
        @(negedge clk);
        InstrD   = 32'b111111111100_00001_010_01101_0000011;
        PCD      = 32'h0000_0028;
        PCPlus4D = 32'h0000_002C;
        @(posedge clk); #1;
        chk1 ("RegWriteE",  RegWriteE,  1'b1);
        chk1 ("ALUSrcE",    ALUSrcE,    1'b1);
        chk2 ("ResultSrcE", ResultSrcE, 2'b01);
        chk32("Imm_Ext_E",  Imm_Ext_E,  32'hFFFF_FFFC);

        
        // TC11 : Store Word - sw x2, 20(x1)
    
        $display("\n TC11: SW (sw x2, 20(x1)) ");
        @(negedge clk);
        InstrD   = 32'b0000000_00010_00001_010_10100_0100011;
        PCD      = 32'h0000_002C;
        PCPlus4D = 32'h0000_0030;
        @(posedge clk); #1;
        chk1 ("RegWriteE",  RegWriteE,  1'b0);
        chk1 ("ALUSrcE",    ALUSrcE,    1'b1);
        chk1 ("MemWriteE",  MemWriteE,  1'b1);
        chk1 ("BranchE",    BranchE,    1'b0);
        chk1 ("JumpE",      JumpE,      1'b0);
        chk4 ("ALUCtrlE",   ALUControlE,4'b0000);
        chk32("Imm_Ext_E",  Imm_Ext_E,  32'h0000_0014);
        chk32("PCE",        PCE,         32'h0000_002C);
        chk32("PCPlus4E",   PCPlus4E,    32'h0000_0030);

        
        // TC12 : SW immediate am - sw x2, -8(x1)
       
        $display("\n TC12: SW immediate am (sw x2, -8(x1)) ");
        @(negedge clk);
        InstrD   = 32'b1111111_00010_00001_010_11000_0100011;
        PCD      = 32'h0000_0030;
        PCPlus4D = 32'h0000_0034;
        @(posedge clk); #1;
        chk1 ("RegWriteE",  RegWriteE,  1'b0);
        chk1 ("MemWriteE",  MemWriteE,  1'b1);
        chk1 ("ALUSrcE",    ALUSrcE,    1'b1);
        chk32("Imm_Ext_E",  Imm_Ext_E,  32'hFFFF_FFF8);

  
        // TC13 : B-type BEQ - beq x1, x2, +8
      
        $display("\n TC13: BEQ (beq x1, x2, +8) ");
        @(negedge clk);
        InstrD   = 32'b0_000000_00010_00001_000_0100_0_1100011;
        PCD      = 32'h0000_0034;
        PCPlus4D = 32'h0000_0038;
        @(posedge clk); #1;
        chk1 ("RegWriteE",  RegWriteE,  1'b0);
        chk1 ("ALUSrcE",    ALUSrcE,    1'b0);
        chk1 ("MemWriteE",  MemWriteE,  1'b0);
        chk1 ("BranchE",    BranchE,    1'b1);
        chk1 ("JumpE",      JumpE,      1'b0);
        chk2 ("ResultSrcE", ResultSrcE, 2'b00);
        chk4 ("ALUCtrlE",   ALUControlE,4'b0001);
        chk32("Imm_Ext_E",  Imm_Ext_E,  32'h0000_0008);
        chk32("PCE",        PCE,         32'h0000_0034);
        chk32("PCPlus4E",   PCPlus4E,    32'h0000_0038);

        // TC14 : BEQ offset am - beq x1, x2, -12
     
        $display("\n TC14: BEQ offset am (beq x1, x2, -12) ");
        @(negedge clk);
        InstrD   = 32'b1_111111_00010_00001_000_1010_1_1100011;
        PCD      = 32'h0000_0038;
        PCPlus4D = 32'h0000_003C;
        @(posedge clk); #1;
        chk1 ("BranchE",    BranchE,    1'b1);
        chk4 ("ALUCtrlE",   ALUControlE,4'b0001);
        chk32("Imm_Ext_E",  Imm_Ext_E,  32'hFFFF_FFF4);

     
        // TC15 : J-type JAL - jal x1, +16
  
        $display("\n TC15: JAL (jal x1, +16) ");
        @(negedge clk);
        InstrD   = 32'b0_0000001000_0_00000000_00001_1101111;
        PCD      = 32'h0000_003C;
        PCPlus4D = 32'h0000_0040;
        @(posedge clk); #1;
        chk1 ("RegWriteE",  RegWriteE,  1'b1);
        chk1 ("ALUSrcE",    ALUSrcE,    1'b0);
        chk1 ("MemWriteE",  MemWriteE,  1'b0);
        chk1 ("BranchE",    BranchE,    1'b0);
        chk1 ("JumpE",      JumpE,      1'b1);
        chk2 ("ResultSrcE", ResultSrcE, 2'b10);
        chk4 ("ALUCtrlE",   ALUControlE,4'b0000);
        chk32("Imm_Ext_E",  Imm_Ext_E,  32'h0000_0010);
        chk32("PCE",        PCE,         32'h0000_003C);
        chk32("PCPlus4E",   PCPlus4E,    32'h0000_0040);

        // TC16 : Reset bat dong bo - dat lenh ADD, bat reset,
      
        $display("\n TC16: Async Reset ");
        @(negedge clk);
        InstrD   = 32'b0000000_00010_00001_000_00011_0110011;
        PCD      = 32'hDEAD_BEEF;
        PCPlus4D = 32'hCAFE_BABE;
        reset    = 1'b1;
        @(posedge clk); #1;

        if (RegWriteE   !== 1'b0    || ALUSrcE    !== 1'b0   ||
            MemWriteE   !== 1'b0    || BranchE    !== 1'b0   ||
            JumpE       !== 1'b0    || ResultSrcE !== 2'b00  ||
            ALUControlE !== 4'b0000 ||
            RD1_E       !== 32'h0   || RD2_E      !== 32'h0  ||
            Imm_Ext_E   !== 32'h0   || PCE        !== 32'h0  ||
            PCPlus4E    !== 32'h0) begin
            $display("  FAIL TC16 : Pipeline reg CHUA ve 0 sau reset!");
            fail_cnt = fail_cnt + 1;
        end else begin
            $display("  PASS TC16 : Tat ca pipeline reg = 0 sau reset");
            pass_cnt = pass_cnt + 1;
        end
        reset = 1'b0;

       
        // TC17 : Ghi vao x0 phai bi bo qua (Register[0] luon = 0)
  
        $display("\n TC17: Ghi x0 bi bo qua ");
        @(negedge clk);
        RegWriteW = 1'b1; RDW = 5'd0; ResultW = 32'hFFFF_FFFF;
        InstrD    = 32'h0000_0013;
        @(posedge clk); #1;

        @(negedge clk);
        RegWriteW = 1'b0;

        InstrD    = 32'b000000000000_00000_000_00101_0010011;
        PCD       = 32'h0000_0040;
        PCPlus4D  = 32'h0000_0044;
        @(posedge clk); #1;
        chk32("RD1_E(x0=0)", RD1_E, 32'h0000_0000);


        // TC18 : Ghi roi doc thanh ghi x3

        $display("\n TC18: Ghi roi doc x3 ");
        @(negedge clk);
        RegWriteW = 1'b1; RDW = 5'd3; ResultW = 32'h1234_5678;
        InstrD    = 32'h0000_0013;
        @(posedge clk); #1;

        @(negedge clk);
        RegWriteW = 1'b0;
        // add x5, x3, x0  : 0000000_00000_00011_000_00101_0110011
        InstrD    = 32'b0000000_00000_00011_000_00101_0110011;
        PCD       = 32'h0000_0044;
        PCPlus4D  = 32'h0000_0048;
        @(posedge clk); #1;
        chk32("RD1_E(x3)", RD1_E, 32'h1234_5678);



        $display(" KET QUA : PASS = %0d   FAIL = %0d", pass_cnt, fail_cnt);
        if (fail_cnt == 0)
            $display(" >> TAT CA TEST CASE DIEU PASS! <<");
        else
            $display(" >> CO %0d TEST CASE THAT BAI <<", fail_cnt);


        #20; $finish;
    end

endmodule