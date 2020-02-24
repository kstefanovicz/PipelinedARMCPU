`timescale 1ns/10ps

module one_bit_alu (A, B, C, Bnot, cntrl, result, carry_out);
	input logic A, B, C, Bnot; //C=carryIn
	input logic [2:0] cntrl;
	output logic carry_out, result;

	logic bIn, adder, andRes, orRes, xorRes;
  parameter delay = 0.5;


//------Invert the b signal to use in two's comp--------------------------------

	mux2_1 bInvert (.out(bIn), .in0(B), .in1(Bnot), .sel1(cntrl[0]));


//------Create the 1-bit ALU from basic components------------------------------

	fullAdder addSub (.result(adder), .carry_out, .A, .B(bIn), .C);
	and #(delay) andSol (andRes, A, B);
	or  #(delay) orSol (orRes, A, B);
	xor #(delay) xorSol (xorRes, A, B);


//------Muliplex the result from each basic operator----------------------------

	mux8_1 cntrlMux (.out(result), .in({1'b0, xorRes, orRes, andRes, adder, adder, 1'b0, B}), .sel(cntrl));


endmodule

module one_bit_alu_testbench();

	logic A, B, C;
	logic [2:0] cntrl;
	logic carry_out, result;

	one_bit_alu dut (.A, .B, .C, .cntrl, .result, .carry_out);

	integer i, j;
	initial begin

	for(i=0; i<8; i++) begin
		{A, B, C} = i;
		for(j=0; j<8; j++) begin
			cntrl = j; #10;
		end
	end

	end
endmodule
