module datapath (
        input  wire        clk,
        input  wire        rst,
        input  wire        branch,
        input  wire        jump,
        input  wire        we_dm,
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
        output wire [31:0] alu_outM,
        output wire [31:0] wd_dmM,
        output wire [31:0] rd3,
        output wire [31:0] instrD,
        output wire we_dmM
    );

    wire [4:0]  rf_waE;
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
    wire [31:0] alu_pbE;
    wire [31:0] wd_rf;
    wire        zeroE;
    wire [31:0] return_address;
    wire [31:0] write_value;
    wire [4:0] write_address;
    wire [31:0] hi;
    wire [31:0] lo;
    wire [31:0] hi_or_lo;
    wire [31:0] pc_plus4D;
    wire [31:0] alu_outE;
    
    wire mf_hi_loE, hi_loE, dm2_regE, we_dmE, reg_dstE, jumpE, jalE, jrE, we_regE;
    wire [2:0] alu_ctrlE;
    wire [4:0] rsE, rtE, rdE;
    wire [31:0] pc_plus4E;
    wire [4:0] shiftE;
    wire [31:0] alu_paE;
    wire [31:0] wd_dmE;    
    wire [31:0] pc_plus4M;
    wire dm2_regM, jalM, zeroM, we_regM;
    wire [31:0] wd_dm;
    wire [31:0] alu_outW;
    wire dm2_regW, we_regW, jalW;
    wire [31:0] pc_plus4W, rd_dmW;
    wire [4:0] rf_waW;
    wire [31:0] wd_rfW;
    wire [4:0] rf_waM;
    wire hi_loM, mf_hi_loM, mf_hi_loW;
    wire [31:0] hiE, loE;
    wire [31:0] hi_regM, lo_regM;
    wire alu_srcE;
    wire zeroD;
    wire [31:0] sext_immE;
    wire stallD, flushE;
    assign pc_src = branch & zeroD;
    assign ba = {sext_imm[29:0], 2'b00};
    assign jta = {pc_plus4D[31:28], instrD[25:0], 2'b00};
    
    // --- PC Logic --- //
    wire stallF;
    reg test;
    always@(pc_current, pc_next2)
    begin
        if(pc_next2 == 4)     test = 0;
        else if(pc_current == 0)  test = 1;
    end
    dreg pc_reg (
            .clk            (clk),
            .rst            (rst),
            .stallF         (stallF),
            .test           (test),
            .d              (pc_next2),
            .q              (pc_current)
        );
    adder pc_plus_4 (
            .a              (pc_current),
            .b              (32'd4),
            .y              (pc_plus4)
        );
    
    
    ID id   (
            .clk        (clk),
            .stallD     (stallD),
            .instrF     (instr),
            .pc_plus4F   (pc_plus4),
            .instrD     (instrD),
            .pc_plus4D   (pc_plus4D)
    );
    
    EX exe (    
        .clk       (clk),
        .flushE     (flushE),
        .sext_imm   (sext_imm),
        .pc_plus4D  (pc_plus4D),   
        .shift      (instrD[10:6]),  
        .mf_hi_lo   (mf_hi_lo),      
        .hi_lo      (hi_lo),
        .we_dm      (we_dm),
        .alu_src    (alu_src),        
        .we_reg     (we_reg),         
        .dm2_reg    (dm2reg),    
        .alu_ctrl   (alu_ctrl),  
        .reg_dst    (reg_dst),   
        .jal        (jal),      
        .rsD        (instrD[25:21]),  
        .rtD        (instrD[20:16]), 
        .rdD        (instrD[15:11]),  
        .pc_plus4E  (pc_plus4E),
        .shiftE      (shiftE),
        .mf_hi_loE   (mf_hi_loE),
        .hi_loE      (hi_loE),
        .alu_srcE    (alu_srcE),
        .we_regE     (we_regE),
        .dm2_regE    (dm2_regE),
        .alu_ctrlE   (alu_ctrlE),
        .reg_dstE    (reg_dstE),
        .we_dmE      (we_dmE),
        .jalE        (jalE),
        .rsE        (rsE),
        .rtE        (rtE),
        .rdE        (rdE),
        .alu_pa     (alu_pa),
        .alu_paE    (alu_paE),
        .wd_dm      (wd_dm),
        .wd_dmE     (wd_dmE),
        .sext_immE  (sext_immE)
    );
    
    MEM mem (
        .clk        (clk),
        .we_dmE     (we_dmE),
        .hi_regE    (hiE),
        .lo_regE    (loE),
        .hi_loE     (hi_loE),
        .mf_hi_loE  (mf_hi_loE),
        .pc_plus4E   (pc_plus4E),
        .dm2_regE    (dm2_regE),
        .wd_dmE     (wd_dmE),
        .we_regE     (we_regE),
        .jalE       (jalE),
        .alu_outE   (alu_outE),
        .rf_waE     (rf_waE),
        .pc_plus4M   (pc_plus4M),
        .dm2_regM    (dm2_regM),
        .we_regM     (we_regM),
        .jalM       (jalM),
        .alu_outM   (alu_outM),
        .wd_dmM     (wd_dmM),
        .rf_waM     (rf_waM),
        .hi_loM     (hi_loM),
        .mf_hi_loM   (mf_hi_loM),
        .hi_regM    (hi_regM),
        .lo_regM    (lo_regM), 
        .we_dmM     (we_dmM)
    );
    
    
    WB wb (
        .clk        (clk),
        .mf_hi_loM  (mf_hi_loM),
        .dm2_regM   (dm2_regM),
        .we_regM    (we_regM),
        .jalM       (jalM),
        .pc_plus4M  (pc_plus4M),
        .alu_outM   (alu_outM),
        .rd_dmM     (rd_dm),
        .rf_waM     (rf_waM),
        .dm2_regW   (dm2_regW),
        .we_regW    (we_regW),
        .jalW       (jalW),
        .pc_plus4W  (pc_plus4W),
        .alu_outW   (alu_outW),
        .rd_dmW     (rd_dmW),
        .rf_waW     (rf_waW),
        .mf_hi_loW  (mf_hi_loW)
    );

    hazardUnit hazard(
        .rsD    (instrD[25:21]),
        .rtD    (instrD[20:16]),
        .rsE    (rsE),
        .rtE    (rtE),
        .dm2_regE   (dm2_regE),
        .stallF     (stallF),
        .stallD     (stallD),
        .flushE     (flushE)
    );
    compared comp(
        .op     (alu_ctrl),
        .a      (alu_pa),
        .b      (wd_dm),
        .zero   (zeroD)
    );
    
    adder pc_plus_br (
            .a              (pc_plus4D),
            .b              (ba),
            .y              (bta)
        );
    multiply multiply1 (
            .a              (alu_paE),
            .b              (alu_pbE),
            .clk            (clk),
            .ctrl           (alu_ctrlE),
            .hi             (hiE),
            .lo             (loE)
            );

    mux2 #(32) pc_src_mux (
            .sel            (pc_src),
            .a              (pc_plus4),
            .b              (bta),
            .y              (pc_pre)
        );
    
    mux2 #(32) jal_mux(
            .sel            (jalW),
            .a              (wd_rfW),
            .b              (pc_plus4W),
            .y              (return_address)
        );
    mux2 #(32) hi_lo_mux2(
            .sel            (hi_loM),
            .a              (lo_regM),
            .b              (hi_regM),
            .y              (hi_or_lo)
        );
    mux2 #(32) hi_lo_mux(
            .sel            (mf_hi_loW),
            .a              (return_address),
            .b              (hi_or_lo),
            .y              (write_value)   
        );
    mux2 #(5) jal_mux2 (
            .sel            (jalW),
            .a              (rf_waW),
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
            .sel            (reg_dstE),
            .a              (rtE),
            .b              (rdE),
            .y              (rf_waE)
        );

    regfile rf (
            .clk            (clk),
            .we             (we_regW),
            .ra1            (instrD[25:21]),
            .ra2            (instrD[20:16]),
            .ra3            (ra3),
            .wa             (write_address),
            .wd             (write_value),
            .rd1            (alu_pa),
            .rd2            (wd_dm),
            .rd3            (rd3)
        );

    signext se (
            .a              (instrD[15:0]),
            .y              (sext_imm)
        );

    // --- ALU Logic --- //
    mux2 #(32) alu_pb_mux (
            .sel            (alu_srcE),
            .a              (wd_dmE),
            .b              (sext_immE),
            .y              (alu_pbE)
        );

    alu alu (
            .op             (alu_ctrlE),
            .a              (alu_paE),
            .b              (alu_pbE),
            .shift_len      (shiftE),
            .zero           (zeroE),
            .y              (alu_outE)
        );

    // --- MEM Logic --- //
    mux2 #(32) rf_wd_mux (
            .sel            (dm2_regW),
            .a              (alu_outW),
            .b              (rd_dmW),
            .y              (wd_rfW)
        );
   
endmodule