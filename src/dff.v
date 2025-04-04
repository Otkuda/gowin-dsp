`timescale 1ns/1ps

module dff #(
    parameter WIDTH=32
) (
    input  wire clk,
    input  wire c_ena,
    input  wire rst,
    input  wire [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
);

always @(posedge clk, posedge rst) begin
    if (rst) q <= 0;
    else begin
        if (c_ena) q <= d;
    end
end

endmodule
