module mux2special #(parameter wide = 8)(
		input wire				rst,
		input wire				sel,
		input wire [wide-1:0] 	a,
		input wire [wide-1:0]	b,
		output wire [wide-1:0] 	y
		);
		reg selx;
		always @ (posedge rst)
		begin
			if(rst == 1) selx = 0;
			else selx = sel;
		end
    assign y = (selx) ? b : a;
endmodule

module mux2 #(parameter wide = 8)(
		input wire				sel,
		input wire [wide-1:0] 	a,
		input wire [wide-1:0]	b,
		output wire [wide-1:0] 	y
		);
    assign y = (sel) ? b : a;
endmodule

module mux4 #(parameter wide = 8)(
		input wire [1:0] 		sel,
		input wire [wide-1:0] 	a,
		input wire [wide-1:0] 	b,
		input wire [wide-1:0] 	c,
		input wire [wide-1:0] 	d, 
		output reg [wide-1:0] 	y
	);
    always@(sel,a,b,c,d)
    begin
        case(sel)
        2'b00: y=a;
        2'b01: y=b;
        2'b10: y=c;
        2'b11: y=d;
        default: y = 4'bz;
        endcase
	end
endmodule

module andgate (
		input wire a,
		input wire b,
		output wire y
	);
	assign y = (a && b);
endmodule

module dreg2 (
		input wire			clk,
		input wire			rst,
		input wire			en,
		input wire [31:0] 	d,
		output reg [31:0] 	q
	);
    always @ (posedge clk, posedge rst)
    begin
        if (rst) q = 0;
        else
        begin 
            if(en) q = d;
        end
    end
endmodule


module mult	(
		input wire [31:0] 	a,
		input wire [31:0]	b,
		output wire [63:0] 	y
	);
    assign y = a * b;
endmodule

module adder (
		input wire [31:0] 	a,
		input wire [31:0]	b,
		output wire [31:0] 	y
	);
    assign y = a + b;
endmodule

module signext (
		input wire [15:0] 	a,
		output wire [31:0] 	y
	);
    assign y = {{16{a[15]}}, a};
endmodule

module alu (
		input wire [2:0] 	op,
		input wire [31:0] 	a,
		input wire [31:0]	b,
		output wire 		zero,
		output reg [31:0] 	y
	);
    assign zero = (y == 0);
    always @ (op, a, b)
    begin
        case (op)
            3'b000: y = a & b;
            3'b001: y = a | b;
            3'b010: y = a + b;
            3'b110: y = a - b;
            3'b111: y = (a < b) ? 32'b1 : 32'b0;
        endcase
    end
endmodule

module dreg (
		input wire 			clk,
		input wire 			rst,
		input wire [31:0] 	d,
		output reg [31:0] 	q
	);
    always @ (posedge clk, posedge rst)
    begin
        if (rst) q = 0;
        else     q = d;
    end
endmodule

module regfile (
		input wire 			clk,
		input wire 			we,
		input wire [4:0] 	ra1,
		input wire [4:0]	ra2,
		input wire [4:0]	ra3,
		input wire [4:0]	wa,
		input wire [31:0] 	wd,
		output wire [31:0] 	rd1,
		output wire	[31:0]	rd2,
		output wire	[31:0]	rd3
	);
    reg [31:0] rf [0:31];
    integer n;
    initial begin
        for (n = 0; n < 32; n = n + 1) rf[n] = 32'h0;
    end
    always @ (posedge clk)
    begin
        if (we) rf[wa] <= wd;
    end
    assign rd1 = (ra1 == 0) ? 0 : rf[ra1];
    assign rd2 = (ra2 == 0) ? 0 : rf[ra2];
    assign rd3 = (ra3 == 0) ? 0 : rf[ra3];
endmodule