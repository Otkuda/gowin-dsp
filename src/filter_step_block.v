`timescale 1ns/1ps
`default_nettype none

module filter_block_step #(
    parameter WIDTH_X = 32,
    parameter WIDTH_Y = 32
) (
    input  wire clk, // clock
    input  wire rst, // positive active reset
    input  wire ena, // enable

    input  wire [WIDTH_X-1:0] x_in, // input signal
    input  wire [WIDTH_X-1:0] b_in,
    input  wire [WIDTH_Y-1:0] y_in,
    output wire [WIDTH_X-1:0] x_out,
    output wire [WIDTH_Y-1:0] y_out
);
    
wire [WIDTH_X-1:0] x_out_wire;
wire [WIDTH_Y-1:0] y_out_wire;

dff #(.WIDTH(WIDTH_X)) dff_inst (
    .clk    (clk),
    .rst    (rst),
    .c_ena  (ena),
    .d      (x_in),
    .q      (x_out_wire)
);

Gowin_MULTALU mult_add_inst (
    .dout   (y_out_wire), // [53:0] output
    .caso   (), 
    .a      (x_in), // [17:0] input
    .b      (b_in),  // [17:0] input
    .c      (y_in)   // [53:0] input
);

assign x_out = x_out_wire;
assign y_out = y_out_wire;

endmodule
