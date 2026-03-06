`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2026 02:19:23
// Design Name: 
// Module Name: final_test
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


module final_test();

parameter dim = 32;
parameter width = 32;
parameter seed = 32'h0003;

localparam res_w = 2*width +1;

reg clk,rst,trig;
integer i,j;
wire [((width*2) +1)*dim*dim -1 : 0] f_result;

final_top #(.dim(dim),.width(width), .n(seed)) final (.clk(clk),.rst(rst),
    .trig(trig),.f_result(f_result));
initial
    clk = 0;
 
always #5 clk = ~clk;

initial
    begin
        rst = 1;
        repeat(3)@(posedge clk);
        rst = 0;
        trig = 1;
        
        wait(final.complete)
        
        repeat(3*dim+2) @(posedge clk); 
    
        $display("--- Final Matrix Result ---");
        for (i = 0; i < dim; i=i+1) begin
             for (j = 0; j < dim; j=j+1) begin

            $write("%0x\t", f_result[(i*dim + j)*res_w +: res_w]);
        end
        $write("\n");
    end

    $finish;

    end


endmodule
