module controlunit (
        input  wire [5:0]  opcode,
        input  wire [5:0]  funct,
        output wire        branch,
        output wire [1:0]  jump,
        output wire        reg_dst,
        output wire        we_reg,
        output wire        alu_src,
        output wire        we_dm,
        output wire        jal_sel,
        output wire        dm2reg,
        output wire [1:0]  hi_lo_ren, hi_lo_wen,
        output wire        hi_lo_sel, wbmux1_sel, wbmux3_sel, left_or_right,
        output wire [2:0]  alu_ctrl
    );
    
    wire [1:0] alu_op;

    maindec md (
        .opcode         (opcode),
        .branch         (branch),
        .jump           (jump),
        .jal_sel        (jal_sel),
        .reg_dst        (reg_dst),
        .we_reg         (we_reg),
        .alu_src        (alu_src),
        .we_dm          (we_dm),
        .dm2reg         (dm2reg),
        .alu_op         (alu_op)
    );

    auxdec ad (
        .alu_op         (alu_op),
        .hi_lo_ren      (hi_lo_ren),
        .hi_lo_wen      (hi_lo_wen),
        .hi_lo_sel      (hi_lo_sel),
        .wbmux1_sel     (wbmux1_sel),
        .wbmux3_sel     (wbmux3_sel),
        .left_or_right  (left_or_right),
        .funct          (funct),
        .alu_ctrl       (alu_ctrl)
    );

endmodule