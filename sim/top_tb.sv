`timescale 1ns/1ps
module top_tb();

GSR GSR(.GSRI(1'b1));

logic clk, rst, ena;

logic [17:0] x_in;
logic [53:0] dout;

top dut (
    .*
);

always #20 clk = ~clk;

initial begin
    x_in = 0;
    ena = 1;
    clk = 0;
    rst = 1;
    #50;
    rst = 0;
    #40;
    x_in = 1000;
    #40;
    x_in = 0;
    #500;
    $stop;
end

endmodule