`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2020 05:59:17 PM
// Design Name: 
// Module Name: Mux_2In
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


module Mux_2In(
    input [3:0] in1,
    input [31:0] in2,
    input sel,
    output [31:0]muxOut
    );
    
    
    assign muxOut = (sel == 1'b1) ? in1 : in2;
    
endmodule
