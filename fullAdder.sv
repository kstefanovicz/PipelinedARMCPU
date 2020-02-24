`timescale 1ns/10ps

module fullAdder(
	output logic result, carry_out,
	input  logic A, B, C
	);

	parameter delay = 0.5;

//------Build sum logic (two half-adders)------------------

	logic haCX, haCY, haSX;

	halfAdder ha1 (.result(haSX), .carry_out(haCX), .A, .B);
	halfAdder ha0 (.result, .carry_out(haCY), .A(haSX), .B(C));

//------Build carry logic (OR gate)-----------------------

	or #(delay) carry (carry_out, haCX, haCY);

endmodule


//------Testbench for full adder--------------------------
module fullAdder_testbench();

logic result, carry_out;
logic A, B, C;

  fullAdder dut (.result, .carry_out, .A, .B, .C);

integer i;
  initial begin
  for(i=0; i<8; i++) begin
    {A, B, C} = i; #10;
  end
end
endmodule
