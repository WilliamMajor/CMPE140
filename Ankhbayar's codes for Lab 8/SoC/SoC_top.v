module SoC_top(
        input  wire        clk,
        input  wire        rst,
        input  wire [4:0]  ra3,
        input  wire [3:0]  gpI1,
        input  wire [31:0] gpI2,
        output wire [31:0] gpO1,
        output wire [31:0] gpO2 
    );
    
    wire [31:0] DONT_USE;
    wire [31:0] pc_current, instr, alu_out, wd_dm, rd3;
    wire [31:0] DMemData, FactData, GPIOData;
    wire [31:0] ReadData;
    wire we_dm;
    wire WE1, WE2, WEM;
    wire [1:0] RdSel;
    
    mips mips (
            .clk            (clk),
            .rst            (rst),
            .ra3            (ra3),
            .instr          (instr),
            .rd_dm          (ReadData),
            .we_dm          (we_dm),
            .pc_current     (pc_current),
            .alu_out        (alu_out),
            .wd_dm          (wd_dm),
            .rd3            (rd3)
        );

    imem imem (
            .a              (pc_current[7:2]),
            .y              (instr)
        );

    dmem dmem (
            .clk            (clk),
            .we             (we_dm),
            .a              (alu_out[7:2]),
            .d              (wd_dm),
            .q              (DMemData)
        );    
        
     ad ad(
        .WE         (we_dm),
        .A          (alu_out[12:9]),
        .WE1        (WE1),
        .WE2        (WE2),
        .WEM        (WEM),
        .RdSel      (RdSel)
     );       
     fact_top fact (
            .clk            (clk),
            .rst            (rst),
            .A              (alu_out[3:2]),
            .WE             (WE1),
            .fact_data_out  (FactData)
     );
     
     gpio_top gpio (
            .clk            (clk),
            .rst            (rst),
            .A              (alu_out[3:2]),
            .WE             (WE2),
            .gpI1           ({{28{1'b0}}, gpI1}),
            .gpI2           (gpO1),
            .WD             (wd_dm),
            .gpO1           (gpO1),
            .gpO2           (gpO2),
            .gpio_data_out  (GPIOData)
     );
     
    mux4to1 SoC_mux(
        .RdSel      (RdSel),
        .a          (DMemData),
        .b          (DMemData),
        .c          (FactData),
        .d          (GPIOData),
        .ReadData   (ReadData)
    );
     
    
    
endmodule
