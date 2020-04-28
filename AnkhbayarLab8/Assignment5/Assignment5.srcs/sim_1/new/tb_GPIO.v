module tb_GPIO;

    
    reg clk, rst;
    reg [1:0] A;
    reg WE;
    reg [31:0] wd_dm;
    reg [3:0] gpI1;
    wire [31:0] GPIOData, gpO1, gpO2;
    gpio_top gpio (
            .clk            (clk),
            .rst            (rst),
            .A              (A),
            .WE             (WE),
            .gpI1           ({{28{1'b0}}, gpI1}),
            .gpI2           (gpO1),
            .WD             (wd_dm),
            .gpO1           (gpO1),
            .gpO2           (gpO2),
            .gpio_data_out  (GPIOData)
    );
    task tick; 
    begin 
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end
    endtask

    task reset;
    begin 
        rst = 1'b0; #5;
        rst = 1'b1; #5;
        rst = 1'b0;
    end
    endtask
        
    initial begin
        A = 0;
        wd_dm = 25;
        WE = 1;
        gpI1 = 6;
        reset;
        tick;
        tick;
        tick;
        A = 1; 
        tick;
        tick;
        A = 2;
        tick;
        tick;
        A = 3;
        tick;
        tick;
    end 
endmodule
