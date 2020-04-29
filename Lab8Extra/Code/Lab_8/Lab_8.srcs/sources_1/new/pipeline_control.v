`timescale 1ns / 1ps

module pipeline_control(
		input wire			clk,
		input wire			dm2regE,
		input wire			we_regE,
		input wire			we_regM,
		input wire			we_regW,
		input wire [4:0]	rf_waM,	
		input wire [4:0]	rf_waW,
		input wire [4:0] 	rsE,
		input wire [4:0]	rtE,
		input wire [4:0]	rsD,
		input wire [4:0]	rtD,
		output wire	[1:0]	forwardAE,
		output wire	[1:0]	forwardBE,
		output wire			stallF,
		output wire 		stallD,
		output wire 		flushE

    );
 reg lwstall = 1'b0;
 reg forwardAE_reg = 2'b00;
 reg forwardBE_reg = 2'b00;
 always @ (posedge clk)
 begin

 	

 	if(we_regM && (rsE != 0) && (rf_waM == rsE)) forwardAE_reg = 2'b10;  	//Forwarding logic from MEM
 	if(we_regM && (rtE != 0) && (rf_waM == rtE)) forwardBE_reg = 2'b10;
 	if(we_regW && (rsE != 0) && (rf_waW == rsE)) forwardAE_reg = 2'b01;  	//fowarding logic from WB
 	if(we_regW && (rtE != 0) && (rf_waW == rtE)) forwardBE_reg = 2'b01;

 	

 end

assign stallF 		= lwstall;
assign stallD 		= lwstall;
assign flushE 		= lwstall;
assign forwardAE 	= forwardAE_reg;
assign forwardBE	= forwardBE_reg;
    
    
endmodule
