module mips(		
		input wire			clk,
		input wire			rst,
		input wire [4:0]	ra3,
		input wire [31:0]	instr,
		input wire [31:0]	rd_dm,
		output wire			we_dm,
		output wire [31:0]	pc_current,
		output wire [31:0]	alu_out,
		output wire [31:0] 	wd_dm,
		output wire	[31:0]	rd3
	);
    wire       pc_src, jump, we_reg, alu_src, dm2reg, mult_en, jump_reg;
    wire [1:0] mult_sel, reg_dst;
    wire [2:0] alu_ctrl;
    wire zero;
    datapath dp (
    	.clk		(clk), 
		.mult_en	(mult_en),
		.jump_reg	(jump_reg),
		.rst		(rst),
		.pc_src		(pc_src),
		.jump		(jump),
		.we_reg		(we_reg),
		.alu_src	(alu_src),
		.dm2reg		(dm2reg),
		.alu_ctrl	(alu_ctrl),
		.reg_dst	(reg_dst),
		.mult_sel	(mult_sel),
		.ra3		(ra3),
		.instr		(instr),
		.rd_dm		(rd_dm),
		.zero		(zero),
		.pc_current	(pc_current),
		.alu_out	(alu_out),
		.wd_dm		(wd_dm),
		.rd3		(rd3)
	);
    controlunit cu (
    	.zero		(zero),
    	.opcode		(instr[31:26]),
    	.funct		(instr[5:0]),
    	.pc_src		(pc_src),
    	.jump		(jump),
    	.we_reg		(we_reg), 
    	.alu_src	(alu_src),
    	.we_dm		(we_dm),
    	.dm2reg		(dm2reg),
    	.mult_en	(mult_en),
    	.jump_reg	(jump_reg),
    	.reg_dst	(reg_dst),
    	.mult_sel	(mult_sel),
    	.alu_ctrl	(alu_ctrl)
	);
endmodule