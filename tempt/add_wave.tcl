# ========================================
# add_wave.tcl - RISC-V UART SoC
# Hierarchy đúng từ find nets
# ========================================

delete wave *

# ── CLOCK / RESET ──────────────────────────────────────────────
add wave -divider "=== CLOCK / RESET ==="
add wave -label "clk"   sim:/tb_riscv_uart_soc/clk
add wave -label "reset" sim:/tb_riscv_uart_soc/reset

# ── TC1 / TC4 / TC5 : CPU Memory Stage ─────────────────────────
add wave -divider "=== TC1/TC4/TC5 : CPU MEMORY STAGE ==="
add wave -label "MemWriteM"   sim:/tb_riscv_uart_soc/dbg_MemWriteM
add wave -label "ALU_ResultM" -radix hex sim:/tb_riscv_uart_soc/dbg_ALU_ResultM
add wave -label "WriteDataM"  -radix hex sim:/tb_riscv_uart_soc/dbg_WriteDataM

# ── APB BUS ─────────────────────────────────────────────────────
add wave -divider "=== APB BUS ==="
add wave -label "PSEL"    sim:/tb_riscv_uart_soc/dut/uart_bridge/PSEL
add wave -label "PENABLE" sim:/tb_riscv_uart_soc/dut/uart_bridge/PENABLE
add wave -label "PWRITE"  sim:/tb_riscv_uart_soc/dut/uart_bridge/PWRITE
add wave -label "PREADY"  sim:/tb_riscv_uart_soc/dut/uart_bridge/PREADY
add wave -label "PSLVERR" sim:/tb_riscv_uart_soc/dut/uart_bridge/PSLVERR
add wave -label "PADDR"   -radix hex sim:/tb_riscv_uart_soc/dut/uart_bridge/PADDR
add wave -label "PWDATA"  -radix hex sim:/tb_riscv_uart_soc/dut/uart_bridge/PWDATA
add wave -label "PRDATA"  -radix hex sim:/tb_riscv_uart_soc/dut/uart_bridge/PRDATA

# ── APB BRIDGE internal ─────────────────────────────────────────
add wave -divider "=== APB UART BRIDGE (internal) ==="
add wave -label "apb_write"   sim:/tb_riscv_uart_soc/dut/uart_bridge/apb_write
add wave -label "apb_read"    sim:/tb_riscv_uart_soc/dut/uart_bridge/apb_read
add wave -label "wr_uart_reg" sim:/tb_riscv_uart_soc/dut/uart_bridge/wr_uart_reg
add wave -label "wr_uart"     sim:/tb_riscv_uart_soc/dut/uart_bridge/wr_uart
add wave -label "rd_uart"     sim:/tb_riscv_uart_soc/dut/uart_bridge/rd_uart
add wave -label "w_data_reg"  -radix hex sim:/tb_riscv_uart_soc/dut/uart_bridge/w_data_reg
add wave -label "r_data"      -radix hex sim:/tb_riscv_uart_soc/dut/uart_bridge/r_data
add wave -label "tx_full"     sim:/tb_riscv_uart_soc/dut/uart_bridge/tx_full
add wave -label "rx_empty"    sim:/tb_riscv_uart_soc/dut/uart_bridge/rx_empty

# ── TX PATH ─────────────────────────────────────────────────────
add wave -divider "=== TX : FIFO → CONTROLLER → PHY ==="
add wave -label "wr_uart"      sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/wr_uart
add wave -label "w_data"       -radix hex sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/w_data
add wave -label "tx_full"      sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/tx_full
add wave -label "tx_empty"     sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/tx_empty
add wave -label "tx_din"       -radix hex sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/tx_din
add wave -label "tx_rd_en"     sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/tx_rd_en_reg
add wave -label "load_pending" sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/load_pending
add wave -label "tx_byte"      -radix hex sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/tx_byte
add wave -label "tx_start"     sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/tx_start_reg
add wave -label "tx_busy"      sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/tx_busy_reg
add wave -label "tx_done_tick" sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/tx_done_tick
add wave -label "uart_tx(phy)" sim:/tb_riscv_uart_soc/uart_tx

# ── TX FIFO internal ────────────────────────────────────────────
add wave -divider "=== TX FIFO (tx_fifo_unit) ==="
add wave -label "write_en"   sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/tx_fifo_unit/write_en
add wave -label "write_data" -radix hex sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/tx_fifo_unit/write_data
add wave -label "read_en"    sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/tx_fifo_unit/read_en
add wave -label "read_data"  -radix hex sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/tx_fifo_unit/read_data
add wave -label "full"       sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/tx_fifo_unit/full
add wave -label "empty"      sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/tx_fifo_unit/empty
add wave -label "count"      sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/tx_fifo_unit/count

# ── TC2 : RX PATH ───────────────────────────────────────────────
add wave -divider "=== TC2 : RX PATH ==="
add wave -label "uart_rx(inject)" sim:/tb_riscv_uart_soc/uart_rx
add wave -label "tick"            sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/tick
add wave -label "rx_done_tick"    sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/rx_done_tick
add wave -label "dout"            -radix hex sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/dout
add wave -label "rx_wr_en"        sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/rx_wr_en
add wave -label "rx_full"         sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/rx_full
add wave -label "rx_empty"        sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/rx_empty
add wave -label "rd_uart"         sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/rd_uart
add wave -label "r_data"          -radix hex sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/r_data

# ── RX FIFO internal ────────────────────────────────────────────
add wave -divider "=== RX FIFO (rx_fifo_unit) ==="
add wave -label "write_en"   sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/rx_fifo_unit/write_en
add wave -label "write_data" -radix hex sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/rx_fifo_unit/write_data
add wave -label "read_en"    sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/rx_fifo_unit/read_en
add wave -label "read_data"  -radix hex sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/rx_fifo_unit/read_data
add wave -label "full"       sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/rx_fifo_unit/full
add wave -label "empty"      sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/rx_fifo_unit/empty
add wave -label "count"      sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/rx_fifo_unit/count

# ── BAUD GENERATOR ──────────────────────────────────────────────
add wave -divider "=== BAUD GENERATOR ==="
add wave -label "cnt_reg"  sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/baud_gen_unit/cnt_reg
add wave -label "baud_tick" sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/baud_gen_unit/tick

# ── TX transmitter_unit ─────────────────────────────────────────
add wave -divider "=== uart_tx (transmitter_unit) ==="
add wave -label "tx_start"   sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/transmitter_unit/tx_start
add wave -label "din"        -radix hex sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/transmitter_unit/din
add wave -label "state"      sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/transmitter_unit/state_reg
add wave -label "b_reg"      sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/transmitter_unit/b_reg
add wave -label "tx_done"    sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/transmitter_unit/tx_done_tick
add wave -label "tx(serial)" sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/transmitter_unit/tx

# ── RX receiver_unit ────────────────────────────────────────────
add wave -divider "=== uart_rx (receiver_unit) ==="
add wave -label "rx(serial)"  sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/receiver_unit/rx
add wave -label "state"       sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/receiver_unit/state_reg
add wave -label "b_reg"       sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/receiver_unit/b_reg
add wave -label "rx_done"     sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/receiver_unit/rx_done_tick
add wave -label "dout"        -radix hex sim:/tb_riscv_uart_soc/dut/uart_bridge/uart_inst/receiver_unit/dout

# ── FORMAT ──────────────────────────────────────────────────────
configure wave -namecolwidth 180
configure wave -valuecolwidth 120
configure wave -timelineunits ns

wave zoom full
