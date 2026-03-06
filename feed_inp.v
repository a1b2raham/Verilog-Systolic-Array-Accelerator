`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2026 22:25:19
// Design Name: 
// Module Name: feed_inp
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


module feed_inp #( parameter dim = 2, parameter width = 32, parameter n= 32'hACE1)(
    input clk,
    input rst,
    input en,
    output reg [dim*width*(2*dim -1) - 1: 0] row_in_flat,
    output reg [dim*width*(2*dim -1) - 1: 0] col_in_flat,
    
    output reg complete
    );
    integer k;
    

    wire [width-1:0] out_row [dim-1:0];
    wire [width-1:0] out_col [dim-1:0];
    reg [7:0] temp;
    reg [7:0] num;
    genvar i;
    generate 
    
    for( i = 0; i<dim; i =i+1)begin
 
            lfsr #( .n(n+i)) row_ifsr (.clk(clk),.rst(rst), .en(en),.data_out(out_row[i]));
            lfsr #( .n(n+i)) col_ifsr (.clk(clk),.rst(rst), .en(en),.data_out(out_col[i]));
  // making ifsr for each row of 2 matrix
    end
    
   endgenerate
    always @(posedge clk or posedge rst)
    begin
       
        if(rst)
            begin
                    row_in_flat <= 0;
                    col_in_flat <= 0;
                    num <= 0;
                    complete <= 1'b0;
            end
        else
            begin
                if(num < dim)begin
                    for(k=num;k<((2*dim-1)*dim); k=k+(2*dim))begin // for 3*3 positions to be filled in flat matrix (0,6,12) (1,7,13) (2,8,14)
                        row_in_flat[width*k +: width] <= out_row[(k-num)/(2*dim)];
                        col_in_flat[width*k +: width] <= out_col[(k-num)/(2*dim)];
                    
                    end
                    num <= num + 1;// keeps track of number of cycles
                end
                else
                    complete <= 1'b1; // finished signal for staggered matrix (flat)
            end    
    end   
    
    

    
endmodule
