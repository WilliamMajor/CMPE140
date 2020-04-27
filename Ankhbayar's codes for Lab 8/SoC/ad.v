module ad(
    input wire      WE,
    input wire [3:0] A,
    output reg WE1, WE2, WEM,
    output reg [1:0] RdSel
    );
    
    
    always@(*)
    begin
        case(A)
            4'b1000:
                begin
                    WE1 = WE;
                    WE2 = 1'b0;
                    WEM = 1'b0; 
                    RdSel = 2'b10;
                end
            4'b1001:
                begin
                    WE1 = 1'b0;
                    WE2 = WE;
                    WEM = 1'b0;
                    RdSel = 2'b11;
                end
            4'b0000:
                begin
                    WE1 = 1'b0;
                    WE2 = 1'b0;
                    WEM = WE;
                    RdSel = 2'b00;
                end
            default:
                begin
                    WE1 = 1'bx;
                    WE2 = 1'bx;
                    WEM = 1'bx;
                    RdSel = 2'bxx;
                end
        endcase
    end

 
    
endmodule
