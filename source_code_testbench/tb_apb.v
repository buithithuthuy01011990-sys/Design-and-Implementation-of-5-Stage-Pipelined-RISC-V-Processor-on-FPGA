

`timescale 1ns/1ps

module tb_mem_to_apb_master;


    localparam CLK_HALF = 5;

    reg clk   = 0;
    reg reset = 1;
    always #CLK_HALF clk = ~clk;


    reg  [31:0] ALU_ResultM = 0;
    reg  [31:0] WriteDataM  = 0;
    reg         MemWriteM   = 0;
    reg         MemReadM    = 0;
    reg  [31:0] PRDATA      = 0;
    reg         PREADY      = 0;

    wire [31:0] ReadDataM;
    wire        PSEL, PENABLE, PWRITE;
    wire [31:0] PADDR, PWDATA;
    wire        apb_stall;

    mem_to_apb_master dut 
    (
        .clk        (clk),
        .reset      (reset),
        .ALU_ResultM(ALU_ResultM),
        .WriteDataM (WriteDataM),
        .MemWriteM  (MemWriteM),
        .MemReadM   (MemReadM),
        .ReadDataM  (ReadDataM),
        .PSEL       (PSEL),
        .PENABLE    (PENABLE),
        .PWRITE     (PWRITE),
        .PADDR      (PADDR),
        .PWDATA     (PWDATA),
        .PRDATA     (PRDATA),
        .PREADY     (PREADY),
        .apb_stall  (apb_stall)
    );

   
    // kiem tra loi 
   
    integer pass_cnt = 0;
    integer fail_cnt = 0;

    task check;
        input        cond;
        input [255:0] msg;
        begin
            if (cond) begin
                $display("  PASS: %0s", msg);
                pass_cnt = pass_cnt + 1;
            end else begin
                $display("  FAIL: %0s  (time=%0t)", msg, $time);
                fail_cnt = fail_cnt + 1;
            end
        end
    endtask


    task idle_cleanup;
        begin
            @(negedge clk);
            MemWriteM   = 0;
            MemReadM    = 0;
            PREADY      = 0;
            ALU_ResultM = 0;
            WriteDataM  = 0;
            PRDATA      = 0;
            @(posedge clk); 
        end
    endtask


    initial begin
    
        $dumpfile("tb_mem_to_apb_master.vcd");
        $dumpvars(0, tb_mem_to_apb_master);


        // TC01  Reset

        $display("\nTC01: Reset / power-on defaults ");
        reset = 1;
        repeat(4) @(posedge clk);
        #1; reset = 0;
        @(posedge clk); #1;

        check(PSEL     == 0, "TC01a PSEL=0 after reset");
        check(PENABLE  == 0, "TC01b PENABLE=0 after reset");
        check(PWRITE   == 0, "TC01c PWRITE=0 after reset");
        check(PADDR    == 0, "TC01d PADDR=0 after reset");
        check(PWDATA   == 0, "TC01e PWDATA=0 after reset");
        check(apb_stall== 0, "TC01f apb_stall=0 after reset");
        check(ReadDataM== 0, "TC01g ReadDataM=0 after reset");


        // TC02  Single write, PREADY immediate

        $display("\n TC02: Single write, immediate PREADY" );


        @(negedge clk);
        ALU_ResultM = 32'h4000_0004;
        WriteDataM  = 32'hDEAD_BEEF;
        MemWriteM   = 1;

        @(posedge clk); #1; 
        check(PSEL    == 1,"TC02a PSEL=1 in SETUP");
        check(PENABLE == 0,"TC02b PENABLE=0 in SETUP");
        check(PWRITE  == 1,"TC02c PWRITE=1 in SETUP");
        check(PADDR   == 32'h4000_0004, "TC02d PADDR dung in SETUP");
        check(PWDATA  == 32'hDEAD_BEEF, "TC02e PWDATA dung in SETUP");
        check(apb_stall == 1,           "TC02f stall=1 in SETUP");

        @(posedge clk); #1; 
        // SETUP  ACCESS
        check(PSEL    == 1, "TC02g PSEL=1 trong ACCESS");
        check(PENABLE == 1, "TC02h PENABLE=1 trong ACCESS");
        check(PWRITE  == 1, "TC02i PWRITE=1 trong ACCESS");
        check(apb_stall == 1, "TC02j stall=1 ACCESS/no-PREADY");

        @(negedge clk); PREADY=1; MemWriteM=0;
        @(posedge clk); #1;  
        // complete ? IDLE
        check(apb_stall == 0, "TC02k stall kich hoat");
        check(PSEL == 0,      "TC02l PSEL=0 quay lai trong IDLE");

        @(negedge clk); PREADY=0; @(posedge clk);

        
        
        
        // TC03  Single read, PREADY immediate
     
        

        $display("\n TC03: Single read, immediate PREADY ");
        
        @(negedge clk);
        ALU_ResultM = 32'h4000_0008;
        MemReadM    = 1;
        PRDATA      = 32'h1234_ABCD;
        
        @(posedge clk); // IDLE -> SETUP
        @(posedge clk); #1; // SETUP -> ACCESS
        check(PWRITE == 0, "TC03a PWRITE=0 for read");
        check(PADDR  == 32'h4000_0008, "TC03b PADDR dung ");
        check(PSEL   == 1, "TC03c PSEL=1 in ACCESS");
        check(PENABLE== 1, "TC03d PENABLE=1 in ACCESS");
        
        @(negedge clk); 
        PREADY  = 1; 
        MemReadM = 0;
        
        @(posedge clk); #1;
        check(ReadDataM == 32'h1234_ABCD, "TC03e ReadDataM  PRDATA");
        check(PSEL == 0, "TC03f PSEL=0 after completion");
        
        @(negedge clk); 
        PREADY = 0; 
        @(posedge clk);
 
        // TC04  Write voi 3 wait states

        $display("\n TC04: Write voi 3 wait states ");

        @(negedge clk);
        ALU_ResultM = 32'h4000_000C;
        WriteDataM  = 32'h1111_2222;
        MemWriteM   = 1;

        @(posedge clk); // IDLE ? SETUP
        @(posedge clk); #1; check(apb_stall==1, "TC04a stall wait-1");
        @(posedge clk); #1; check(apb_stall==1, "TC04b stall wait-2");
        @(posedge clk); #1; check(apb_stall==1, "TC04c stall wait-3");

        @(negedge clk); PREADY=1; MemWriteM=0;
        @(posedge clk); #1;
        check(apb_stall==0, "TC04d stall released");
        check(PSEL==0,      "TC04e PSEL=0 after write with waits");

        @(negedge clk); PREADY=0; @(posedge clk);

       
        // TC05  Read voi  3 wait states
        
        $display("\n TC05: Read with 3 wait states ");

        @(negedge clk);
        ALU_ResultM = 32'h4000_0000;
        MemReadM    = 1;
        PRDATA      = 32'hABCD_EF01;

        @(posedge clk); @(posedge clk);         // IDLE?SETUP?ACCESS
        @(posedge clk); @(posedge clk); @(posedge clk); // 3 waits

        @(negedge clk); PREADY=1; MemReadM=0;
        @(posedge clk); #1;
        check(ReadDataM==32'hABCD_EF01, "TC05a ReadDataM dung sau khi doi ");
        check(PSEL==0,                  "TC05b PSEL=0 read with waits");

        @(negedge clk); PREADY=0; @(posedge clk);

        
        // TC06  Back-to-back write  write
        
        $display("\nTC06: Back-to-back write->write ");

        @(negedge clk);
        ALU_ResultM = 32'h4000_0004;
        WriteDataM  = 32'hAAAA_0001;
        MemWriteM   = 1;

        @(posedge clk); @(posedge clk); 

        
        @(negedge clk);
        ALU_ResultM = 32'h4000_0008;
        WriteDataM  = 32'hBBBB_0002;
        PREADY = 1; 

        @(posedge clk); #1; 
        check(PSEL   == 1,             "TC06a PSEL=1 in 2nd SETUP");
        check(PENABLE== 0,             "TC06b PENABLE=0 in SETUP");
        check(PWRITE == 1,             "TC06c PWRITE=1 for 2nd write");
        check(PADDR  == 32'h4000_0008, "TC06d 2nd addr latched");
        check(PWDATA == 32'hBBBB_0002, "TC06e 2nd wdata latched");

        @(negedge clk); PREADY=0;
        @(posedge clk); // SETUP?ACCESS (2nd)
        @(negedge clk); PREADY=1; MemWriteM=0;
        @(posedge clk); #1;
        check(PSEL==0, "TC06f PSEL=0 after 2nd write done");

        @(negedge clk); PREADY=0; @(posedge clk);




        $display("\n TC07: Back-to-back write->read ");

        @(negedge clk);
        ALU_ResultM = 32'h4000_0000;
        WriteDataM  = 32'h5555_AAAA;
        MemWriteM   = 1;
        MemReadM    = 0;
        PRDATA      = 0;

        @(posedge clk); @(posedge clk); 

        
        @(negedge clk);
        ALU_ResultM = 32'h4000_000C;
        MemWriteM   = 0;
        MemReadM    = 1;
        PRDATA      = 32'h9999_6666;
        PREADY      = 1;

        @(posedge clk); #1;
        check(PWRITE==0, "TC07a PWRITE=0 in 2nd SETUP (read)");
        check(PADDR ==32'h4000_000C, "TC07b addr  2nd txn");

        @(negedge clk); PREADY=0;
        @(posedge clk); // SETUP?ACCESS (read)
        @(negedge clk); PREADY=1; MemReadM=0;
        @(posedge clk); #1;
        check(ReadDataM==32'h9999_6666, "TC07c ReadDataM from back-to-back read");

        @(negedge clk); PREADY=0; @(posedge clk);


        // TC08  apb_stall  SETUP + ACCESS

        $display("\n TC08: apb_stall");

        @(negedge clk); ALU_ResultM=32'h4000_0004; MemWriteM=1;

        @(posedge clk); #1; check(apb_stall==1, "TC08a stall=1 in SETUP");
        @(posedge clk); #1; check(apb_stall==1, "TC08b stall=1 in ACCESS/no-PREADY");

        @(negedge clk); PREADY=1; MemWriteM=0;
        @(posedge clk); #1; check(apb_stall==0, "TC08c stall=0 after done");

        @(negedge clk); PREADY=0; @(posedge clk);

    
        // TC09  Address decode  offset trong UART
   
        $display("\n TC09: Address decode - trong  UART  ");
        begin : tc09
            integer k;
            for (k = 0; k < 4; k = k + 1) begin
                @(negedge clk);
                ALU_ResultM = 32'h4000_0000 + (k * 4);
                MemReadM    = 1;
                @(posedge clk); #1;
                check(apb_stall==1, "TC09 stall=1 for UART addr");
                check(PSEL==1,      "TC09 PSEL=1 for UART addr");
                @(negedge clk); PREADY=1; MemReadM=0;
                @(posedge clk);
                @(negedge clk); PREADY=0; @(posedge clk);
            end
        end

       
        // TC10  Address decode  ngoài UART 
      
        $display("\nTC10: Address decode - ngoai UART ");

        @(negedge clk); ALU_ResultM=32'h4000_0010; MemReadM=1;
        @(posedge clk); #1;
        check(apb_stall==0, "TC10a no stall 0x40000010");
        check(PSEL==0,      "TC10b PSEL=0 0x40000010");

        @(negedge clk); ALU_ResultM=32'h2000_0000;
        @(posedge clk); #1;
        check(apb_stall==0, "TC10c no stall 0x20000000");
        check(PSEL==0,      "TC10d PSEL=0 0x20000000");

        @(negedge clk); MemReadM=0; ALU_ResultM=0; @(posedge clk);

        
        // TC11  Watchdog timeout
        
        $display("\nTC11: Watchdog timeout ");

        @(negedge clk); ALU_ResultM=32'h4000_0004; MemWriteM=1; PREADY=0;

        begin : tc11_wait
            integer cy;
            reg escaped, prev_pe;
            escaped = 0; prev_pe = 0;
            for (cy = 0; cy < 300; cy = cy + 1) begin
                @(posedge clk); #1;
                if (prev_pe && !PENABLE) escaped = 1;
                prev_pe = PENABLE;
            end
            check(escaped==1, "TC11a FSM escaped ACCESS via watchdog");
        end
        check(apb_stall==1, "TC11b stall held while MemWriteM asserted");

        // Cleanup: deassert MemWriteM + assert PREADY together so the in-flight
        // txn drains cleanly and FSM returns to IDLE (not stuck in ACCESS forever)
        @(negedge clk); MemWriteM=0; ALU_ResultM=0; PREADY=1;
        @(posedge clk); @(posedge clk); // drain SETUP or ACCESS state
        @(negedge clk); PREADY=0;
        @(posedge clk);

 
        // TC12  ReadDataM 
     
        $display("\n TC12: ReadDataM unchanged on write ");

      
        @(negedge clk);
        ALU_ResultM=32'h4000_0000; MemReadM=1; PRDATA=32'hFACE_FEED;
        @(posedge clk); @(posedge clk);
        @(negedge clk); PREADY=1; MemReadM=0;
        @(posedge clk); #1;
        check(ReadDataM==32'hFACE_FEED, "TC12-pre ReadDataM seeded");
        @(negedge clk); PREADY=0; @(posedge clk);

        
        @(negedge clk);
        ALU_ResultM=32'h4000_0004; WriteDataM=32'h1234_5678;
        MemWriteM=1; PRDATA=32'hDEAD_DEAD;
        @(posedge clk); @(posedge clk);
        @(negedge clk); PREADY=1; MemWriteM=0;
        @(posedge clk); #1;
        check(ReadDataM==32'hFACE_FEED, "TC12 ReadDataM unchanged after write");

        @(negedge clk); PREADY=0; @(posedge clk);

      
        // TC13  PADDR 32-bit 
     
        $display("\n TC13: PADDR full 32-bit ");

        @(negedge clk); ALU_ResultM=32'h4000_000C; MemReadM=1;
        @(posedge clk); @(posedge clk); #1; // IDLE?SETUP?ACCESS
        check(PADDR==32'h4000_000C, "TC13 PADDR full 32-bit dung ");

        @(negedge clk); PREADY=1; MemReadM=0;
        @(posedge clk);
        @(negedge clk); PREADY=0; @(posedge clk);

       
        // TC14  IDLE outputs 
        
        $display("\nTC14: IDLE outputs clean ");
        idle_cleanup;
        #1;
        check(PSEL   ==0, "TC14a PSEL=0 in IDLE");
        check(PENABLE==0, "TC14b PENABLE=0 in IDLE");
        check(PADDR  ==0, "TC14c PADDR=0 in IDLE");
        check(PWDATA ==0, "TC14d PWDATA=0 in IDLE");

        
      
        $display("  Results:  %0d passed,  %0d failed", pass_cnt, fail_cnt);
       
        if (fail_cnt == 0)
            $display("  TESTS PASSED");
        else
            $display("   TESTS FAILED");
        $finish;
    end

    initial begin #500_000; $display("TIMEOUT"); $finish; end

endmodule