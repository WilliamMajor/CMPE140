module ad(
    input wire      WE,
    input wire [31:0] A,
    output reg WE1, WE2, WEM,
    output reg [1:0] RdSel
    );
    always@(*)
    begin
        if(A <= 252)
        begin
            WE1 = 1'b0;
            WE2 = 1'b0;
            WEM = WE;
            RdSel = 2'b00;
        end
        
        else if(A <= 2060 && A >= 2048)
        begin
            WE1 = WE;
            WE2 = 1'b0;
            WEM = 1'b0; 
            RdSel = 2'b10;    
        end
        
        else if(A <= 2316 && A >= 2304)
        begin
            WE1 = 1'b0;
            WE2 = WE;
            WEM = 1'b0;
            RdSel = 2'b11;
        end
    end 

endmodule
