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
		input wire			clk,
		input wire [31:0] 	instrD_in,
		input wire [31:0]	pc_plus4D_in,
		output reg [31:0] 	instrD_out,
		output reg [31:0]	pc_plus4D_out 
    );
    
    always @ (posedge clk)begin
    	instrD_out 		<= instrD_in;
    	pc_plus4D_out 	<= pc_plus4D_in;
    end
endmodule

module pipe_reg_E(
		input wire			clk,
		input wire 			alu_ctrlE_in,
		input wire			alu_srcE_in,
		input wire			dm2regE_in,
		input wire			mult_enE_in,
		input wire			we_dmE_in,
		input wire			reg_dstE_in,
		input wire [31:0]	pc_plus4E_in,
		input wire [31:0]	alu_paE_in,
		input wire [31:0]	instrE_in,
		output reg			alu_ctrlE_out,
		output reg			alu_srcE_out,
		output reg			dm2regE_out,
		output reg			mult_enE_out,
		output reg			reg_dstE_out,
		output reg [31:0]	pc_plus4E_out,
		output reg [31:0]	alu_paE_out,
		output reg [31:0] 	instrE_out
	);
	
	always @ (posedge clk)begin
		alu_ctrlE_out 	<=	alu_ctrlE_in;
		alu_srcE_out 	<=	alu_srcE_in;
		dm2regE_out 	<=	dm2regE_in;
		mult_enE_out 	<=	mult_enE_in;
		reg_dstE_out 	<=	reg_dstE_in;
		pc_plus4E_out 	<=	pc_plus4E_in;
		alu_paE_out 	<=	alu_paE_in;
		instrE_out 		<=	instrE_in;
	end

endmodule

module pipe_reg_M(
		input wire			clk,
		input wire [31:0]	alu_outM_in,
		input wire [31:0]	wd_dmM_in,
		input wire			dm2regM_in,
		input wire			mult_enM_in,
		input wire			rf_waM_in,
		input wire			multM_in,
		input wire			pc_plus_brM_in,
		output reg [31:0]	alu_outM_out,
		output reg [31:0]	wd_dmM_out,
		output reg			dm2regM_out,
		output reg			mult_enM_out,
		output reg			rf_waM_out,
		output reg			multM_out,
		output reg			pc_plus_brM_out
	);
	
	always @ (posedge clk)begin
		alu_outM_out 	<=	alu_outM_in;
		wd_dmM_out 		<=	wd_dmM_in;
		dm2regM_out 	<=	dm2regM_in;
		mult_enM_out 	<=	mult_enM_in;
		rf_waM_out 		<=	rf_waM_in;
		multM_out 		<=	multM_in;
		pc_plus_brM_out <=	pc_plus_brM_in;
	end

endmodule

module pipe_reg_W(
		input wire			clk,
		input wire [31:0]	alu_outW_in,
		input wire [31:0]	rd_dmW_in,
		input wire [31:0]	mult_loW_in,
		input wire [31:0]	mult_hiW_in,
		input wire [4:0]	rf_waW_in,
		input wire 			dm2regW_in,
		output reg [31:0]	alu_outW_out,
		output reg [31:0]	rd_dmW_out,
		output reg [31:0]	mult_loW_out,
		output reg [31:0]	mult_hiW_out,
		output reg [4:0]	rf_waW_out,
		output reg 		dm2regW_out	
	);
	
	always @ (posedge clk)begin
		alu_outW_out 	<=	alu_outW_in;
		rd_dmW_out 		<=	rd_dmW_in;
		mult_loW_out 	<=	mult_loW_in;
		mult_hiW_out 	<=	mult_hiW_in;
		rf_waW_out 		<=	rf_waW_in;
		dm2regW_out 	<=	dm2regW_in;
	end
	
endmodule