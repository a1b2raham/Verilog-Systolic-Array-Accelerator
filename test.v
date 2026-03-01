`timescale 1ns / 1ps

module test();
    // Parameters
    parameter W = 32;
    parameter D = 64;
    localparam RES_W = (W*2) + 1;
    localparam WORDS_PER_PISO = (2*D - 1); 
    localparam P_BITS = W * WORDS_PER_PISO; 

    reg clk, rst, load;
    reg [D*P_BITS-1:0] row_in_flat, col_in_flat;
    wire [(RES_W*D*D)-1:0] f_result;


    top #(.width(W), .dim(D)) uut (
        .clk(clk), .rst(rst), .load(load),
        .row_in(row_in_flat), .col_in(col_in_flat),
        .f_result(f_result)
    );
    integer i,j,k;
   
    initial clk = 0;
    always #5 clk = ~clk;

    integer n =1;
    integer matrix_A [0:D-1][0:D-1];
    integer matrix_B [0:D-1][0:D-1];
    

    initial begin
        // 1. Initialize Matrices 

        for (i = 0; i < D; i = i+1) begin
            for (j = 0; j < D; j = j+1) begin          // A= [1,2,3,4,5
                                                       //     6,7,8,9...]
                matrix_A[i][j] = n; 
                n = n+1;
            end
        end
        
    $display("--- A Matrix ---");
    for (i = 0; i < D; i=i+1) begin
             for (j = 0; j < D; j=j+1) begin

            $write("%0d\t", matrix_A[i][j]);
        end
        $write("\n");
    end  
        
        
      for (i = 0; i < D; i = i+1) begin
            for (j = 0; j < D; j = j+1) begin
                if(i==j)                               // B = identity matrix
                    matrix_B[i][j] = 1;
                else
                    matrix_B[i][j] = 0;
            end
        end
        
     $display("--- B Matrix ---");
        for (i = 0; i < D; i=i+1) begin
             for (j = 0; j < D; j=j+1) begin

            $write("%0d\t", matrix_B[i][j]);
        end
        $write("\n");
    end
        
        
        
        // 2. Build the Staggered Buses 
        row_in_flat = 0;
        col_in_flat = 0;




        for (i = 0; i < D; i=i+1) begin : ROW_CONSTRUCT
            for (k = 0; k < WORDS_PER_PISO; k=k+1) begin
     
                if (k >= i && k < i + D) begin
                    row_in_flat[(i*P_BITS + k*W) +: W] = matrix_A[i][k-i];
                end else begin
                    row_in_flat[(i*P_BITS + k*W) +: W] = 0;
                end
            end
        end




        for (j = 0; j < D; j=j+1) begin : COL_CONSTRUCT
            for (k = 0; k < WORDS_PER_PISO; k=k+1) begin
                if (k >= j && k < j + D) begin
                    col_in_flat[(j*P_BITS + k*W) +: W] = matrix_B[k-j][j];
                end else begin
                    col_in_flat[(j*P_BITS + k*W) +: W] = 0;
                end
            end
        end



        // 3. Execute Simulation 
        rst = 1; load = 0;
        #20 rst = 0;
        
        @(negedge clk);
        load = 1;
        #10 load = 0;


        repeat(3*D+2) @(posedge clk); // repeat(3D-2)
        
        
        

        $display("--- Final Matrix Result ---");
        for (i = 0; i < D; i=i+1) begin
             for (j = 0; j < D; j=j+1) begin

            $write("%0d\t", f_result[(i*D + j)*RES_W +: RES_W]);
        end
        $write("\n");
    end

        
        
    end
endmodule