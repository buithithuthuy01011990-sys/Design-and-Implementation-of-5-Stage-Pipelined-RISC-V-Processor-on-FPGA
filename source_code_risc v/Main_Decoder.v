module Main_Decoder(
    input  [6:0] Op,
    output       RegWrite,
    output [2:0] ImmSrc,    
    output       ALUSrc,
    output       MemWrite,
    output [1:0] ResultSrc,
    output       Branch,
    output       Jump,
    output [1:0] ALUOp
);

assign RegWrite =
    (Op == 7'b0000011 |   // lw
     Op == 7'b0110011 |   // R-type
     Op == 7'b0010011 |   // I-type
     Op == 7'b1101111 |   // JAL
     Op == 7'b0110111 |   // LUI
     Op == 7'b0010111) ?  // AUIPC
     1'b1 : 1'b0;

assign ImmSrc =
    (Op == 7'b0100011) ? 3'b001 :  // S-type
    (Op == 7'b1100011) ? 3'b010 :  // B-type
    (Op == 7'b1101111) ? 3'b011 :  // J-type
    (Op == 7'b0110111) ? 3'b100 :  // LUI   
    (Op == 7'b0010111) ? 3'b100 :  // AUIPC 
                         3'b000 ;  // I-type 

assign ALUSrc =
    (Op == 7'b0000011 |   // lw
     Op == 7'b0100011 |   // sw
     Op == 7'b0010011 |   // I-type
     Op == 7'b0110111 |   // LUI
     Op == 7'b0010111) ?  // AUIPC
     1'b1 : 1'b0;

assign MemWrite  = (Op == 7'b0100011) ? 1'b1 : 1'b0;

assign ResultSrc =
    (Op == 7'b0000011) ? 2'b01 :  // lw
    (Op == 7'b1101111) ? 2'b10 :  // JAL
                         2'b00 ;

assign Branch = (Op == 7'b1100011) ? 1'b1 : 1'b0;
assign Jump   = (Op == 7'b1101111) ? 1'b1 : 1'b0;

assign ALUOp =
    (Op == 7'b0110011) ? 2'b10 :  // R-type
    (Op == 7'b0010011) ? 2'b10 :  // I-type ALU
    (Op == 7'b1100011) ? 2'b01 :  // B-type
                         2'b00 ;  

endmodule