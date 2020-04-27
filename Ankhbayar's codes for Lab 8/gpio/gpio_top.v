module gpio_top(
    input wire      clk,
    input wire      rst,
    input wire [1:0] A,
    input wire WE,
    input wire [31:0] gpI1, gpI2, WD,
    output wire [31:0] gpO1, gpO2, gpio_data_out
    );
    
    wire WE1, WE2;
    wire [1:0] RdSel;
    gpio_ad ad(
        .A          (A),
        .WE         (WE),
        .WE1        (WE1),
        .WE2        (WE2),
        .RdSel      (RdSel)
    );
    
    SoC_reg #(32) gp1_reg( 
        .clk        (clk),
        .rst        (rst),
        .D          (gpI1),
        .EN         (WE1),
        .Q          (gpO1)
    );
    
    SoC_reg #(32) gp2_reg( 
        .clk        (clk),
        .rst        (rst),
        .D          (gpI2),
        .EN         (WE2),
        .Q          (gpO2)
    );    
    
    mux4to1 gpio_mux(
        .RdSel      (RdSel),
        .a          (gpI1),
        .b          (gpI2),
        .c          (gpO1),
        .d          (gpO2),
        .ReadData   (gpio_data_out)
    );
            
        
endmodule
