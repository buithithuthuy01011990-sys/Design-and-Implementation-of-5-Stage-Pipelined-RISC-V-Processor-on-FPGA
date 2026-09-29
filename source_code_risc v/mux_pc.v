module Mux (a,b,select,c);

    input [31:0]a,b;
    input select;
    output [31:0]c;
    assign c = (select == 0) ? a : b;
    
endmodule

module Mux_3_by_1 (a,b,c,select,d);
    input [31:0] a,b,c;
    input [1:0] select;
    output [31:0] d;

    assign d = (select == 2'b00) ? a : (select == 2'b01) ? b : (select == 2'b10) ? c : 32'h00000000;
    
endmodule