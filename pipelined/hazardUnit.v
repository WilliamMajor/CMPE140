module hazardUnit(
    input wire [4:0] rsD,
    input wire [4:0] rtD,
    input wire [4:0] rsE,
    input wire [4:0] rtE,
    input wire dm2_regE,
    output reg stallF,
    output reg stallD,
    output reg flushE
    );
    
    reg lwstall;
    always@(*)
    begin
    lwstall = ((rsD == rtE) | (rtD == rtE)) & dm2_regE;
    stallF = lwstall;
    stallD = lwstall;
    flushE = lwstall;
    end
        
endmodule
