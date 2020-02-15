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
        input go, clk, gt, error, highlow,
        output reg outEn, loadCnt, loadReg, en, sel, highlowSel, done
    );
    
    reg[2:0] cs, ns;
    reg[6:0] ctrl;
    
    
    
    parameter   START = 3'b000,
                LOAD = 3'b001,
                WAIT = 3'b010,
                MULT = 3'b011,
                DONEH = 3'b100,
                DONEL = 3'b101;
                
      // Control signal parameters
      // state    |   outEn  | loadCnt  | loadReg |   en  |   sel  | highlow |done |
      // START    |     0    |     0    |    0    |   0   |    0   |    0    |  0  |
      // LOAD     |     0    |     1    |    1    |   0   |    0   |    0    |  0  |
      // WAIT     |     0    |     0    |    0    |   0   |    0   |    0    |  0  |
      // MULTIPLY |     0    |     0    |    1    |   1   |    1   |    0    |  0  |
      // DONE     |     1    |     0    |    0    |   0   |    1   |   1/0   |  1  |
                
    parameter   START_out    = 7'b1000100,
                LOAD_out     = 7'b1110100,
                WAIT_out     = 7'b1000100,
                MULT_out     = 7'b1011000,
                DONE_outh    = 7'b0000011,               
                DONE_outl    = 7'b0000001;
                
 
                
    initial
    begin
        cs = 3'b0;
        ns = 3'b0;
    end
    
    always @ (ctrl) {outEn, loadCnt, loadReg, en, sel, highlowSel ,done} = ctrl;
    
    always @(posedge clk) cs = ns;
    
    always @(go, gt, cs, error, highlowSel, highlow)
    begin
        case(cs)
            START:    begin ns <= (go && !error) ? LOAD : START; $display (error); end
            LOAD:     ns <= WAIT;
            WAIT:     begin if(gt) ns <= MULT;
                      else if(highlow) ns <= DONEH;
                      else ns <= DONEL;end
            MULT:     ns <= WAIT;
            DONEH:    begin if(highlow)ns <= START;
                          else ns <= DONEL; end
            DONEL:    begin if(!highlow)ns <= START;
                          else ns <= DONEH; end
        endcase
        
    end
    
    always @(cs, go)
    begin
        case(cs)
        START:    ctrl = START_out;
        LOAD:     ctrl = LOAD_out;
        WAIT:     ctrl = WAIT_out;
        MULT:     ctrl = MULT_out;
        DONEH:    ctrl = DONE_outh;
        DONEL:    ctrl = DONE_outl;
        
        endcase
    end
    
endmodule
