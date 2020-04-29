module mips(		
		input wire			clk,
		input wire			rst,
		input wire [4:0]	ra3,
		input wire [31:0]	instr,
		input wire [31:0]	rd_dm,
		output wire			we_dmE_out,
		output wire [31:0]	pc_current,
		output wire [31:0]	alu_outM_out,
		output wire [31:0] 	wd_dmM_out,
		output wire	[31:0]	rd3
	);
    wire       pc_src, jump, we_reg, alu_src, dm2reg, mult_en, jump_reg, we_dm;
    wire [1:0] mult_sel, reg_dst;
    wire [2:0] alu_ctrl;
    wire zero, branch;
    
    wire [5:0] opcode, funct;
    
    datapath dp (
    	.clk			(clk), 
    	.branch			(branch),
		.mult_en		(mult_en),
		.jump_reg		(jump_reg),
		.rst			(rst),
		.jump			(jump),
		.we_reg			(we_reg),
		.alu_src		(alu_src),
		.dm2reg			(dm2reg),
		.we_dm			(we_dm),
		.alu_ctrl		(alu_ctrl),
		.reg_dst		(reg_dst),
		.mult_sel		(mult_sel),
		.ra3			(ra3),
		.instr			(instr),
		.rd_dm			(rd_dm),
		.we_dmE_out		(we_dmE_out),
		.pc_current		(pc_current),
		.alu_outM_out	(alu_outM_out),
		.wd_dmM_out		(wd_dmM_out),
		.rd3			(rd3),
		.opcode			(opcode),
		.funct			(funct)
	);
    controlunit cu (
    	.opcode		(opcode),
    	.funct		(funct),
    	.branch		(branch),
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