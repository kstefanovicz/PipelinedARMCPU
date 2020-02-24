`timescale 1ns/10ps

module adder_64(
  output logic [63:0] result,
  output logic        carry_out,
  input  logic [63:0] A,
  input  logic [63:0] B
  );

  logic        [62:0] carries;
  parameter DELAY = 0.05;

//------Create a 64 bit adder using a chain of full adders.---------------------
//      Add the 0th and the 63rd bit separately.

  fullAdder add63 (.result(result[63]), .carry_out,             .A(A[63]), .B(B[63]), .C(carries[62]));
  fullAdder add0  (.result(result[0]),  .carry_out(carries[0]), .A(A[0]),  .B(B[0]),  .C(1'b0));


  genvar i;

  generate
    for(i=1; i<63; i++) begin : eachAdder
      fullAdder add1_to_62 (.result(result[i]), .carry_out(carries[i]), .A(A[i]),  .B(B[i]),  .C(carries[i-1]));
    end
  endgenerate
endmodule

module adder_64_testbench();

	parameter delay = 100;
  logic [63:0] result;
  logic        carry_out;
  logic [63:0] A;
  logic [63:0] B, S;

  adder_64 dut (.result, .carry_out, .A, .B);
	integer i;

	initial begin

      for (i=0; i<10; i++) begin
        A = $random(); B = $random();

        //This value for verification only
        assign S = A + B;

        #(delay);
      end
    end
  endmodule
