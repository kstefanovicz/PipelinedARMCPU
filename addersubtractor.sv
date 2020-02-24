module add_sub(
	input  logic A, B, C,
	output logic result, negative, zero, carry_out //do we need zero? can we use a decoder to feed all signals in?
	);



//------if cntrl = 1, subtract---------------------------
//      if cntrl = 0, add

//------Invert signal a for subtraction---------------------

	logic notA;
	not invtr (notA, A);

//------Multiplex a and nota based on operation------------

	logic muxedA;

	mux2_1 muxA (.out(muxedA), .in0(A), .in1(notA), .sel1(cntrl));

//------Send the signals to the full adder-----------------

fullAdder fa (.result, .carry_out, .A, .B, .C(cntrl));

endmodule


//------Testbench for adder-subtractor---------------------
module fullAdder_testbench();

logic A, B, C;
logic result, negative, zero, carry_out;

  addersubtractor dut (.result, .negative[], .zero, .carry_out, .A, .B, .C);

integer i;
  initial begin
  for(i=0; i<8; i++) begin
    {A, B, C} = i; #10;
  end
end
endmodule
