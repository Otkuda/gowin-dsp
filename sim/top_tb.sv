`timescale 1ns/1ps
module top_tb();

GSR GSR(.GSRI(1'b1));

logic clk, rst;

logic [17:0] r;
logic [53:0] dout;

top dut (
    .*
);

always #20 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    #50;
    rst = 0;
    r = 1;
    #40;
    r = 2;
    #40;
    r = 3;
    #150;
    $stop;
end

endmodule