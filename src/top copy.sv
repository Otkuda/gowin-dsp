`timescale 1ns/1ps
module top(
    input logic clk,
    input logic rst,

    input logic [17:0] r,
    output logic [53:0] dout
);

logic [17:0] r_pipe [1:0];

logic [17:0] coef [2:0];
logic [53:0] y [2:0];



initial begin
    coef[0] = 1;
    coef[1] = 2;
    coef[2] = 3;
end

always_ff @(posedge clk) begin : blockName
    if (rst) begin
        r_pipe <= '{default: 0};
        y <= '{default: 0};
    end
    else r_pipe <= {r_pipe[0], r}; 
end

Gowin_MULTALU inst1 (
    .dout(y[0]), //output [53:0] dout
    .caso(), //output [54:0] caso
    .a(r), //input [17:0] a
    .b(coef[0]), //input [17:0] b
    .c('0), //input [53:0] c
    .ce('1),
    .clk(clk),
    .reset(rst)
);

Gowin_MULTALU inst2 (
    .dout(y[1]), //output [53:0] dout
    .caso(), //output [54:0] caso
    .a(r_pipe[0]), //input [17:0] a
    .b(coef[1]), //input [17:0] b
    .c(y[0]), //input [53:0] c
    .ce('1),
    .clk(clk),
    .reset(rst)
);

Gowin_MULTALU inst3 (
    .dout(y[2]), //output [53:0] dout
    .caso(), //output [54:0] caso
    .a(r_pipe[1]), //input [17:0] a
    .b(coef[2]), //input [17:0] b
    .c(y[1]), //input [53:0] c
    .ce('1),
    .clk(clk),
    .reset(rst)
);

assign dout = y[2];

endmodule
