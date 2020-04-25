module mips_top(
		input wire			clk,
		input wire			rst,
		input wire [4:0]	ra3,
		input wire [31:0] 	instr,
		output wire			we_dmE,
		output wire [31:0]	rd_dm,
		output wire [31:0]	pc_current,
		output wire [31:0]	alu_outM_out,
		output wire [31:0]	wd_dmM_out,
		output wire [31:0]	rd3
		);
    wire [31:0] DONT_USE;
    mips mips (
    	.clk			(clk),
    	.rst			(rst),
    	.ra3			(ra3),
    	.instr			(instr),
    	.rd_dm			(rd_dm),
    	.we_dmE			(we_dmE),
    	.pc_current		(pc_current),
    	.alu_outM_out 	(alu_outM_out),
    	.wd_dmM_out		(wd_dmM_out),
    	.rd3			(rd3)
    	);
    
    
    imem imem (
    	.a			(pc_current[7:2]),
    	.y			(instr)
		);
    dmem dmem (
    	.clk	(clk),
    	.we		(we_dmE),
    	.a		(alu_outM_out[7:2]),
    	.d		(wd_dmM_out),
    	.q		(rd_dm)
    	);
endmodule