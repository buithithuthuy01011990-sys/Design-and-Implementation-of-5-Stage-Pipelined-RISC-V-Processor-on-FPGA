

module ALU (
    input  [31:0] A, B,
    input  [3:0]  ALUControl,
    output reg [31:0] Result,
    output Carry, OverFlow, Zero, Negative
);
    wire [31:0] Sum;
    wire        Cout;
    assign {Cout, Sum} = (ALUControl == 4'b0001) ? (A + (~B + 1)) : (A + B);
 
    wire slt_result = ($signed(A) < $signed(B));
 
    wire [63:0] mul_ss = $signed(A)   * $signed(B);
    wire [63:0] mul_su = $signed(A)   * $unsigned(B);
    wire [63:0] mul_uu = $unsigned(A) * $unsigned(B);
 
   
    wire [31:0] div_s = 32'h0000_0000;
    wire [31:0] div_u = 32'h0000_0000;
    wire [31:0] rem_s = 32'h0000_0000;
 
   
    wire [4:0] shamt = B[4:0];
 
    always @(*) begin
        case (ALUControl)
            4'b0000: Result = Sum;                        
            4'b0001: Result = Sum;                        
            4'b0010: Result = A & B;                     
            4'b0011: Result = A | B;                      // OR
            4'b0100: Result = A ^ B;                      // XOR
            4'b0101: Result = {31'b0, slt_result};        // SLT
            4'b0110: Result = A << shamt;                 // SLL  
            4'b0111: Result = A >> shamt;                 // SRL  
            4'b1000: Result = $signed(A) >>> shamt;       // SRA  
            4'b1001: Result = mul_ss[31:0];               // MUL
            4'b1010: Result = mul_ss[63:32];              // MULH
            4'b1011: Result = mul_su[63:32];              // MULHSU
            4'b1100: Result = mul_uu[63:32];              // MULHU
            4'b1101: Result = div_s;                      // DIV  
            4'b1110: Result = div_u;                      // DIVU 
            4'b1111: Result = rem_s;                      // REM  
            default: Result = 32'b0;
        endcase
    end
 
    assign Carry    = ((ALUControl==4'b0000)||(ALUControl==4'b0001)) ? Cout : 1'b0;
 
    wire add_ov = (~A[31] & ~B[31] &  Sum[31]) | ( A[31] &  B[31] & ~Sum[31]);
    wire sub_ov = (~A[31] &  B[31] &  Sum[31]) | ( A[31] & ~B[31] & ~Sum[31]);
    assign OverFlow = (ALUControl==4'b0000) ? add_ov :
                      (ALUControl==4'b0001) ? sub_ov : 1'b0;
 
    assign Zero     = (Result == 32'b0);
    assign Negative = Result[31];
 
endmodule
