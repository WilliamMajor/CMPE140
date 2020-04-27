module tb_AD;

    reg         we_dm;
    wire WE1, WE2, WEM;
    reg [3:0]   test;
    wire [1:0] RdSel;

     ad DUT(
        .WE         (we_dm),
        .A          (test),
        .WE1        (WE1),
        .WE2        (WE2),
        .WEM        (WEM),
        .RdSel      (RdSel)
     );  
    initial begin
        test = 8;
        we_dm = 1;
    end

endmodule