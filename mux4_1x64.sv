`timescale 1ns/10ps
module mux4_1x64 #(parameter LINES=64) (
	output logic [LINES-1:0] out,
	input  logic [LINES-1:0] in0, in1, in2, in3,
  input  logic [1:0] sel1
	);

  genvar i;

  generate
  for(i=0; i<LINES; i++) begin : mux2_1_testbench
    mux4_1 m0 (.out(out[i]), .in({in3[i], in2[i], in1[i], in0[i]}), .sel(sel1));
  end
  endgenerate

endmodule

//------Testbench for 4_1x64 mux---------------------------------
module mux4_1x64_testbench();
	logic [6:0] in0, in1, in2, in3, out;
  logic [1:0] sel1;
	mux4_1x64 #(7) dut  (.out, .in0, .in1, .in2, .in3, .sel1);

	integer i;
		initial begin
		for(i=0; i<16; i++) begin
      in0 = $random(); in1 = $random(); in2 = $random(); in3 = $random();
			sel1 = i[1:0]; #10;
		end
	end
endmodule
