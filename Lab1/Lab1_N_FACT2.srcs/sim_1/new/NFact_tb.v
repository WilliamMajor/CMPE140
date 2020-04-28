`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/09/2020 06:28:28 PM
// Design Name: 
// Module Name: NFact_tb
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


module NFact_tb;
reg[3:0]N;
reg go, clk;
wire[15:0]splitResult;
wire done, error;
integer i, idx, errorCount;

NFact DUT(
        .number         (N),
        .clk            (clk),
        .go             (go),
        .switch         (1'b0),
        .splitResult    (splitResult),
        .done           (done),
        .error          (error)
    );
        
        
        
task tick_tock;
    begin
        clk = 1;
        #2;
        clk = 0;
        #2;
    end
endtask



initial
begin
errorCount = 0;
N = 0;
clk = 0;
go = 1'b1;
tick_tock;
for (i = 0; i < 14; i = i + 1)
begin
N = i;
for (idx = 0; idx < 30; idx = idx + 1)
begin 
    tick_tock;
    if(done) 
    begin
        $finish;
//        case(N)
//            0: if(result != 1) errorCount = errorCount + 1;
//            1: if(result != 1) errorCount = errorCount + 1;
//            2: if(result != 2) errorCount = errorCount + 1;
//            3: if(result != 6) errorCount = errorCount + 1;
//            4: if(result != 24) errorCount = errorCount + 1;
//            5: if(result != 120) errorCount = errorCount + 1;
//            6: if(result != 720) errorCount = errorCount + 1;
//            7: if(result != 5040) errorCount = errorCount + 1;
//            8: if(result != 40320) errorCount = errorCount + 1;
//            9: if(result != 362880) errorCount = errorCount + 1;
//            10: if(result != 3628800) errorCount = errorCount + 1;
//            11: if(result != 39916800) errorCount = errorCount + 1;
//            12: if(result != 479001600) errorCount = errorCount + 1;
//            13: if(error != 1) errorCount = errorCount + 1;
//        endcase
    end
end
end
$finish;
end
endmodule
