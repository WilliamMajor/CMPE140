module EX(
    input wire clk,
    input wire flushE,
    input wire [31:0] sext_imm,
    input wire [31:0] alu_pa,
    input wire [31:0] wd_dm,
    input wire [31:0] pc_plus4D,  
    input wire [4:0] shift,   
    input wire mf_hi_lo,   
    input wire hi_lo,       
    input wire dm2_reg,    
    input wire we_dm,
    input wire alu_src,           
    input wire [2:0] alu_ctrl,   
    input wire reg_dst,    
    input wire we_reg,         
    input wire jal,          
    input wire [4:0] rsD,    
    input wire [4:0] rtD,     
    input wire [4:0] rdD,     
    output reg mf_hi_loE,
    output reg hi_loE,
    output reg dm2_regE,
    output reg we_dmE,
    output reg [2:0] alu_ctrlE,
    output reg reg_dstE,
    output reg we_regE,
    output reg jalE,
    output reg [4:0] rsE,
    output reg [4:0] rtE,
    output reg [4:0] rdE,
    output reg [31:0] pc_plus4E,
    output reg [4:0] shiftE,
    output reg alu_srcE,
    output reg [31:0] alu_paE,
    output reg [31:0] wd_dmE,
    output reg [31:0] sext_immE
);

    always@(posedge clk)
    begin
    if(flushE)
    begin
                pc_plus4E <= 0;
                mf_hi_loE <= 0;
                hi_loE <= 0;
                dm2_regE <= 0;
                we_dmE <= 0;
                alu_ctrlE <= 0;
                we_regE <= 0;
                reg_dstE <= 0;
                jalE <= 0;
                rsE <= 0;
                rtE <= 0;
                rdE <= 0;
                shiftE <= 0;
                alu_srcE <= 0;
                alu_paE <= 0;
                wd_dmE <= 0;
                sext_immE <= 0;
    end
    else
    begin
                pc_plus4E <= pc_plus4D;
                mf_hi_loE <= mf_hi_lo;
                hi_loE <= hi_lo;
                dm2_regE <= dm2_reg;
                we_dmE <= we_dm;
                alu_ctrlE <= alu_ctrl;
                we_regE <= we_reg;
                reg_dstE <= reg_dst;
                jalE <= jal;
                rsE <= rsD;
                rtE <= rtD;
                rdE <= rdD;
                shiftE <= shift;
                alu_srcE <= alu_src;
                alu_paE <= alu_pa;
                wd_dmE <= wd_dm;
                sext_immE <= sext_imm;
    end
    end
endmodule