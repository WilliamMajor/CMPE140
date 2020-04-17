module mips (
        input  wire        clk,
        input  wire        rst,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr,
        input  wire [31:0] rd_dm,
        output wire        we_dm,
        output wire [31:0] pc_current,
        output wire [31:0] alu_out,
        output wire [31:0] wd_dm,
        output wire [31:0] rd3
    );
    
    wire       branch;
    wire    [1:0]   jump;
    wire    [1:0] hi_lo_ren, hi_lo_wen;
    wire       hi_lo_sel;
    wire       reg_dst;
    wire       we_reg;
    wire       alu_src;
    wire       dm2reg;
    wire        jal_sel, left_or_right,wbmux1_sel,wbmux2_sel,wbmux3_sel;
    wire [2:0] alu_ctrl;

    datapath dp (
            .clk            (clk),
            .rst            (rst),
            .branch         (branch),
            .jump           (jump),
            .reg_dst        (reg_dst),
            .we_reg         (we_reg),
            .alu_src        (alu_src),
            .dm2reg         (dm2reg),
            .alu_ctrl       (alu_ctrl),
            .left_or_right  (left_or_right),
            .ra3            (ra3),
            .instr          (instr),
            .rd_dm          (rd_dm),
            .jal_sel        (jal_sel),
            .pc_current     (pc_current),
            .alu_out        (alu_out),
            .hi_lo_sel      (hi_lo_sel),
            .wbmux1_sel     (wbmux1_sel),
            .wbmux3_sel     (wbmux3_sel),
            .wd_dm          (wd_dm),
            .rd3            (rd3),
            .hi_lo_ren      (hi_lo_ren),
            .hi_lo_wen      (hi_lo_wen)
        );

    controlunit cu (
            .opcode         (instr[31:26]),
            .funct          (instr[5:0]),
            .branch         (branch),
            .jump           (jump),
            .reg_dst        (reg_dst),
            .we_reg         (we_reg),
            .alu_src        (alu_src),
            .we_dm          (we_dm),
            .dm2reg         (dm2reg),
            .alu_ctrl       (alu_ctrl),
            .left_or_right  (left_or_right),
            .jal_sel        (jal_sel),
            .wbmux1_sel     (wbmux1_sel),
            .wbmux3_sel     (wbmux3_sel),
            .hi_lo_ren      (hi_lo_ren),
            .hi_lo_wen      (hi_lo_wen),
            .hi_lo_sel      (hi_lo_sel)
        );

endmodule