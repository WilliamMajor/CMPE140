module WB(
    input wire clk,
    input wire mf_hi_loM,
    input wire dm2_regM,
    input wire we_regM,
    input wire jalM,
    input wire [31:0] pc_plus4M,
    input wire [31:0] alu_outM,
    input wire [31:0] rd_dmM,
    input wire [4:0] rf_waM,
    output reg dm2_regW,
    output reg we_regW,
    output reg jalW,
    output reg [31:0] alu_outW,
    output reg [31:0] rd_dmW,
    output reg [4:0] rf_waW,
    output reg [31:0] pc_plus4W,
    output reg mf_hi_loW
);

    always@(posedge clk)
    begin
        pc_plus4W <= pc_plus4M;
        dm2_regW <= dm2_regM;
        we_regW <= we_regM;
        alu_outW <= alu_outM;
        jalW <= jalM;
        rd_dmW <= rd_dmM;
        rf_waW <= rf_waM;
        mf_hi_loW <= mf_hi_loM;
    end
endmodule