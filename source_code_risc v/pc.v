module pc (
    input              clk,
    input              reset,
    input StallF, StallD, 
    input      [31:0]  pc_next,
    output reg [31:0]  pc_current
);

    always @(posedge clk or posedge reset) 
    begin
        if (reset)// reset =1 
            pc_current <= 32'h0000_0000;
         else if (!StallF) // stallf=0  
            pc_current <= pc_next;
    end

endmodule