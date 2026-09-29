###############################################################################
# constraints.xdc
# Design: riscv_uart_soc
# Tool  : Xilinx Vivado
#
# System clock:
# - clk = 50 MHz
# - period = 20 ns
#
# Notes:
# - UART baud rate is generated internally by baud_generator, so UART baud is
#   not constrained as a separate clock.
# - reset and uart_rx are asynchronous board inputs.
# - Debug outputs are observation-only pins. They are given explicit output
#   delays so Vivado check_timing does not report no_output_delay warnings.
###############################################################################

###############################################################################
# Primary Clock
###############################################################################

create_clock -name sys_clk -period 20.000 [get_ports clk]

###############################################################################
# Asynchronous Inputs
###############################################################################

# Active-high asynchronous reset.
#
# The input delays are placeholders to satisfy check_timing. The false path keeps
# reset from being analyzed as normal synchronous data.
set_input_delay -clock [get_clocks sys_clk] -max 2.000 [get_ports reset]
set_input_delay -clock [get_clocks sys_clk] -min 0.000 [get_ports reset]
set_false_path -from [get_ports reset]

# UART RX is asynchronous to sys_clk at the FPGA pin. The RTL has an RX
# synchronizer inside apb_uart_bridge. The input delays are placeholders to
# satisfy check_timing; the false path prevents normal synchronous timing on the
# async pin-to-synchronizer path.
set_input_delay -clock [get_clocks sys_clk] -max 2.000 [get_ports uart_rx]
set_input_delay -clock [get_clocks sys_clk] -min 0.000 [get_ports uart_rx]
set_false_path -from [get_ports uart_rx]

###############################################################################
# UART TX Output Timing
#
# Write max/min explicitly to avoid XDCH methodology warnings about identical
# implicit max/min output delays.
###############################################################################

set_output_delay -clock [get_clocks sys_clk] -max 2.000 [get_ports uart_tx]
set_output_delay -clock [get_clocks sys_clk] -min 0.000 [get_ports uart_tx]

###############################################################################
# Debug Outputs
#
# These ports are for observation/debug only:
# - dbg_ALU_ResultM
# - dbg_WriteDataM
# - dbg_MemWriteM
#
# They are not intended to drive a synchronous external device. The explicit
# max/min delays are placeholders to satisfy check_timing.
###############################################################################

set_output_delay -clock [get_clocks sys_clk] -max 2.000 [get_ports {dbg_ALU_ResultM[*]}]
set_output_delay -clock [get_clocks sys_clk] -min 0.000 [get_ports {dbg_ALU_ResultM[*]}]

set_output_delay -clock [get_clocks sys_clk] -max 2.000 [get_ports {dbg_WriteDataM[*]}]
set_output_delay -clock [get_clocks sys_clk] -min 0.000 [get_ports {dbg_WriteDataM[*]}]

set_output_delay -clock [get_clocks sys_clk] -max 2.000 [get_ports dbg_MemWriteM]
set_output_delay -clock [get_clocks sys_clk] -min 0.000 [get_ports dbg_MemWriteM]

###############################################################################
# Optional Input/Output Delay Template
#
# If uart_tx or other outputs are later connected to a synchronous external
# device, replace false paths/output placeholders with real board timing:
#
# set_input_delay  -clock [get_clocks sys_clk] -max <max_ns> [get_ports <port>]
# set_input_delay  -clock [get_clocks sys_clk] -min <min_ns> [get_ports <port>]
# set_output_delay -clock [get_clocks sys_clk] -max <max_ns> [get_ports <port>]
# set_output_delay -clock [get_clocks sys_clk] -min <min_ns> [get_ports <port>]
###############################################################################
