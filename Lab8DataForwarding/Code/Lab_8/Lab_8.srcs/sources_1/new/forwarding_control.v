`timescale 1ns / 1ps


module forwarding_control(
		input wire [4:0] 	rsD,
		input wire [4:0] 	rsE,
		input wire [4:0] 	rtD,
		input wire [4:0] 	rtE,
		input wire [4:0]	rf_waM,
		input wire [4:0]	rf_waW,
		input wire 			we_regE,
		input wire 			we_regM,
		input wire 			we_regW,
		output wire [1:0] 	forwardAE,
		output wire [1:0] 	forwardBE
    );
    reg [1:0] forwardAE_reg, forwardBE_reg = 2'b00;
    always @ (*)
    begin
    	if(we_regM && (rsE != 0) && (rf_waM == rsE)) forwardAE_reg = 2'b10;
    	else if(we_regM && (rtE != 0) && (rf_waM == rtE)) forwardBE_reg = 2'b10;
    	else if(we_regW && (rsE != 0) && (rf_waW == rsE)) forwardAE_reg = 2'b01;
    	else if(we_regW && (rtE != 0) && (rf_waW == rtE)) forwardBE_reg = 2'b01;
    	else
    	begin
    		forwardAE_reg = 2'b00;
    		forwardBE_reg = 2'b00;
    	end
    	
    end
    assign forwardAE = forwardAE_reg;
    assign forwardBE = forwardBE_reg;
endmodule
