`timescale 1ns/1ps
module top_tb();

parameter CLK_PER = 20;

GSR GSR(.GSRI(1'b1));

logic clk, rst, ena;

logic write;
logic [6:0] adr_in;

logic [17:0] x_in;
logic [53:0] dout;

top dut (
    .*
);

task write_x (input [6:0] end_addr);
    integer i;
    write = 1;
    for (i = 0; i < end_addr; i = i + 1) begin
        adr_in = i;
        x_in = i + 1;
        #20;
    end
    write = 0;
endtask

always #(CLK_PER / 2) clk = ~clk;

// set everything to 0
initial begin
    x_in = 0;
    rst  = 0;
    clk  = 0;
    ena  = 0;
    write = 0;
    adr_in = 0;
    x_in = 0;
end

initial begin
    #(CLK_PER);
    rst = 1;
    #(CLK_PER);
    rst = 0;
    #(CLK_PER);

    ena = 1;
    #(CLK_PER);
    write_x(64);
    #500;
    $stop;
end

endmodule