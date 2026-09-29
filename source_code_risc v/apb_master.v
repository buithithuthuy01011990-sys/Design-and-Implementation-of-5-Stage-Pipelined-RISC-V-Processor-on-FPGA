module mem_to_apb_master
 (
    input  wire        clk,
    input  wire        reset,
    input  wire [31:0] ALU_ResultM,
    input  wire [31:0] WriteDataM,
    input  wire        MemWriteM,
    input  wire        MemReadM,
    output reg  [31:0] ReadDataM,

    // APB master outputs
    output reg         PSEL,
    output reg         PENABLE,
    output reg         PWRITE,
    output reg  [31:0] PADDR,     
    output reg  [31:0] PWDATA,

    // APB slave inputs
    input  wire [31:0] PRDATA,
    input  wire        PREADY,

    output wire        apb_stall
);

    
    wire uart_sel = (ALU_ResultM[31:4] == 28'h4000000);
    wire apb_req  = uart_sel & (MemWriteM | MemReadM);

    localparam [1:0]
        IDLE   = 2'd0,
        SETUP  = 2'd1,
        ACCESS = 2'd2;

    reg [1:0]  state, state_next;

    reg [31:0] addr_lat, wdata_lat;
    reg wr_lat;

    wire latch_en = (state == IDLE   &&  apb_req) | (state == ACCESS && PREADY && apb_req);

    localparam WATCHDOG_MAX = 8'd255;
    
    
    reg [7:0] watchdog_cnt;
    wire      watchdog_hit = (watchdog_cnt == WATCHDOG_MAX);

    always @(posedge clk or posedge reset) 
    begin
        if (reset)
            watchdog_cnt <= 8'd0;
        else if (state == ACCESS && !PREADY)
            watchdog_cnt <= watchdog_cnt + 8'd1;
        else
            watchdog_cnt <= 8'd0;
    end

    always @(posedge clk or posedge reset) 
    begin
        if (reset) 
        begin
            state     <= IDLE;
            addr_lat  <= 32'h0;
            wdata_lat <= 32'h0;
            wr_lat    <= 1'b0;
        end else 
        begin
            state <= state_next;
            if (latch_en)
             begin
                addr_lat  <= ALU_ResultM;
                wdata_lat <= WriteDataM;
                wr_lat    <= MemWriteM;
            end
        end
    end

    always @(*) begin
        state_next = state;
        PSEL       = 1'b0;
        PENABLE    = 1'b0;
        PWRITE     = 1'b0;
        PADDR      = 32'h0;
        PWDATA     = 32'h0;

        case (state)
            IDLE: 
            begin
                if (apb_req)
                    state_next = SETUP;
            end

            SETUP:
             begin
                PSEL       = 1'b1;
                PENABLE    = 1'b0;
                PWRITE     = wr_lat;
                PADDR      = addr_lat;
                PWDATA     = wdata_lat;
                state_next = ACCESS;
            end

            ACCESS: 
            begin
                PSEL    = 1'b1;
                PENABLE = 1'b1;
                PWRITE  = wr_lat;
                PADDR   = addr_lat;
                PWDATA  = wdata_lat;

                if (PREADY) 
                begin
                    
                    if (apb_req)
                        state_next = SETUP;
                    else
                        state_next = IDLE;
                end else if (watchdog_hit) 
                
                begin
                    state_next = IDLE;
                end
            end

            default: state_next = IDLE;
        endcase
    end

    always @(posedge clk or posedge reset) 
    begin
        if (reset)
            ReadDataM <= 32'h0;
        else if (state == ACCESS && PREADY && !wr_lat)
            ReadDataM <= PRDATA;
    end

    assign apb_stall = apb_req | (state == SETUP)  | (state == ACCESS && !PREADY);

endmodule