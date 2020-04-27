`timescale 1ns / 1ps

module mux2to1(
        input  wire             sel,
        input  wire [31:0] d0,
        output wire [31:0] out
    );

    assign out = (sel == 1'b1) ? d0 : 32'b0000_0000_0000_0000_0000_0000_0000_0001;
    
endmodule
