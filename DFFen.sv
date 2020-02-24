`timescale 1ns/10ps

module DFFen(
	output logic q,
	input  logic d, en, reset, clk
	);

//------Intermediate logic to add enable signal to D_FF-------
	logic p, d1, q1, notEn;
	parameter delay = 0.05;

//------Enable multiplexes d and q, ends up as p.-------------
//      Gates are have 50 ps delay based on
//      regstim testbench timescale.
//      **Should try to switch to nand/nor**
	not #delay not1  (notEn, en);
	and #delay and1 (d1, en, d);
	and #delay and2 (q1, notEn, q);
	or  #delay or2  (p, d1, q1);

//------Instantiate the D_FF with gated signal p--------------
	dFF addEn (.q, .d(p), .reset, .clk);

endmodule



//------Testbench for dff-------------------------------------
`timescale 1ns/10ps
module DFFen_testbench();

	logic q, d, en, reset, clk;
	parameter period = 100;

	DFFen dut (.q, .d, .en, .reset, .clk);

	initial begin // Set up the clock
		clk <= 0;
		forever #(period/2) clk <= ~clk;
	end

	initial begin
		reset <= 1; d <= 0; en <= 0;				@(posedge clk);
		reset <= 0;													@(posedge clk);
		en <= 1; 														@(posedge clk);
		d <= 1;															@(posedge clk);
		en <= 0; d <= 0;										@(posedge clk);
		en <= 1; 														@(posedge clk);
		en <= 0; 														@(posedge clk);
																				@(posedge clk);
		$stop();
	end

endmodule
