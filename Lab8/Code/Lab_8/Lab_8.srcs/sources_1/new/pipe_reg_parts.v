`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2020 04:01:52 PM
// Design Name: 
// Module Name: pipe_reg_parts
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


module pipe_reg_D(
		input wire [31:0] 	instrD_in,
		input wire [31:0]	pc_plus4D_in,
		output wire [31:0] 	instrD_out,
		output wire [31:0]	pc_plus4D_out 
    );
endmodule

module pipe_reg_E(
		input wire 			alu_ctrlE_in,
		input wire			alu_srcE_in,
		input wire			dm2regE_in,
		input wire			mult_enE_in,
		input wire			we_dmE_in,
		input wire			reg_dstE_in,
		input wire [31:0]	pc_plus4E_in,
		input wire [31:0]	alu_paE_in,
		input wire [31:0]	instrE_in,
		output wire			alu_ctrlE_out,
		output wire			alu_srcE_out,
		output wire			dm2regE_out,
		output wire			mult_enE_out,
		output wire			reg_dstE_out,
		output wire [31:0]	pc_plus4E_out,
		output wire [31:0]	alu_paE_out,
		output wire [31:0] 	instrE_out
	);

endmodule
