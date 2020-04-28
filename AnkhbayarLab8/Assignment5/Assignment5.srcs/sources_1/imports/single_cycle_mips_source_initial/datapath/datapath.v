module datapath (
        input  wire        clk,
        input  wire        rst,
        input  wire        branch,
        input  wire        jump,
        input  wire        reg_dst,
        input  wire        we_reg,
        input  wire        alu_src,
        input  wire        dm2reg,
        input  wire [2:0]  alu_ctrl,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr,
        input  wire [31:0] rd_dm,
        input  wire        mf_hi_lo,
        input  wire        hi_lo,
        input  wire        jal,
        input  wire        jr,
        output wire [31:0] pc_current,
        output wire [31:0] alu_out,
        output wire [31:0] wd_dm,
        output wire [31:0] rd3
    );

    wire [4:0]  rf_wa;
    wire        pc_src;
    wire [31:0] pc_plus4;
    wire [31:0] pc_pre;
    wire [31:0] pc_next;
    wire [31:0] pc_next2;
    wire [31:0] sext_imm;
    wire [31:0] ba;
    wire [31:0] bta;
    wire [31:0] jta;
    wire [31:0] alu_pa;
    wire [31:0] alu_pb;
    wire [31:0] wd_rf;
    wire        zero;
    wire [31:0] return_address;
    wire [31:0] write_value;
    wire [31:0] write_address;
    wire [31:0] hi;
    wire [31:0] lo;
    wire [31:0] hi_or_lo;
    
    assign pc_src = branch & zero;
    assign ba = {sext_imm[29:0], 2'b00};
    assign jta = {pc_plus4[31:28], instr[25:0], 2'b00};
    
    // --- PC Logic --- //
    dreg pc_reg (
            .clk            (clk),
            .rst            (rst),
            .d              (pc_next2),
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
    multiply multiply1 (
            .a              (alu_pa),
            .b              (wd_dm),
            .clk            (clk),
            .ctrl           (alu_ctrl),
            .hi             (hi),
            .lo             (lo)
            );

    mux2 #(32) pc_src_mux (
            .sel            (pc_src),
            .a              (pc_plus4),
            .b              (bta),
            .y              (pc_pre)
        );
    
    mux2 #(32) jal_mux(
            .sel            (jal),
            .a              (wd_rf),
            .b              (pc_plus4),
            .y              (return_address)
        );
    mux2 #(32) hi_lo_mux2(
            .sel            (hi_lo),
            .a              (lo),
            .b              (hi),
            .y              (hi_or_lo)
        );
    mux2 #(32) hi_lo_mux(
            .sel            (mf_hi_lo),
            .a              (return_address),
            .b              (hi_or_lo),
            .y              (write_value)   
        );
    mux2 #(5) jal_mux2 (
            .sel            (jal),
            .a              (rf_wa),
            .b              (5'b11111),
            .y              (write_address)
        );
    mux2 #(32) pc_jmp_mux (
            .sel            (jump),
            .a              (pc_pre),
            .b              (jta),
            .y              (pc_next)
        );
    mux2 #(32) jr_mux (
            .sel            (jr),
            .a              (pc_next),
            .b              (alu_pa),
            .y              (pc_next2)
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
            .wa             (write_address),
            .wd             (write_value),
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
            .y              (alu_out)
        );

    // --- MEM Logic --- //
    mux2 #(32) rf_wd_mux (
            .sel            (dm2reg),
            .a              (alu_out),
            .b              (rd_dm),
            .y              (wd_rf)
        );

endmodule