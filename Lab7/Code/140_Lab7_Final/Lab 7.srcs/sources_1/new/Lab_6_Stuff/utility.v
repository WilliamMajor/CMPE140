module clk_gen (
        input  wire clk100MHz,
        input  wire rst,
        output reg  clk_4sec,
        output reg  clk_5KHz
    );

    integer count1, count2;

    always @ (posedge clk100MHz) begin
        if (rst) begin
            count1 = 0;
            count2 = 0;
            clk_5KHz = 0;
            clk_4sec = 0;
        end
        else begin
            if (count1 == 200000000) begin
                clk_4sec = ~clk_4sec;
                count1 = 0;
            end

            if (count2 == 10000) begin
                clk_5KHz = ~clk_5KHz;
                count2 = 0;
            end

            count1 = count1 + 1;
            count2 = count2 + 1;            
        end
    end

endmodule

module hex_to_7seg (
            input  wire [3:0] HEX,
            output reg  [7:0] s
        );

    always @ (HEX) begin
        case (HEX) 
               4'h0: s = 8'b11000000;
               4'h1: s = 8'b11111001;
               4'h2: s = 8'b10100100;
               4'h3: s = 8'b10110000;
               4'h4: s = 8'b10011001;
               4'h5: s = 8'b10010010;
               4'h6: s = 8'b10000010;
               4'h7: s = 8'b11111000;
               4'h8: s = 8'b10000000;
               4'h9: s = 8'b10010000;
               4'hA: s = 8'b10001000;
               4'hB: s = 8'b10000000;
               4'hC: s = 8'b11000110;
               4'hD: s = 8'b11000000;
               4'hE: s = 8'b10000110;
               4'hF: s = 8'b10001110;
            default: s = 8'b01111111;
       endcase
    end

endmodule

module led_mux (
        input  wire       clk,
        input  wire       rst,
        input  wire [7:0] LED3,
        input  wire [7:0] LED2,
        input  wire [7:0] LED1,
        input  wire [7:0] LED0,
        output wire [3:0] LEDSEL,
        output wire [7:0] LEDOUT
    );

    reg [1:0]  index;
    reg [11:0] led_ctrl;

    assign {LEDSEL, LEDOUT} = led_ctrl;
    
    always @ (posedge clk) index <= (rst) ? 2'b0 : (index + 2'd1);
    
    always @ (index, LED0, LED1, LED2, LED3) begin
        case (index)
               2'd0: led_ctrl <= {4'b1110, LED0};
               2'd1: led_ctrl <= {4'b1101, LED1};
               2'd2: led_ctrl <= {4'b1011, LED2};
               2'd3: led_ctrl <= {4'b0111, LED3};
            default: led_ctrl <= {4'b1111, 8'hFF};
        endcase
    end
    
endmodule

module button_debouncer #(parameter depth = 16) (
        input  wire clk,                 /* 5 KHz clock */
        input  wire button,              /* Input button from constraints */
        output reg  debounced_button
    );
    
    localparam history_max = (2**depth)-1;

    /* History of sampled input button */
    reg [depth-1:0] history;

    always @ (posedge clk) begin
        /* Move history back one sample and insert new sample */
        history <= { button, history[depth-1:1] };
        
        /* Assert debounced button if it has been in a consistent state throughout history */
        debounced_button <= (history == history_max) ? 1'b1 : 1'b0;
    end
    
endmodule
