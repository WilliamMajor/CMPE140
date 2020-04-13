module auxdec (
        input  wire [1:0] alu_op,
        input  wire [5:0] funct,
        output reg       [1:0]hi_lo_ren, //added for multu
        output reg       [1:0]hi_lo_wen, //added for multu
        output reg  hi_lo_sel, wbmux1_sel, wbmux2_sel, wbmux3_sel,
        output wire [2:0] alu_ctrl
        
    );

    reg [2:0] ctrl;
    assign {alu_ctrl} = ctrl;

    always @ (alu_op, funct) begin
        case (alu_op)
            2'b00: ctrl = 3'b010;          // ADD
            2'b01: ctrl = 3'b110;          // SUB
            default: case (funct)
                6'b10_0100:
                begin
                            ctrl <= 3'b000; // AND
                            hi_lo_ren <= 2'b00;
                            hi_lo_wen <= 2'b00;
                end
                6'b10_0101: 
                begin
                            ctrl <= 3'b001; // OR
                            hi_lo_ren <= 2'b00;
                            hi_lo_wen <= 2'b00;
                
                end
                6'b10_0000:
                begin
                            ctrl <= 3'b010; // ADD
                            hi_lo_ren <= 2'b00;
                            hi_lo_wen <= 2'b00;
                end
                6'b01_1001:
                begin
                            hi_lo_ren <= 2'b11;
                            hi_lo_wen <= 2'b00;
                            ctrl <= 3'b011; // MULTU
                end        
                6'b10_0010: 
                begin
                            hi_lo_ren = 2'b00;
                            hi_lo_wen = 2'b00;
                            ctrl = 3'b110; // SUB
                end
                6'b10_1010: 
                begin
                            hi_lo_ren = 2'b00;
                            hi_lo_wen = 2'b00;
                            ctrl = 3'b111; // SLT
                            
                end
                6'b01_0000:
                begin //MFHI
                            ctrl = 3'b000; 
                            hi_lo_ren = 2'b00;
                            hi_lo_wen = 2'b10;
                end
                6'b01_0010:
                begin //MFLO
                            ctrl = 3'b000;
                            hi_lo_ren = 2'b00;
                            hi_lo_wen = 2'b01;
                end
                default:    
                begin
                            hi_lo_ren = 2'b00;
                            hi_lo_wen = 2'b00;
                            ctrl = 3'bxxx;
                end
            endcase
        endcase
    end

endmodule