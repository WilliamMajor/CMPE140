module SoC_reg#(parameter width = 32)(
    input wire      clk, 
    input wire      rst,
    input wire [width - 1:0] D,
    input wire      EN,
    output reg [width - 1:0] Q
    );
    
    always@(posedge clk, posedge rst)
    begin
        if(rst)
            Q <= 0;
        else if(EN)
            Q <= D;
        else
            Q <= Q;
    end
endmodule
