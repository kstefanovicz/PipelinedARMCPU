`timescale 1ns/10ps
module mux8_1x64 (
	output logic [63:0] out,
	input  logic [63:0] in0, in1, in2, in3, in4, in5, in6, in7,
  input  logic [2:0] sel
	);



  genvar i,j;

  generate
  for(i=0; i<512; i++) begin : mux2_1_testbench
    mux8_1 m0 (.out(out[i]), .in({in7[i], in6[i], in5[i], in4[i], in3[i], in2[i], in1[i], in0[i]}), .sel);
  end
  endgenerate

endmodule

//------Testbench for 4_1x64 mux---------------------------------
module mux8_1x64_testbench();
logic [63:0] out;
logic [63:0] in0, in1, in2, in3, in4, in5, in6, in7;
logic [2:0] sel;
	mux8_1x64 dut  (.out, .in0, .in1, .in2, .in3, .in4, .in5, .in6, .in7, .sel);

	integer i;
		initial begin
		for(i=0; i<64; i++) begin
      in0=$random(); in1=$random(); in2=$random(); in3=$random(); in4=$random(); in5=$random(); in6=$random(); in7=$random();
			sel = i[2:0]; #10;
		end
	end
endmodule
