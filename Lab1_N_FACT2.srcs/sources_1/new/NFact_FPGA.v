`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2020 01:57:34 AM
// Design Name: 
// Module Name: NFact_FPGA
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module NFact_FPGA(
    input           clk100MHz, go, rst, switch, push_button_input,
    input   [3:0]   N_in,
    output          go_led, done_led, error_led, switch_led,
    output  [3:0]   N_led, LEDSEL,
    output  [7:0]   LEDOUT
    );
    
supply1 [7:0] vcc;

wire            DONT_USE;
wire            clk_5KHz;

wire            debounced_clock_signal, done, error;
wire    [7:0]   out_display0;
wire    [7:0]   out_display1;
wire    [7:0]   out_display2;   
wire    [7:0]   out_display3;
wire    [15:0]  splitResult;

assign go_led       = go;
assign done_led     = done;
assign error_led    = error;
assign N_led        = N_in;
assign switch_led   = switch; 

NFact DUT(
        .number     (N_in),
        .clk        (debounced_clock_signal),
        .go         (go),
        .switch     (switch),
        .splitResult(splitResult),
        .done       (done),
        .error      (error)
    );
clk_gen CLK (
        .clk100MHz  (clk100MHz), 
        .rst        (rst), 
        .clk_4sec   (DONT_USE),
        .clk_5KHz   (clk_5KHz)
    );
       
bcd_to_7seg BCD (
        .BCD    (splitResult[15:12]),
        .s      (out_display3)
    );

bcd_to_7seg BCD1 (
        .BCD    (splitResult[11:8]),
        .s      (out_display2)
   );
   
bcd_to_7seg BCD2 (
       .BCD    (splitResult[7:4]),
       .s      (out_display1)
   );

bcd_to_7seg BCD3 (
       .BCD    (splitResult[3:0]),
       .s      (out_display0)
   );
       
led_mux LED (                      
        .clk        (clk_5KHz), 
        .rst        (rst),
        .LED3       (out_display3),
        .LED2       (out_display2),
        .LED1       (out_display1),
        .LED0       (out_display0),
        .LEDSEL     (LEDSEL),
        .LEDOUT     (LEDOUT)
    );

button_debouncer #64 DEBOUNCER(
        .clk                (clk_5KHz), 
        .button             (push_button_input),
        .debounced_button   (debounced_clock_signal)
    );
endmodule
