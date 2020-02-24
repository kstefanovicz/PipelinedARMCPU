`timescale 1ns/10ps

module pc(
  output logic [63:0] oldaddress,
  input  logic [63:0] newaddress,
  input  logic        clk, reset
);

//------Create an array of dffs to hold the address-----------------------------

genvar i;
generate
  for (i=0; i<64; i++) begin: gen_64
    dFF dffGen (.q(oldaddress[i]), .d(newaddress[i]), .reset, .clk);
  end
endgenerate

endmodule
//------Testbench passes in random values to the PC-----------------------------

module pc_testbench();

	parameter ClockDelay = 100;
  logic [63:0] oldaddress;
  logic [63:0] newaddress;
  logic        clk, reset;

  pc dut (.oldaddress, .newaddress, .clk, .reset);
	integer i;

  initial begin // Set up the clock
    clk <= 0;
    forever #(ClockDelay/2) clk <= ~clk;
  end

  initial begin
    newaddress <=$random();
		reset<=1; @(posedge clk);
		reset<=0; @(posedge clk);

    newaddress <=$random();

		@(posedge clk);
		@(posedge clk);
		@(posedge clk);

    newaddress <=$random();
		@(posedge clk);
		@(posedge clk);
    newaddress <=$random();
		@(posedge clk);
		@(posedge clk);
    newaddress <=$random();
		@(posedge clk);
    newaddress <=$random();
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);

		$stop;
	end
endmodule
