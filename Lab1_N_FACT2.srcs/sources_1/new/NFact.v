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
    input clk, go, switch,
    output [15:0] splitResult,
    output done, error
    );
    
wire loadCnt, loadReg, en, sel, outEn, gt, highlowSel;
NFactDP DP (
        .number     (number),
        .loadCnt    (loadCnt),
        .loadReg    (loadReg),
        .en         (en),
        .clk        (clk),
        .sel        (sel),
        .outEn      (outEn),
        .highlow    (highlowSel),
        .splitResult(splitResult),
        .gt         (gt),
        .error      (error)
    );
    
NFactCU CU (
        .go         (go),
        .clk        (clk),
        .gt         (gt),
        .error      (error),
        .highlow    (switch),
        .outEn      (outEn),
        .loadCnt    (loadCnt),
        .loadReg    (loadReg),
        .en         (en),
        .sel        (sel),
        .highlowSel (highlowSel),
        .done       (done)
    );
endmodule
