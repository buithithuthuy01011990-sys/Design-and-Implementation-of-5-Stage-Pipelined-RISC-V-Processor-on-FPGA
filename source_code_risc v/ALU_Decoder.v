module ALU_Decoder (
    input  [1:0] ALUOp,
    input  [2:0] funct3,
    input  [6:0] funct7,
    input  [6:0] Op,
    output [3:0] ALUControl
);

    
    // Opcode R-type = 0110011 and funct7 = 0000001
    wire is_rtype = (Op == 7'b0110011);
    wire is_m_ext = is_rtype && (funct7 == 7'b0000001);

    assign ALUControl =
        // ALUOp = 00: lw / sw / jal / LUI / AUIPC -> ADD
        (ALUOp == 2'b00) ? 4'b0000 :

        // ALUOp = 01: B-type compare -> SUB
        (ALUOp == 2'b01) ? 4'b0001 :

       
        // ALUOp = 10: R-type, I-type ALU, and RV32M
     

        // RV32M extension
        ((ALUOp == 2'b10) && is_m_ext && (funct3 == 3'b000)) ? 4'b1001 : // MUL
        ((ALUOp == 2'b10) && is_m_ext && (funct3 == 3'b001)) ? 4'b1010 : // MULH
        ((ALUOp == 2'b10) && is_m_ext && (funct3 == 3'b010)) ? 4'b1011 : // MULHSU
        ((ALUOp == 2'b10) && is_m_ext && (funct3 == 3'b011)) ? 4'b1100 : // MULHU
        ((ALUOp == 2'b10) && is_m_ext && (funct3 == 3'b100)) ? 4'b1101 : // DIV
        ((ALUOp == 2'b10) && is_m_ext && (funct3 == 3'b101)) ? 4'b1110 : // DIVU
        ((ALUOp == 2'b10) && is_m_ext && (funct3 == 3'b110)) ? 4'b1111 : // REM
       
        

        // Normal R-type / I-type ALU
        ((ALUOp == 2'b10) && !is_m_ext && (funct3 == 3'b000) && ({Op[5], funct7[5]} != 2'b11)) ? 4'b0000 : // ADD / ADDI
        ((ALUOp == 2'b10) && !is_m_ext && (funct3 == 3'b000) && ({Op[5], funct7[5]} == 2'b11)) ? 4'b0001 : // SUB
        ((ALUOp == 2'b10) && !is_m_ext && (funct3 == 3'b111))                                  ? 4'b0010 : // AND / ANDI
        ((ALUOp == 2'b10) && !is_m_ext && (funct3 == 3'b110))                                  ? 4'b0011 : // OR  / ORI
        ((ALUOp == 2'b10) && !is_m_ext && (funct3 == 3'b100))                                  ? 4'b0100 : // XOR / XORI
        ((ALUOp == 2'b10) && !is_m_ext && (funct3 == 3'b010))                                  ? 4'b0101 : // SLT / SLTI
        ((ALUOp == 2'b10) && !is_m_ext && (funct3 == 3'b001))                                  ? 4'b0110 : // SLL / SLLI
        ((ALUOp == 2'b10) && !is_m_ext && (funct3 == 3'b101) && (funct7[5] == 1'b0))            ? 4'b0111 : // SRL / SRLI
        ((ALUOp == 2'b10) && !is_m_ext && (funct3 == 3'b101) && (funct7[5] == 1'b1))            ? 4'b1000 : // SRA / SRAI

        4'b0000; // default ADD

endmodule
