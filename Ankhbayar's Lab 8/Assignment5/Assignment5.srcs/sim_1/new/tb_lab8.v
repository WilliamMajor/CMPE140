module tb_lab8;

    reg         clk;
    reg         rst;
    reg [3:0]   test;
    wire [31:0] gpO1, gpO2;

    SoC_top DUT(
            .clk            (clk),
            .rst            (rst),
            .gpI1           (test),
            .gpI2           (gpO1),
            .gpO1           (gpO1),
            .gpO2           (gpO2)
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
    integer n;
    initial begin

        n = 0;
        test = 1;
        reset;
        while(n < 32) 
        begin
            tick;
            n = n + 1;
        end
    end

endmodule