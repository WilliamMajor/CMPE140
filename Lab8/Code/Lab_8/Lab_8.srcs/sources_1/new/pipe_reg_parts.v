`timescale 1ns / 1ps

module pipe_reg_D(
		input wire			clk,
		input wire			rst,
		input wire [31:0] 	instrD_in,
		input wire [31:0]	pc_plus4D_in,
		output wire [31:0] 	instrD_out,
		output wire [31:0]	pc_plus4D_out 
    );
	reg [31:0] instrD, pc_plus4D;
    always @ (posedge clk, posedge rst)
    begin
		if(rst == 1)
		begin
			instrD 		<= 0;
			pc_plus4D	<= 0;
		end
		else
		begin
			instrD 		<= instrD_in;
			pc_plus4D 	<= pc_plus4D_in;
		end
    end
    assign instrD_out 		= instrD;
    assign pc_plus4D_out 	= pc_plus4D;
    
endmodule

module pipe_reg_E(
		input wire			clk,
		input wire			rst,
		input wire [2:0]	alu_ctrlE_in,
		input wire			alu_srcE_in,
		input wire			dm2regE_in,
		input wire			mult_enE_in,
		input wire			we_dmE_in,
		input wire			pc_srcE_in,
		input wire			we_regE_in,
		input wire [1:0]	reg_dstE_in,
		input wire [31:0]	pc_plus4E_in,
		input wire [31:0]	alu_paE_in,
		input wire [31:0]	instrE_in,
		input wire [31:0]	seE_in,
		output wire	[2:0]	alu_ctrlE_out,
		output wire			alu_srcE_out,
		output wire			dm2regE_out,
		output wire			mult_enE_out,
		output wire			we_dmE_out,
		output wire			pc_srcE_out,
		output wire			we_regE_out,
		output wire	[1:0]	reg_dstE_out,
		output wire [31:0]	pc_plus4E_out,
		output wire [31:0]	alu_paE_out,
		output wire [31:0] 	instrE_out,
		output wire [31:0]	seE_out
	);
	reg 		alu_srcE, dm2regE, mult_enE, we_dmE, pc_srcE, we_regE;
	reg [1:0]	reg_dstE;
	reg	[2:0]	alu_ctrlE;
	reg [31:0]	pc_plus4E, alu_paE, instrE, seE;
	always @ (posedge clk, posedge rst)
	begin
		if(rst == 1)
		begin
			alu_ctrlE 	<=	0;
			alu_srcE 	<=	0;
			dm2regE 	<=	0;
			mult_enE 	<=	0;
			we_dmE		<=	0;
			pc_srcE		<= 	0;
			we_regE		<=	0;
			reg_dstE 	<=	0;
			pc_plus4E 	<=	0;
			alu_paE 	<=	0;
			instrE 		<=	0;
			seE			<= 	0;
		end
		else
		begin
			alu_ctrlE 	<=	alu_ctrlE_in;
			alu_srcE 	<=	alu_srcE_in;
			dm2regE 	<=	dm2regE_in;
			mult_enE 	<=	mult_enE_in;
			we_dmE		<=	we_dmE_in;
			pc_srcE		<= 	pc_srcE_in;
			we_regE		<= 	we_regE_in;
			reg_dstE 	<=	reg_dstE_in;
			pc_plus4E 	<=	pc_plus4E_in;
			alu_paE 	<=	alu_paE_in;
			instrE 		<=	instrE_in;
			seE			<= 	seE_in;
		end
	end
	
	assign alu_ctrlE_out 	= alu_ctrlE;
	assign alu_srcE_out 	= alu_srcE;
	assign dm2regE_out 		= dm2regE;
	assign mult_enE_out 	= mult_enE;
	assign we_dmE_out 		= we_dmE;
	assign pc_srcE_out		= pc_srcE;
	assign we_regE_out		= we_regE;
	assign reg_dstE_out 	= reg_dstE;
	assign pc_plus4E_out 	= pc_plus4E;
	assign alu_paE_out 		= alu_paE;
	assign instrE_out 		= instrE;
	assign seE_out 			= seE;

endmodule

module pipe_reg_M(
		input wire			clk,
		input wire			rst,
		input wire [63:0]	multM_in,
		input wire [31:0]	alu_outM_in,
		input wire [31:0]	wd_dmM_in,
		input wire [31:0]	pc_plus_brM_in,
		input wire [4:0]	rf_waM_in,
		input wire			dm2regM_in,
		input wire			mult_enM_in,
		input wire			pc_srcM_in,
		input wire			we_regM_in,
		input wire			zeroM_in,
		output wire [63:0]	multM_out,
		output wire [31:0]	alu_outM_out,
		output wire [31:0]	wd_dmM_out,
		output wire [31:0]	pc_plus_brM_out,
		output wire [4:0]	rf_waM_out,
		output wire			dm2regM_out,
		output wire			mult_enM_out,
		output wire			pc_srcM_out,
		output wire			we_regM_out,
		output wire			zeroM_out
	);
	reg [63:0] 	multM;
	reg [31:0] 	alu_outM, wd_dmM, pc_plus_brM;
	reg [4:0]	rf_waM;
	reg	dm2regM, mult_enM, pc_srcM, we_regM, zeroM;
	always @ (posedge clk, posedge rst)
	begin
		if(rst == 1)
		begin
			multM		<= 	0;
			alu_outM 	<=	0;
			wd_dmM 		<=	0;
			dm2regM 	<=	0;
			mult_enM 	<=	0;
			pc_srcM		<= 	0;
			we_regM		<=	0;
			zeroM		<=	0;
			rf_waM 		<=	0;
			multM 		<=	0;
			pc_plus_brM <=	0;
		end
		else
		begin
			multM		<= 	multM_in;
			alu_outM 	<=	alu_outM_in;
			wd_dmM 		<=	wd_dmM_in;
			dm2regM 	<=	dm2regM_in;
			mult_enM 	<=	mult_enM_in;
			pc_srcM		<= 	pc_srcM_in;
			we_regM		<=	we_regM_in;
			zeroM		<= 	zeroM_in;
			rf_waM 		<=	rf_waM_in;
			multM 		<=	multM_in;
			pc_plus_brM <=	pc_plus_brM_in;
		end
	end
	assign multM_out 		= multM;
	assign alu_outM_out 	= alu_outM;
	assign wd_dmM_out		= wd_dmM;
	assign pc_plus_brM_out	= pc_plus_brM;
	assign rf_waM_out		= rf_waM;
	assign dm2regM_out		= dm2regM;
	assign mult_enM_out		= mult_enM;
	assign pc_srcM_out		= pc_srcM;
	assign we_regM_out		= we_regM;
	assign zeroM_out		= zeroM;
	
endmodule

module pipe_reg_W(
		input wire			clk,
		input wire			rst,
		input wire [31:0]	alu_outW_in,
		input wire [31:0]	rd_dmW_in,
		input wire [31:0]	mult_loW_in,
		input wire [31:0]	mult_hiW_in,
		input wire [4:0]	rf_waW_in,
		input wire 			dm2regW_in,
		input wire			we_regW_in,
		output wire [31:0]	alu_outW_out,
		output wire [31:0]	rd_dmW_out,
		output wire [31:0]	mult_loW_out,
		output wire [31:0]	mult_hiW_out,
		output wire [4:0]	rf_waW_out,
		output wire 		dm2regW_out,
		output wire			we_regW_out	
	);
	reg [31:0]	alu_outW, rd_dmW, mult_loW, mult_hiW, we_regW;
	reg [4:0]	rf_waW;
	reg 		dm2regW;
	always @ (posedge clk, posedge rst)
	begin
		if(rst == 1)
		begin
			alu_outW 	<=	0;
			rd_dmW		<=	0;
			mult_loW	<=	0;
			mult_hiW 	<=	0;
			rf_waW 		<=	0;
			dm2regW 	<=	0;
			we_regW		<=	0;			
		end
		else
		begin
			alu_outW 	<=	alu_outW_in;
			rd_dmW		<=	rd_dmW_in;
			mult_loW	<=	mult_loW_in;
			mult_hiW 	<=	mult_hiW_in;
			rf_waW 		<=	rf_waW_in;
			dm2regW 	<=	dm2regW_in;
			we_regW		<=	we_regW_in;
		end
	end
	
	assign alu_outW_out = alu_outW;
	assign rd_dmW_out	= rd_dmW;
	assign mult_loW_out	= mult_loW;
	assign mult_hiW_out	= mult_hiW;
	assign rf_waW_out	= rf_waW;
	assign dm2regW_out	= dm2regW;
	assign we_regW_out	= we_regW;
	
endmodule