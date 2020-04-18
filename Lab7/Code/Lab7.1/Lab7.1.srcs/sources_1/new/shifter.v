`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2020 07:16:47 PM
// Design Name: 
// Module Name: shifter
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


module shifter(
    input wire left_or_right, // left = 0, right = 1 
    input wire[31:0] data,
    input wire[4:0] shmt,
    output wire[31:0] out
    );
    assign out = (left_or_right == 0) ? (data << shmt): (data >> shmt);
    
    
endmodule
