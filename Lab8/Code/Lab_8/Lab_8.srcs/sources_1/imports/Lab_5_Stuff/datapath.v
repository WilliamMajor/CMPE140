module datapath(
		input wire clk,
		input wire mult_en,
		input wire jump_reg,
		input wire rst,
		input wire pc_src,
		input wire jump,
		input wire we_reg,
		input wire alu_src,
		input wire dm2reg,
		input wire [2:0] alu_ctrl,
		input wire [1:0] reg_dst,
		input wire [1:0] mult_sel,
		input wire [4:0] ra3,
		input wire [31:0] instr,
		input wire [31:0] rd_dm,
		output wire zero,
		output wire [31:0] pc_current,
		output wire [31:0] alu_out,
		output wire [31:0] wd_dm,
		output wire	[31:0] rd3
	);
    wire [4:0]  rf_wa;
    wire [31:0] pc_plus4, pc_pre, pc_next, sext_imm, ba, bta, jta, alu_pa, alu_pb, wd_rf;
    wire [63:0] mult_out;
    wire [31:0] lo_out, hi_out, mult_mux_out, jr_mux_out;
    
    assign ba = {sext_imm[29:0], 2'b00};
    assign jta = {pc_plus4[31:28], instr[25:0], 2'b00};
    
    // --- PC Logic --- //
    dreg pc_reg (
		.clk	(clk),
		.rst	(rst),
		.d		(jr_mux_out),
		.q		(pc_current)
	);
	
    adder pc_plus_4	(
    	.a		(pc_current),
    	.b 		(4),
    	.y		(pc_plus4)
    );
    
    adder pc_plus_br (
    	.a		(pc_plus4),
    	.b		(ba),
    	.y		(bta)
	);
	
    mux2 #(32) pc_src_mux (
    	.sel	(pc_src),
    	.a		(pc_plus4),
    	.b		(bta),
    	.y		(pc_pre)
	);
	
    mux2 #(32) pc_jmp_mux (
    	.sel	(jump),
    	.a		(pc_pre),
    	.b		(jta),
    	.y		(pc_next)
	);
    mux2 #(32) pc_jreg_mux (
    	.sel	(jump_reg),
    	.a		(pc_next),
    	.b		(alu_pa),
    	.y		(jr_mux_out)
	);
    
    // --- RF Logic --- //
    mux4 #(5) rf_wa_mux (
    	.sel	(reg_dst),
    	.a		(instr[20:16]),
    	.b		(instr[15:11]),
    	.c		(31),
    	.d		(0),
    	.y		(rf_wa)
	);
	
    regfile rf (
    	.clk	(clk),
    	.we		(we_reg),
    	.ra1	(instr[25:21]),
    	.ra2	(instr[20:16]),
    	.ra3	(ra3),
    	.wa		(rf_wa),
    	.wd		(mult_mux_out),
    	.rd1	(alu_pa),
    	.rd2	(wd_dm),
    	.rd3	(rd3)
	);
    
    signext se (
    	.a		(instr[15:0]),
    	.y		(sext_imm)
	);
    
    // --- ALU Logic --- //
    mux2 #(32) alu_pb_mux (
    	.sel	(alu_src),
    	.a		(wd_dm),
    	.b		(sext_imm),
    	.y		(alu_pb)
	);
    
    alu alu (
    	.op		(alu_ctrl),
    	.a		(alu_pa),
    	.b		(alu_pb),
    	.zero	(zero),
    	.y		(alu_out)
	);
    
    // --- MEM Logic --- //
    mux2 #(32) rf_wd_mux (
    	.sel	(dm2reg),
    	.a		(alu_out),
    	.b		(rd_dm),
    	.y		(wd_rf)
	);
    
    // --- MULTU Logic --- //
    mult multu (
    	.a		(alu_pa),
    	.b		(wd_dm),
    	.y		(mult_out)
	);
    
    dreg2 lo (
    	.clk	(clk),
    	.rst	(rst),
    	.en		(mult_en),
    	.d		(mult_out[31:0]),
    	.q		(lo_out)
	);
    
    dreg2 hi (
    	.clk	(clk),
    	.rst	(rst),
    	.en		(mult_en),
    	.d		(mult_out[63:32]),
    	.q		(hi_out)
	);
    
    mux4 #(32) mult_mux (
    	.sel	(mult_sel),
    	.a		(pc_plus4),
    	.b		(wd_rf),
    	.c		(lo_out),
    	.d		(hi_out),
    	.y		(mult_mux_out)
	);
    
endmodule