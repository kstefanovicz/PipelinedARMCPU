//------Make a 5:32 decoder out of 5 3:8 decoders-------------

module decoder (
	output logic [31:0] en,
	input  logic [4:0] WriteRegister,
	input  logic RegWrite
	);

//------Create wiring structure for decoder--------------------
	logic [4:0] notWriteRegister;
	logic [4:0] firstDec;
	logic [2:0] nullWires;

	parameter delay = 0.05;


//------Make 5 decoders-----------------------------------
//      Wire them to produce an 8:32 decoder
dec3_8 dcdr4 (.en({nullWires, firstDec}), .WriteRegister({1'b0,WriteRegister[4:3]}), .RegWrite);
dec3_8 dcdr3 (.en(en[31:24]), .WriteRegister(WriteRegister[2:0]), .RegWrite(firstDec[3]));
dec3_8 dcdr2 (.en(en[23:16]), .WriteRegister(WriteRegister[2:0]), .RegWrite(firstDec[2]));
dec3_8 dcdr1 (.en(en[15:8]),  .WriteRegister(WriteRegister[2:0]), .RegWrite(firstDec[1]));
dec3_8 dcdr0 (.en(en[7:0]),   .WriteRegister(WriteRegister[2:0]), .RegWrite(firstDec[0]));

endmodule

//------Testbench for register array---------------------------
module decoder_testbench();
	logic [31:0] en;
	logic [4:0] WriteRegister;
	logic RegWrite, clk;
	parameter period = 100;

  //Instantiate the decoder
	decoder dut (.en, .WriteRegister, .RegWrite);

  //Set up the clock
	initial begin
		clk <= 0;
		forever #(period/2) clk <= ~clk;
	end

	//Write test values to the decoder
	initial begin

		RegWrite <= 0; WriteRegister <= 5'b00001;			@(posedge clk); //test 1
		RegWrite <= 1; 																@(posedge clk);
																									@(posedge clk);
		RegWrite <= 0; WriteRegister <= 5'b00101;			@(posedge clk); //test 5
																									@(posedge clk);
		RegWrite <= 1; 																@(posedge clk);
		 																							@(posedge clk);
		RegWrite <= 0; WriteRegister <= 5'b10111;			@(posedge clk); //test 23
																									@(posedge clk);
		RegWrite <= 1; 																@(posedge clk);
		RegWrite <= 0;																@(posedge clk);
		@(posedge clk);
		$stop();
	end

endmodule
