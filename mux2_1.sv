`timescale 1ns/10ps

module mux2_1(
	output logic out,
	input  logic in0, in1, sel1
	);

	parameter delay = 0.05;

//------Initialize and create inverted select signal-----------
	logic nsel1;

	not invtr1 (nsel1, sel1);


//------Create the multiplexer---------------------------------
	logic a, b;

	nand nand1 (a, in0, nsel1);
	nand nand2 (b, in1, sel1);
	nand nand3 (out, a, b);


endmodule

//------Testbench for 2_1 mux---------------------------------
module mux2_1_testbench();
	logic in0, in1, sel1;
	logic out;

	mux2_1 dut (.out, .in0, .in1, .sel1);

	integer i;
		initial begin
		for(i=0; i<8; i++) begin
			{sel1, in0, in1} = i; #10;
		end
	end
endmodule
