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
wire[31:0]result;
wire done, error;
integer i, idx;

NFact DUT(
        .number     (N),
        .clk        (clk),
        .go         (go),
        .result     (result),
        .done       (done),
        .error      (error)
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
    if(done) idx = 30;
end
end
$finish;
end
endmodule
