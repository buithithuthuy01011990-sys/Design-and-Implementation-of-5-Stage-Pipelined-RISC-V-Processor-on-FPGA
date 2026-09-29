module ins_mem (
    input  [31:0] read_add,
    output [31:0] ins
);

    reg [31:0] mem [0:1023];

    assign ins = mem[read_add[11:2]];

    integer i;

    initial begin
        for (i = 0; i < 1024; i = i + 1) begin
            mem[i] = 32'h00000013;
        end

        if (!$value$plusargs("IMEM_FILE=%s", imem_file)) begin
            $readmemh("firmware.hex", mem);
            $display("[IMEM] Loaded default firmware.hex");
        end else begin
            $readmemh(imem_file, mem);
            $display("[IMEM] Loaded %s", imem_file);
        end
    end

    reg [1023:0] imem_file;

endmodule