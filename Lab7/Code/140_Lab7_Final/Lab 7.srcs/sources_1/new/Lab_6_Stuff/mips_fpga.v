module mips_fpga
(
		input  wire       clk,
        input  wire       rst,
        input  wire       button,
        input  wire [8:0] switches,
        output wire       we_dm,
        output wire [3:0] LEDSEL,
        output wire [7:0] LEDOUT
);
    reg  [15:0] reg_hex;
    wire        clk_sec, clk_5KHz, clk_pb;
    wire [7:0]  digit0, digit1, digit2, digit3;
    wire [31:0] pc_current, instr, alu_out, wd_dm, rd_dm, dispData;
    
  clk_gen clk_gen (
		.clk100MHz          (clk),
		.rst                (rst),
		.clk_4sec           (clk_sec),
		.clk_5KHz           (clk_5KHz)
	);
   button_debouncer bd (
		.clk                (clk_5KHz),
		.button             (button),
		.debounced_button   (clk_pb)
	);
	mips_top mips_top (
		.clk				(clk_pb),
		.rst				(rst),
		.ra3				(switches[4:0]),
		.instr				(instr),
		.we_dm				(we_dm),
		.rd_dm				(rd_dm),
		.pc_current			(pc_current),
		.alu_out			(alu_out),
		.wd_dm				(wd_dm),
		.rd3				(dispData)	
	);
    
    hex_to_7seg hex3 (
            .HEX                (reg_hex[15:12]),
            .s                  (digit3)
        );

    hex_to_7seg hex2 (
            .HEX                (reg_hex[11:8]),
            .s                  (digit2)
        );

    hex_to_7seg hex1 (
            .HEX                (reg_hex[7:4]),
            .s                  (digit1)
        );

    hex_to_7seg hex0 (
            .HEX                (reg_hex[3:0]),
            .s                  (digit0)
        );

    led_mux led_mux (
            .clk                (clk_5KHz),
            .rst                (rst),
            .LED3               (digit3),
            .LED2               (digit2),
            .LED1               (digit1),
            .LED0               (digit0),
            .LEDSEL             (LEDSEL),
            .LEDOUT             (LEDOUT)
        );
        
		always @ (posedge clk) begin
	case ({switches[8:5]})
		4'b0000: reg_hex = dispData[15:0];
		4'b0001: reg_hex = dispData[31:16];
		4'b0010: reg_hex = instr[15:0];
		4'b0011: reg_hex = instr[31:16];
		4'b0100: reg_hex = alu_out[15:0];
		4'b0101: reg_hex = alu_out[31:16];
		4'b0110: reg_hex = wd_dm[15:0];
		4'b1000: reg_hex = pc_current[15:0];
		4'b1001: reg_hex = pc_current[31:16];
		default: reg_hex = pc_current[15:0];
	endcase
end
endmodule
