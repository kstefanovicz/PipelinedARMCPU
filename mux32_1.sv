`timescale 1ns/10ps

module mux32_1(
	output logic out,
	input  logic [31:0] in,
	input  logic [4:0]  sel
	);

	parameter delay = 0.05;

//------Create the mux8_1 from mux2_1--------------------------
	logic [9:0] w;

	mux2_1 mux10 (.out, .in0(w[8]), .in1(w[9]), .sel1(sel[4]));
	mux4_1 mux9	 (.out(w[9]), .in(w[7:4]),      .sel(sel[3:2]));
	mux4_1 mux8	 (.out(w[8]), .in(w[3:0]),      .sel(sel[3:2]));
	mux4_1 mux7	 (.out(w[7]), .in(in[31:28]),   .sel(sel[1:0]));
	mux4_1 mux6	 (.out(w[6]), .in(in[27:24]),   .sel(sel[1:0]));
	mux4_1 mux5	 (.out(w[5]), .in(in[23:20]),   .sel(sel[1:0]));
	mux4_1 mux4	 (.out(w[4]), .in(in[19:16]),   .sel(sel[1:0]));
	mux4_1 mux3	 (.out(w[3]), .in(in[15:12]),   .sel(sel[1:0]));
	mux4_1 mux2	 (.out(w[2]), .in(in[11:8]),    .sel(sel[1:0]));
	mux4_1 mux1	 (.out(w[1]), .in(in[7:4]),     .sel(sel[1:0]));
	mux4_1 mux0	 (.out(w[0]), .in(in[3:0]),     .sel(sel[1:0]));

endmodule

//------Testbench for 32_1 mux---------------------------------
module mux32_1_testbench();
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
