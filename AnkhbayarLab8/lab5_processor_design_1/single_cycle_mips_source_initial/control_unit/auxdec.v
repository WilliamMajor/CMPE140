module auxdec (
        input  wire [1:0] alu_op,
        input  wire [5:0] funct,
        output wire [2:0] alu_ctrl,
        output wire       hi_lo,
        output wire       jr,
        output wire       mf_hi_lo
    );

    reg [5:0] ctrl;
    assign {alu_ctrl, hi_lo, jr, mf_hi_lo} = ctrl;
    always @ (alu_op, funct) begin
        case (alu_op)
            2'b00: ctrl = 6'b010_0_0_0;          // ADD
            2'b01: ctrl = 6'b110_0_0_0;          // SUB
            default: case (funct)
                6'b10_0100: ctrl = 6'b000_0_0_0; // AND
                6'b10_0101: ctrl = 6'b001_0_0_0; // OR
                6'b10_0000: ctrl = 6'b010_0_0_0; // ADD
                6'b10_0010: ctrl = 6'b110_0_0_0; // SUB
                6'b10_1010: ctrl = 6'b111_0_0_0; // SLT
                6'b00_0010: ctrl = 6'b100_0_0_0; // shift right
                6'b00_0000: ctrl = 6'b011_0_0_0; // shift left
                6'b00_1000: ctrl = 6'bxxx_0_1_0; // jr 
                6'b01_0010: ctrl = 6'bxxx_0_0_1; // mflo
                6'b01_0000: ctrl = 6'bxxx_1_0_1; // mfhi
                6'b01_1001: ctrl = 6'b101_0_0_0; // multu
                default:    ctrl = 6'bxxx_0_0_0;
            endcase
        endcase
    end

endmodule