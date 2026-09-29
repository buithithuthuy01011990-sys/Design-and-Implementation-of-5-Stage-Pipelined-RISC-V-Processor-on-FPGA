module fetch (
    input clk,
    input reset,
    input PCSrcE,
    input [31:0] PCTargetE,
    input  StallF,         
    input  StallD,
    input FlushD,                 
    output [31:0] InstrD,
    output [31:0] PCD,
    output [31:0] PCPlus4D
);
    wire [31:0] PC_next;
    wire [31:0] PCF;
    wire [31:0] PCPlus4F;
    wire [31:0] InstrF;

    Mux PC_MUX (
        .a(PCPlus4F),
        .b(PCTargetE),
        .select(PCSrcE),
        .c(PC_next)
    );

    pc Program_Counter (
        .clk(clk),
        .reset(reset),
        .StallF(StallF),
        .StallD(StallD),    
        .pc_next(PC_next),
        .pc_current(PCF)
    );

    ins_mem IMEM (
      
        .read_add(PCF),
        .ins(InstrF)
    );

    pc_adder_1 PC_adder (
        .pc(PCF),
        .pc_plus4(PCPlus4F)
    );

   
    reg [31:0] InstrF_reg;
    reg [31:0] PCF_reg;
    reg [31:0] PCPlus4F_reg;

    always @(posedge clk or posedge reset) 
    begin
    if (reset) 
    begin
        InstrF_reg   <= 32'h0;
        PCF_reg      <= 32'h0;
        PCPlus4F_reg <= 32'h0;
    end
    else if (FlushD)
     begin
       
        InstrF_reg   <= 32'h00000013; 
        PCF_reg      <= 32'h0;
        PCPlus4F_reg <= 32'h0;
    end
    else if (!StallD)
     begin
        InstrF_reg   <= InstrF;
        PCF_reg      <= PCF;
        PCPlus4F_reg <= PCPlus4F;
    end
end
assign InstrD   = InstrF_reg;
assign PCD      = PCF_reg;
assign PCPlus4D = PCPlus4F_reg;
endmodule
