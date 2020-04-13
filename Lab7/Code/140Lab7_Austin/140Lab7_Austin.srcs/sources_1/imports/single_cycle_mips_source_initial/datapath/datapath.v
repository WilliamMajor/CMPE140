module datapath (
        input  wire        clk,
        input  wire        rst,
        input  wire        branch,
        input  wire        jump,
        input  wire        reg_dst,
        input  wire        we_reg,
        input  wire        alu_src,
        input  wire        dm2reg,
        input  wire [1:0]  hi_lo_ren, hi_lo_wen, // added for MULTU, MFLO, MFHI 
        input  wire        hi_lo_sel, //hi_lo register mux selector
        input  wire [2:0]  alu_ctrl,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr,
        input  wire [31:0] rd_dm,
        output wire [31:0] pc_current,
        output wire [31:0] alu_out,
        output wire [31:0] wd_dm,
        output wire [31:0] rd3
    );
    wire [31:0] wd_hi;
    wire imm1, imm2, imm3, imm4;
    wire [4:0]  rf_wa;
    wire        pc_src;
    wire [31:0] hi_mux, lo_mux, multmux_out;
    wire [31:0] pc_plus4;
    wire [31:0] pc_pre;
    wire [31:0] pc_next;
    wire [31:0] sext_imm;
    wire [31:0] ba;
    wire [31:0] bta;
    wire [31:0] jta;
    wire [31:0] alu_pa;
    wire [31:0] alu_pb;
    wire [31:0] wd_rf;
    wire        zero;
    
    assign pc_src = branch & zero;
    assign ba = {sext_imm[29:0], 2'b00};
    assign jta = {pc_plus4[31:28], instr[25:0], 2'b00};
    
    // --- PC Logic --- //
    dreg pc_reg (
            .clk            (clk),
            .rst            (rst),
            .d              (pc_next),
            .q              (pc_current)
        );

    adder pc_plus_4 (
            .a              (pc_current),
            .b              (32'd4),
            .y              (pc_plus4)
        );

    adder pc_plus_br (
            .a              (pc_plus4),
            .b              (ba),
            .y              (bta)
        );

    mux2 #(32) pc_src_mux (
            .sel            (pc_src),
            .a              (pc_plus4),
            .b              (bta),
            .y              (pc_pre)
        );

    mux2 #(32) pc_jmp_mux (
            .sel            (jump),
            .a              (pc_pre), //branch target address or PC+4
            .b              (jta), // need to add bigger mux for jump return option
            .y              (pc_next)
        );

    // --- RF Logic --- //
    mux2 #(5) rf_wa_mux (
            .sel            (reg_dst),
            .a              (instr[20:16]),
            .b              (instr[15:11]),
            .y              (rf_wa)
        );

    regfile rf (
            .clk            (clk),
            .we             (we_reg),
            .ra1            (instr[25:21]),
            .ra2            (instr[20:16]),
            .ra3            (ra3),
            .wa             (rf_wa),
            .wd             (wd_rf),
            .rd1            (alu_pa),
            .rd2            (wd_dm),
            .rd3            (rd3)
        );

    signext se (
            .a              (instr[15:0]),
            .y              (sext_imm)
        );

    // --- ALU Logic --- //
    mux2 #(32) alu_pb_mux (
            .sel            (alu_src),
            .a              (wd_dm),
            .b              (sext_imm),
            .y              (alu_pb)
        );

    alu alu (
            .op             (alu_ctrl),
            .a              (alu_pa),
            .b              (alu_pb),
            .zero           (zero),
            .y              (alu_out),
            .wd_hi          (wd_hi)
        );
    // ---MULTU Logic--- //
    sp_reg hi(
            .clk            (clk),
            .hi_lo_wen      (hi_lo_wen[1]), //hi_lo[1] = enable write to hi register
            .hi_lo_ren      (hi_lo_ren[1]),
            .d              (wd_hi),
            .q              (hi_mux)
            );
    sp_reg lo(
            .clk            (clk),
            .hi_lo_wen       (hi_lo_wen[0]),
            .hi_lo_ren      (hi_lo_ren[0]),
            .d              (alu_out),
            .q              (lo_mux)
            );

            

    // --- MEM Logic --- //
    mux2 #(32) rf_wd_mux (
            .sel            (dm2reg),
            .a              (alu_out),
            .b              (rd_dm),
            .y              (wd_rf)
        );
    mux2 #(32) jalsel (
            .sel            (dm2reg),
            .a              (alu_out),
            .b              (rd_dm),
            .y              (wd_rf)
        );

    // --- WB to RF Logic --- //
    mux2 #(32) mult_reg ( //MULTMUX
        .sel            (hi_lo_sel),
        .a              (hi_mux),
        .b              (lo_mux),
        .y              (multmux_out)
        );
    mux2 #(32) mult_rfwd_mux ( //WBMUX2
        .sel            (hi_lo_sel),
        .a              (wd_rf),
        .b              (multmux_out),
        .y              (imm1)
        );
    mux2 #(32) mult_rfwd_jal ( //WBMUX3
        .sel            (hi_lo_sel),
        .a              (imm1),
        .b              (pc_plus4),
        .y              (imm2)
        );
    mux2 #(32) mult_rfwd_jal_shifter ( //WBMUX4
        .sel            (hi_lo_sel),
        .a              (imm2),
        .b              (shift_d),
        .y              (imm3)
        );
        
        
        
        
        
        
        

endmodule