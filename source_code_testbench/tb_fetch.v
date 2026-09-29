module fetch_tb;

    reg         clk;
    reg         reset;
    reg         PCSrcE;
    reg  [31:0] PCTargetE;
    reg         StallF;
    reg         StallD;
    reg         FlushD;

    // --- Outputs ---
    wire [31:0] InstrD;
    wire [31:0] PCD;
    wire [31:0] PCPlus4D;

    // --- Counters ---
    integer pass_cnt;
    integer fail_cnt;

    // --- Instantiate DUT ---
    fetch DUT (
        .clk       (clk),
        .reset     (reset),
        .PCSrcE    (PCSrcE),
        .PCTargetE (PCTargetE),
        .StallF    (StallF),
        .StallD    (StallD),
        .FlushD    (FlushD),
        .InstrD    (InstrD),
        .PCD       (PCD),
        .PCPlus4D  (PCPlus4D)
    );

    
    initial clk = 0;
    always #5 clk = ~clk;

  
    task check;
        input [255:0] name;
        input         cond;
    begin
        if (cond) begin
            $display("  [PASS] %s", name);
            pass_cnt = pass_cnt + 1;
        end else begin
            $display("  [FAIL] %s  (PCD=%08h  InstrD=%08h  PCPlus4D=%08h)",
                     name, PCD, InstrD, PCPlus4D);
            fail_cnt = fail_cnt + 1;
        end
    end
    endtask


    task print_state;
        input [255:0] label;
    begin
        $display("         %-28s | PCD=%08h  PCPlus4D=%08h  InstrD=%08h",
                 label, PCD, PCPlus4D, InstrD);
    end
    endtask

   
    task do_reset;
    begin
        reset = 1; PCSrcE = 0; PCTargetE = 0;
        StallF = 0; StallD = 0; FlushD = 0;
        @(posedge clk); #1;
        @(posedge clk); #1;
        reset = 0;
        @(posedge clk); #1;
    end
    endtask


    task do_branch;
        input [31:0] target;
    begin
        PCTargetE = target;

        @(negedge clk);       
        PCSrcE = 1;
        FlushD = 1;

        @(posedge clk); #1; 
                            

        @(posedge clk); #1;   
                              
        PCSrcE = 0;
        FlushD = 0;          

        @(posedge clk); #1;  
                             
    end
    endtask

   
    initial begin
        $dumpfile("fetch_tb.vcd");
        $dumpvars(0, fetch_tb);

        pass_cnt = 0;
        fail_cnt = 0;

       
        $display(" TESTBENCH: fetch module ");
      

        
        // TC1 - Reset: IF/ID pipeline registers 
        
        do_reset; // <-- G?i hàm này ra ch?y, thay vì vi?t l?i m??i m?y dòng gán.

	print_state("during reset (clk edge)");
	check("PCD      == 0 during reset", PCD     === 32'h0);

       
        // TC2 - Fetch 
     
        $display("\n[TC2] Sequential fetch - PC increments +4 each cycle");
        PCSrcE = 0; StallF = 0; StallD = 0; FlushD = 0;
        begin : seq_block
            integer k;
            for (k = 0; k < 6; k = k + 1) begin
                @(posedge clk); #1;
                print_state("seq fetch");
                check("PCPlus4D == PCD + 4", PCPlus4D === PCD + 32'd4);
            end
        end

        
        $display("\n[TC3] StallF=1 - PC stage-F must not increment");
        begin : stallf_block
            reg [31:0] pcd_snap;
            reg [31:0] pc4_snap;
            reg [31:0] instr_snap;

            @(posedge clk); #1;
            pcd_snap   = PCD;
            pc4_snap   = PCPlus4D;
            instr_snap = InstrD;

            @(negedge clk);
            StallF = 1;
            StallD = 1;

            @(posedge clk); #1;
            print_state("StallF=1+StallD=1 cy1");
            check("PCD      unchanged when StallF=1 (cy1)", PCD      === pcd_snap);
            check("PCPlus4D unchanged when StallF=1 (cy1)", PCPlus4D === pc4_snap);
            check("InstrD   unchanged when StallF=1 (cy1)", InstrD   === instr_snap);

            @(posedge clk); #1;
            print_state("StallF=1+StallD=1 cy2");
            check("PCD      unchanged when StallF=1 (cy2)", PCD      === pcd_snap);
            check("PCPlus4D unchanged when StallF=1 (cy2)", PCPlus4D === pc4_snap);
            check("InstrD   unchanged when StallF=1 (cy2)", InstrD   === instr_snap);

            @(negedge clk);
            StallF = 0;
            StallD = 0;

            @(posedge clk); #1;
            print_state("after StallF released");
            check("PCD increments after StallF released", PCD !== pcd_snap);
        end

       
        // TC4 - StallD=1: IF/ID register 
       
        $display("\n[TC4] StallD=1 - IF/ID pipeline register must be frozen");
        begin : stalld_block
            reg [31:0] pcd_snap;
            reg [31:0] instr_snap;
            reg [31:0] pc4_snap;

            @(posedge clk); #1;
            pcd_snap   = PCD;
            instr_snap = InstrD;
            pc4_snap   = PCPlus4D;

            @(negedge clk);
            StallD = 1;

            @(posedge clk); #1;
            print_state("StallD=1 cycle 1");
            check("PCD      unchanged (StallD cy1)", PCD      === pcd_snap);
            check("InstrD   unchanged (StallD cy1)", InstrD   === instr_snap);
            check("PCPlus4D unchanged (StallD cy1)", PCPlus4D === pc4_snap);

            @(posedge clk); #1;
            print_state("StallD=1 cycle 2");
            check("PCD      unchanged (StallD cy2)", PCD      === pcd_snap);
            check("InstrD   unchanged (StallD cy2)", InstrD   === instr_snap);
            check("PCPlus4D unchanged (StallD cy2)", PCPlus4D === pc4_snap);

            @(negedge clk);
            StallD = 0;

            @(posedge clk); #1;
            check("PCD advances after StallD released", PCD !== pcd_snap);
        end

       
        // TC5 - Branch taken:
       
        $display("\n[TC5] Branch taken - PC must jump to PCTargetE");
        begin : branch_tc5
            PCTargetE = 32'h0000_0008;

            @(negedge clk);         
            PCSrcE = 1;
            FlushD = 1;

            @(posedge clk); #1;      

            @(posedge clk); #1;     
           
            print_state("T2: FlushD still high, InstrD=NOP");
            check("InstrD flushed to NOP",  InstrD === 32'h0000_0013);

            PCSrcE = 0;
            FlushD = 0;             

            @(posedge clk); #1;     
            print_state("T3: after branch, pipeline running");
            check("PCD == PCTargetE (8h)",  PCD      === 32'h0000_0008);
            check("PCPlus4D == 0xc",        PCPlus4D === 32'h0000_000c);
        end

        
        // TC6 - Branch + StallD 
       
        $display("\n[TC6] Branch + StallD simultaneously - Flush must win");
        begin : branch_stall_block
          
            repeat(3) @(posedge clk); #1;
            $display("         InstrD before flush = %08h (should be non-NOP)",
                     InstrD);

            @(negedge clk);
            FlushD = 1;
            StallD = 1;

            @(posedge clk); #1;
            print_state("FlushD+StallD (flush wins)");
            check("InstrD=NOP when FlushD+StallD",   InstrD === 32'h0000_0013);
            check("PCD==0 when FlushD asserted",      PCD    === 32'h0);

            @(negedge clk);
            FlushD = 0;
            StallD = 0;
            @(posedge clk); #1;
            print_state("after flush+stall released");
        end

       
        // TC7 - Mid-operation reset:
       
        $display("\n[TC7] Mid-operation reset - registers must clear");
        repeat(3) @(posedge clk);
        @(negedge clk);
        reset = 1;
        @(posedge clk); #1;
        print_state("mid-op reset active");
        check("PCD      == 0 on mid-reset", PCD      === 32'h0);
        check("InstrD   == 0 on mid-reset", InstrD   === 32'h0);
        check("PCPlus4D == 0 on mid-reset", PCPlus4D === 32'h0);
        @(negedge clk);
        reset = 0;
        @(posedge clk); #1;

        
        // TC8 - StallF + StallD 
       
        $display("\n[TC8] StallF=1 + StallD=1 - everything frozen");
        begin : both_stall
            reg [31:0] pcd_snap;
            reg [31:0] instr_snap;
            reg [31:0] pc4_snap;

            @(posedge clk); #1;
            @(posedge clk); #1;
            pcd_snap   = PCD;
            instr_snap = InstrD;
            pc4_snap   = PCPlus4D;

            @(negedge clk);
            StallF = 1; StallD = 1;

            @(posedge clk); #1;
            print_state("StallF+StallD cycle 1");
            check("PCD      frozen (cy1)", PCD      === pcd_snap);
            check("InstrD   frozen (cy1)", InstrD   === instr_snap);
            check("PCPlus4D frozen (cy1)", PCPlus4D === pc4_snap);

            @(posedge clk); #1;
            print_state("StallF+StallD cycle 2");
            check("PCD      frozen (cy2)", PCD      === pcd_snap);
            check("InstrD   frozen (cy2)", InstrD   === instr_snap);
            check("PCPlus4D frozen (cy2)", PCPlus4D === pc4_snap);

            @(negedge clk);
            StallF = 0; StallD = 0;
            @(posedge clk); #1;
            check("PCD advances after stalls released", PCD !== pcd_snap);
        end

     
        // TC9 - FlushD=1: IF/ID 
        
        $display("\n[TC9] FlushD=1 - IF/ID must be cleared to NOP");
        begin : flush_block
            repeat(3) @(posedge clk); #1;
            $display("         InstrD before flush = %08h", InstrD);

            @(negedge clk);
            FlushD = 1;

            @(posedge clk); #1;
            print_state("FlushD=1 active");
            check("InstrD = NOP after FlushD",   InstrD   === 32'h0000_0013);
            check("PCD    == 0  after FlushD",   PCD      === 32'h0);
            check("PCPlus4D == 0 after FlushD",  PCPlus4D === 32'h0);

            @(negedge clk);
            FlushD = 0;
            @(posedge clk); #1;
            print_state("cycle after FlushD released");
        end

        
        // TC10 - FlushD + StallD:
       
        $display("\n[TC10] FlushD + StallD - Flush must win over StallD");
        begin : flush_wins_block
         
            do_branch(32'h0000_0008);
            repeat(2) @(posedge clk); #1;

            $display("         InstrD before test = %08h (should be non-NOP)",
                     InstrD);
            if (InstrD === 32'h0000_0013 || InstrD === 32'hxxxx_xxxx)
                $display("  [WARN] InstrD not valid - TC10 may give false PASS.");

            @(negedge clk);
            StallD = 1;
            FlushD = 1;

            @(posedge clk); #1;
            print_state("FlushD wins over StallD");
            check("Flush overrides StallD: InstrD=NOP", InstrD === 32'h0000_0013);

            @(negedge clk);
            StallD = 0;
            FlushD = 0;
        end

        // TC11 
        
        $display("\n[TC11] Toggle ");
        
        do_branch(32'h00FF_FF00); 
        begin : toggle_boost_block
        
            integer m;
            for (m = 0; m < 5; m = m + 1) 
            begin
                @(posedge clk); #1;
                print_state("high-addr fetch");
                
                
                check("PCPlus4D == PCD + 4 (High Addr)", PCPlus4D === PCD + 32'd4);
            end
        end

        
        
        do_branch(32'h0000_0000);
        @(posedge clk); #1;
     
        
      
        $display("  RESULT:  %0d PASSED  /  %0d FAILED", pass_cnt, fail_cnt);
        if (fail_cnt == 0)
            $display("    TESTS PASSED  ");
        else
            $display("     TESTS FAILED   ");
    
        $finish;
    end

    initial begin
        #20000;
        $display("[ERROR]  timeout!");
        $finish;
    end

endmodule