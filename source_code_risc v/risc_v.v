module Pipeline_top (
    input  wire        clk,
    input  wire        reset,

    
    input  wire [31:0] PRDATA,
    input  wire        PREADY,
    output wire        PSEL,
    output wire        PENABLE,
    output wire        PWRITE,
    output wire [31:0]  PADDR,
    output wire [31:0] PWDATA,

  
    output wire [31:0] ALU_ResultM,
    output wire [31:0] WriteDataM,
    output wire        MemWriteM
);

    
    wire        PCSrcE;
    wire        RegWriteW, RegWriteE, RegWriteM;
    wire        ALUSrcE, MemWriteE_w;
    wire        BranchE, JumpE;

    wire        StallF_hz, StallD_hz, FlushE_hz;
    wire        StallF, StallD, FlushE, FlushD;
    wire        apb_stall;

    assign FlushD = PCSrcE;


    wire StallF_final = StallF_hz | apb_stall;
    wire StallD_final = StallD_hz | apb_stall;
    wire FlushE_final = FlushE_hz & ~apb_stall;

    
    wire [1:0]  ResultSrcE, ResultSrcM, ResultSrcW;
    wire [3:0]  ALUControlE;
    wire [4:0]  RD_E, RD_M, RDW;
    wire [4:0]  RS1_E, RS2_E;
    wire [4:0]  Rs1_D, Rs2_D;
    wire [1:0]  ForwardAE, ForwardBE;
    wire [31:0] PCTargetE;
    wire [31:0] InstrD, PCD, PCPlus4D;
    wire [31:0] ResultW;
    wire [31:0] RD1_E, RD2_E, Imm_Ext_E;
    wire [31:0] PCE, PCPlus4E;
    wire [31:0] PCPlus4M;
    wire [31:0] PCPlus4W, ALU_ResultW, ReadDataW;
    wire FlushD_hz;

    wire [31:0] ALU_ResultM_w;
    wire [31:0] WriteDataM_w;
    wire        MemWriteM_w;

    assign ALU_ResultM = ALU_ResultM_w;
    assign WriteDataM  = WriteDataM_w;
    assign MemWriteM   = MemWriteM_w;

  
    wire is_apb_addr = (ALU_ResultM_w[31:16] == 16'h4000);
    wire MemReadM    = ResultSrcM[0] & ~MemWriteM_w;

  
    wire [31:0] ReadDataAPB;

    mem_to_apb_master apb_master (
        .clk         (clk),
        .reset       (reset),
        .ALU_ResultM (ALU_ResultM_w),
        .WriteDataM  (WriteDataM_w),
        .MemWriteM   (MemWriteM_w),
        .MemReadM    (MemReadM),
        .ReadDataM   (ReadDataAPB),
        .PSEL        (PSEL),
        .PENABLE     (PENABLE),
        .PWRITE      (PWRITE),
        .PADDR       (PADDR),
        .PWDATA      (PWDATA),
        .PRDATA      (PRDATA),
        .PREADY      (PREADY),
        .apb_stall   (apb_stall)
    );

   
    // Fetch
  
    fetch Fetch (
        .clk       (clk),
        .reset     (reset),
        .PCSrcE    (PCSrcE),
        .PCTargetE (PCTargetE),
        .StallF    (StallF_final),
        .StallD    (StallD_final),
        .FlushD    (FlushD),
        .InstrD    (InstrD),
        .PCD       (PCD),
        .PCPlus4D  (PCPlus4D)
    );

   
    // Decode
    
    decode_cycle Decode (
        .clk         (clk),
        .reset       (reset),
        .FlushE      (FlushE_final),
        .InstrD      (InstrD),
        .PCD         (PCD),
        .PCPlus4D    (PCPlus4D),
        .RegWriteW   (RegWriteW),
        .RDW         (RDW),
        .ResultW     (ResultW),
        .RegWriteE   (RegWriteE),
        .ALUSrcE     (ALUSrcE),
        .MemWriteE   (MemWriteE_w),
        .ResultSrcE  (ResultSrcE),
        .BranchE     (BranchE),
        .JumpE       (JumpE),
        .ALUControlE (ALUControlE),
        .RD1_E       (RD1_E),
        .RD2_E       (RD2_E),
        .Imm_Ext_E   (Imm_Ext_E),
        .RD_E        (RD_E),
        .PCE         (PCE),
        .PCPlus4E    (PCPlus4E),
        .RS1_E       (RS1_E),
        .RS2_E       (RS2_E),
        .Rs1_D_out   (Rs1_D),
        .Rs2_D_out   (Rs2_D)
    );

   
    // Execute
   
    execute_cycle Execute (
        .clk         (clk),
        .reset       (reset),
        .RegWriteE   (RegWriteE),
        .ALUSrcE     (ALUSrcE),
        .MemWriteE   (MemWriteE_w),
        .ResultSrcE  (ResultSrcE),
        .BranchE     (BranchE),
        .JumpE       (JumpE),
        .ALUControlE (ALUControlE),
        .RD1_E       (RD1_E),
        .RD2_E       (RD2_E),
        .Imm_Ext_E   (Imm_Ext_E),
        .RD_E        (RD_E),
        .RS1_E       (RS1_E),
        .RS2_E       (RS2_E),
        .PCE         (PCE),
        .PCPlus4E    (PCPlus4E),
        .PCSrcE      (PCSrcE),
        .PCTargetE   (PCTargetE),
        .RegWriteM   (RegWriteM),
        .MemWriteM   (MemWriteM_w),
        .ResultSrcM  (ResultSrcM),
        .RD_M        (RD_M),
        .PCPlus4M    (PCPlus4M),
        .WriteDataM  (WriteDataM_w),
        .ALU_ResultM (ALU_ResultM_w),
        .ResultW     (ResultW),
        .ForwardA_E  (ForwardAE),
        .ForwardB_E  (ForwardBE)
    );

   
    // Memory  
  
    memory_stage Memory (
        .clk          (clk),
        .reset        (reset),
        .RegWriteM    (RegWriteM),
        .MemWriteM    (MemWriteM_w),
        .ResultSrcM   (ResultSrcM),
        .RdM          (RD_M),
        .ALUResultM   (ALU_ResultM_w),
        .WriteDataM   (WriteDataM_w),
        .PCPlus4M     (PCPlus4M),
        .ReadDataAPB  (ReadDataAPB),      
        .IsAPBAddr    (is_apb_addr),     
        .RegWriteW    (RegWriteW),
        .ResultSrcW   (ResultSrcW),
        .RdW          (RDW),
        .PCPlus4W     (PCPlus4W),
        .ALUResultW   (ALU_ResultW),
        .ReadDataW    (ReadDataW),
        .ResultW      (ResultW)
    );

    
    // Writeback
 
    writeback_cycle WriteBack (
        .clk         (clk),
        .reset       (reset),
        .ResultSrcW  (ResultSrcW),
        .PCPlus4W    (PCPlus4W),
        .ALU_ResultW (ALU_ResultW),
        .ReadDataW   (ReadDataW),
        .ResultW     (ResultW)
    );

    
    // Hazard unit
   
    hazard_unit Forwarding_block (
        .reset        (reset),
        .RegWriteM    (RegWriteM),
        .RegWriteW    (RegWriteW),
        .RD_M         (RD_M),
        .RD_W         (RDW),
        .Rs1_E        (RS1_E),
        .Rs2_E        (RS2_E),
        .ForwardAE    (ForwardAE),
        .ForwardBE    (ForwardBE),
        .ResultSrcE_0 (ResultSrcE[0]),
        .RD_E         (RD_E),
        .Rs1_D        (Rs1_D),
        .Rs2_D        (Rs2_D),
        .StallF       (StallF_hz),
        .StallD       (StallD_hz),
        .FlushE       (FlushE_hz),
    	.FlushD       (FlushD_hz),
      .PCSrcE(PCSrcE)
    );

endmodule