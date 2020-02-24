module dec3_8 (
	output logic [7:0] en,
	input  logic [2:0] WriteRegister,
	input  logic RegWrite
	);

	parameter delay = 0.05;

//------Create wiring structure for decoder--------------------
	logic [2:0] notWriteRegister;


//------Generate negated address signals-----------------------
  genvar k;

  generate
    for(k=0; k<3; k++) begin : eachNot
      not invtr (notWriteRegister[k], WriteRegister[k]);
    end
  endgenerate

//------Make 8 AND gates--------------------------------------
//      And each signal with each negated signal
//			as well as RegWrite
and and0 (en[7], RegWrite,    WriteRegister[2],    WriteRegister[1],    WriteRegister[0]);
and and1 (en[6], RegWrite,    WriteRegister[2],    WriteRegister[1], notWriteRegister[0]);
and and2 (en[5], RegWrite,    WriteRegister[2], notWriteRegister[1],    WriteRegister[0]);
and and3 (en[4], RegWrite,    WriteRegister[2], notWriteRegister[1], notWriteRegister[0]);
and and4 (en[3], RegWrite, notWriteRegister[2],    WriteRegister[1],    WriteRegister[0]);
and and5 (en[2], RegWrite, notWriteRegister[2],    WriteRegister[1], notWriteRegister[0]);
and and6 (en[1], RegWrite, notWriteRegister[2], notWriteRegister[1],    WriteRegister[0]);
and and7 (en[0], RegWrite, notWriteRegister[2], notWriteRegister[1], notWriteRegister[0]);

endmodule

//------Testbench for register array---------------------------
module dec3_8_testbench();
	logic [7:0] en;
	logic [2:0] WriteRegister;
	logic RegWrite, clk;
	parameter period = 100;

  //Instantiate the decoder
	dec3_8 dut (.en, .WriteRegister, .RegWrite);

  //Set up the clock
	initial begin
		clk <= 0;
		forever #(period/2) clk <= ~clk;
	end

	//Write test values to the decoder
	initial begin

		RegWrite <= 0; WriteRegister <= 3'b001;				@(posedge clk);
		RegWrite <= 1; 																@(posedge clk);
																									@(posedge clk);
		RegWrite <= 0; WriteRegister <= 3'b101;				@(posedge clk);
																									@(posedge clk);
		RegWrite <= 1; 																@(posedge clk);
		 																							@(posedge clk);
																									@(posedge clk);
		$stop();
	end

endmodule
