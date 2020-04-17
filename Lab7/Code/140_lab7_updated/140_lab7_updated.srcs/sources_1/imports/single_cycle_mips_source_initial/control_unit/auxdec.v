module auxdec (
        input  wire [1:0] alu_op,
        input  wire [5:0] funct,
        output reg       [1:0]hi_lo_ren, //added for multu
        output reg       [1:0]hi_lo_wen, //added for multu
        output reg  hi_lo_sel, wbmux1_sel, wbmux3_sel, left_or_right,
        output reg JR,
        
        output wire [2:0] alu_ctrl
        
    );

    reg [2:0] ctrl;
    assign {alu_ctrl} = ctrl;

    always @ (alu_op, funct) begin
        case (alu_op)
            2'b00:
            begin
                            ctrl = 3'b010;          // ADD
                            hi_lo_ren <= 2'b00;
                            hi_lo_wen <= 2'b00;
                            hi_lo_sel <= 0;
                            wbmux1_sel <= 0;
                            wbmux3_sel <= 0;
                            left_or_right <= 0;
                            JR<=0;
            end
            2'b01:
            begin
                            ctrl = 3'b110;          // SUB
                            hi_lo_ren <= 2'b00;
                            hi_lo_wen <= 2'b00;
                            hi_lo_sel <= 0;
                            wbmux1_sel <= 0;
                            wbmux3_sel <= 0;
                            left_or_right <= 0;
                            JR<=0;
            end
            2'b10:
            begin //JAL
                            ctrl = 3'b000;          
                            hi_lo_ren <= 2'b00;
                            hi_lo_wen <= 2'b00;
                            hi_lo_sel <= 0;
                            wbmux1_sel <= 0;
                            wbmux3_sel <= 0;
                            left_or_right <= 0;
                            JR<=1;
            end
            default: case (funct)
                6'b10_0100:
                begin
                            ctrl <= 3'b000; // AND
                            hi_lo_ren <= 2'b00;
                            hi_lo_wen <= 2'b00;
                            hi_lo_sel <= 0;
                            wbmux1_sel <= 0;
                            wbmux3_sel <= 0;
                            left_or_right <= 0;
                            JR<=0;
                            
                end
                6'b10_0101: 
                begin
                            ctrl <= 3'b001; // OR
                            hi_lo_ren <= 2'b00;
                            hi_lo_wen <= 2'b00;
                            hi_lo_sel <= 0;
                            wbmux1_sel <= 0;
                            wbmux3_sel <= 0;
                            left_or_right <= 0;
                            JR<=0;
                
                end
                6'b10_0000:
                begin
                            ctrl <= 3'b010; // ADD
                            hi_lo_ren <= 2'b00;
                            hi_lo_wen <= 2'b00;
                            hi_lo_sel <= 0;
                            wbmux1_sel <= 0;
                            wbmux3_sel <= 0;
                            left_or_right <= 0;
                            JR<=0;
                end
                6'b01_1001:
                begin
                            hi_lo_ren <= 2'b11;
                            hi_lo_wen <= 2'b00;
                            hi_lo_sel <= 0;
                            wbmux1_sel <= 0;
                            wbmux3_sel <= 0;
                            left_or_right <= 0;
                            ctrl <= 3'b011; // MULTU
                            JR<=0;
                end        
                6'b10_0010: 
                begin
                            hi_lo_ren = 2'b00;
                            hi_lo_wen = 2'b00;
                            ctrl = 3'b110; // SUB
                            hi_lo_sel <= 0;
                            wbmux1_sel <= 0;
                            wbmux3_sel <= 0;
                            left_or_right <= 0;
                            JR<=0;
                end
                6'b10_1010: 
                begin
                            hi_lo_ren = 2'b00;
                            hi_lo_wen = 2'b00;
                            ctrl = 3'b111; // SLT
                            hi_lo_sel <= 0;
                            wbmux1_sel <= 0;
                            wbmux3_sel <= 0;
                            left_or_right <= 0;
                            JR<=0;
                            
                end
                6'b01_0000:
                begin //MFHI
                            ctrl = 3'b000; 
                            hi_lo_ren = 2'b00;
                            hi_lo_wen = 2'b10;
                            hi_lo_sel <= 1;
                            wbmux1_sel <= 1;
                            wbmux3_sel <= 0;
                            left_or_right <= 0;
                            JR<=0;
                end
                6'b01_0010:
                begin //MFLO
                            ctrl = 3'b000;
                            hi_lo_ren = 2'b00;
                            hi_lo_wen = 2'b01;
                            hi_lo_sel <= 0;
                            wbmux1_sel <= 1;
                            wbmux3_sel <= 0;
                            left_or_right <= 0;
                            JR<=0;
                end
                6'b00_0000:
                begin //SLL
                            ctrl = 3'b000;
                            hi_lo_ren = 2'b00;
                            hi_lo_wen = 2'b00;           
                            hi_lo_sel <= 0;
                            wbmux1_sel <= 0;
                            wbmux3_sel <= 1;
                            left_or_right <= 0;           
                            JR<=0;
                                  
                
                end
                6'b00_0010:
                begin //SRL
                            ctrl = 3'b000;
                            hi_lo_ren = 2'b00;
                            hi_lo_wen = 2'b00;
                            hi_lo_sel <= 0;
                            wbmux1_sel <= 0;
                            wbmux3_sel <= 1;
                            left_or_right <= 1;
                            JR<=0;
                end
                6'b00_1000:
                begin //JR
                            ctrl = 3'b011;
                            hi_lo_ren = 2'b00;
                            hi_lo_wen = 2'b00;
                            hi_lo_sel <= 0;
                            wbmux1_sel <= 0;
                            wbmux3_sel <= 0;
                            left_or_right <= 0;
                            JR<=1;
                end
                
                default:    
                begin
                            hi_lo_ren = 2'b00;
                            hi_lo_wen = 2'b00;
                            ctrl = 3'bxxx;
                            hi_lo_sel <= 0;
                            wbmux1_sel <= 0;
                            wbmux3_sel <= 0;
                            left_or_right <= 0;
                            JR<=0;
                end
            endcase
        endcase
    end

endmodule