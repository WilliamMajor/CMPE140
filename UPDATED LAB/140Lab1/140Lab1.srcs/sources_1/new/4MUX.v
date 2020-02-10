`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/09/2020 02:58:05 PM
// Design Name: 
// Module Name: 4MUX
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
module four_bit_MUX(
input [3:0] A, B,
input Sel,
output [3:0] out
);
assign out = Sel ? A : B;

endmodule
