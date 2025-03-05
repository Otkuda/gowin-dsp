`timescale 1ns/1ps
`default_nettype none

module top #(
    parameter order = 5
) (
    input wire clk,
    input wire rst,
    input wire ena,

    input wire signed [17:0] x_in,
    output wire signed [53:0] dout
);

wire signed [17:0] b [order+1:0];
wire signed [17:0] x_reg;

wire signed [53:0] dout_wire;


// first 6 real values of ifft of inverse step function
// resulting in sinc(x) = sin(x)/x
assign b[0] = 18'd200;
assign b[1] = 18'd152;
assign b[2] = 18'd48;
assign b[3] = -18'd30;
assign b[4] = -18'd37;
assign b[5] = 18'd0;


dff #(.WIDTH(18)) sync_reg_inst (
    .clk    (clk),
    .rst    (rst),
    .c_ena  (ena),
    .d      (x_in),
    .q      (x_reg)
);

wire signed [(order*18)-1:0] x_wire;
wire signed [(order*54)-1:0] y_wire;

genvar i;
generate
    for (i = 0; i < order + 1; i= i + 1) begin : for_loop
        if (i == 0) begin
            filter_block_step #(
                .WIDTH_X(18),
                .WIDTH_Y(54)
            ) filter_inst0 (
                .clk    (clk),
                .rst    (rst),
                .ena    (ena),
                .x_in   (x_reg),
                .x_out  (x_wire[17:0]),
                .y_in   (54'd0),
                .y_out  (y_wire[53:0]),
                .b_in   (b[i])
            );
        end else if (i != order) begin
            filter_block_step #(
                .WIDTH_X(18),
                .WIDTH_Y(54)
            ) filter_inst1 (
                .clk    (clk),
                .rst    (rst),
                .ena    (ena),
                .x_in   (x_wire[i*18-1:(i-1)*18]),
                .x_out  (x_wire[(i+1)*18-1:i*18]),
                .y_in   (y_wire[i*54-1:(i-1)*54]),
                .y_out  (y_wire[(i+1)*54-1:i*54]),
                .b_in   (b[i])
            );
        end else begin
            filter_block_step #(
                .WIDTH_X(18),
                .WIDTH_Y(54)
            ) filter_inst2 (
                .clk    (clk),
                .rst    (rst),
                .ena    (ena),
                .x_in   (x_wire[order*18-1:(order-1)*18]),
                .x_out  (),
                .y_in   (y_wire[order*54-1:(order-1)*54]),
                .y_out  (dout_wire),
                .b_in   (b[i])
            );
        end
    end
endgenerate

assign dout = dout_wire;

endmodule
