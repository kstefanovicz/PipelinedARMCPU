`timescale 1ns/10ps

module halfAdder(
  output logic result, carry_out,
  input  logic A, B
);

	parameter delay = 0.5;

//------Build sum logic (4-nand XOR gate)------------------

  logic aNANDb, x, y;

  nand #(delay) nand3 (aNANDb, A, B);
  nand #(delay) nand2 (x, aNANDb, A);
  nand #(delay) nand1 (y, aNANDb, B);
  nand #(delay) nand0 (result, x, y);

//------Build carry logic (AND gate)-----------------------

  and #(delay) carry (carry_out, A, B);

endmodule


//------Testbench for half adder--------------------------
module halfAdder_testbench();

  logic result, carry_out;
  logic A, B;

  halfAdder dut (.result, .carry_out, .A, .B);

  integer i;
    initial begin
    for(i=0; i<4; i++) begin
      {A, B} = i; #10;
      end
    end
endmodule
