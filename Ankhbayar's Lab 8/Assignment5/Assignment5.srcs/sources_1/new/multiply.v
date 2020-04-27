`timescale 1ns / 1ps

module multiply(
    input  wire [31:0]          a,
    input  wire [31:0]          b,
    input  wire                 clk,
    input  wire [2:0]           ctrl,
    output wire [31:0]          lo,
    output wire [31:0]          hi
    );
    reg [63:0] sum;
    always@(ctrl)
    begin
        if(ctrl == 3'b101)
        begin   
            sum = a * b;
        end
    end
    assign lo = sum[31:0];
    assign hi = sum[63:0];
    
    /*
    reg [31:0] a_temp, b_temp;
    reg [63:0] sum_temp[1:0];
    assign lo = sum[31:0];
    assign hi = sum[63:32];
    integer i;
    
    assign sum = sum_temp[1];
    
    always@(posedge clk, ctrl)
    begin
        if(ctrl == 3'b101)
        begin
            a_temp <= a;
            b_temp <= b;
            sum_temp[0] <= a_temp * b_temp;
            for(i = 1; i < 2; i = i +1)
            begin
                sum_temp[i] <= sum_temp[i-1];
            end
        end
   end
   */
endmodule
