module alu (
        input  wire [2:0]  op,
        input  wire [31:0] a,
        input  wire [31:0] b,
        output wire        zero,
        output reg  [31:0] y
    );

    assign zero = (y == 0);

    always @ (op, a, b) begin
        case (op)
            3'b000: 
            begin
            y <= a & b; //AND
            end
            3'b001:
            begin 
            y <= a | b; //OR
            end
            3'b010:
            begin 
            y <= a + b; //ADD
            end
            3'b110:
            begin 
            y <= a - b; //SUB
            end
            3'b111: 
            begin
            y <= (a < b) ? 1 : 0; //LT COMP
            end
            3'b011: //JR
            begin
            y <= 32'b0;
            end
        endcase
    end

endmodule