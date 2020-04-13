module maindec (
        input  wire [5:0] opcode,
        output wire       branch,
        output wire [1:0] jump,
        output wire       reg_dst,
        output wire       we_reg,
        output wire       alu_src,
        output wire       we_dm,
        output wire       jal_sel,
        output wire       dm2reg,
        output wire [1:0] alu_op
    );

    reg [10:0] ctrl;

    assign {branch, jump, reg_dst, we_reg, alu_src, we_dm, dm2reg, alu_op, jal_sel} = ctrl;

    always @ (opcode) begin
        case (opcode)
            6'b00_0000: ctrl = 11'b0_00_1_1_0_0_0_10_0; // R-type
            6'b00_1000: ctrl = 11'b0_00_0_1_1_0_0_00_0; // ADDI
            6'b00_0100: ctrl = 11'b1_00_0_0_0_0_0_01_0; // BEQ
            6'b00_0010: ctrl = 11'b0_01_0_0_0_0_0_00_0; // J
            6'b00_0011: ctrl = 10'b0_10_0_0_0_0_0_00_1; // JAL
            6'b10_1011: ctrl = 11'b0_00_0_0_1_1_0_00_0; // SW
            6'b10_0011: ctrl = 11'b0_00_0_1_1_0_1_00_0; // LW
            default:    ctrl = 11'bx_xx_x_x_x_x_x_xx;
        endcase
    end

endmodule