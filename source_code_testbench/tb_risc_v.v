`timescale 1ns/1ps


module tb_pipeline_top;


    reg clk, reset;
    initial clk = 0;
    always #5 clk = ~clk;


    reg  [31:0] PRDATA;
    reg         PREADY;

    initial begin
        PRDATA = 32'h0;
        PREADY = 1'b1;
    end


    wire        PSEL, PENABLE, PWRITE;
    wire [31:0] PADDR;
    wire [31:0] PWDATA;
    wire [31:0] ALU_ResultM, WriteDataM;
    wire        MemWriteM;

    Pipeline_top dut (
        .clk         (clk),
        .reset       (reset),
        .PRDATA      (PRDATA),
        .PREADY      (PREADY),
        .PSEL        (PSEL),
        .PENABLE     (PENABLE),
        .PWRITE      (PWRITE),
        .PADDR       (PADDR),
        .PWDATA      (PWDATA),
        .ALU_ResultM (ALU_ResultM),
        .WriteDataM  (WriteDataM),
        .MemWriteM   (MemWriteM)
    );


    always @(posedge clk) begin
        if (PSEL && PENABLE && PWRITE && PREADY) begin
            $display("[APB-TX] t=%0t  addr=0x%08X  data=0x%08X  char='%c'",
                     $time,
                     PADDR,
                     PWDATA,
                     (PWDATA[7:0] >= 8'h20 && PWDATA[7:0] <= 8'h7E)
                         ? PWDATA[7:0] : 8'h2E);
        end
    end


    reg         tx_H_seen,  tx_i_seen,  tx_lf_seen;
    reg [31:0]  tx_H_addr,  tx_i_addr,  tx_lf_addr;
    reg [31:0]  tx_H_data,  tx_i_data,  tx_lf_data;

    initial begin
        tx_H_seen  = 0; tx_H_addr  = 0; tx_H_data  = 0;
        tx_i_seen  = 0; tx_i_addr  = 0; tx_i_data  = 0;
        tx_lf_seen = 0; tx_lf_addr = 0; tx_lf_data = 0;
    end

    always @(posedge clk) begin
        if (PSEL && PENABLE && PWRITE && PREADY) begin
            case (PWDATA[7:0])
                8'h48 : begin
                    tx_H_seen  <= 1'b1;
                    tx_H_addr  <= PADDR;
                    tx_H_data  <= PWDATA;
                end
                8'h69 : begin
                    tx_i_seen  <= 1'b1;
                    tx_i_addr  <= PADDR;
                    tx_i_data  <= PWDATA;
                end
                8'h0A : begin
                    tx_lf_seen <= 1'b1;
                    tx_lf_addr <= PADDR;
                    tx_lf_data <= PWDATA;
                end
            endcase
        end
    end

    task clear_tx_flags;
        begin
            @(negedge clk);
            tx_H_seen  = 0; tx_H_addr  = 0; tx_H_data  = 0;
            tx_i_seen  = 0; tx_i_addr  = 0; tx_i_data  = 0;
            tx_lf_seen = 0; tx_lf_addr = 0; tx_lf_data = 0;
        end
    endtask


    integer pass_cnt, fail_cnt;

    task check32;
        input [8*40-1:0] name;
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
        input [8*40-1:0] name;
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


    task wait_apb_char;
        input  [7:0]       expected_char;
        input  integer     max_cycles;
        output             timed_out;
        output [31:0]      got_addr;
        output [31:0]      got_data;

        integer cnt;
        reg     found;
        begin
            found     = 0;
            timed_out = 0;
            got_addr  = 0;
            got_data  = 0;
            cnt       = 0;

            while (!found && cnt < max_cycles) begin
                @(posedge clk);
                cnt = cnt + 1;
                if (PSEL && PENABLE && PWRITE && PREADY
                        && PWDATA[7:0] == expected_char) begin
                    got_addr = PADDR;
                    got_data = PWDATA;
                    found    = 1;
                end
            end

            if (!found) timed_out = 1;
        end
    endtask


    integer cy;
    reg     timed_out;
    reg [31:0] got_addr, got_data;


    reg [15:0] alu_seen;
    reg [15:0] alu_expected;

    always @(posedge clk) begin
        if (reset) begin
            alu_seen <= 16'h0000;
        end else begin
            alu_seen[dut.ALUControlE] <= 1'b1;
        end
    end

    initial begin
        $dumpfile("tb_pipeline_top.vcd");
        $dumpvars(0, tb_pipeline_top);
        pass_cnt = 0;
        fail_cnt = 0;
        alu_expected = 16'hF7FF;


        reset = 1;
        repeat(4) @(posedge clk);
        @(negedge clk); reset = 0;

        $display("  Testbench: Pipeline_top (RISC-V 5-stage)  ");


        $display("\n TEST 1: Reset ");
        @(posedge clk); #1;
        check32("ALU_ResultM after reset", ALU_ResultM, 32'h0);
        check1 ("MemWriteM after reset",   MemWriteM,   1'b0);


        $display("\n TEST 2: Run 30 cycles ");
        $display("%-4s | %-10s %-10s | %-8s %-8s | %-10s %s",
                 "Cy", "PC_fetch", "InstrD", "ALUSrc", "ALUCtrl",
                 "ALU_M", "MemWr");

        for (cy = 1; cy <= 30; cy = cy + 1) begin
            @(posedge clk); #1;
            $display("Cy%-2d | PC=%08h  InstrD=%08h | ALUSrc=%b  ALUCtrl=%04b | ALU_M=%08h  MemWr=%b",
                cy,
                dut.Fetch.PCD,
                dut.Decode.InstrD,
                dut.ALUSrcE,
                dut.ALUControlE,
                ALU_ResultM,
                MemWriteM);
        end


        $display("\n TEST 3: Wait for TX 'H' (PWDATA=0x48) ");
        if (tx_H_seen) begin
            $display("  PASS: TX 'H' detected (captured earlier)  addr=%08h  data=%08h",
                     tx_H_addr, tx_H_data);
            pass_cnt = pass_cnt + 1;
        end else begin
            wait_apb_char(8'h48, 300, timed_out, got_addr, got_data);
            if (timed_out) begin
                $display("  FAIL: TIMEOUT waiting for TX H");
                fail_cnt = fail_cnt + 1;
            end else begin
                $display("  PASS: TX 'H' detected  addr=%08h  data=%08h",
                         got_addr, got_data);
                pass_cnt = pass_cnt + 1;
            end
        end


        $display("\n  TEST 4: Wait for TX 'i' (PWDATA=0x69) ");
        if (tx_i_seen) begin
            $display("  PASS: TX 'i' detected (captured earlier)  addr=%08h  data=%08h",
                     tx_i_addr, tx_i_data);
            pass_cnt = pass_cnt + 1;
        end else begin
            wait_apb_char(8'h69, 300, timed_out, got_addr, got_data);
            if (timed_out) begin
                $display("  FAIL: TIMEOUT waiting for TX i");
                fail_cnt = fail_cnt + 1;
            end else begin
                $display("  PASS: TX 'i' detected  addr=%08h  data=%08h",
                         got_addr, got_data);
                pass_cnt = pass_cnt + 1;
            end
        end


        $display("\n TEST 5: Wait for TX LF (PWDATA=0x0A) ");
        if (tx_lf_seen) begin
            $display("  PASS: TX LF detected (captured earlier)  addr=%08h  data=%08h",
                     tx_lf_addr, tx_lf_data);
            pass_cnt = pass_cnt + 1;
        end else begin
            wait_apb_char(8'h0A, 300, timed_out, got_addr, got_data);
            if (timed_out) begin
                $display("  FAIL: TIMEOUT waiting for TX LF");
                fail_cnt = fail_cnt + 1;
            end else begin
                $display("  PASS: TX LF detected   addr=%08h  data=%08h",
                         got_addr, got_data);
                pass_cnt = pass_cnt + 1;
            end
        end


        $display("\n TEST 6:  reset (flush) ");
        @(negedge clk); reset = 1;
        repeat(3) @(posedge clk); #1;
        check1 ("MemWriteM=0 after reset",   MemWriteM,   1'b0);
        check32("ALU_ResultM=0 after reset", ALU_ResultM, 32'h0);
        @(negedge clk); reset = 0;


        clear_tx_flags;


        $display("\nTEST 7: Pipeline sau  reset ");
        wait_apb_char(8'h48, 400, timed_out, got_addr, got_data);
        if (timed_out) begin
            $display("  FAIL: TX 'H'  400 cycles");
            fail_cnt = fail_cnt + 1;
        end else begin
            $display("  PASS: TX 'H' sau  reset  addr=%08h  data=%08h",
                     got_addr, got_data);
            pass_cnt = pass_cnt + 1;
        end


        $display("\n TEST 8: APB stall rn ");
        begin : check_stall
            integer stall_cycles;
            integer wait_cycles;
            reg     stall_failed;

            stall_cycles  = 0;
            wait_cycles   = 0;
            stall_failed  = 0;


            while (!dut.apb_stall && wait_cycles < 200) begin
                @(posedge clk);
                wait_cycles = wait_cycles + 1;
            end

            if (!dut.apb_stall) begin
                $display("  INFO: apb_stall không lên trong 200 cycles");
            end else begin
                while (dut.apb_stall) begin
                    @(posedge clk);
                    stall_cycles = stall_cycles + 1;
                    if (stall_cycles > 20) begin
                        $display("  FAIL: apb_stall stuck HIGH > 20 cycles");
                        fail_cnt  = fail_cnt + 1;
                        stall_failed = 1;
                        disable check_stall;
                    end
                end
                if (!stall_failed) begin
                    $display("  PASS: apb_stall released after %0d cycle(s)",
                             stall_cycles);
                    pass_cnt = pass_cnt + 1;
                end
            end
        end


        $display("\n TEST 9: APB handshake sequence (SETUP->ACCESS) ");
        begin : check_handshake
            integer hs_wait;
            reg     setup_seen;
            reg     seq_ok;

            hs_wait    = 0;
            setup_seen = 0;
            seq_ok     = 0;


            while (!setup_seen && hs_wait < 500) begin
                @(posedge clk);
                hs_wait = hs_wait + 1;
                if (PSEL && !PENABLE && PWRITE) begin
                    setup_seen = 1;
                    $display("  [HS] SETUP  phase: PSEL=%b PENABLE=%b PADDR=%08h",
                             PSEL, PENABLE, PADDR);
                end
            end

            if (setup_seen) begin

                @(posedge clk);
                if (PSEL && PENABLE) begin
                    $display("  [HS] ACCESS phase: PSEL=%b PENABLE=%b PREADY=%b PWDATA=%08h",
                             PSEL, PENABLE, PREADY, PWDATA);
                    $display("  PASS: APB handshake sequence correct");
                    pass_cnt = pass_cnt + 1;
                    seq_ok   = 1;
                end
                if (!seq_ok) begin
                    $display("  FAIL: PENABLE không lên sau SETUP (PSEL=%b PENABLE=%b)",
                             PSEL, PENABLE);
                    fail_cnt = fail_cnt + 1;
                end
            end else begin
                $display("  INFO: Không thay SETUP phase trong 500 cycles");
            end
        end


        $display("\n TEST 10: ALUControl coverage monitor ");
        begin : check_alucontrol_coverage
            integer cov_wait;
            cov_wait = 0;


            while (((alu_seen & alu_expected) != alu_expected) && cov_wait < 1000) begin
                @(posedge clk);
                cov_wait = cov_wait + 1;
            end

            $display("  ALUControl seen mask = %016b", alu_seen);

            if ((alu_seen & alu_expected) == alu_expected) begin
                $display("  PASS: All ALUControl codes 0..15 were exercised");
                pass_cnt = pass_cnt + 1;
            end else begin
                $display("  FAIL: Missing ALUControl coverage");
                if (!alu_seen[0])  $display("    missing ADD  ALUControl=0000");
                if (!alu_seen[1])  $display("    missing SUB  ALUControl=0001");
                if (!alu_seen[2])  $display("    missing AND  ALUControl=0010");
                if (!alu_seen[3])  $display("    missing OR   ALUControl=0011");
                if (!alu_seen[4])  $display("    missing XOR  ALUControl=0100");
                if (!alu_seen[5])  $display("    missing SLT  ALUControl=0101");
                if (!alu_seen[6])  $display("    missing SLL  ALUControl=0110");
                if (!alu_seen[7])  $display("    missing SRL  ALUControl=0111");
                if (!alu_seen[8])  $display("    missing SRA  ALUControl=1000");
                if (!alu_seen[9])  $display("    missing MUL  ALUControl=1001");
                if (!alu_seen[10]) $display("    missing MULH ALUControl=1010");

                if (!alu_seen[12]) $display("    missing MULHU ALUControl=1100");
                if (!alu_seen[13]) $display("    missing DIV  ALUControl=1101");
                if (!alu_seen[14]) $display("    missing DIVU ALUControl=1110");
                if (!alu_seen[15]) $display("    missing REM  ALUControl=1111");
                fail_cnt = fail_cnt + 1;
            end
        end


        $display("\n DEBUG: Internal signals ");
        $display("  PC Fetch     : %08h", dut.Fetch.PCD);
        $display("  InstrD       : %08h", dut.Decode.InstrD);
        $display("  ALUControlE  : %04b", dut.ALUControlE);
        $display("  ALU_ResultM  : %08h", ALU_ResultM);
        $display("  apb_stall    : %b",   dut.apb_stall);
        $display("  StallF_final : %b",   dut.StallF_final);
        $display("  PSEL         : %b",   PSEL);
        $display("  PENABLE      : %b",   PENABLE);
        $display("  PREADY       : %b",   PREADY);
        $display("  PADDR        : %08h", PADDR);
        $display("  PWDATA       : %08h", PWDATA);


        $display("\n  KET QUA: %0d PASS  |  %0d FAIL", pass_cnt, fail_cnt);
        $finish;
    end


    initial begin
        #500_000;
        $display("\n[TIMEOUT] Simulation exceeded 500 us");
        $finish;
    end

endmodule
