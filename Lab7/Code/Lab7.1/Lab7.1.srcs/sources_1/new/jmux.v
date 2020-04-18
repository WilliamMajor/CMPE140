`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2020 11:18:13 PM
// Design Name: 
// Module Name: jmux
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


module jmux #(parameter WIDTH = 8 )(
        input wire[1:0] sel,
        input wire[WIDTH - 1:0] a,
        input wire[WIDTH - 1:0] b,
        input wire[WIDTH - 1:0] c,
        input wire[WIDTH - 1:0] d,
        output reg[WIDTH - 1:0] y
    );
    always @ (a or b or c or d or sel)
    begin
    case(sel)
		2'b00: y <= a;
		2'b01: y <= b;
		2'b10: y <= c;
		2'b11: y <= d;
    endcase
    end
    

endmodule
