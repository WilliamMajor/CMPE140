`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2020 01:51:25 AM
// Design Name: 
// Module Name: sp_reg
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


module sp_reg(
    input wire clk, hi_lo_wen, hi_lo_ren,
    input wire[31:0] d,
    output reg[31:0] q
    );
    reg [31:0]data;
    initial
    begin
    	data = 32'h0;
    end
    always @ (posedge clk, posedge hi_lo_wen, posedge hi_lo_ren)
    begin
		if (hi_lo_wen == 1)begin
			data <= d; 
		end
		else if (hi_lo_wen == 0 && hi_lo_ren == 1)begin
			q <= data;		
	 	end
	end
endmodule
