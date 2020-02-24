`timescale 1ns/10ps

module register64 #(parameter DATA_WIDTH=64) (
	output logic [DATA_WIDTH-1:0] q,
	input  logic [DATA_WIDTH-1:0] d,
  input  logic en,
	input  logic reset, clk
	);

	parameter delay = 0.05;

//------Validate data width------------------------------------
  initial assert(DATA_WIDTH>0);

//------Generate an array of flip flops -----------------------
  genvar i;
  generate
    for(i=0; i<DATA_WIDTH; i++) begin : eachDff
		   	DFFen dff (.q(q[i]), .d(d[i]), .en, .reset, .clk);
    end
  endgenerate
endmodule



//------Testbench for register---------------------------------
module register64_testbench();
  parameter DATA_WIDTH = 64;

	logic [3:0] q, d;
  logic en;
	logic reset, clk;
	parameter period = 100;

  //Instantiate the register
	register64 #(4) dut (.q, .d, .en, .reset, .clk);

  //Set up the clock
	initial begin
		clk <= 0;
		forever #(period/2) clk <= ~clk;
	end

	initial begin
		reset <= 1; d <= 64'b0; en <= 0;		@(posedge clk);
		reset <= 0;													@(posedge clk);
		en <= 1; 														@(posedge clk);
		d <= $random();											@(posedge clk);
		en <= 0; d <= $random();						@(posedge clk);
		en <= 1; d <= $random();						@(posedge clk);
		en <= 0; d <= $random();						@(posedge clk);
																				@(posedge clk);
		$stop();
	end

endmodule
