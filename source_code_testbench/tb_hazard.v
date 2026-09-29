`timescale 1ns/1ps

module tb_hazard;

    reg        reset;
    reg        RegWriteM, RegWriteW;
    reg  [4:0] RD_M, RD_W;
    reg  [4:0] Rs1_E, Rs2_E;
    reg        ResultSrcE_0;
    reg  [4:0] RD_E;
    reg  [4:0] Rs1_D, Rs2_D;

    wire [1:0] ForwardAE, ForwardBE;
    wire       StallF, StallD, FlushE, FlushD;

    hazard_unit uut (
        .reset        (reset),
        .RegWriteM    (RegWriteM),
        .RegWriteW    (RegWriteW),
        .RD_M         (RD_M),
        .RD_W         (RD_W),
        .Rs1_E        (Rs1_E),
        .Rs2_E        (Rs2_E),
        .ForwardAE    (ForwardAE),
        .ForwardBE    (ForwardBE),
        .ResultSrcE_0 (ResultSrcE_0),
        .RD_E         (RD_E),
        .Rs1_D        (Rs1_D),
        .Rs2_D        (Rs2_D),
        .StallF       (StallF),
        .StallD       (StallD),
        .FlushE       (FlushE),
        .FlushD       (FlushD)
    );

    integer pass_cnt, fail_cnt;

    task chk1;
        input [200:0] name;
        input         got;
        input         exp;
        begin
            if (got === exp) begin
                $display("  [PASS] %0s  got=%0b", name, got);
                pass_cnt = pass_cnt + 1;
            end else begin
                $display("  [FAIL] %0s  got=%0b  exp=%0b", name, got, exp);
                fail_cnt = fail_cnt + 1;
            end
        end
    endtask

    task chk2;
        input [200:0] name;
        input  [1:0]  got;
        input  [1:0]  exp;
        begin
            if (got === exp) begin
                $display("  [PASS] %0s  got=%02b", name, got);
                pass_cnt = pass_cnt + 1;
            end else begin
                $display("  [FAIL] %0s  got=%02b  exp=%02b", name, got, exp);
                fail_cnt = fail_cnt + 1;
            end
        end
    endtask

    task init;
        begin
            reset        = 0;
            RegWriteM    = 0;
            RegWriteW    = 0;
            RD_M         = 0;
            RD_W         = 0;
            Rs1_E        = 0;
            Rs2_E        = 0;
            ResultSrcE_0 = 0;
            RD_E         = 0;
            Rs1_D        = 0;
            Rs2_D        = 0;
        end
    endtask

    initial begin
        $dumpfile("tb_hazard.vcd");
        $dumpvars(0, tb_hazard);

        pass_cnt = 0;
        fail_cnt = 0;

        $display("\n[TC1] Reset active");
        init;
        RegWriteM = 1;
        RD_M = 5'd3;
        Rs1_E = 5'd3;
        RegWriteW = 1;
        RD_W = 5'd4;
        Rs2_E = 5'd4;
        ResultSrcE_0 = 1;
        RD_E = 5'd5;
        Rs1_D = 5'd5;
        reset = 1;
        #1;
        chk2("TC1 ForwardAE=00 khi reset", ForwardAE, 2'b00);
        chk2("TC1 ForwardBE=00 khi reset", ForwardBE, 2'b00);
        chk1("TC1 FlushD=0 hardwired", FlushD, 1'b0);
        reset = 0;
        #1;

        $display("\n[TC2] ForwardA: EX/MEM -> EX  ForwardAE=10");
        init;
        RegWriteM = 1;
        RD_M = 5'd5;
        Rs1_E = 5'd5;
        Rs2_E = 5'd9;
        #1;
        chk2("TC2 ForwardAE=10", ForwardAE, 2'b10);
        chk2("TC2 ForwardBE=00", ForwardBE, 2'b00);

        $display("\n[TC3] ForwardA: MEM/WB -> EX  ForwardAE=01");
        init;
        RegWriteW = 1;
        RD_W = 5'd7;
        Rs1_E = 5'd7;
        Rs2_E = 5'd9;
        #1;
        chk2("TC3 ForwardAE=01", ForwardAE, 2'b01);
        chk2("TC3 ForwardBE=00", ForwardBE, 2'b00);

        $display("\n[TC4] ForwardB: EX/MEM -> EX  ForwardBE=10");
        init;
        RegWriteM = 1;
        RD_M = 5'd6;
        Rs2_E = 5'd6;
        Rs1_E = 5'd9;
        #1;
        chk2("TC4 ForwardAE=00", ForwardAE, 2'b00);
        chk2("TC4 ForwardBE=10", ForwardBE, 2'b10);

        $display("\n[TC5] ForwardB: MEM/WB -> EX  ForwardBE=01");
        init;
        RegWriteW = 1;
        RD_W = 5'd8;
        Rs2_E = 5'd8;
        Rs1_E = 5'd9;
        #1;
        chk2("TC5 ForwardAE=00", ForwardAE, 2'b00);
        chk2("TC5 ForwardBE=01", ForwardBE, 2'b01);

        $display("\n[TC6] ForwardA=10 & ForwardB=10");
        init;
        RegWriteM = 1;
        RD_M = 5'd3;
        Rs1_E = 5'd3;
        Rs2_E = 5'd3;
        #1;
        chk2("TC6 ForwardAE=10", ForwardAE, 2'b10);
        chk2("TC6 ForwardBE=10", ForwardBE, 2'b10);

        $display("\n[TC7] ForwardA=10 MEM & ForwardB=01 WB");
        init;
        RegWriteM = 1;
        RD_M = 5'd2;
        Rs1_E = 5'd2;
        RegWriteW = 1;
        RD_W = 5'd4;
        Rs2_E = 5'd4;
        #1;
        chk2("TC7 ForwardAE=10", ForwardAE, 2'b10);
        chk2("TC7 ForwardBE=01", ForwardBE, 2'b01);

        $display("\n[TC8] MEM vs WB priority");
        init;
        RegWriteM = 1;
        RD_M = 5'd5;
        RegWriteW = 1;
        RD_W = 5'd5;
        Rs1_E = 5'd5;
        #1;
        chk2("TC8 ForwardAE=10 MEM wins", ForwardAE, 2'b10);

        $display("\n[TC9] Khong forward khi RD=x0");
        init;
        RegWriteM = 1;
        RD_M = 5'd0;
        Rs1_E = 5'd0;
        RegWriteW = 1;
        RD_W = 5'd0;
        Rs2_E = 5'd0;
        #1;
        chk2("TC9 ForwardAE=00 RD_M=x0", ForwardAE, 2'b00);
        chk2("TC9 ForwardBE=00 RD_W=x0", ForwardBE, 2'b00);

        $display("\n[TC10] Khong forward khi RegWriteM=0");
        init;
        RegWriteM = 0;
        RD_M = 5'd3;
        Rs1_E = 5'd3;
        #1;
        chk2("TC10 ForwardAE=00 RegWriteM=0", ForwardAE, 2'b00);

        $display("\n[TC11] Load-use hazard: RD_E==Rs1_D");
        init;
        ResultSrcE_0 = 1;
        RD_E  = 5'd3;
        Rs1_D = 5'd3;
        Rs2_D = 5'd9;
        #1;
        chk1("TC11 StallF=1", StallF, 1'b1);
        chk1("TC11 StallD=1", StallD, 1'b1);
        chk1("TC11 FlushE=1", FlushE, 1'b1);
        chk1("TC11 FlushD=0", FlushD, 1'b0);

        $display("\n[TC12] Load-use hazard: RD_E==Rs2_D");
        init;
        ResultSrcE_0 = 1;
        RD_E  = 5'd5;
        Rs1_D = 5'd9;
        Rs2_D = 5'd5;
        #1;
        chk1("TC12 StallF=1", StallF, 1'b1);
        chk1("TC12 StallD=1", StallD, 1'b1);
        chk1("TC12 FlushE=1", FlushE, 1'b1);

        $display("\n[TC13] Load EX nhung ID dung register khac");
        init;
        ResultSrcE_0 = 1;
        RD_E  = 5'd3;
        Rs1_D = 5'd7;
        Rs2_D = 5'd8;
        #1;
        chk1("TC13 StallF=0", StallF, 1'b0);
        chk1("TC13 StallD=0", StallD, 1'b0);
        chk1("TC13 FlushE=0", FlushE, 1'b0);

        $display("\n[TC14] ResultSrcE_0=0 R-type");
        init;
        ResultSrcE_0 = 0;
        RD_E  = 5'd3;
        Rs1_D = 5'd3;
        #1;
        chk1("TC14 StallF=0", StallF, 1'b0);
        chk1("TC14 StallD=0", StallD, 1'b0);
        chk1("TC14 FlushE=0", FlushE, 1'b0);

        $display("\n[TC15] Load-use RD_E=x0");
        init;
        ResultSrcE_0 = 1;
        RD_E  = 5'd0;
        Rs1_D = 5'd0;
        Rs2_D = 5'd0;
        #1;
        $display("         StallF=%0b StallD=%0b FlushE=%0b", StallF, StallD, FlushE);

        $display("\n[TC16] FlushD hardwired = 0");
        init;
        RegWriteM = 1;
        RD_M = 5'd1;
        Rs1_E = 5'd1;
        ResultSrcE_0 = 1;
        RD_E = 5'd2;
        Rs1_D = 5'd2;
        #1;
        chk1("TC16 FlushD=0 luon", FlushD, 1'b0);

        
        $display("  KET QUA: %0d PASS  |  %0d FAIL", pass_cnt, fail_cnt);
        
        if (fail_cnt == 0)
            $display("  >>> TAT CA TEST CASE DA PASSED <<<\n");
        else
            $display("  >>> CO %0d TEST CASE BI FAILED <<<\n", fail_cnt);

        $finish;
    end

    initial begin
        #5000;
        $display("[TIMEOUT]");
        $finish;
    end

endmodule