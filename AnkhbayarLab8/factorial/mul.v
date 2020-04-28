`timescale 1ns / 1ps

module mul(
    input wire [3:0] x,
    input wire [31:0] y,
    output wire [31:0] z
    );
    
    assign z = x * y;
    
endmodule
