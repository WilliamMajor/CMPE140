module tb_FACT;

    
    reg clk, rst;
    reg [1:0] test;
    reg [3:0] test2;
    reg WE;
    wire [31:0] FactData;
    fact_top fact (
            .clk            (clk),
            .rst            (rst),
            .A              (test),
            .WE             (WE),
            .WD             (test2),
            .fact_data_out  (FactData)
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
        test = 0;
        test2 = 6;
        WE = 1;
        reset;
        tick;
        tick;
        test = 1;
        test2 = 1;
        tick; 
        tick;
        tick;
        tick;
        tick;
        tick;
        tick;
        tick;
        tick;
        tick;
        tick;
        tick;
        tick; 
        tick;
        tick;
        tick;
        tick;
        tick;
        tick;
        tick;
        tick;
        tick;
        tick;
        tick;
    end 
endmodule
