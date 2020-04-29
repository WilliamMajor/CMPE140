module controlunit(
		input zero,
		input [5:0] opcode,
		input [5:0] funct, 
		output pc_src,
		output jump,
		output we_reg, 
		output alu_src, 
		output we_dm, 
		output dm2reg, 
		output mult_en,
		output jump_reg,
		output [1:0] reg_dst,
		output [1:0] mult_sel,
		output [2:0] alu_ctrl
	);
    wire [1:0] alu_op;
    wire branch;
    
    maindec md (
    	.opcode		(opcode),
    	.branch		(branch),
    	.jump		(jump),
    	.reg_dst	(reg_dst),
    	.we_reg		(we_reg),
    	.alu_src	(alu_src),
    	.we_dm		(we_dm),
    	.dm2reg		(dm2reg),
    	.alu_op		(alu_op)
	);
    
    auxdec ad (
    	.alu_op		(alu_op),
    	.funct		(funct),
    	.alu_ctrl	(alu_ctrl),
    	.multi_sel	(mult_sel),
    	.multi_en	(mult_en),
    	.jump_reg	(jump_reg)
	);
    
    assign pc_src = branch & zero;
    
endmodule