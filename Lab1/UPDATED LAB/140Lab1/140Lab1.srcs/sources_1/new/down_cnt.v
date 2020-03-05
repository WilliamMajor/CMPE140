`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/09/2020 03:18:00 PM
// Design Name: 
// Module Name: down_cnt
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


module down_cnt(
input [3:0] D,
input load, en, clk,
output reg [3:0] Q );

always @(posedge clk)
begin
if (load ==1) Q <= D;
else if (load == 0 && en == 1) Q <= Q - 1;

end
    

endmodule
