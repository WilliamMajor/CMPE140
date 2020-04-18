module mips (
        input  wire        	clk,
        input  wire        	rst,
        input  wire [4:0]  	ra3,
        input  wire [31:0] 	instr,
        input  wire [31:0] 	rd_dm,
        output wire [31:0] 	pc_current,
        output wire [31:0] 	alu_out,
        output wire [31:0] 	wd_dm,
        output wire [31:0] 	rd3,
        output wire			we_dm
    );
    
   	wire [2:0] 	alu_ctrl;
	wire [1:0] 	jump;
	wire [1:0]	hi_lo_ren;
    wire [1:0]	hi_lo_wen;
    wire       	branch;
    wire       	reg_dst;
    wire       	we_reg;
    wire       	alu_src;
    wire       	dm2reg;
    wire 	   	jalsel;
    wire		hi_lo_sel;
    wire		wbmux1_sel;
    wire		wbmux2_sel;
    wire		wbmux3_sel;
    wire		left_or_right;

    datapath dp (
            .clk            (clk),
            .rst            (rst),
            .branch         (branch),
            .left_or_right	(left_or_right),
            .jump           (jump),
            .reg_dst        (reg_dst),
            .we_reg         (we_reg),
            .alu_src        (alu_src),
            .dm2reg         (dm2reg),
            .jal_sel		(jalsel),
            .hi_lo_ren		(hi_lo_ren),
            .hi_lo_wen		(hi_lo_wen),
            .hi_lo_sel		(hi_lo_sel),
            .wbmux1_sel		(wbmux1_sel),
            .wbmux2_sel		(wbmux2_sel),
            .wbmux3_sel		(wbmux3_sel),
            .alu_ctrl       (alu_ctrl),
            .ra3            (ra3),
            .instr          (instr),
            .rd_dm          (rd_dm),
            .pc_current     (pc_current),
            .alu_out        (alu_out),
            .wd_dm          (wd_dm),
            .rd3            (rd3)
        );

    controlunit cu (
            .opcode         (instr[31:26]),
            .funct          (instr[5:0]),
            .alu_ctrl       (alu_ctrl),
			.jump           (jump),
			.hi_lo_ren		(hi_lo_ren),
			.hi_lo_wen		(hi_lo_wen),
			.jalsel			(jalsel),
            .branch         (branch),
            .reg_dst        (reg_dst),
            .we_reg         (we_reg),
            .alu_src        (alu_src),
            .we_dm          (we_dm),
            .dm2reg         (dm2reg),
            .hi_lo_sel		(hi_lo_sel),
            .wbmux1_sel		(wbmux1_sel),
            .wbmux2_sel		(wbmux2_sel),
			.wbmux3_sel		(wbmux3_sel),
			.left_or_right	(left_or_right)	
            
        );

endmodule