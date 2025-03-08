`timescale 1ns/1ps
`default_nettype none

module top #(
    parameter order = 5
) (
    input wire clk,
    input wire rst,
    input wire ena,

    input wire write,
    
    input  wire        [6:0]  adr_in,
    input  wire signed [17:0] x_in,
    output wire signed [53:0] dout
);

wire signed [17:0] b [order+1:0];
wire signed [17:0] x_reg, x_out;

wire signed [53:0] dout_wire;

wire [6:0] x_ptr_int;

localparam IDLE = 0;
localparam WRITE = 1;
localparam READ = 2;

reg [1:0] state = IDLE;

// first 6 real values of ifft of inverse step function
// resulting in sinc(x) = sin(x)/x
assign b[0] = 18'd200;
assign b[1] = 18'd152;
assign b[2] = 18'd48;
assign b[3] = -18'd30;
assign b[4] = -18'd37;
assign b[5] = 18'd0;

reg [6:0] x_ptr, last_adr;

assign x_ptr_int = (write) ?  x_in : x_ptr;

Gowin_SP mem_x(
    .dout(x_out),    //output [17:0] dout
    .clk(clk),      //input clk
    .oce(),         //input oce (output data clock enable)
    .ce(ena),       //input ce (clk_enable)
    .reset(rst),  //input reset
    .wre(write),      //input wre (write enable)
    .ad(x_ptr_int),    //input [6:0] ad (address)
    .din(x_in)      //input [17:0] din (data in)
);

always @(posedge clk) begin
    case (state)
        IDLE: begin
            if (rst) begin
                x_ptr <= 0;
                last_adr <= 0;
            end else begin
                if (write)
                    state <= WRITE;
            end
        end
        WRITE: begin
            if (~write)
                state <= READ;
            else begin
                last_adr <= adr_in;
            end
        end
        READ: begin
            if (x_ptr <= last_adr) begin
                x_ptr <= x_ptr + 1;
            end else
                state = IDLE;
        end
    endcase    
end

dff #(.WIDTH(18)) sync_reg_inst (
    .clk    (clk),
    .rst    (rst),
    .c_ena  (ena),
    .d      (x_out),
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
