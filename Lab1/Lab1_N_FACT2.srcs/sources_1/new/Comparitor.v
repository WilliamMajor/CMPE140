`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2020 06:04:31 PM
// Design Name: 
// Module Name: Comparitor
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


module Comparitor(
    input [3:0] in1, in2,
    output gt
    );
 
    assign gt = (in1 > in2) ? 1 : 0;
    
endmodule
