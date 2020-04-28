`timescale 1ns / 1ps

module pipeline_control(
		input wire			clk,
		input wire			dm2regE,
		input wire 			opcode,
		input wire			we_regE,
		input wire			we_regM,
		input wire			we_regW,
		input wire [4:0] 	rsE,
		input wire [4:0]	rtE,
		input wire [4:0]	rsD,
		input wire [4:0]	rtD,
		output wire			stallF,
		output wire 		stallD,
		output wire 		flushE
    );
 reg stallF_reg = 0;
 reg stallD_reg = 0;
 reg flushE_reg = 0;
 always @ (posedge clk)
 begin
 	if(!opcode)
 	begin
 	 	if((rtE == rsD || rtE == rtD)) stallF_reg <= 1;
 		else if (we_regW) stallF_reg <= 0;
 	end

 end

assign stallF = stallF_reg;
assign stallD = stallF_reg;
assign flushE = stallF_reg;
    
    
endmodule
