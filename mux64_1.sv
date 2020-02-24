`timescale 1ns/10ps

module mux64_1(
	output logic out,
	input  logic [32:0] in,
	input  logic [4:0] sel
	);

	parameter delay = 0.05;

//------Create the mux8_1 from mux2_1--------------------------
	logic [3:0] w;

	mux2_1 mux6 (.out,       .in0(w[0]),  .in1(w[1]),  .sel1(sel[2]));
	mux2_1 mux5 (.out(w[1]), .in0(w[4]),  .in1(w[5]),  .sel1(sel[1]));
	mux2_1 mux4 (.out(w[0]), .in0(w[2]),  .in1(w[3]),  .sel1(sel[1]));
	mux8_1 mux3 (.out(w[3]), .in(in[31:24]), .sel(sel[2:0]));
	mux8_1 mux2 (.out(w[2]), .in(in[23:16]), .sel(sel[2:0]));
	mux8_1 mux1 (.out(w[1]), .in(in[15:8]),  .sel(sel[2:0]));
	mux8_1 mux0 (.out(w[0]), .in(in[7:0]),   .sel(sel[2:0]));

endmodule

//------Testbench for 2_1 mux---------------------------------
module mux64_1_testbench();
	logic [63:0] in;
	logic [5:0] sel;
	logic out;

	mux64_1 dut (.out, .in, .sel);

	integer i, j;
		initial begin
		for(i=0; i<32; i++) begin
			sel = i;

			in = 32'h00000000;		#10;
			in = 32'hFFFFFFFF;		#10;
			in = 32'h000000FF;		#10;
			in = 32'h0000FF00;		#10;
			in = 32'h00FF0000;		#10;
			in = 32'hFF000000;		#10;
			in = 32'h0000003C;		#10;
			in = 32'h00003C00;		#10;
			in = 32'h003C0000;		#10;
			in = 32'h3C000000;		#10;

		end
	end
endmodule
