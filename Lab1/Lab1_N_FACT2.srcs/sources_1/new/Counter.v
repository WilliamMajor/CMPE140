`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2020 05:51:35 PM
// Design Name: 
// Module Name: Counter
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


module Counter(
    input [3:0] cntIn,
    input loadCnt, en, clk,
    output reg [3:0] cntOut
    );
always @ (posedge clk) begin
    if(loadCnt) cntOut = cntIn;
    if(en) cntOut = cntOut - 4'b0001;
end
        
endmodule
