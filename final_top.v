`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2026 01:38:52
// Design Name: 
// Module Name: final_top
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


module final_top#(parameter dim = 2, parameter width = 32, parameter n= 32'hACE1)(
    input clk,
    input rst,
    input trig,
    
    output [((width*2) +1)*dim*dim -1 : 0] f_result
    
    );
    wire [dim*width*(2*dim -1) - 1: 0] row_in_flat;
    wire [dim*width*(2*dim -1) - 1: 0] col_in_flat;
    wire complete;
    
    wire en;
    
    reg complete_q; 

    always @(posedge clk) begin
        complete_q <= complete;
    end

    wire load_pulse = complete && !complete_q;
    
    feed_inp #(.dim(dim),.width(width),.n(n))  feed (.clk(clk),.rst(rst),.en(en),
                .row_in_flat(row_in_flat),
                .col_in_flat(col_in_flat) ,.complete(complete));
    
    top #(.dim(dim), .width(width)) process (.clk(clk),.rst(rst), .load(load_pulse),
    .row_in(row_in_flat), .col_in(col_in_flat), .f_result(f_result));
    
    assign en = trig && ~complete;
    
endmodule
