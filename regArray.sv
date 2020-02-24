`timescale 1ns/10ps

module regArray #(parameter DATA_WIDTH=64, ADDR_WIDTH=5) (
	output logic [63:0] q [31:0],
	input  logic [DATA_WIDTH-1:0] d,
  input  logic [31:0] en,
	input  logic reset, clk
	);

	parameter delay = 0.05;

//------Validate data width------------------------------------
  initial assert(DATA_WIDTH>0);
	initial assert(ADDR_WIDTH>0);

//------Generate ADDR_WIDTH-1 registers------------------------
//      *Leave last register out (hardwired zeros)
  genvar i;

  generate
    for(i=0; i<31; i++) begin : eachReg
      register64 regA (.q(q[i]), .d, .en(en[i]), .reset, .clk);
    end
  endgenerate

	//hardwired zero register
	register64 regA (.q(q[31]), .d, .en(en[31]), .reset(1'b1), .clk);

endmodule

//------Testbench for register array---------------------------
module regArray_testbench();
  parameter DATA_WIDTH = 64, ADDR_WIDTH = 5;

	logic [DATA_WIDTH-1:0] q [0:2**ADDR_WIDTH-1];
	logic [DATA_WIDTH-1:0] d;
  logic en, reset, clk;
	parameter period = 100;

  //Instantiate the register array
	regArray dut (.q, .d, .en, .reset, .clk);

  //Set up the clock
	initial begin
		clk <= 0;
		forever #(period/2) clk <= ~clk;
	end

	//This will set the bits of every register since
	//there is no multiplexing yet.
	initial begin
		reset <= 1; d <= 64'b0; en <= 0;		@(posedge clk);
		reset <= 0;													@(posedge clk);
		en <= 1; 														@(posedge clk);
		d <= 64'd128;												@(posedge clk);
		en <= 0; d <= 64'b0;								@(posedge clk);
		en <= 1; 														@(posedge clk);
		en <= 0; 														@(posedge clk);
																				@(posedge clk);
		$stop();
	end

endmodule
