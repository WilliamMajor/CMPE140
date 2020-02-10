`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2020 06:30:15 PM
// Design Name: 
// Module Name: NFactCU
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


module NFactCU(
        input go, clk, gt, error,
        output reg outEn, loadCnt, loadReg, en, sel, done
    );
    
    reg[2:0] cs, ns;
    reg[5:0] ctrl;
    
    
    
    parameter   START = 3'b000,
                LOAD = 3'b001,
                WAIT = 3'b010,
                MULT = 3'b011,
                DONE = 3'b100;
                
      // Control signal parameters
      // state    |   outEn  | loadCnt  | loadReg |   en  |   sel  | done |
      // START    |     0    |     0    |    0    |   0   |    0   |   0  |
      // LOAD     |     0    |     1    |    1    |   0   |    0   |   0  |
      // WAIT     |     0    |     0    |    0    |   0   |    0   |   0  |
      // MULTIPLY |     0    |     0    |    1    |   1   |    1   |   0  |
      // DONE     |     1    |     0    |    0    |   0   |    1   |   1  |
                
    parameter   START_out    = 6'b100010,
                LOAD_out     = 6'b111010,
                WAIT_out     = 6'b100010,
                MULT_out     = 6'b101100,
                DONE_out     = 6'b000001;
                
 
                
    initial
    begin
        cs = 3'b0;
        ns = 3'b0;
    end
    
    always @ (ctrl) {outEn, loadCnt, loadReg, en, sel, done} = ctrl;
    
    always @(posedge clk) cs = ns;
    
    always @(go, gt, cs)
    begin
        case(cs)
            START:    begin ns <= (go && !error) ? LOAD : START; $display (error); end
            LOAD:     ns <= WAIT;
            WAIT:     ns <= gt ? MULT : DONE;
            MULT:     ns <= WAIT;
            DONE:     ns <= START;
        endcase
        
    end
    
    always @(cs, go)
    begin
        case(cs)
        START:    ctrl = START_out;
        LOAD:     ctrl = LOAD_out;
        WAIT:     ctrl = WAIT_out;
        MULT:     ctrl = MULT_out;
        DONE:     ctrl = DONE_out;
        
        endcase
    end
    
endmodule
