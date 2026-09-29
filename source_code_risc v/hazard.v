module hazard_unit(
    input        reset,
    input        PCSrcE,

    input        RegWriteM,
    input        RegWriteW,
    input [4:0]  RD_M, RD_W,
    input [4:0]  Rs1_E, Rs2_E,
    output [1:0] ForwardAE, ForwardBE,

    input        ResultSrcE_0,
    input [4:0]  RD_E,
    input [4:0]  Rs1_D, Rs2_D,
    output       StallF,
    output       StallD,
    output       FlushE,
    output       FlushD
);

    assign ForwardAE =
        (reset) ? 2'b00 :
        ((RegWriteM) && (RD_M != 5'h0) && (RD_M == Rs1_E)) ? 2'b10 :
        ((RegWriteW) && (RD_W != 5'h0) && (RD_W == Rs1_E)) ? 2'b01 :
        2'b00;

    assign ForwardBE =
        (reset) ? 2'b00 :
        ((RegWriteM) && (RD_M != 5'h0) && (RD_M == Rs2_E)) ? 2'b10 :
        ((RegWriteW) && (RD_W != 5'h0) && (RD_W == Rs2_E)) ? 2'b01 :
        2'b00;

    wire load_use_hazard;

    assign load_use_hazard =
        ResultSrcE_0 &&
        ((RD_E == Rs1_D) || (RD_E == Rs2_D));

    assign StallF = load_use_hazard;
    assign StallD = load_use_hazard;

    assign FlushD = PCSrcE;
    assign FlushE = load_use_hazard | PCSrcE;

endmodule
