`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.02.2026 18:24:18
// Design Name: 
// Module Name: PISO
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


module PISO #(parameter n=3, parameter width = 32)( // n = 2x-1 (where x is the number of rows or columns)
    input clk,
    input rst,
    input load,
    input  [width*n-1:0] p_in ,
    output reg [width-1:0] out
    );
    integer k;
    reg [width-1:0] register [n-1:0];
    
    always @(posedge clk or posedge rst)
        begin
            if(rst)
                begin
                    out <= 0;
                    for(k=0;k<n;k=k+1)begin
                        register[k] <= 0;
                    end
                end
            else if(load)
                begin
                    for (k = 0; k < n; k = k + 1) begin
                        register[k] <= p_in[k*width +: width];
                    end
                end
            else
                begin
                     out <= register[0];
                     for(k=0;k < n-1; k= k+1)begin
                        register[k] <= register[k+1];
                     end
                     register[n-1] <= 0;
                end
            
        end
    
endmodule
