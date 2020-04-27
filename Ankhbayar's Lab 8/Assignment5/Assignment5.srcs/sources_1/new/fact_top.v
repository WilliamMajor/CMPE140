module fact_top(
    input wire clk, rst,
    input wire [1:0] A,
    input wire WE,
    input wire [3:0] WD,
    output reg [31:0] fact_data_out
    );
    
    wire WE1, WE2;
    wire [1:0] RdSel;
    wire [3:0] n;
    wire Go, Err, Done;
    wire [31:0] nf, Result;
    
    wire pulse;
    reg GoPulse;
    reg ResDone, ResErr;
    
    assign pulse = WD[0] & WE2;
    
    fact_ad factorial_ad(
        .A          (A),
        .WE         (WE),
        .WE1        (WE1),
        .WE2        (WE2),
        .RdSel      (RdSel)
    );
    
    factorial fact(
        .clk        (clk),
        .rst        (rst),
        .n          (n),
        .Go         (GoPulse),
        .Done       (Done),
        .Err        (Err),
        .nf         (nf)
    );
    
    SoC_reg #(4) n_reg( 
        .clk        (clk),
        .rst        (rst),
        .D          (WD),
        .EN         (WE1),
        .Q          (n)
    );    

    SoC_reg #(1) Go_reg( 
        .clk        (clk),
        .rst        (rst),
        .D          (WD[0]),
        .EN         (WE2),
        .Q          (Go)
    );    

    SoC_reg #(32) gp2_reg( 
        .clk        (clk),
        .rst        (rst),
        .D          (nf),
        .EN         (Done),
        .Q          (Result)
    );    
    
    always@(posedge clk, posedge rst)
    begin
        if(rst)
            GoPulse <= 1'b0;
        else
            GoPulse <= pulse;
    end
    
    always@(posedge clk, posedge rst)
    begin
        if(rst)
            ResDone <= 1'b0;
        else
            ResDone <= (~pulse) & (Done | ResDone);
    end
    
    always@(posedge clk, posedge rst)
    begin
        if(rst)
            ResErr <= 1'b0;
        else
            ResErr <= (~pulse) & (Err | ResErr);
    end    
    
    always@(*)
    begin
        case(RdSel)
            2'b00: fact_data_out = {{28{1'b0}}, n};
            2'b01: fact_data_out = {{31{1'b0}}, Go};
            2'b10: fact_data_out = {{30{1'b0}}, ResErr, ResDone};
            2'b11: fact_data_out = Result;
            default: fact_data_out = {31{1'bx}};
        endcase
    end
endmodule
