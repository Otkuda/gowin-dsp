`timescale 1ns/1ps
module top_tb();

parameter CLK_PER = 20;

GSR GSR(.GSRI(1'b1));

logic clk, rst, ena;

logic [17:0] x_in;
logic [53:0] dout;

top dut (
    .*
);

always #(CLK_PER / 2) clk = ~clk;

// set everything to 0
initial begin
    x_in = 0;
    rst  = 0;
    clk  = 0;
    ena  = 0;
end

initial begin
    #(CLK_PER);
    rst = 1;
    #(CLK_PER);
    rst = 0;
    #(CLK_PER);

    ena = 1;
    #(CLK_PER);
    x_in = 1000;
    #(CLK_PER);
    x_in = 0;
    #500;
    $stop;
end

endmodule