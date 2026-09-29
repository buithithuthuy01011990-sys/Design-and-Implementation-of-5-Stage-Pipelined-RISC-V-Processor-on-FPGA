module apb_uart_bridge
  #(
    parameter DVSR   = 27,
              FIFO_W = 4
  )
  (
    input  wire        PCLK,
    input  wire        PRESETn,
    input  wire        PSEL,
    input  wire        PENABLE,
    input  wire        PWRITE,
    input  wire [3:0]  PADDR,
    input  wire [31:0] PWDATA,
    output reg  [31:0] PRDATA,   
    output wire        PREADY,
    output wire        PSLVERR,
    input  wire        RX,
    output wire        TX
  );

    assign PREADY  = 1'b1;
    assign PSLVERR = 1'b0;

    // RX 
    reg rx_sync1, rx_sync2;
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn)
            {rx_sync2, rx_sync1} <= 2'b11;
        else
            {rx_sync2, rx_sync1} <= {rx_sync1, RX};
    end

    wire [7:0] r_data;
    wire       rx_empty;
    wire       tx_full;

    // APB decode
    // PADDR[3:2]:
    //   2'b00 = TX data (write)
    //   2'b01 = RX data (read)
    //   2'b10 = Status  (read): bit[1]=tx_full, bit[0]=rx_empty

    wire apb_write = PSEL & PENABLE &  PWRITE;
    wire apb_read  = PSEL & PENABLE & ~PWRITE;
    wire wr_uart   = apb_write & (PADDR[3:2] == 2'b00);
    wire rd_uart   = apb_read  & (PADDR[3:2] == 2'b01);

    // TX data register
    reg [7:0] w_data_reg;
    reg       wr_uart_reg;
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            w_data_reg  <= 8'h00;
            wr_uart_reg <= 1'b0;
        end else begin
            w_data_reg  <= wr_uart ? PWDATA[7:0] : w_data_reg;
            wr_uart_reg <= wr_uart;
        end
    end

   
    always @(*) begin
        if (apb_read) begin
            case (PADDR[3:2])
                2'b01:   PRDATA = {24'h0, r_data};           // RX data
                2'b10:   PRDATA = {30'h0, tx_full, rx_empty}; // Status
                default: PRDATA = 32'h0;
            endcase
        end else begin
            PRDATA = 32'h0;
        end
    end

    uart_top #(
        .DBIT    (8),
        .SB_TICK (16),
        .DVSR    (DVSR),
        .FIFO_W  (FIFO_W)
    ) uart_inst (
        .CLK      (PCLK),
        .reset    (~PRESETn),
        .RX       (rx_sync2),
        .TX       (TX),
        .r_data   (r_data),
        .rd_uart  (rd_uart),
        .rx_empty (rx_empty),
        .w_data   (w_data_reg),
        .wr_uart  (wr_uart_reg),
        .tx_full  (tx_full)
    );

endmodule