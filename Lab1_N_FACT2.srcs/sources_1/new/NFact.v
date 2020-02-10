`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2020 06:34:09 PM
// Design Name: 
// Module Name: NFact
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module NFact(
    input [3:0] number,
    input clk, go,
    output [31:0] result,
    output done, error
    );
    
wire loadCnt, loadReg, en, sel, outEn, gt;
NFactDP DP (
        .number     (number),
        .loadCnt    (loadCnt),
        .loadReg    (loadReg),
        .en         (en),
        .clk        (clk),
        .sel        (sel),
        .outEn      (outEn),
        .result     (result),
        .gt         (gt),
        .error      (error)
    );
    
NFactCU CU (
        .go         (go),
        .clk        (clk),
        .gt         (gt),
        .error      (error),
        .outEn      (outEn),
        .loadCnt    (loadCnt),
        .loadReg    (loadReg),
        .en         (en),
        .sel        (sel),
        .done       (done)
    );
endmodule
