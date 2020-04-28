`timescale 1ns / 1ps

module factorial(
    input wire clk, 
    input wire rst,
    input wire [3:0] n,
    input wire Go,
    output wire Done,
    output wire Err,
    output wire [31:0] nf
    );
    wire sel1, sel2, Load_cnt, Load_reg, EN, compared;
    fact_datapath datapath_1(clk, rst, n, sel1, sel2, Load_cnt, Load_reg, EN, compared, Err, nf); 
    fact_cu cu_1(clk, rst, Go, compared, Err, sel1, sel2, Load_cnt, Load_reg, EN, Done);
    
endmodule
