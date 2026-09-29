`timescale 1ns/1ps

module tb_riscv_uart_soc;

    localparam DVSR        = 27;
    localparam DVSR_BIT    = 5;
    localparam FIFO_W      = 4;

    localparam CLK_PERIOD  = 20;
    localparam BAUD_CYCLES = 16 * DVSR;   // 432 cycles/bit
    localparam BYTE_CYCLES = 10 * BAUD_CYCLES; // 4320 cycles/byte

    reg clk   = 0;
    reg reset = 1;

    wire uart_tx;
    reg  uart_rx = 1;

    wire [31:0] dbg_ALU_ResultM;
    wire [31:0] dbg_WriteDataM;
    wire        dbg_MemWriteM;

    integer current_tc;

    reg tc1_pass;
    reg tc_xor_pass;
    reg tc4_apb_pass;
    reg tc4_uart_pass;
    reg tc5_doan1_pass;

    reg [7:0]  tx_byte;
    integer    tx_bit;
    reg [47:0] uart_shift_6byte;

   
    reg [2:0] tc1_byte_count;
    reg [23:0] tc1_expected [0:2];
    initial begin
        tc1_expected[0] = 8'h48; // H
        tc1_expected[1] = 8'h69; // i
        tc1_expected[2] = 8'h0A; // \n
    end

    // DUT
    riscv_uart_soc #(
        .DVSR     (DVSR),
        .DVSR_BIT (DVSR_BIT),
        .FIFO_W   (FIFO_W)
    ) dut (
        .clk             (clk),
        .reset           (reset),
        .uart_tx         (uart_tx),
        .uart_rx         (uart_rx),
        .dbg_ALU_ResultM (dbg_ALU_ResultM),
        .dbg_WriteDataM  (dbg_WriteDataM),
        .dbg_MemWriteM   (dbg_MemWriteM)
    );

    always #(CLK_PERIOD/2) clk = ~clk;

    initial begin
        reset = 1'b1;
        repeat(10) @(posedge clk);
        @(negedge clk);
        reset = 1'b0;
        $display("\n[RESET DONE] t=%0t\n", $time);
    end

    initial begin
        $dumpfile("tb_riscv_uart_soc.vcd");
        $dumpvars(0, tb_riscv_uart_soc);
    end

    initial begin
        current_tc      = 0;
        tc1_pass        = 1'b0;
        tc_xor_pass     = 1'b0;
        tc4_apb_pass    = 1'b0;
        tc4_uart_pass   = 1'b0;
        tc5_doan1_pass  = 1'b0;
        tx_byte         = 8'h00;
        uart_shift_6byte = 48'h0;
        tc1_byte_count  = 0;
    end

    
    always @(posedge clk) begin
        if (!reset && dbg_MemWriteM && current_tc != 0) begin
            if (dbg_ALU_ResultM[31:16] == 16'h4000) begin
                $display("[TC%0d SW->UART] t=%0t addr=0x%08X data=0x%08X",
                         current_tc, $time, dbg_ALU_ResultM, dbg_WriteDataM);
            end
        end
    end

    // Monitor APB
    always @(posedge clk) begin
        if (!reset && dut.cpu.PSEL && dut.cpu.PENABLE && dut.cpu.PREADY) begin
            if (dut.cpu.PWRITE) begin
                if (current_tc == 4) begin
                    $display("[TC4 APB] t=%0t WRITE PADDR=0x%08X PWDATA=0x%08X",
                             $time, dut.cpu.PADDR, dut.cpu.PWDATA);
                end
                // TC4: check 0x4B
                if (dut.cpu.PADDR  == 32'h40000000 &&
                    dut.cpu.PWDATA == 32'h0000004B) begin
                    tc4_apb_pass <= 1'b1;
                    $display("[TC4 APB PASS] PWDATA=0x4B");
                end
                // XOR check
                if (dut.cpu.PADDR  == 32'h40000000 &&
                    dut.cpu.PWDATA == 32'h00000009) begin
                    tc_xor_pass <= 1'b1;
                    $display("[XOR PASS] XOR result 0x09");
                end
            end else begin
                if (current_tc == 4) begin
                    $display("[TC4 APB] t=%0t READ PADDR=0x%08X PRDATA=0x%08X",
                             $time, dut.cpu.PADDR, dut.cpu.PRDATA);
                end
            end
        end
    end

    // UART TX monitor
    initial begin
        wait(uart_tx === 1'b1);
        forever begin
            @(negedge uart_tx);
            #(CLK_PERIOD * BAUD_CYCLES + CLK_PERIOD * BAUD_CYCLES / 2);
            for (tx_bit = 0; tx_bit < 8; tx_bit = tx_bit + 1) begin
                tx_byte[tx_bit] = uart_tx;
                #(CLK_PERIOD * BAUD_CYCLES);
            end

            $display("[TC%0d UART_TX] t=%0t byte=0x%02X ('%c')",
                     current_tc, $time, tx_byte,
                     (tx_byte >= 8'h20 && tx_byte <= 8'h7E) ? tx_byte : 8'h2E);

            // TC1: check H i \n theo th? t?
            if (current_tc == 1) begin
                if (tc1_byte_count == 0 && tx_byte == 8'h48)
                    tc1_byte_count <= 1;
                else if (tc1_byte_count == 1 && tx_byte == 8'h69)
                    tc1_byte_count <= 2;
                else if (tc1_byte_count == 2 && tx_byte == 8'h0A) begin
                    tc1_byte_count <= 3;
                    tc1_pass <= 1'b1;
                    $display("[TC1 UART PASS] TX = H i LF dung thu tu");
                end
            end

            // TC4: check 0x4B
            if (!tc4_uart_pass && tx_byte == 8'h4B) begin
                tc4_uart_pass = 1'b1;
                $display("[TC4 UART PASS] UART TX = 'K' (0x4B)");
            end

            // TC5: shift 6 byte
            uart_shift_6byte = {uart_shift_6byte[39:0], tx_byte};
            if (!tc5_doan1_pass &&
                uart_shift_6byte == {8'h64,8'h6F,8'h61,8'h6E,8'h31,8'h0A}) begin
                tc5_doan1_pass = 1'b1;
                $display("[TC5 PASS] UART TX = \"doan1\\n\" (64 6F 61 6E 31 0A)");
            end

            wait(uart_tx === 1'b1);
        end
    end

    // UART RX task
    task send_uart_byte;
        input [7:0] data;
        integer i;
        begin
            $display("[TC%0d UART_RX] Inject 0x%02X @ t=%0t",
                     current_tc, data, $time);
            uart_rx = 1'b0;
            repeat(BAUD_CYCLES) @(posedge clk);
            for (i = 0; i < 8; i = i + 1) begin
                uart_rx = data[i];
                repeat(BAUD_CYCLES) @(posedge clk);
            end
            uart_rx = 1'b1;
            repeat(BAUD_CYCLES) @(posedge clk);
        end
    endtask

    // Check x5
    initial begin
        wait(reset == 0);
        repeat(25) @(posedge clk);
        $display("[REG] x5 = 0x%08X expect 0x40000000",
                 dut.cpu.Decode.rf.Register[5]);
    end

    
    initial begin
        wait(reset == 0);

        // -- TC1: test gui  3 byte TX (H i \n) 
        current_tc = 1;
        $display("\n================ TC1: TX \"Hi\\n\" ================\n");
        $display("Expect UART TX: H(0x48) i(0x69) LF(0x0A)");

        // 3 byte × 4320 cycle + overhead poll + pipeline ˜ 20000 cycle
        repeat(20000) @(posedge clk);

        if (tc1_pass)
            $display("[TEST PASS] TC1 thanh cong");
        else begin
            $display("[TEST FAIL] TC1 chua dat");
            $display("tc1_byte_count = %0d/3", tc1_byte_count);
        end

        // -- TC2: UART RX gui 2 ky tu X va Y vao uart fifo 
        current_tc = 2;
        $display("\n================ TC2: UART RX ================\n");
        send_uart_byte(8'h58); // X
        repeat(500) @(posedge clk);
        send_uart_byte(8'h59); // Y
        repeat(500) @(posedge clk);

        // -- TC3: ALU cho 
        current_tc = 3;
        $display("\n================ TC3: ALU TEST ================\n");
        repeat(500) @(posedge clk);

        // -- TC4: 0x32+0x19=0x4B TX 'K' thuc hien phep toan XOR
        current_tc = 4;
        $display("\n================ TC4: 0x32+0x19=0x4B TX 'K' ================\n");
        $display("Expect APB WRITE: PADDR=0x40000000, PWDATA=0x0000004B");
        $display("Expect UART TX  : byte=0x4B ('K')");

        // 1 byte × 4320 
        repeat(6000) @(posedge clk);

        if (tc4_apb_pass && tc4_uart_pass)
            $display("[TEST PASS] TC4 thanh cong");
        else begin
            $display("[TEST FAIL] TC4 chua dat");
            $display("tc4_apb_pass  = %0d", tc4_apb_pass);
            $display("tc4_uart_pass = %0d", tc4_uart_pass);
        end

        // -- TC5: TX "doan1\n" 
        current_tc = 5;
        $display("\n================ TC5: TX \"doan1\\n\" ================\n");
        $display("Expect HEX: 64 6F 61 6E 31 0A");

        // 6 byte × 4320 + overhead ˜ 30000 cycle
        repeat(30000) @(posedge clk);

        if (tc5_doan1_pass)
            $display("[TEST PASS] TC5 thanh cong");
        else
            $display("[TEST FAIL] TC5 chua dat");

        current_tc = 0;
        $display("\n================ SIMULATION FINISHED ================\n");
        $finish;
    end

    initial begin
        repeat (5) begin
            #1_000_000_000; 
        end
        $display("\n[TIMEOUT]\n");
        $finish;
    end
endmodule