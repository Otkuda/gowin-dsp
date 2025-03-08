module mem_example (
    input wire clk,
    input wire reset,
    input wire oce,
    input wire ce,
    input wire wre,

    input wire [6:0] adr_in,
    input wire [17:0] x_in,
    output wire [17:0] dout
);


Gowin_SP mem_x(
    .dout(dout),    //output [17:0] dout
    .clk(clk),      //input clk
    .oce(oce),      //input oce (output data clock enable)
    .ce(ce),       //input ce (clk_enable)
    .reset(reset),  //input reset
    .wre(wre),      //input wre (write enable)
    .ad(adr_in),    //input [6:0] ad (address)
    .din(x_in)      //input [17:0] din (data in)
);

endmodule