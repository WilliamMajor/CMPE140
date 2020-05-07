module MEM(
    input wire clk,
    input wire [31:0] hi_regE,
    input wire [31:0] lo_regE,
    input wire we_dmE,
    input wire hi_loE,
    input wire mf_hi_loE,
    input wire [31:0] pc_plus4E,
    input wire dm2_regE,
    input wire we_regE,
    input wire jalE,
    input wire [31:0] alu_outE,
    input wire [31:0] wd_dmE,
    input wire [4:0] rf_waE,
    output reg dm2_regM,
    output reg we_regM,
    output reg jalM,
    output reg [31:0] alu_outM,
    output reg [31:0] wd_dmM,
    output reg [4:0] rf_waM,
    output reg [31:0] pc_plus4M,
    output reg hi_loM,
    output reg mf_hi_loM,
    output reg [31:0] hi_regM,
    output reg [31:0] lo_regM,
    output reg we_dmM
);
    always@(posedge clk)
    begin
        pc_plus4M <= pc_plus4E;
        dm2_regM <= dm2_regE;
        wd_dmM <= wd_dmE;
        we_regM <= we_regE;
        jalM <= jalE;
        alu_outM <= alu_outE;
        wd_dmM <= wd_dmE;
        rf_waM <= rf_waE;
        hi_loM <= hi_loE;
        mf_hi_loM<= mf_hi_loE;
        hi_regM <= hi_regE;
        lo_regM <= lo_regE;
        we_dmM <= we_dmE;
    end 
endmodule