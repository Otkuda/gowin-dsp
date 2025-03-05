import os
from pathlib import Path

from cocotb.runner import get_runner

def test_simple_dff_runner():

    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")
    sim = os.getenv("SIM", "questa")

    verilog_sources = ["../../src/dff.v",]

    runner = get_runner(sim)
    runner.build(
        verilog_sources=verilog_sources,
        hdl_toplevel="dff",
        always=True,
    )

    runner.test(hdl_toplevel="dff", test_module="test_dff", gui=True, waves=True)