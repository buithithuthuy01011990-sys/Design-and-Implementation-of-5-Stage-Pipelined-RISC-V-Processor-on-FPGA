`timescale 1ns/1ps

module tb_uart_top;

    localparam DBIT      = 8;
    localparam SB_TICK   = 16;
    localparam DVSR      = 3;
    localparam FIFO_W    = 4;

    localparam CLK_PERIOD = 10;
    localparam BAUD_CLKS  = SB_TICK * DVSR;  // 16*3 = 48 clk/bit

    reg        CLK    = 0;
    reg        reset  = 1;  // fix: active-high
    reg        RX     = 1;
    wire [7:0] r_data;
    reg        rd_uart = 0;
    wire       rx_empty;
    reg  [7:0] w_data  = 0;
    reg        wr_uart = 0;
    wire       tx_full;
    wire       TX;

    always #(CLK_PERIOD/2) CLK = ~CLK;

    uart_top #(
        .DBIT   (DBIT),
        .SB_TICK(SB_TICK),
        .DVSR   (DVSR),
        .FIFO_W (FIFO_W)
    ) dut (
        .CLK     (CLK),
        .reset   (reset),   // fix: active-high
        .RX      (RX),
        .TX      (TX),
        .r_data  (r_data),
        .rd_uart (rd_uart),
        .rx_empty(rx_empty),
        .w_data  (w_data),
        .wr_uart (wr_uart),
        .tx_full (tx_full)
    );

    integer pass_cnt = 0;
    integer fail_cnt = 0;

    task check8;
        input [8*40-1:0] name;
        input [7:0] got, exp;
        begin
            if (got === exp) begin
                $display("  PASS [%0s]  got=0x%02h", name, got);
                pass_cnt = pass_cnt + 1;
            end else begin
                $display("  FAIL [%0s]  got=0x%02h  exp=0x%02h", name, got, exp);
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

    // -------------------------------------------------------
    // uart_send_byte: drive RX serial LSB-first
    // -------------------------------------------------------
    task uart_send_byte;
        input [7:0] data;
        integer i;
        begin
            $display("  [RX-IN] Inject 0x%02h ('%c')", data,
                     (data >= 8'h20 && data <= 8'h7E) ? data : ".");
            @(negedge CLK); RX = 0;
            repeat(BAUD_CLKS) @(posedge CLK);
            for (i = 0; i < 8; i = i + 1) begin
                @(negedge CLK); RX = data[i];
                repeat(BAUD_CLKS) @(posedge CLK);
            end
            @(negedge CLK); RX = 1;
            repeat(BAUD_CLKS) @(posedge CLK);
        end
    endtask

    // -------------------------------------------------------
    // uart_capture_byte: sample TX serial LSB-first
    // -------------------------------------------------------
    reg [7:0] captured_byte;

    task uart_capture_byte;
        integer i;
        begin
            @(negedge TX);
            repeat(BAUD_CLKS)     @(posedge CLK);
            repeat(BAUD_CLKS / 2) @(posedge CLK);
            for (i = 0; i < 8; i = i + 1) begin
                captured_byte[i] = TX;
                repeat(BAUD_CLKS) @(posedge CLK);
            end
            $display("  [TX-OUT] Captured 0x%02h ('%c')", captured_byte,
                     (captured_byte >= 8'h20 && captured_byte <= 8'h7E)
                     ? captured_byte : ".");
        end
    endtask

    // -------------------------------------------------------
    // fifo_write
    // -------------------------------------------------------
    task fifo_write;
        input [7:0] data;
        begin
            @(negedge CLK);
            w_data  = data;
            wr_uart = 1;
            @(posedge CLK); #1;
            wr_uart = 0;
        end
    endtask

    // -------------------------------------------------------
    // fifo_read
    // -------------------------------------------------------
    reg [7:0] captured_rx;

    task fifo_read;
        begin
            @(negedge CLK);
            rd_uart = 1;
            #1;
            captured_rx = r_data;
            @(posedge CLK); #1;
            rd_uart = 0;
        end
    endtask

    // ================================================================
    // MAIN TEST
    // ================================================================
    initial begin
        $dumpfile("tb_uart_top.vcd");
        $dumpvars(0, tb_uart_top);

        // fix: active-high reset
        reset = 1;
        repeat(5) @(posedge CLK);
        @(negedge CLK); reset = 0;  // fix: tha reset
        repeat(2) @(posedge CLK);

        $display("\n================================================");
        $display("  Testbench: uart_top");
        $display("  DVSR=%0d  SB_TICK=%0d  BAUD_CLKS=%0d  FIFO_W=%0d",
                 DVSR, SB_TICK, BAUD_CLKS, FIFO_W);
        $display("================================================\n");

        // TC1: Reset state
        $display("--- TC1: Reset state ---");
        check1("rx_empty after reset", rx_empty, 1'b1);
        check1("tx_full after reset",  tx_full,  1'b0);
        check1("TX idle (high)",       TX,       1'b1);

        // TC2: TX single byte 'A'
        $display("\n--- TC2: TX single byte 0x41 'A' ---");
        fork
            begin fifo_write(8'h41); end
            begin
                uart_capture_byte;
                check8("TX byte 'A'", captured_byte, 8'h41);
            end
        join

        // TC3: TX multiple bytes 'H','i'
        $display("\n--- TC3: TX multiple bytes 'H','i' ---");
        fork
            begin
                fifo_write(8'h48);
                fifo_write(8'h69);
            end
            begin
                uart_capture_byte;
                check8("TX byte 'H'", captured_byte, 8'h48);
                uart_capture_byte;
                check8("TX byte 'i'", captured_byte, 8'h69);
            end
        join

        // TC4: RX single byte 'U'
        $display("\n--- TC4: RX single byte 0x55 'U' ---");
        uart_send_byte(8'h55);
        repeat(10) @(posedge CLK);
        check1("rx_empty=0 after RX",  rx_empty, 1'b0);
        fifo_read;
        check8("RX byte 'U'", captured_rx, 8'h55);
        repeat(2) @(posedge CLK); #1;
        check1("rx_empty=1 after read", rx_empty, 1'b1);

        // TC5: RX multiple bytes 'X','Y'
        $display("\n--- TC5: RX multiple bytes 'X','Y' ---");
        uart_send_byte(8'h58);
        uart_send_byte(8'h59);
        repeat(10) @(posedge CLK);
        check1("rx_empty=0 after 2 RX", rx_empty, 1'b0);
        fifo_read;
        check8("RX byte 'X'", captured_rx, 8'h58);
        fifo_read;
        check8("RX byte 'Y'", captured_rx, 8'h59);
        repeat(2) @(posedge CLK); #1;
        check1("rx_empty=1 after 2 reads", rx_empty, 1'b1);

        // TC6: Loopback sequential
        $display("\n--- TC6: Loopback RX->FIFO->TX byte 0x4C 'L' ---");
        uart_send_byte(8'h4C);
        repeat(10) @(posedge CLK);
        fifo_read;
        fifo_write(captured_rx);
        uart_capture_byte;
        check8("Loopback TX 'L'", captured_byte, 8'h4C);

        // TC7: TX FIFO full 15 bytes
        $display("\n--- TC7: TX FIFO full (15 bytes) ---");
        begin : fill_fifo
            integer k;
            for (k = 0; k < 16; k = k + 1) begin
                @(negedge CLK);
                w_data  = k[7:0];
                wr_uart = 1;
                @(posedge CLK); #1;
                wr_uart = 0;
            end
        end
        #1;
        check1("tx_full=1 after 15 writes", tx_full, 1'b1);
        repeat(15 * (BAUD_CLKS * 10 + 10)) @(posedge CLK);
        #1;
        check1("tx_full=0 after drain", tx_full, 1'b0);

        // TC8: Mid-run reset
        $display("\n--- TC8: Mid-run reset clears FIFOs ---");
        uart_send_byte(8'h30);
        repeat(10) @(posedge CLK);
        check1("rx_empty=0 before reset", rx_empty, 1'b0);
        @(negedge CLK); reset = 1;  // fix: active-high
        repeat(3) @(posedge CLK);
        @(negedge CLK); reset = 0;  // fix: tha reset
        repeat(2) @(posedge CLK); #1;
        check1("rx_empty=1 after reset", rx_empty, 1'b1);
        check1("tx_full=0 after reset",  tx_full,  1'b0);
        check1("TX idle after reset",    TX,       1'b1);

        // TC9: TX edge values
        $display("\n--- TC9: TX edge values 0x00 and 0xFF ---");
        fork
            begin fifo_write(8'h00); end
            begin
                uart_capture_byte;
                check8("TX byte 0x00", captured_byte, 8'h00);
            end
        join
        fork
            begin fifo_write(8'hFF); end
            begin
                uart_capture_byte;
                check8("TX byte 0xFF", captured_byte, 8'hFF);
            end
        join

        // TC10: RX edge values
        $display("\n--- TC10: RX edge values 0x00 and 0xFF ---");
        uart_send_byte(8'h00);
        repeat(10) @(posedge CLK);
        fifo_read;
        check8("RX byte 0x00", captured_rx, 8'h00);
        uart_send_byte(8'hFF);
        repeat(10) @(posedge CLK);
        fifo_read;
        check8("RX byte 0xFF", captured_rx, 8'hFF);

        // SUMMARY
        repeat(10) @(posedge CLK);
        $display("\n================================================");
        $display("  KET QUA: %0d PASS  |  %0d FAIL", pass_cnt, fail_cnt);
        $display("================================================\n");
        $finish;
    end

    initial begin
        #50_000_000;
        $display("\n[TIMEOUT] Simulation exceeded 50ms\n");
        $finish;
    end

endmodule