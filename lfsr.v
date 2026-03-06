`timescale 1ns / 1ps


module lfsr #(parameter n= 32'hACE1) (
    input clk,
    input rst,
    input en,
    output reg [31:0] data_out
);
    // Polynomial: x^32 + x^22 + x^2 + x^1 + 1
    wire feedback = data_out[31] ^ data_out[21] ^ data_out[1] ^ data_out[0];

    always @(posedge clk) begin
        if (rst) begin
            data_out <= n;
        end else if (en) begin
            data_out <= {data_out[30:0], feedback};
        end
    end
endmodule