`timescale 1ns/10ps
module mux2_1x64 #(parameter LINES=64) (
	output logic [LINES-1:0] out,
	input  logic [LINES-1:0] in0, in1,
  input  logic sel1
	);

  genvar i;

  generate
  for(i=0; i<LINES; i++) begin : mux2_1_testbench
    mux2_1 m0 (.out(out[i]), .in0(in0[i]), .in1(in1[i]), .sel1(sel1));
  end
  endgenerate

endmodule

//------Testbench for 2_1x64 mux---------------------------------
module mux2_1x64_testbench();
	logic [6:0] in0, in1, out;
  logic sel1;
	mux2_1x64 #(7) dut  (.out, .in0, .in1, .sel1);

	integer i;
		initial begin
		for(i=0; i<8; i++) begin
      in0 = $random(); in1 = $random();
			sel1 = i[0]; #10;
		end
	end
endmodule
