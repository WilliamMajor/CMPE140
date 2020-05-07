
module ID(
    input wire clk,
    input wire [31:0] instrF,
    input wire stallD,
    input wire [31:0] pc_plus4F,
    output reg [31:0] instrD,
    output reg [31:0] pc_plus4D
    );
    
    always@(posedge clk)
    begin
    if(stallD)
    begin
        instrD <= instrD;
        pc_plus4D <= pc_plus4D;
    end
    else
        begin
            instrD <= instrF;
            pc_plus4D <= pc_plus4F;
        end
    end
    
endmodule
