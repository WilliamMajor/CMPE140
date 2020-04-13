module alu (
        input  wire [2:0]  op,
        input  wire [31:0] a,
        input  wire [31:0] b,
        output wire        zero,
        output reg  [31:0] y,
        output reg [31:0] d_hi // added for MULTU isntead of creating a MULTU module
    );

    assign zero = (y == 0);

    always @ (op, a, b) begin
        case (op)
            3'b000: 
            begin
            d_hi <= 0;
            y <= a & b;
            end
            3'b001:
            begin 
            d_hi <= 0;
            y <= a | b;
            end
            3'b010:
            begin 
            d_hi <= 0;
            y <= a + b;
            end
            3'b110:
            begin 
            y <= a - b;
            d_hi <= 0;
            end
            3'b111: 
            begin
            y <= (a < b) ? 1 : 0;
            d_hi <= 0;
            end
            3'b011: {d_hi,y} = a * b; // added for multu operation
        endcase
    end

endmodule