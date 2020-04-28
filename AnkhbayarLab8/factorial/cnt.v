`timescale 1ns / 1ps

module cnt(
    
    input wire clk,
    input wire rst,
    input wire Load_cnt,
    input wire EN,
    input wire [3:0] D,
    output reg [3:0] Q
    );
    
    always@(posedge clk)
        begin
            if(rst)
                Q = 0;
            else if(Load_cnt)
                Q = D;
            else if(EN)
                Q = Q - 4'b0001;
            else
                Q = Q;
        end
endmodule
