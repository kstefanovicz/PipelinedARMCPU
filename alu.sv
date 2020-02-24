`timescale 1ns/10ps

module alu(
  input  logic [63:0] A, B,
  input  logic [2:0]  cntrl,
  output logic [63:0] result,
  output logic negative, zero, overflow, carry_out
  );

  logic [63:0] carry;
  logic [63:0] Bnot;

  parameter delay = 0.05;

//------For ease of reading simulation, cast cntrl as an enumerated type--------
//      *Not used in the ALU construction*

  typedef enum logic [2:0] {passB=3'b000, plus=3'b010, minus=3'b011, bwAnd=3'b100, bwOr=3'b101, bwXor=3'b110} OPS;
  OPS operation;
  assign operation = OPS'(cntrl);


//------Create the inverted B signal here---------------------------------------

  genvar k;

  generate
    for(k=0; k<64; k++) begin : eachINV
      not #(delay) binv (Bnot[k], B[k]);
    end
  endgenerate


//------Create a chain of 1-bit ALUs.-------------------------------------------
//      Set the carry-in of the first ALU to the LSB of the
//      control bit for use in converting B to two's compliment.

  one_bit_alu alu0 (.A(A[0]), .B(B[0]), .C(cntrl[0]), .Bnot(Bnot[0]), .cntrl, .result(result[0]), .carry_out(carry[0]));

  genvar i;

  generate
    for(i=1; i<64; i++) begin : eachALU
      one_bit_alu alu1 (.A(A[i]), .B(B[i]), .C(carry[i-1]), .Bnot(Bnot[i]), .cntrl, .result(result[i]), .carry_out(carry[i]));
    end
  endgenerate


//------Get Overflow from the last carry out and the ---------------------------
//      second-to-last carry.

  logic subtraction;
  //logic negIPposOP, posIPnegOP;
  //and #(delay) nIPpOP (negIPposOP, ~A[63], ~B[63], result[63]);
  //and #(delay) pIPnOP (posIPnegOP , A[63], B[63], ~result[63]);
  //or  #(delay) (overflow, negIPposOP, posIPnegOP);
  //and #(delay) subt (subtraction, ~cntrl[2], cntrl[1], cntrl[0]);
  xor #(delay) of   (overflow, carry[62], carry[63]);

//------Set negative flag to the top bit of result------------------------------

  buf #(delay) negFlag (negative, result[63]);


//------Set carry_out to top bit of carry---------------------------------------
//      Set if result of addition is greater than 64 bits (carry[63]==1)
//      or if result of subtraction is positive (result[63]==0)
  //logic subtractionCarry, additionCarry;
  //or #(delay) carryFlag  (carry_out, subtractionCarry, additionCarry);
  //and #(delay) subCar    (subtractionCarry, subtraction, ~result[63]);
  //and #(delay) addCar    (additionCarry, ~subtraction, carry[63]);
  buf   #(delay) carryFlag  (carry_out, carry[63]);


//------Cascade OR gates to determine zero signal-------------------------------

  logic [15:0] x;
  logic [3:0] y;
  logic z;

  or #(delay) or0  (x[0],  result[0],  result[1],  result[2],  result[3]);
  or #(delay) or1  (x[1],  result[4],  result[5],  result[6],  result[7]);
  or #(delay) or2  (x[2],  result[8],  result[9],  result[10], result[11]);
  or #(delay) or3  (x[3],  result[12], result[13], result[14], result[15]);
  or #(delay) or4  (x[4],  result[16], result[17], result[18], result[19]);
  or #(delay) or5  (x[5],  result[20], result[21], result[22], result[23]);
  or #(delay) or6  (x[6],  result[24], result[25], result[26], result[27]);
  or #(delay) or7  (x[7],  result[28], result[29], result[30], result[31]);
  or #(delay) or8  (x[8],  result[32], result[33], result[34], result[35]);
  or #(delay) or9  (x[9],  result[36], result[37], result[38], result[39]);
  or #(delay) or10 (x[10], result[40], result[41], result[42], result[43]);
  or #(delay) or11 (x[11], result[44], result[45], result[46], result[47]);
  or #(delay) or12 (x[12], result[48], result[49], result[50], result[51]);
  or #(delay) or13 (x[13], result[52], result[53], result[54], result[55]);
  or #(delay) or14 (x[14], result[56], result[57], result[58], result[59]);
  or #(delay) or15 (x[15], result[60], result[61], result[62], result[63]);

  or #(delay) orA  (y[0],  x[0],  x[1],  x[2],  x[3]);
  or #(delay) orB  (y[1],  x[4],  x[5],  x[6],  x[7]);
  or #(delay) orC  (y[2],  x[8],  x[9],  x[10], x[11]);
  or #(delay) orD  (y[3],  x[12], x[13], x[14], x[15]);

  or #(delay) orl  (z,  y[0],  y[1],  y[2],  y[3]);

  not #(delay) notZ (zero, z);

endmodule


// Test bench for ALU
`timescale 1ns/10ps

