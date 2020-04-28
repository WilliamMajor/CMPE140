module FPGA_top_level (
        input  wire       clk,
        input  wire       rst,
        input  wire       button,
        input  wire [4:0] switches,
        output wire [3:0] test,
        output wire [3:0] LEDSEL,
        output wire [7:0] LEDOUT
    );

    reg  [15:0] reg_hex;
    wire        clk_sec;
    wire        clk_5KHz;
    wire        clk_pb;

    wire [7:0]  digit0;
    wire [7:0]  digit1;
    wire [7:0]  digit2;
    wire [7:0]  digit3;

    wire [31:0] gpO1;
    wire [31:0] gpO2;

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
     
     SoC_top SoC(
            .clk            (clk_pb),
            .rst            (rst),
            .gpI1           (switches[3:0]),
            .gpI2           (gpO1),
            .gpO1           (gpO1),
            .gpO2           (gpO2)
     );
     
     assign test[3] = switches[3];
     assign test[2] = switches[2];
     assign test[1] = switches[1];
     assign test[0] = switches[0];
     

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
        case (switches[4])
            1'b0: reg_hex = gpO2[15:0];
            1'b1: reg_hex = gpO2[31:16];
        endcase
    end

endmodule

