module uart_top
#(
    parameter DBIT    = 8,
              SB_TICK = 16,
              DVSR    = 27,
              FIFO_W  = 4
)(
    input  wire        CLK,
    input  wire        reset,
    input  wire        RX,
    output wire        TX,
    output wire [7:0]  r_data,
    input  wire        rd_uart,
    input  wire [7:0]  w_data,
    input  wire        wr_uart,
    output wire        rx_empty,
    output wire        tx_full
);

    
    // Internal signals
    
    wire tick;
    wire rx_done_tick;
    wire tx_done_tick;
    wire [7:0] dout;
    wire [7:0] tx_din;
    
    wire rx_full;
    wire tx_empty;
    
    wire rx_wr_en;
    wire tx_rd_en;
    wire tx_start;

    
    // Baud Rate Generator
    
    baud_generator #(
        .DIV (DVSR)
    ) baud_gen_unit (
        .clk   (CLK),
        .reset (reset),
        .tick  (tick)
    );


    // UART Receiver
    
    uart_rx #(
        .DBIT    (DBIT),
        .SB_TICK (SB_TICK)
    ) receiver_unit (
        .clk          (CLK),
        .reset        (reset),
        .rx           (RX),
        .s_tick       (tick),
        .rx_done_tick (rx_done_tick),
        .dout         (dout)
    );

    
    // RX FIFO
    
    fifo #(
        .DEPTH (2**FIFO_W),
        .WIDTH (DBIT)
    ) rx_fifo_unit (
        .clk         (CLK),
        .rst_n       (~reset),
        .write_en    (rx_wr_en),
        .write_data  (dout),
        .read_en     (rd_uart),
        .read_data   (r_data),
        .full        (rx_full),
        .empty       (rx_empty),
        .almost_full (),
        .almost_empty()
    );

    assign rx_wr_en = rx_done_tick & ~rx_full;

    
    // TX FIFO
    
    fifo #(
        .DEPTH (2**FIFO_W),
        .WIDTH (DBIT)
    ) tx_fifo_unit (
        .clk         (CLK),
        .rst_n       (~reset),
        .write_en    (wr_uart),
        .write_data  (w_data),
        .read_en     (tx_rd_en),
        .read_data   (tx_din),
        .full        (tx_full),
        .empty       (tx_empty),
        .almost_full (),
        .almost_empty()
    );

   
      // TX Control 

    reg        tx_start_reg;
    reg        tx_rd_en_reg;
    reg        tx_busy_reg;
    reg        load_pending;
    reg [7:0]  tx_byte;
    
    assign tx_start = tx_start_reg;
    assign tx_rd_en = tx_rd_en_reg;
    
    always @(posedge CLK or posedge reset) 
    begin
        if (reset) 
        begin
            tx_start_reg <= 1'b0;
            tx_rd_en_reg <= 1'b0;
            tx_busy_reg  <= 1'b0;
            load_pending <= 1'b0;
            tx_byte      <= 8'h00;
        end else 
        begin
            // default pulse
            tx_start_reg <= 1'b0;
            tx_rd_en_reg <= 1'b0;
    
            
            if (!tx_busy_reg && !tx_empty && !load_pending)
             begin
                tx_byte      <= tx_din;
                tx_rd_en_reg <= 1'b1;
                load_pending <= 1'b1;
            end
    
            
            
            else if (load_pending)
             begin
                tx_start_reg <= 1'b1;
                tx_busy_reg  <= 1'b1;
                load_pending <= 1'b0;
            end
    
            
            
            if (tx_done_tick) 
            begin
                tx_busy_reg <= 1'b0;
            end
        end
    end


    // UART Transmitter
 
    uart_tx #(
    .DBIT    (DBIT),
    .SB_TICK (SB_TICK)
) transmitter_unit (
    .clk          (CLK),
    .reset        (reset),
    .tx_start     (tx_start),
    .s_tick       (tick),
    .din          (tx_byte),      
    .tx_done_tick (tx_done_tick),
    .tx           (TX)
);

        always @(posedge CLK) begin
        if (tx_rd_en) begin
            $display("[TX_FIFO_POP] t=%0t tx_din=0x%02h",
                     $time, tx_din);
        end
    
        if (tx_start) begin
            $display("[TX_START] t=%0t tx_byte=0x%02h",
                     $time, tx_byte);
        end
    
        if (tx_done_tick) begin
            $display("[TX_DONE] t=%0t tx_byte=0x%02h",
                     $time, tx_byte);
        end
    end

    
      // DEBUG UART RX
      
      always @(posedge CLK) begin
          if (rx_done_tick) begin
              $display("[UART_RX_DONE] t=%0t dout=0x%02h ('%c')",
                       $time,
                       dout,
                       (dout >= 8'h20 && dout <= 8'h7e) ? dout : 8'h2e);
          end
      
          if (rx_wr_en) begin
              $display("[RX_FIFO_WRITE] t=%0t write_data=0x%02h ('%c')",
                       $time,
                       dout,
                       (dout >= 8'h20 && dout <= 8'h7e) ? dout : 8'h2e);
          end
      
          if (rd_uart) begin
              $display("[RX_FIFO_READ] t=%0t r_data=0x%02h ('%c') rx_empty=%b",
                       $time,
                       r_data,
                       (r_data >= 8'h20 && r_data <= 8'h7e) ? r_data : 8'h2e,
                       rx_empty);
          end
      end
  
endmodule