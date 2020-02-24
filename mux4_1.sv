`timescale 1ns/10ps

module mux4_1(
	output logic out,
	input  logic [3:0] in,
	input  logic [1:0] sel
	);

	parameter delay = 0.05;

//------Initialize and create inverted select signal-----------
	logic [1:0] nsel;

	not invtr1 (nsel[1], sel[1]);
	not invtr0 (nsel[0], sel[0]);


//------Create the multiplexer---------------------------------
	logic [3:0] w;

	nand nand4 (out,  w[3],  w[2],  w[1], w[0]);
	nand nand3 (w[3], in[3], sel[1],   sel[0]);
	nand nand2 (w[2], in[2], sel[1],   nsel[0]);
	nand nand1 (w[1], in[1], nsel[1],  sel[0]);
	nand nand0 (w[0], in[0], nsel[1],  nsel[0]);

endmodule

//------Testbench for 4_1 mux---------------------------------
module mux4_1_testbench();
	logic out;
	logic [3:0] in;
	logic [1:0] sel;

	mux4_1 dut (.out, .in, .sel);

	integer i;
		initial begin
		for(i=0; i<64; i++) begin
			{sel, in} = i; #10;
		end
	end
endmodule
