`timescale 1ns / 1ps

module cmp(
    
    input wire [3:0] a,
    output reg compared    
    );
    
    always@(a)
        begin
            compared <= 0;
            if(a > 4'b0001)
                compared <= 1;
        end    
endmodule
