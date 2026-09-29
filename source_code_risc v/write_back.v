
module writeback_cycle(clk, reset, ResultSrcW, PCPlus4W, ALU_ResultW, ReadDataW, ResultW);


input clk, reset;
input [1:0] ResultSrcW;
input [31:0] PCPlus4W, ALU_ResultW, ReadDataW;

output [31:0] ResultW;

Mux_3_by_1 result_mux (
        .a      (ALU_ResultW),  
        .b      (ReadDataW),   
        .c      (PCPlus4W),     
        .select (ResultSrcW),
        .d      (ResultW)
    );
endmodule
