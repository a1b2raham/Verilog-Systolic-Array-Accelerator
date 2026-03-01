`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.02.2026 22:06:45
// Design Name: 
// Module Name: top
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


module top #(parameter width = 32, parameter dim = 2)(
    input clk,
    input rst,
    input load,
    
    input [dim*width*(2*dim-1) -1 : 0] row_in,      // input wire to piso flattened ie for 2*2 it contains 3*2*32-1 : 0
    input [dim*width*(2*dim-1) -1 : 0] col_in,       // input wire to piso flattened
    
    output [(width*2 +1)*dim*dim -1 : 0] f_result
    );
    localparam PIS0_w = width*(2*dim -1);// size of one feeder row
    localparam res_w = width*2 +1;// size of one result
    
     wire [width-1:0] h_wire [0:dim-1][0:dim];
     wire [width-1:0] v_wire [0:dim][0:dim-1];
     wire [res_w-1:0] res [0:dim-1][0:dim-1];
    
    
    
    genvar i,j;
    generate
    
    for(i=0;i<dim;i=i+1)begin:feeder
    // row piso+
        PISO #(.n(2*dim-1),.width(width)) row_piso(
            .clk(clk),.rst(rst),.load(load),.p_in(row_in[i*width*(2*dim-1)+: width*(2*dim-1)]),
            .out(h_wire[i][0])
            );
     // col piso
        PISO #(.n(2*dim-1),.width(width)) col_piso(
            .clk(clk),.rst(rst),.load(load),.p_in(col_in[i*width*(2*dim-1) +: width*(2*dim-1)]),
            .out(v_wire[0][i])
            );
    end
    for(i=0;i < dim; i= i+1) begin : row_loop
        for(j=0; j<dim; j= j+1) begin: col_loop
                unit #(.width(width)) block (.clk(clk),.rst(rst),
                .west(h_wire[i][j]),.north(v_wire[i][j]),
                .south(v_wire[i+1][j]),.east(h_wire[i][j+1]),
                .result(res[i][j])
                );
                assign f_result[(i*dim+j)*(2*width +1) +: 2*width +1] = res[i][j];
            end
        end
    endgenerate
    
  
endmodule
