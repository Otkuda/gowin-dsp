
module filter_block_step #(
    parameter WIDTH_X = 32,
    parameter WIDTH_Y = 32
) (
    input  wire clk, // clock
    input  wire rst, // positive active reset
    input  wire ena, // enable

    input  wire signed [WIDTH_X-1:0] x_in, // input signal
    input  wire signed [WIDTH_X-1:0] b_in,
    input  wire signed [WIDTH_Y-1:0] y_in,
    output reg  signed [WIDTH_X-1:0] x_out,
    output reg  signed [WIDTH_Y-1:0] y_out
);
    
dff #(.WIDTH(WIDTH_X)) dff_inst (
    .clk    (clk),
    .rst    (rst),
    .c_ena  (ena),
    .d      (x_in),
    .q      (x_out)
);

Gowin_MULTALU mult_add_inst (
    .dout   (y_out), // [53:0] output
    .caso   (), 
    .a      (x_in), // [17:0] input
    .b      (b_in),  // [17:0] input
    .c      (y_in)   // [53:0] input
);

endmodule
