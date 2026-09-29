`timescale 1ns/1ps


module tb_writeback_cycle;

    reg         clk, reset;
    reg  [1:0]  ResultSrcW;
    reg  [31:0] PCPlus4W, ALU_ResultW, ReadDataW;
    wire [31:0] ResultW;

    writeback_cycle dut (
        .clk        (clk),
        .reset      (reset),
        .ResultSrcW (ResultSrcW),
        .PCPlus4W   (PCPlus4W),
        .ALU_ResultW(ALU_ResultW),
        .ReadDataW  (ReadDataW),
        .ResultW    (ResultW)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    integer pass_count, fail_count;

    task check;
        input [200:0] name;
        input [31:0]  got;
        input [31:0]  expected;
        begin
            if (got === expected) begin
                $display("  [PASS] %-30s | got=0x%08h", name, got);
                pass_count = pass_count + 1;
            end else begin
                $display("  [FAIL] %-30s | expected=0x%08h | got=0x%08h",
                         name, expected, got);
                fail_count = fail_count + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("tb_writeback_cycle.vcd");
        $dumpvars(0, tb_writeback_cycle);
        pass_count = 0; fail_count = 0;

        reset = 1; ResultSrcW = 0;
        ALU_ResultW = 0; ReadDataW = 0; PCPlus4W = 0;
        #10; reset = 0;

      
        // TC1: select=00 ? ResultW = ALU_ResultW  (R-type / I-type)
        
        $display("\n TC1: ResultSrc=00 (ALU Result) ");

        ALU_ResultW = 32'h1111_2222;
        ReadDataW   = 32'hAAAA_BBBB;
        PCPlus4W    = 32'h0000_3008;
        ResultSrcW  = 2'b00;
        #1;
        check("ResultW == ALU_ResultW", ResultW, 32'h1111_2222);
        
        ALU_ResultW = 32'h2222_3333;
        ResultSrcW  = 2'b00;
        #1;
        check("ALU = 0x22223333", ResultW, 32'h2222_3333);
        
        ALU_ResultW = 32'h0000_0000;
        ResultSrcW  = 2'b00;
        #1;
        check("ALU = 0x00000000 zero", ResultW, 32'h0000_0000);
        
        ALU_ResultW = 32'h8000_0000;
        ResultSrcW  = 2'b00;
        #1;
        check("ALU = 0x80000000 MSB", ResultW, 32'h8000_0000);

        
       // TC2: select=01 -> ResultW = ReadDataW  (LW)

        $display("\nTC2: ResultSrc=01 (Read Data / LW) ");
        
        ALU_ResultW = 32'hAAAA_1111;
        ReadDataW   = 32'h1111_2222;
        PCPlus4W    = 32'h0000_3008;
        ResultSrcW  = 2'b01;
        #1;
        check("ResultW == ReadDataW", ResultW, 32'h1111_2222);
        
        ReadDataW  = 32'h2222_3333;
        ResultSrcW = 2'b01;
        #1;
        check("ReadData = 0x22223333", ResultW, 32'h2222_3333);
        
        ReadDataW  = 32'hABCD_1234;
        ResultSrcW = 2'b01;
        #1;
        check("ReadData = 0xABCD1234", ResultW, 32'hABCD_1234);
        
        ReadDataW  = 32'h0000_00FF;
        ResultSrcW = 2'b01;
        #1;
        check("ReadData = 0x000000FF", ResultW, 32'h0000_00FF);

        
        // TC3: select=10  ResultW = PCPlus4W  (JAL/JALR)
        
        $display("\n TC3: ResultSrc=10 (PCPlus4 / JAL) ");
        ALU_ResultW = 32'hCAFE_BABE; ReadDataW = 32'hDEAD_BEEF; PCPlus4W = 32'h0000_3008;
        ResultSrcW = 2'b10; #1;
        check("ResultW == PCPlus4W",      ResultW, 32'h0000_3008);

        PCPlus4W = 32'h0000_0004; ResultSrcW = 2'b10; #1;
        check("PC+4 = 0x00000004",        ResultW, 32'h0000_0004);

        PCPlus4W = 32'hFFFF_FFFC; ResultSrcW = 2'b10; #1;
        check("PC+4 = 0xFFFFFFFC",        ResultW, 32'hFFFF_FFFC);

        
        // TC4: select=11 ? ResultW = 0x00000000 
        
        $display("\n TC4: ResultSrc=11 (undefined ? 0x00000000) ");
        ALU_ResultW = 32'hAAAA_AAAA; ReadDataW = 32'h5555_5555; PCPlus4W = 32'h1234_5678;
        ResultSrcW = 2'b11; #1;
        check("ResultSrc=11 ? 0x0",       ResultW, 32'h0000_0000);

        
        // TC5: C
      
        $display("\n TC5:  ");
        ALU_ResultW = 32'hAAAA_AAAA;
        ReadDataW   = 32'h5555_5555;
        PCPlus4W    = 32'h1234_5678;

        ResultSrcW = 2'b00; #1; check("Switch ? 00 (ALU)",  ResultW, 32'hAAAA_AAAA);
        ResultSrcW = 2'b01; #1; check("Switch ? 01 (RD)",   ResultW, 32'h5555_5555);
        ResultSrcW = 2'b10; #1; check("Switch ? 10 (PC+4)", ResultW, 32'h1234_5678);
        ResultSrcW = 2'b11; #1; check("Switch ? 11 (zero)", ResultW, 32'h0000_0000);
        ResultSrcW = 2'b00; #1; check("Switch back ? 00",   ResultW, 32'hAAAA_AAAA);

        
        // TC6: 
        
        $display("\n--- TC6: All inputs same value ---");
        ALU_ResultW = 32'hBEEF_CAFE;
        ReadDataW   = 32'hBEEF_CAFE;
        PCPlus4W    = 32'hBEEF_CAFE;

        ResultSrcW = 2'b00; #1; check("Same val select=00", ResultW, 32'hBEEF_CAFE);
        ResultSrcW = 2'b01; #1; check("Same val select=01", ResultW, 32'hBEEF_CAFE);
        ResultSrcW = 2'b10; #1; check("Same val select=10", ResultW, 32'hBEEF_CAFE);

       
        // TC7: 
        
        $display("\n TC7: Mux 2-to-1 ");
        // Dùng writeback ?? gián ti?p verify Mux (select gi?a 2 nhánh)
        ALU_ResultW = 32'h1111_1111; ReadDataW = 32'h2222_2222; PCPlus4W = 32'h0;
        ResultSrcW = 2'b00; #1; check("Mux2: select=0 ? a", ResultW, 32'h1111_1111);
        ResultSrcW = 2'b01; #1; check("Mux2: select=1 ? b", ResultW, 32'h2222_2222);

       
      
        $display("  K?T QU?: %0d PASS | %0d FAIL", pass_count, fail_count);
        
        if (fail_count == 0) $display("  TEST CASE  PASSED ?\n");
        else                  $display(" CÓ %0d TEST CASE  FAILED ?\n", fail_count);
        $finish;
    end

    initial begin #5000; $display("[TIMEOUT]"); $finish; end

endmodule