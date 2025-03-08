`timescale 1ns/1ps
module mem_tb();
    
GSR GSR(.GSRI(1'b1));

logic clk;
logic reset;
logic oce;
logic ce;
logic wre;

logic [6:0] adr_in;
logic [17:0] x_in;
logic [17:0] dout;

mem_example uut (.*);

always #10 clk = ~clk;

initial begin
    clk = 0;
    reset = 0;
    oce = 0;
    ce = 0;
    wre = 0;
    adr_in = 0;
    x_in = 0;
    #40;
    reset = 1;
    #40;
    reset = 0;
    ce = 1;
    x_in = 1;
    #20;
    wre = 1;
    #20;
    adr_in = 1;
    x_in = 2;
    #20;
    adr_in = 2;
    x_in = 3;
    #20;
    wre = 0;
    x_in = 10;
    #40;
    adr_in = 0;
    #20;
    adr_in = 1;
    #20;
    adr_in = 2;
    #100;
    $stop;
end

endmodule