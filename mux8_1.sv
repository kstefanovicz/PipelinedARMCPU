`timescale 1ns/10ps

module mux8_1(
	output logic out,
	input  logic [7:0] in,
	input  logic [2:0] sel
	);

	parameter delay = 0.05;

//------Create the mux8_1 from mux2_1--------------------------
	logic [5:0] w;

	mux2_1 mux6 (.out,       .in0(w[1]), .in1(w[0]), .sel1(sel[2]));
	mux2_1 mux5 (.out(w[0]), .in0(w[3]), .in1(w[2]), .sel1(sel[1]));
	mux2_1 mux4 (.out(w[1]), .in0(w[5]), .in1(w[4]), .sel1(sel[1]));
	mux2_1 mux3 (.out(w[5]), .in0(in[0]), .in1(in[1]), .sel1(sel[0]));
	mux2_1 mux2 (.out(w[4]), .in0(in[2]), .in1(in[3]), .sel1(sel[0]));
	mux2_1 mux1 (.out(w[3]), .in0(in[4]), .in1(in[5]), .sel1(sel[0]));
	mux2_1 mux0 (.out(w[2]), .in0(in[6]), .in1(in[7]), .sel1(sel[0]));

endmodule

//------Testbench for 2_1 mux---------------------------------
module mux8_1_testbench();
	logic [7:0] in;
	logic [2:0] sel;
	logic out;

	mux8_1 dut (.out, .in, .sel);

	integer i;
		initial begin
		for(i=0; i<2048; i++) begin
			{sel, in} = i; #10;
		end
	end
endmodule
