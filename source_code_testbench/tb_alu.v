 `timescale 1ns/1ps

module ALU_tb;


    reg  [31:0] A, B;
    reg  [3:0]  ALUControl;
    wire [31:0] Result;
    wire OverFlow, Carry, Zero, Negative;


    ALU dut
    (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .OverFlow(OverFlow),
        .Carry(Carry),
        .Zero(Zero),
        .Negative(Negative)
    );
    
    initial begin
    $display("ALU TEST");

    // ADD
    A=10; B=5; ALUControl=4'b0000;
    #5;
    $display("ADD: A=%d B=%d Result=%d Z=%b", A, B, Result, Zero);

    // ADD zero
    A=0; B=0; ALUControl=4'b0000;
    #5;
    $display("ADD zero: Result=%d Z=%b", Result, Zero);

    // SUB
    A=10; B=5; ALUControl=4'b0001;
    #5;
    $display("SUB: Result=%d Z=%b", Result, Zero);

    // AND
    A=32'hFF; B=32'h0F; ALUControl=4'b0010;
    #5;
    $display("AND: Result=%h", Result);

    // OR
    A=32'hF0; B=32'h0F; ALUControl=4'b0011;
    #5;
    $display("OR: Result=%h", Result);

    // XOR
    A=32'hFF; B=32'hFF; ALUControl=4'b0100;
    #5;
    $display("XOR: Result=%h Z=%b", Result, Zero);

    // SLT
    A=3; B=5; ALUControl=4'b0101;
    #5;
    $display("SLT(3<5): Result=%d", Result);

    A=5; B=3; ALUControl=4'b0101;
    #5;
    $display("SLT(5<3): Result=%d", Result);

    // MUL
    A=6; B=7; ALUControl=4'b1000;
    #5;
    $display("MUL: Result=%d", Result);

    // DIV
    A=20; B=5; ALUControl=4'b1100;
    #5;
    $display("DIV: Result=%d", Result);

    // REM
    A=10; B=3; ALUControl=4'b1110;
    #5;
    $display("REM: Result=%d", Result);
    // SUB âm
    A = 5; B = 10; ALUControl = 4'b0001;
    #5;
    $display("SUB negative: Result=%d Neg=%b", Result, Negative);
    
    // ADD âm
    A = -3; B = 1; ALUControl = 4'b0000;
    #5;
    $display("ADD negative: Result=%d Neg=%b", Result, Negative);
    
    // SLT 
    A = -1; B = 1; ALUControl = 4'b0101;
    #5;
    $display("SLT(-1 < 1): Result=%d", Result);
    

    $finish;
end
endmodule 