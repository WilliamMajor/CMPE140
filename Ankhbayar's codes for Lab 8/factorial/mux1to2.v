`timescale 1ns / 1ps

module mux1to2(
        input  wire             sel,
        input  wire [31:0] d0,
        output wire [31:0] out1,
        output wire [31:0] out2
    );
    
    assign out1 = (sel == 1'b1) ? d0 : d0;
    assign out2 = (sel == 1'b1) ? 0 : d0;
    
endmodule
