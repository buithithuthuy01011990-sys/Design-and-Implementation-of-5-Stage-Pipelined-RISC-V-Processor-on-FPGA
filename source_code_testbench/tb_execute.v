`timescale 1ns/1ps

module tb_execute_cycle;

    reg clk, reset;

    reg        RegWriteE, ALUSrcE, MemWriteE, BranchE, JumpE;
    reg  [1:0] ResultSrcE;
    reg  [3:0] ALUControlE;
    reg  [31:0] RD1_E, RD2_E, Imm_Ext_E;
    reg  [4:0]  RD_E, RS1_E, RS2_E;
    reg  [31:0] PCE, PCPlus4E;
    reg  [31:0] ResultW;
    reg  [1:0]  ForwardA_E, ForwardB_E;

    wire        PCSrcE;
    wire        RegWriteM, MemWriteM;
    wire [1:0]  ResultSrcM;
    wire [4:0]  RD_M;
    wire [31:0] PCPlus4M, WriteDataM, ALU_ResultM;
    wire [31:0] PCTargetE;

    execute_cycle dut (
        .clk(clk), .reset(reset),
        .RegWriteE(RegWriteE), .ALUSrcE(ALUSrcE),
        .MemWriteE(MemWriteE), .ResultSrcE(ResultSrcE),
        .JumpE(JumpE), .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .RD1_E(RD1_E), .RD2_E(RD2_E), .Imm_Ext_E(Imm_Ext_E),
        .RD_E(RD_E), .PCE(PCE), .PCPlus4E(PCPlus4E),
        .PCSrcE(PCSrcE), .PCTargetE(PCTargetE),
        .RegWriteM(RegWriteM), .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM), .RD_M(RD_M),
        .PCPlus4M(PCPlus4M), .WriteDataM(WriteDataM),
        .ALU_ResultM(ALU_ResultM),
        .ResultW(ResultW),
        .ForwardA_E(ForwardA_E), .ForwardB_E(ForwardB_E),
        .RS1_E(RS1_E), .RS2_E(RS2_E)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    integer pass_cnt, fail_cnt;

    task check32;
        input [8*32-1:0] name;
        input [31:0] got, exp;
        begin
            if (got === exp) begin
                $display("  PASS [%0s]  got=0x%08h", name, got);
                pass_cnt = pass_cnt + 1;
            end else begin
                $display("  FAIL [%0s]  got=0x%08h  exp=0x%08h", name, got, exp);
                fail_cnt = fail_cnt + 1;
            end
        end
    endtask

    task check1;
        input [8*32-1:0] name;
        input got, exp;
        begin
            if (got === exp) begin
                $display("  PASS [%0s]  got=%0b", name, got);
                pass_cnt = pass_cnt + 1;
            end else begin
                $display("  FAIL [%0s]  got=%0b  exp=%0b", name, got, exp);
                fail_cnt = fail_cnt + 1;
            end
        end
    endtask

    task init;
        begin
            RegWriteE  = 0; ALUSrcE    = 0;
            MemWriteE  = 0; BranchE    = 0; JumpE = 0;
            ResultSrcE = 0; ALUControlE = 0;
            RD1_E = 0; RD2_E = 0; Imm_Ext_E = 0;
            RD_E  = 0; RS1_E = 0; RS2_E     = 0;
            PCE   = 32'h0000_1000;
            PCPlus4E = 32'h0000_1004;
            ResultW    = 0;
            ForwardA_E = 0; ForwardB_E = 0;
        end
    endtask

    task latch_and_read;
        begin
            @(posedge clk);
            @(posedge clk);
            #1;
        end
    endtask

    initial begin
        pass_cnt = 0; fail_cnt = 0;
        init;

        reset = 1;
        @(posedge clk); @(posedge clk);
        reset = 0;
        
        $display("  execute_cycle Testbench");
        

       
        // NHÓM 1: ALU RV32I
        
        $display("\n--- Nhom 1: ALU RV32I ---");

        // TC1.1  ADD: 10 + 5 = 15
        init;
        RD1_E = 32'd10; RD2_E = 32'd5;
        ALUControlE = 4'b0000;
        latch_and_read;
        check32("ADD 10+5", ALU_ResultM, 32'd15);

        // TC1.2  SUB: 20 - 7 = 13
        init;
        RD1_E = 32'd20; RD2_E = 32'd7;
        ALUControlE = 4'b0001;
        latch_and_read;
        check32("SUB 20-7", ALU_ResultM, 32'd13);

        // TC1.3  AND: 0xFF & 0x0F = 0x0F
        init;
        RD1_E = 32'h0000_00FF; RD2_E = 32'h0000_000F;
        ALUControlE = 4'b0010;
        latch_and_read;
        check32("AND FF&0F", ALU_ResultM, 32'h0000_000F);

        // TC1.4  OR: 0xF0 | 0x0F = 0xFF
        init;
        RD1_E = 32'h0000_00F0; RD2_E = 32'h0000_000F;
        ALUControlE = 4'b0011;
        latch_and_read;
        check32("OR F0|0F", ALU_ResultM, 32'h0000_00FF);

        // TC1.5  XOR: 0xFF ^ 0x0F = 0xF0
        init;
        RD1_E = 32'h0000_00FF; RD2_E = 32'h0000_000F;
        ALUControlE = 4'b0100;
        latch_and_read;
        check32("XOR FF^0F", ALU_ResultM, 32'h0000_00F0);

        // TC1.6  SLT: 3 < 5 => 1
        init;
        RD1_E = 32'd3; RD2_E = 32'd5;
        ALUControlE = 4'b0101;
        latch_and_read;
        check32("SLT 3<5", ALU_ResultM, 32'd1);

        // TC1.7  SLT: 5 < 3 => 0
        init;
        RD1_E = 32'd5; RD2_E = 32'd3;
        ALUControlE = 4'b0101;
        latch_and_read;
        check32("SLT 5<3", ALU_ResultM, 32'd0);

        // TC1.8  SLT signed: -1 < 1 => 1
        init;
        RD1_E = 32'hFFFF_FFFF; RD2_E = 32'd1;
        ALUControlE = 4'b0101;
        latch_and_read;
        check32("SLT -1<1", ALU_ResultM, 32'd1);

        
        // NHÓM 2: ALUSrc = 1
       
        $display("\n Nhom 2: ALUSrc=1 (Immediate) ");

        // TC2.1  ADDI: 100 + 55 = 155
        init;
        RD1_E = 32'd100; Imm_Ext_E = 32'd55;
        ALUSrcE = 1; ALUControlE = 4'b0000;
        latch_and_read;
        check32("ADDI 100+55", ALU_ResultM, 32'd155);

        // TC2.2  WriteDataM ph?i là RD2, không ph?i Imm
        init;
        RD1_E = 32'd1; RD2_E = 32'hDEAD_BEEF;
        Imm_Ext_E = 32'hFFFF_0000;
        ALUSrcE = 1; ALUControlE = 4'b0000;
        latch_and_read;
        check32("WriteDataM=RD2 not Imm", WriteDataM, 32'hDEAD_BEEF);

     
        // NHÓM 3: Forwarding
       
        $display("\n Nhom 3: Forwarding ");

        // TC3.1  ForwardA=01 (ResultW -> SrcA)
        init;
        ResultW = 32'd50; RD2_E = 32'd0;
        ForwardA_E = 2'b01; ALUControlE = 4'b0000;
        latch_and_read;
        check32("FwdA=01 ADD", ALU_ResultM, 32'd50);

        // TC3.2  ForwardB=01 (ResultW -> SrcB)
        init;
        RD1_E = 32'd10; ResultW = 32'd40;
        ForwardB_E = 2'b01; ALUControlE = 4'b0000;
        latch_and_read;
        check32("FwdB=01 ADD", ALU_ResultM, 32'd50);

        // TC3.3  ForwardB=01: WriteDataM = ResultW
        init;
        RD2_E = 32'hAAAA_AAAA; ResultW = 32'hBBBB_BBBB;
        ForwardB_E = 2'b01; ALUControlE = 4'b0000;
        latch_and_read;
        check32("FwdB=01 WriteDataM", WriteDataM, 32'hBBBB_BBBB);

        // TC3.4  Không forward: RD1=7, RD2=3, SUB=4
        init;
        RD1_E = 32'd7; RD2_E = 32'd3;
        ForwardA_E = 2'b00; ForwardB_E = 2'b00;
        ALUControlE = 4'b0001;
        latch_and_read;
        check32("NoFwd SUB", ALU_ResultM, 32'd4);

       
        // NHÓM 4: Combinatorial - PCSrcE, PCTargetE
     
        $display("\nNhom 4: Combinatorial - PCSrcE, PCTargetE ");

        // TC4.1  BEQ taken
        init;
        RD1_E = 32'd42; RD2_E = 32'd42;
        ALUControlE = 4'b0001; BranchE = 1;
        #1;
        check1("BEQ taken", PCSrcE, 1'b1);

        // TC4.2  BEQ not taken
        init;
        RD1_E = 32'd10; RD2_E = 32'd20;
        ALUControlE = 4'b0001; BranchE = 1;
        #1;
        check1("BEQ not taken", PCSrcE, 1'b0);

        // TC4.3  Jump
        init;
        RD1_E = 0; RD2_E = 0; BranchE = 0; JumpE = 1;
        #1;
        check1("JumpE=1", PCSrcE, 1'b1);

        // TC4.4  Không branch, không jump
        init;
        BranchE = 0; JumpE = 0;
        RD1_E = 32'd5; RD2_E = 32'd5;
        ALUControlE = 4'b0001;
        #1;
        check1("No branch/jump", PCSrcE, 1'b0);

        // TC4.5  PCTargetE = PCE + Imm_Ext_E
        init;
        PCE = 32'h0000_1000; Imm_Ext_E = 32'h0000_0020;
        #1;
        check32("PCTargetE", PCTargetE, 32'h0000_1020);

        // TC4.6  PCTargetE âm offset
        init;
        PCE = 32'h0000_1000; Imm_Ext_E = 32'hFFFF_FFFC;
        #1;
        check32("PCTargetE neg", PCTargetE, 32'h0000_0FFC);

      
        // NHÓM 5: Pipeline registers
        
        $display("\n Nhom 5: Pipeline registers");

        init;
        RegWriteE = 1; MemWriteE = 0;
        ResultSrcE = 2'b10; RD_E = 5'd15;
        PCPlus4E = 32'hAAAA_0004;
        @(posedge clk); #1;
        check1("RegWriteM", RegWriteM, 1'b1);
        check1("MemWriteM", MemWriteM, 1'b0);
        check32("RD_M", {27'b0, RD_M}, {27'b0, 5'd15});
        check32("PCPlus4M", PCPlus4M, 32'hAAAA_0004);
        check32("ResultSrcM", {30'b0, ResultSrcM}, {30'b0, 2'b10});

        init;
        RegWriteE = 0; MemWriteE = 1;
        @(posedge clk); #1;
        check1("MemWriteM=1", MemWriteM, 1'b1);
        check1("RegWriteM=0", RegWriteM, 1'b0);

      
        // NHÓM 6: Reset
       
        $display("\n Nhom 6: Reset" );

        init;
        RegWriteE = 1; MemWriteE = 1;
        RD1_E = 32'hDEAD; RD2_E = 32'hBEEF;
        ALUControlE = 4'b0000; RD_E = 5'd31;
        PCPlus4E = 32'hFFFF_FFFC;
        @(posedge clk); #1;

        reset = 1;
        @(posedge clk); #1;
        reset = 0;

        check1("Reset RegWriteM", RegWriteM, 1'b0);
        check1("Reset MemWriteM", MemWriteM, 1'b0);
        check32("Reset ALU_ResultM", ALU_ResultM, 32'h0);
        check32("Reset WriteDataM",  WriteDataM,  32'h0);
        check32("Reset PCPlus4M",    PCPlus4M,    32'h0);
        check32("Reset RD_M", {27'b0, RD_M}, 32'h0);
        check32("Reset ResultSrcM", {30'b0, ResultSrcM}, 32'h0);

        
        // NHÓM 7: RV32M  -- encoding kh?p ALU g?c
     
        //   ALU case:
        //     4'b1001 = MUL     (mul_ss[31:0])
        //     4'b1010 = MULH    (mul_ss[63:32])
        //     4'b1011 = MULHSU  (mul_su[63:32])
        //     4'b1100 = MULHU   (mul_uu[63:32])
        //     4'b1101 = DIVS    (div_s)
        //     4'b1110 = DIVU    (div_u)
        //     4'b1111 = REMS    (rem_s)
        //     default = REMU không có case riêng trong ALU
       
        $display("\n Nhom 7: RV32M");

        // TC7.1  MUL lower 32-bit: 100 * 200 = 20000 = 0x00004E20
        // ALU: 4'b1001 = MUL
        init;
        RD1_E = 32'd100; RD2_E = 32'd200;
        ALUControlE = 4'b1001;                         
        latch_and_read;
        check32("MUL 100*200", ALU_ResultM, 32'h0000_4E20);

        // TC7.2  DIVS chia cho 0 ? 0xFFFFFFFF
        // ALU: 4'b1101 = DIVS
        init;
        RD1_E = 32'd7; RD2_E = 32'd0;
        ALUControlE = 4'b1101;                          
        latch_and_read;
        check32("DIVS /0", ALU_ResultM, 32'hFFFF_FFFF);

        // TC7.3  REMS signed: 10 % 3 = 1
        // ALU: 4'b1111 = REMS
        init;
        RD1_E = 32'd10; RD2_E = 32'd3;
        ALUControlE = 4'b1111;                         
        latch_and_read;
        check32("REMS 10%3", ALU_ResultM, 32'd1);

        // TC7.4  DIVS overflow: INT_MIN / -1 = INT_MIN (0x80000000)
        // ALU: 4'b1101 = DIVS
        init;
        RD1_E = 32'h8000_0000; RD2_E = 32'hFFFF_FFFF;
        ALUControlE = 4'b1101;                          
        latch_and_read;
        check32("DIVS overflow", ALU_ResultM, 32'h8000_0000);

        // TC7.5  REMS overflow: INT_MIN % -1 = 0
        // ALU: 4'b1111 = REMS
        init;
        RD1_E = 32'h8000_0000; RD2_E = 32'hFFFF_FFFF;
        ALUControlE = 4'b1111;                         
        latch_and_read;
        check32("REMS overflow", ALU_ResultM, 32'd0);

        // TC7.6  DIVU unsigned: 10 / 3 = 3
        // ALU: 4'b1110 = DIVU
        init;
        RD1_E = 32'd10; RD2_E = 32'd3;
        ALUControlE = 4'b1110;                          
        latch_and_read;
        check32("DIVU 10/3", ALU_ResultM, 32'd3);

       
        init;
        RD1_E = 32'd10; RD2_E = 32'd3;
        ALUControlE = 4'b1111;  
       
        latch_and_read;
        check32("REMU 10%3", ALU_ResultM, 32'd1);

      
        #10;
       
        $display("  TONG KET: %0d PASS  |  %0d FAIL", pass_cnt, fail_cnt);
       
        $finish;
    end

    initial begin
        #10000;
        $display("TIMEOUT");
        $finish;
    end

endmodule