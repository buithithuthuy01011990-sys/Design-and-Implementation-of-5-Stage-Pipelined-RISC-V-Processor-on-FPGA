module fifo #(
  parameter DEPTH               = 8,
  parameter WIDTH               = 8,
  parameter ALMOST_FULL_THRESH  = DEPTH - 2,
  parameter ALMOST_EMPTY_THRESH = 1
)(
  input  wire clk,
  input  wire rst_n,       
  input  wire write_en,
  input  wire [WIDTH-1:0]  write_data,
  input  wire read_en,
  output wire [WIDTH-1:0]  read_data,
  output wire full,
  output wire empty,
  output wire almost_full,
  output wire almost_empty
);

  localparam PTR_W = (DEPTH > 1) ? $clog2(DEPTH) : 1;

  reg [WIDTH-1:0]  mem    [0:DEPTH-1];
  reg [PTR_W-1:0]  wr_ptr;
  reg [PTR_W-1:0]  rd_ptr;
  reg [PTR_W:0]    count;

  assign full  = (count == DEPTH);
  assign empty = (count == 0);
  assign almost_full  = (count >= ALMOST_FULL_THRESH);
  assign almost_empty = (count <= ALMOST_EMPTY_THRESH);

  assign read_data = mem[rd_ptr];


  // Write pointer + memory write

  always @(posedge clk or negedge rst_n)
  begin
    if (!rst_n) 
    begin
      wr_ptr <= 0;
    end else if (write_en && !full) 
    begin
      mem[wr_ptr] <= write_data;
      wr_ptr      <= (wr_ptr == DEPTH-1) ? 0 : wr_ptr + 1;
    end
  end

  
  // Read pointer
  
  always @(posedge clk or negedge rst_n)
  begin
    if (!rst_n) 
    begin
      rd_ptr <= 0;
    end else if (read_en && !empty) 
    begin
      rd_ptr <= (rd_ptr == DEPTH-1) ? 0 : rd_ptr + 1;
    end
  end

  
  //  counter

  always @(posedge clk or negedge rst_n) 
  begin
    if (!rst_n) 
    begin
      count <= 0;
    end else 
    begin
      case ({write_en && !full, read_en && !empty})
        2'b10:   count <= count + 1;
        2'b01:   count <= count - 1;
        2'b11:   count <= count;
        default: count <= count;
      endcase
    end
  end

endmodule