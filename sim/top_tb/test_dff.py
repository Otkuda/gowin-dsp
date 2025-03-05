import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer

CLK_PER = 20

class TB:
    def __init__(self, dut):
        self.dut = dut
        
        self.dut.clk.setimmediatevalue(0)
        self.dut.rst.setimmediatevalue(0)
        self.dut.c_ena.setimmediatevalue(0)

        cocotb.start_soon(Clock(self.dut.clk, CLK_PER, 'ns').start())

    async def init(self):
        await self.reset()

    async def reset(self):        
        self.dut.rst.value = 1
        await Timer(CLK_PER * 2, 'ns')
        self.dut.rst.value = 0
        await Timer(CLK_PER * 2, 'ns')


@cocotb.test()
async def dff_test(dut):

    tb = TB(dut)
    
    await tb.init()

    tb.dut.d.value = 32
    await Timer(40, 'ns')

    tb.dut.c_ena.value = 1

    await Timer(40, 'ns')
    await tb.reset()