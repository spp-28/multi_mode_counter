# SPDX-FileCopyrightText: © 2025 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_multimode_counter(dut):
    dut._log.info("Start Multi-Mode Counter Test")

    # Start clock (10 us period)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut.rst_n.value = 0
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Counter after reset: %s", dut.uo_out.value)

    # Example: select UP counting mode (uio_in[1:0] = 00)
    dut.uio_in.value = 0b00
    await ClockCycles(dut.clk, 5)
    dut._log.info("Counter after 5 UP cycles: %s", dut.uo_out.value)

    # Example: select DOWN counting mode (uio_in[1:0] = 01)
    dut.uio_in.value = 0b01
    await ClockCycles(dut.clk, 5)
    dut._log.info("Counter after 5 DOWN cycles: %s", dut.uo_out.value)

    # Example: select UP/DOWN toggle mode (uio_in[1:0] = 10)
    dut.uio_in.value = 0b10
    await ClockCycles(dut.clk, 20)
    dut._log.info("Counter after 20 UP/DOWN toggle cycles: %s", dut.uo_out.value)

    # You can add assertions based on expected count values here
