`timescale 1ns/1ps

module tb_memory_stage;

    reg  clk, reset;
    reg  RegWriteM, MemWriteM;
    reg  [1:0]  ResultSrcM;
    reg  [4:0]  RdM;
    reg  [31:0] ALUResultM, WriteDataM, PCPlus4M;

   
    reg  [31:0] ReadDataAPB;   
    reg  IsAPBAddr;     

    wire RegWriteW;
    wire [1:0]  ResultSrcW;
    wire [4:0]  RdW;
    wire [31:0] PCPlus4W, ALUResultW, ReadDataW, ResultW;

    memory_stage dut (
        .clk         (clk),
        .reset       (reset),
        .RegWriteM   (RegWriteM),
        .MemWriteM   (MemWriteM),
        .ResultSrcM  (ResultSrcM),
        .RdM         (RdM),
        .ALUResultM  (ALUResultM),
        .WriteDataM  (WriteDataM),
        .PCPlus4M    (PCPlus4M),
       
        .ReadDataAPB (ReadDataAPB),
        .IsAPBAddr   (IsAPBAddr),
       
        .RegWriteW   (RegWriteW),
        .ResultSrcW  (ResultSrcW),
        .RdW         (RdW),
        .PCPlus4W    (PCPlus4W),
        .ALUResultW  (ALUResultW),
        .ReadDataW   (ReadDataW),
        .ResultW     (ResultW)
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
                $display("  [PASS] %-24s | got=0x%08h", name, got);
                pass_count = pass_count + 1;
            end else begin
                $display("  [FAIL] %-24s | expected=0x%08h | got=0x%08h",
                         name, expected, got);
                fail_count = fail_count + 1;
            end
        end
    endtask

    task set_inputs;
        input        rw, mw;
        input [1:0]  rsrc;
        input [4:0]  rd;
        input [31:0] alu, wdata, pc4;
        begin
            RegWriteM  = rw;   MemWriteM  = mw;
            ResultSrcM = rsrc; RdM        = rd;
            ALUResultM = alu;  WriteDataM = wdata;
            PCPlus4M   = pc4;
            
            ReadDataAPB = 32'h0;
            IsAPBAddr   = 1'b0;
        end
    endtask

    initial begin
        $dumpfile("tb_memory_stage.vcd");
        $dumpvars(0, tb_memory_stage);
        pass_count = 0; fail_count = 0;

       
        reset = 1;
        ReadDataAPB = 0; IsAPBAddr = 0;
        set_inputs(0,0,0,0,0,0,0);
        @(negedge clk); @(posedge clk); #1;
        @(negedge clk); @(posedge clk); #1;

        // TC1: Reset outputs
        $display("\nTC1: Reset outputs");
        check("RegWriteW",  {31'b0, RegWriteW},  32'h0);
        check("ResultSrcW", {30'b0, ResultSrcW}, 32'h0);
        check("RdW",        {27'b0, RdW},        32'h0);
        check("PCPlus4W",   PCPlus4W,            32'h0);
        check("ALUResultW", ALUResultW,          32'h0);
        check("ReadDataW",  ReadDataW,           32'h0);

        @(negedge clk); reset = 0;

        // TC2: SW then read back
        $display("\n TC2: SW Store Word ");
        // Ghi mem[0x10] = 0xDEAD_BEEF
        @(negedge clk); set_inputs(1,1,2'b00,5'd5, 32'h10, 32'hDEAD_BEEF, 32'h1004);
        @(posedge clk); #1;
       
        @(negedge clk); set_inputs(1,0,2'b01,5'd6, 32'h10, 32'h0, 32'h1008);
        @(posedge clk); #1;
        check("ReadDataW(SW)",   ReadDataW, 32'hDEAD_BEEF);
        check("ResultW(LW mux)", ResultW,   32'hDEAD_BEEF);

        // TC3: LW
        $display("\n TC3: LW Load Word ");
        @(negedge clk); set_inputs(1,0,2'b01,5'd7, 32'h10, 32'h0, 32'h100C);
        @(posedge clk); #1;
        check("ReadDataW(LW)", ReadDataW, 32'hDEAD_BEEF);
        check("ResultW(LW)",   ResultW,   32'hDEAD_BEEF);

        // TC4: R-type ALU (ResultSrc=00)
        $display("\n TC4: R-type ResultSrc=00");
        @(negedge clk); set_inputs(1,0,2'b00,5'd10, 32'hCAFE_BABE, 32'h0, 32'h2000);
        @(posedge clk); #1;
        check("ALUResultW",   ALUResultW, 32'hCAFE_BABE);
        check("ResultW(ALU)", ResultW,    32'hCAFE_BABE);

        // TC5: JAL (ResultSrc=10)
        $display("\nTC5: JAL ResultSrc=10 ");
        @(negedge clk); set_inputs(1,0,2'b10,5'd1, 32'h0, 32'h0, 32'h3008);
        @(posedge clk); #1;
        check("PCPlus4W",     PCPlus4W, 32'h3008);
        check("ResultW(JAL)", ResultW,  32'h3008);

        // TC6: Control signal forwarding
        $display("\n--- TC6: Control signal forwarding ---");
        @(negedge clk); set_inputs(1,0,2'b01,5'd15, 32'h0, 32'h0, 32'h0);
        @(posedge clk); #1;
        check("RegWriteW",  {31'b0, RegWriteW},  32'h1);
        check("ResultSrcW", {30'b0, ResultSrcW}, 32'h1);
        check("RdW",        {27'b0, RdW},        32'd15);

        // TC7: Write blocked during reset
        $display("\n TC7: Write blocked during reset ");
        // Ghi mem[0x20] = 0xABCD_0000
        @(negedge clk); set_inputs(1,1,2'b00,5'd0, 32'h20, 32'hABCD_0000, 32'h0);
        @(posedge clk); #1;
        // Reset 
        @(negedge clk); reset = 1;
        set_inputs(1,1,2'b00,5'd0, 32'h20, 32'h9999_9999, 32'h0);
        @(posedge clk); #1;
        // Reset 
        @(negedge clk); reset = 0;
        set_inputs(1,0,2'b01,5'd3, 32'h20, 32'h0, 32'h0);
        @(posedge clk); #1;
        check("ReadDataW(no_ow)", ReadDataW, 32'hABCD_0000);

        // TC8: Multiple SW then LW
        
        $display("\n TC8: Multiple SW then LW ");
        @(negedge clk); set_inputs(1,1,2'b00,5'd0,32'h100,32'h1111_1111,32'h0); @(posedge clk); #1;
        @(negedge clk); set_inputs(1,1,2'b00,5'd0,32'h104,32'h2222_2222,32'h0); @(posedge clk); #1;
        @(negedge clk); set_inputs(1,1,2'b00,5'd0,32'h108,32'h3333_3333,32'h0); @(posedge clk); #1;

        @(negedge clk); set_inputs(1,0,2'b01,5'd8, 32'h100,32'h0,32'h0); @(posedge clk); #1;
        check("LW mem[0x100]", ReadDataW, 32'h1111_1111);
        @(negedge clk); set_inputs(1,0,2'b01,5'd9, 32'h104,32'h0,32'h0); @(posedge clk); #1;
        check("LW mem[0x104]", ReadDataW, 32'h2222_2222);
        @(negedge clk); set_inputs(1,0,2'b01,5'd10,32'h108,32'h0,32'h0); @(posedge clk); #1;
        check("LW mem[0x108]", ReadDataW, 32'h3333_3333);

        // TC9: SW overwrite
        $display("\n--- TC9: SW overwrite ---");
        @(negedge clk); set_inputs(1,1,2'b00,5'd0,32'h200,32'hFFFF_FFFF,32'h0); @(posedge clk); #1;
        @(negedge clk); set_inputs(1,1,2'b00,5'd0,32'h200,32'h0000_0001,32'h0); @(posedge clk); #1;
        @(negedge clk); set_inputs(1,0,2'b01,5'd5, 32'h200,32'h0,32'h0);        @(posedge clk); #1;
        check("OW ReadDataW", ReadDataW, 32'h0000_0001);

        // TC10: Byte address alignment
        // Data_Memory dùng word_addr = A[11:2] nên 0x300/0x301/0x302/0x303
        
        $display("\n TC10: Byte address alignment ");
        @(negedge clk); set_inputs(1,1,2'b00,5'd0,32'h300,32'hBEEF_CAFE,32'h0); @(posedge clk); #1;

        @(negedge clk); set_inputs(1,0,2'b01,5'd5,32'h301,32'h0,32'h0); @(posedge clk); #1;
        check("A[1:0]=01", ReadDataW, 32'hBEEF_CAFE);
        @(negedge clk); set_inputs(1,0,2'b01,5'd5,32'h302,32'h0,32'h0); @(posedge clk); #1;
        check("A[1:0]=10", ReadDataW, 32'hBEEF_CAFE);
        @(negedge clk); set_inputs(1,0,2'b01,5'd5,32'h303,32'h0,32'h0); @(posedge clk); #1;
        check("A[1:0]=11", ReadDataW, 32'hBEEF_CAFE);

        
        $display("  KET QUA: %0d PASS | %0d FAIL", pass_count, fail_count);
       
        if (fail_count == 0)
            $display(">>> TAT CA TEST CASE DA PASSED\n");
        else
            $display(">>> CO %0d TEST CASE BI FAILED\n", fail_count);
        $finish;
    end

    initial begin #30000; $display("[TIMEOUT]"); $finish; end

endmodule