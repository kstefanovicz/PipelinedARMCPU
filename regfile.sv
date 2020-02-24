`timescale 1ns/10ps

parameter DATA_LINES =  32;  //number of registers
parameter DATA_LENGTH = 64;  //register word width
parameter ADDRESS = 5;       //register address width

module regfile(
		input  logic [ADDRESS-1:0]  ReadRegister1, ReadRegister2, WriteRegister,
		input  logic [DATA_LENGTH-1:0]	WriteData,  		//incoming data
		input  logic RegWrite,   												//enable to write to register
		input  logic clk, reset,
		output logic [DATA_LENGTH-1:0]	ReadData1, ReadData2
		);

//------Zoe's register organization to change the orientation of----------------
//      the packed array coming out of the register array.
//      Modified by Kristi to include different submodules
//			including mux32_1, decoder, and regArray

logic  [DATA_LENGTH-1:0] register32by64 [DATA_LINES-1:0];
logic  [DATA_LINES-1:0] register64by32 [DATA_LENGTH-1:0];

//------Assign the output of the register array to------------------------------
//      an array of registers that can be parsed for the -----------------------
//      multiplexers.

genvar i, j;

generate
	for (i=0; i<DATA_LENGTH; i++) begin: gen_reg
		for (j=0; j<DATA_LENGTH; j++) begin: gen_reg2
			assign register64by32[i][j] = register32by64[j][i];
		end
	end
endgenerate


//------Create two sets of 64 multiplexers to take each bit---------------------
//      from the register and reassemble it to the correct output.

genvar k;

generate
for (k=0; k<DATA_LENGTH; k++) begin: gen_muxes
	  mux32_1 mux1 (.out(ReadData1[k]), .in(register64by32[k]), .sel(ReadRegister1));
		mux32_1 mux2 (.out(ReadData2[k]), .in(register64by32[k]), .sel(ReadRegister2));
	end
endgenerate


//------Instantiate decoder and register array----------------------------------

	logic [DATA_LINES-1:0] decoderOutput;

	decoder mainDec 			(.en(decoderOutput), .WriteRegister, .RegWrite);
	regArray mainReg 			(.q(register32by64), .d(WriteData), .en(decoderOutput), .reset(), .clk(clk));

endmodule

module regfile_testbench();

	parameter ClockDelay = 5000;

	logic	[4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	logic [63:0]	WriteData;
	logic 			  RegWrite, clk, reset;
	logic [63:0]	ReadData1, ReadData2;

	integer i;

	// Your register file MUST be named "regfile".
	// Also you must make sure that the port declarations
	// match up with the module instance in this stimulus file.
	regfile dut (.ReadData1, .ReadData2, .WriteData,
					 .ReadRegister1, .ReadRegister2, .WriteRegister,
					 .RegWrite, .clk, .reset);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial begin
		reset <= 1'b1;
		@(posedge clk);
		reset <= 1'b0;
		@(posedge clk);
		// Try to write the value 0xA0 into register 31.
		// Register 31 should always be at the value of 0.
		RegWrite <= 5'd0;
		ReadRegister1 <= 5'd0;
		ReadRegister2 <= 5'd0;
		WriteRegister <= 5'd31;
		WriteData <= 64'h00000000000000A0;
		@(posedge clk);

		$display("%t Attempting overwrite of register 31, which should always be 0", $time);
		RegWrite <= 1;
		@(posedge clk);

		// Write a value into each  register.
		$display("%t Writing pattern to all registers.", $time);
		for (i=0; i<31; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000010204080001;
			@(posedge clk);

			RegWrite <= 1;
			@(posedge clk);
		end

		// Go back and verify that the registers
		// retained the data.
		$display("%t Checking pattern.", $time);
		for (i=0; i<32; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000000000000100+i;
			@(posedge clk);
		end
		$stop;
	end
endmodule
