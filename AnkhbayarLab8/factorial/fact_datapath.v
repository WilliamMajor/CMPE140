`timescale 1ns / 1ps

module fact_datapath(
    input wire clk,
    input wire rst,
    input wire [3:0] n,
    input wire sel1, 
    input wire sel2,
    input wire Load_cnt,
    input wire Load_reg,
    input wire EN,
    output wire compared,
    output wire error,
    output wire [31:0] product
    );
    wire [3:0] correct;
    wire [3:0] cnt_Q;
    wire [31:0] z, out, out1, register_Q;
    check_error check_error_1(n, correct, error);
    cnt cnt_1(clk, rst, Load_cnt, EN, correct, cnt_Q);
    cmp cmp_1(cnt_Q, compared);
    mux2to1 mux2to1_1(sel1, z, out);
    mul mul_1(cnt_Q, out1, z);
    mux1to2 mux1to2_1(sel2, register_Q, out1, product);
    register register_1(Load_reg, clk, out, register_Q);
endmodule
