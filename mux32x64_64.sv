`timescale 1ns/10ps

module mux32x64_64(
	output logic [63:0] out,
	input  logic [63:0] in [0:31],
	input  logic [4:0]  sel
	);

	parameter delay = 0.5;

//------Create the 64 multiplexers in parallel----------------
//		  for each bit of data

	genvar i;

	generate
		for(i=0; i<64; i++) begin : eachBitMux
	  		mux32_1 mux (.out(out[i]), .in(in[i]), .sel);
			end
	  endgenerate

endmodule

//------Testbench for 32_1 mux---------------------------------
module mux32x64_32_testbench();
	logic out;
	logic [31:0] in;
	logic [4:0]  sel;

	mux32_1 dut (.out, .in, .sel);

	integer j;
		initial begin
		for (j=0; j<32; j++) begin
			in[j] = 64'b0;
		end
	end

	integer i;
		initial begin
		for(i=0; i<32; i++) begin
			sel = i;

			in[i]   = 64'h0000000000000000;		#10;
			in[i]   = 64'hFFFFFFFFFFFFFFFF;		#10;
			in[i]   = 64'h00000000FF000000;		#10;
			in[i]   = 64'h0000000000000000;		#10;

			in[14]   = 64'h00000000FF000000;		#10;
			in[i]   = 64'h0000000000000000;		#10;

			in[2]   = 64'h00000000FF000000;		#10;
			in[2]   = 64'h0000000000000000;		#10;


		end
	end
endmodule
