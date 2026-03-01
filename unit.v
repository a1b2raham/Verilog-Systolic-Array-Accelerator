`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.02.2026 18:15:00
// Design Name: 
// Module Name: unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module unit #(parameter width = 32)(
    input clk,
    input rst,
    input [width - 1:0] west,
    input [width-1:0] north,
    output reg [width-1:0] east,
    output reg [width-1:0] south,
    output reg [width*2:0] result
    );

    always @(posedge clk or posedge rst)
        if(rst)
            begin
                result <= 0;
                south <= 0;
                east <= 0;
            end
         else
            begin
                result <= result + (north*west);
                east <= west; 
                south <= north;
            end

endmodule
