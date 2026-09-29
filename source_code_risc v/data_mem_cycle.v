


module MtoW_Reg (
    input         clk,
    input         reset,
    input         RegWriteM,
    input  [1:0]  ResultSrcM,
    input  [4:0]  RdM,
    input  [31:0] PCPlus4M,
    input  [31:0] ALUResultM,
    input  [31:0] ReadDataM,      
    output reg        RegWriteW,
    output reg [1:0]  ResultSrcW,
    output reg [4:0]  RdW,
    output reg [31:0] PCPlus4W,
    output reg [31:0] ALUResultW,
    output reg [31:0] ReadDataW
);
    always @(posedge clk or posedge reset)
     begin
        if (reset) 
        begin
            RegWriteW  <= 1'b0;
            ResultSrcW <= 2'b00;
            RdW        <= 5'h0;
            PCPlus4W   <= 32'h0;
            ALUResultW <= 32'h0;
            ReadDataW  <= 32'h0;
        end else
        begin
            RegWriteW  <= RegWriteM;
            ResultSrcW <= ResultSrcM;
            RdW        <= RdM;
            PCPlus4W   <= PCPlus4M;
            ALUResultW <= ALUResultM;
            ReadDataW  <= ReadDataM;
        end
    end
endmodule



module memory_stage
 (
    input clk,
    input reset,

    input  RegWriteM,
    input  MemWriteM,
    input  [1:0]  ResultSrcM,
    input  [4:0]  RdM,
    input  [31:0] ALUResultM,
    input  [31:0] WriteDataM,
    input  [31:0] PCPlus4M,

    
    input  [31:0] ReadDataAPB,   
    input         IsAPBAddr,     

    output RegWriteW,
    output [1:0]  ResultSrcW,
    output [4:0]  RdW,
    output [31:0] PCPlus4W,
    output [31:0] ALUResultW,
    output [31:0] ReadDataW,
    output [31:0] ResultW
);
    
    wire [31:0] ReadDataDMEM;

    Data_Memory dmem
     (
        .clk   (clk),
        .reset (reset),
        .WE    (MemWriteM & ~IsAPBAddr),   
        .A     (ALUResultM),
        .WD    (WriteDataM),
        .RD    (ReadDataDMEM)
    );

    
    wire [31:0] ReadDataM_final = IsAPBAddr ? ReadDataAPB : ReadDataDMEM;

    MtoW_Reg mw_reg (
        .clk        (clk),
        .reset      (reset),
        .RegWriteM  (RegWriteM),
        .ResultSrcM (ResultSrcM),
        .RdM        (RdM),
        .PCPlus4M   (PCPlus4M),
        .ALUResultM (ALUResultM),
        .ReadDataM  (ReadDataM_final),    
        .RegWriteW  (RegWriteW),
        .ResultSrcW (ResultSrcW),
        .RdW        (RdW),
        .PCPlus4W   (PCPlus4W),
        .ALUResultW (ALUResultW),
        .ReadDataW  (ReadDataW)
    );

    assign ResultW = (ResultSrcW == 2'b01) ? ReadDataW  :  (ResultSrcW == 2'b10) ? PCPlus4W   : ALUResultW;
endmodule


// Data_Memory  

module Data_Memory (
    input         clk,
    input         reset,
    input         WE,
    input  [31:0] A,
    input  [31:0] WD,
    output [31:0] RD
);
    reg [31:0] mem [0:1023];

    integer i;
    initial begin
        for (i = 0; i < 1024; i = i + 1)
            mem[i] = 32'h0;
    end

    wire [9:0] word_addr = A[11:2];

    always @(posedge clk) begin
        if (WE && !reset)
            mem[word_addr] <= WD;
    end

    assign RD = reset ? 32'h0 : mem[word_addr];
endmodule