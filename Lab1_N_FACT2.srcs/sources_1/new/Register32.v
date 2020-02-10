`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2020 06:09:50 PM
// Design Name: 
// Module Name: Register32
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


module Register32(
        input [31:0] regIn,
        input loadReg, clk,
        output reg [31:0] regOut
    );
    
always @ ( posedge clk)
begin
    regOut = loadReg ? regIn : regOut; 
end
endmodule
