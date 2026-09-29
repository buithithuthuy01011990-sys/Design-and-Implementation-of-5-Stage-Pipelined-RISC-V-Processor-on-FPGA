module baud_generator
  #(
    parameter DIV = 27,
    parameter DIV_BIT = $clog2(DIV)   
  )
  (
    input  wire clk,
    input  wire reset,
    output wire tick
  );

  reg [DIV_BIT-1:0] cnt_reg, cnt_next;

  // Register
  always @(posedge clk or posedge reset)
    if (reset)
      cnt_reg <= 0;
    else
      cnt_reg <= cnt_next;

  // Next-state logic
  always @(*)
    if (cnt_reg == DIV - 1)
      cnt_next = 0;
    else
      cnt_next = cnt_reg + 1;

  
  assign tick = (cnt_reg == DIV - 1);

endmodule