// Meaning of signals in and out of the ALU:

// Flags:
// negative: whether the result output is negative if interpreted as 2's comp.
// zero: whether the result output was a 64-bit zero.
// overflow: on an add or subtract, whether the computation overflowed if the inputs are interpreted as 2's comp.
// carry_out: on an add or subtract, whether the computation produced a carry-out.

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

module alu_testbench();

	parameter delay = 100000;

	logic [63:0] A, B;
	logic [2:0]  cntrl;
	logic [63:0] result;
	logic		     negative, zero, overflow, carry_out;
  logic        sum, difference, anded, ored, xored;

	parameter ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110;


	alu dut (.A, .B, .cntrl, .result, .negative, .zero, .overflow, .carry_out);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	integer i;
	logic [63:0] test_val;
	initial begin

//------Test Pass B-------------------------------------------------------------
		$display("%t testing PASS_B operations", $time);
		cntrl = ALU_PASS_B;
		for (i=0; i<10; i++) begin
			A = $random(); B = $random();
			#(delay);
//			assert(result == B && negative == B[63] && zero == (result == '0)) else $error("PASS_B failed on %d at %t", i, $time);
//      $display("result:");
		end

//------Test Addition-----------------------------------------------------------
    $display("%t testing ADDITION operations", $time);
    cntrl = ALU_ADD;
    assign sum = A + B;
    for (i=0; i<10; i++) begin
      A = $random(); B = $random();
      #(delay);
//      assert(result == (sum) && negative == B[63] && zero == (result == 64'b0)) else $error("ADDITION failed on %d at %t. Sum is %d", i, $time, sum);
//      $display("sum is %d", sum);
    end

//------Test Subtraction--------------------------------------------------------
    $display("%t testing SUBTRACTION operations", $time);
    cntrl = ALU_SUBTRACT;
    assign difference = A - B;
    for (i=0; i<10; i++) begin
      A = $random(); B = $random();
      #(delay);
//      assert(result == (difference) && negative == B[63] && zero == (result=='0)) else $error("SUBTRACTION failed on %d at %t", i, $time);
    end

//------Test AND----------------------------------------------------------------
    $display("%t testing AND operations", $time);
    cntrl = ALU_AND;
    assign anded = A && B;
    for (i=0; i<10; i++) begin
      A = $random(); B = $random();
      #(delay);
//      assert(result == (anded) && negative == B[63] && zero == (result == '0)) else $error("AND failed on %d at %t", i, $time);
    end

//------Test OR-----------------------------------------------------------------
    $display("%t testing OR operations", $time);
    cntrl = ALU_OR;
    assign ored = A || B;
    for (i=0; i<10; i++) begin
      A = $random(); B = $random();
      #(delay);
//      assert(result == (ored) && negative == B[63] && zero == (result == '0)) else $error("OR failed on %d at %t", i, $time);
    end

//------Test XOR----------------------------------------------------------------
    $display("%t testing XOR operations", $time);
    cntrl = ALU_XOR;
    assign xored = (A && ~B) || (~A && B);
    for (i=0; i<10; i++) begin
      A = $random(); B = $random();
      #(delay);
//      assert(result == xored && (negative == B[63]) && zero == (result == '0)) else $error("XOR failed on %d at %t", i, $time);
    end

		$display("%t testing addition", $time);
		cntrl = ALU_ADD;
		A = 64'h0000000000000001; B = 64'h0000000000000001;
		#(delay);
//		assert(result == 64'h0000000000000002 && carry_out == 0 && overflow == 0 && negative == 0 && zero == 0) else $error("Problem!");

//------Test Edges-----------------------------------------------------------
    $display("%t testing EDGE operations", $time);
    cntrl = ALU_ADD;
    for (i=0; i<10; i++) begin
      A = 64'h7fffffffffffffff; B = 64'hf;
//      assert (overflow==1) else $error("overflow should be true");
      #(delay);
    end

    cntrl = ALU_SUBTRACT;
    for (i=0; i<10; i++) begin
      A = 64'h7f5ffbff0fffffff; B = 64'h7f5ffbff0fffffff;
//      assert(zero==1) else $error("zero should be true");
      #(delay);
    end

    cntrl = ALU_SUBTRACT;
    for (i=0; i<10; i++) begin
      A = 64'h7f5ffbff0fffffff; B = 64'h7f5ffbff1fffffff;
//      assert(negative==1) else $error("negative should be true");
      #(delay);
    end

  $display("%t done", $time);
	end
endmodule
