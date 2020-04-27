module mux4to1 (
    input wire [1:0] RdSel,
    input wire [31:0] a, b, c, d,
    output reg [31:0] ReadData
    );
    
    always@(*)
    begin
        case(RdSel)
            2'b00:
                begin
                    ReadData = a;
                end
            2'b01:
                begin
                    ReadData = b;
                end
            2'b10:
                begin
                    ReadData = c;
                end
            2'b11:
                begin
                    ReadData = d;
                end
            default:   
                begin
                    ReadData = 31'bx;
                end
        endcase    
    end                        
endmodule
