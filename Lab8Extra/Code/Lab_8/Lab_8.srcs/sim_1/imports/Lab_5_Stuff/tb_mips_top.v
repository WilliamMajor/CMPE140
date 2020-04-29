module tb_mips_top;
    reg         clk, rst;
    wire        we_dm;
    wire [31:0] pc_current, instr, alu_out, wd_dm, rd_dm, DONT_USE;
    
    mips_top DUT (
    	.clk			(clk),
    	.rst			(rst),
		.ra3			(5'd0),
		.instr			(instr),
		.we_dmE_out		(we_dm),
		.rd_dm			(rd_dm),
		.pc_current		(pc_current),
		.alu_outM_out	(alu_out),
		.wd_dmM_out		(wd_dm),
		.rd3			(DONT_USE)					
		);
		
    

    task tick; begin #5 clk = 1; #5 clk = 0; end endtask
    task rest; begin #5 rst = 1; clk = 1; #5 rst = 0; clk = 0; end endtask
    
    initial begin
		rest;
        while(pc_current != 32'h38)
        begin
            tick;
        end
        $display("TB MIPS TOP COMPLETED");
        $finish;
    end
endmodule