`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2020 06:11:53 PM
// Design Name: 
// Module Name: NFactDP
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


module NFactDP(
        input [3:0] number,
        input loadCnt, loadReg, en, clk, sel, outEn, highlow,
        output [15:0] splitResult,
        output gt, error
    );
    
wire [3:0] cntOut;
wire [31:0] muxOut, multOut, regOut, result;


Comparitor ERR (
        .in1        (number),
        .in2        (4'd12),
        .gt         (error)
    );

Counter CNT (
        .cntIn      (number),
        .loadCnt    (loadCnt),
        .en         (en),
        .clk        (clk),
        .cntOut     (cntOut)
    );

Comparitor CMP (
        .in1        (cntOut),
        .in2        (4'b0001),
        .gt         (gt)
    );

Multiplier MLT (
        .in1        (cntOut),
        .in2        (regOut),
        .multOut    (multOut)
    );

Mux_2In MUX2_0 (
        .in1        (4'b0001),
        .in2        (multOut),
        .sel        (sel),
        .muxOut     (muxOut)
    );
    
Mux_2In MUX2_1 (
        .in1        (4'b0000),
        .in2        (regOut),
        .sel        (outEn),
        .muxOut     (result)
    );

Mux_2In MuxResults (
        .in1        (result[31:16]),
        .in2        (result[15:0]),
        .sel        (highlow),
        .muxOut     (splitResult)
    );
        

Register32  REG32 (
        .regIn      (muxOut),
        .loadReg    (loadReg),
        .clk        (clk),
        .regOut     (regOut)
    );

endmodule
