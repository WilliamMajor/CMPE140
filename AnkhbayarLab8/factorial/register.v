`timescale 1ns / 1ps

module register(
    
    input wire Load_reg,
    input wire clk,
    input wire [31:0] D,
    output reg [31:0] Q
    );
    
    always@(posedge clk)
    begin
        if(Load_reg)
            Q = D;
        else
            Q = Q;
    end
endmodule

