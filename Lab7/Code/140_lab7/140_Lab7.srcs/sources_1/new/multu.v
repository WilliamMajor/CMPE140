`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2020 09:13:44 PM
// Design Name: 
// Module Name: multu
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


module multu(
        input wire clk,
        input  wire [31:0] in1,
        input  wire [31:0] in2,
        output reg [31:0] hiout,
        output reg [31:0] lowout
    );
        always @ (clk, in1, in2)
        begin
        	{hiout,lowout} = in1 * in2;
        end
    
    
    
    
    
endmodule
