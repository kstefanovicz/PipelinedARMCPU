`timescale 1ns/10ps

//------DECODE INSTRUCTION receives the instruction and passes------------------
//      the appropriate signals to the datapath.

module decodeInstruction (
	output logic [4:0] 	Rn, Rm, Rd,
	output logic [5:0]  shamt,
	output logic [11:0] ALU_Imm12,
	output logic [18:0] CondAddr19,
	output logic [25:0] BrAddr26,
	output logic [8:0]  DAddr9,
	output logic [1:0]	ALUSrc,
	output logic [2:0]  ALUOp,
	output logic  			MemWrite, MemRead,
	output logic [1:0]  MemToReg,
	output logic 				RegWrite,	Reg2Loc,
	output logic 				CondBrTaken, setFlags,
	input  logic [31:0] instruction,
	input  logic [2:0]  FwdScB,
	input  logic 				negative, zero, currentzero, overflow, carry_out,	clk, reset
);

	parameter DELAY = 0.05;

//------LIST OPCODES------------------------------------------------------------
//      Create enumerated types for each instruction format,
//      opcode, and condition code. Use these types to easily generate
//      control signal logic.

	enum {B_TYPE=6, CB_TYPE=8, R_TYPE=11, I_TYPE=9, D_TYPE=12, UNDEF=0} format;


	typedef enum {B=5, BL=37, Bcond=84, CBZ=180, CBNZ=181, AND=1104, ADD=1112,
								SDIV=1238, MUL=1240, ORR=1360, ADDS=1368, EOR=1616, SUB=1624,
								LSR=1690, LSL=1691,	BR=1712, ANDS=1872, SUBS=1880, ADDI=580,
								ANDI=584, ADDIS=356, ORRI=360, SUBI=836, EORI=840, SUBIS=708,
								ANDIS=712, STURB=448, LDURB=450, STUR=1984, LDUR=1986} OPCODE;

	typedef enum {EQ=0, NE=1, GE=10, LT=11, GT=12, LE=13} CONDCODE;


//------Format and Opcode Idenfication------------------------------------------
//      Classify the format of the instruction
// 			based on range and value of the 11 MSBs.

parameter BTYPE=5, CBTYPE=7, RTYPE=10, ITYPE=9, DTYPE=10, COND=4;
logic [10:0] iMSB;
assign iMSB = instruction[31:21];
OPCODE opcode;
CONDCODE condcode;
		always_comb begin
		     	 if (((iMSB>=11'h0A0)&&(iMSB<=11'h0BF)) || ((iMSB>=11'h4A0)&&(iMSB<=11'h4BF)))
					  	begin
								format = B_TYPE;
								opcode = OPCODE'(instruction[31:31-BTYPE]);
							end

			else if (((iMSB>=11'h2A0)&&(iMSB<=11'h2A7)) || ((iMSB>=11'h5A0)&&(iMSB<=11'h5AF)))
							begin
								format = CB_TYPE;
								opcode = OPCODE'(instruction[31:31-CBTYPE]);
								condcode = CONDCODE'(instruction[4:0]);
							end

	  	else if (((iMSB>=11'h450)&&(iMSB<=11'h458)) || ((iMSB>=11'h4D6)&&(iMSB<=11'h558)) ||
						   ((iMSB>=11'h650)&&(iMSB<=11'h658)) || ((iMSB>=11'h69A)&&(iMSB<=11'h758)))
							 begin
							 	format = R_TYPE;
							 	opcode = OPCODE'(instruction[31:31-RTYPE]);
							end

	  	else if (((iMSB>=11'h488)&&(iMSB<=11'h491)) || ((iMSB>=11'h588)&&(iMSB<=11'h591)) ||
							 ((iMSB>=11'h688)&&(iMSB<=11'h691)) || ((iMSB>=11'h788)&&(iMSB<=11'h791)) ||
								(iMSB == 11'h2c8))
								begin
									format = I_TYPE;
									opcode = OPCODE'(instruction[31:31-ITYPE]);
								end

	  	else if (((iMSB>=11'h1C0)&&(iMSB<=11'h1C2)) || ((iMSB>=11'h7C0)&&(iMSB<=11'h7C2)))
								begin
									format = D_TYPE;
									opcode = OPCODE'(instruction[31:31-DTYPE]);
								end

			else format = UNDEF; //undefined instruction
		end


//------Parse the instruction to the appropriate fields-------------------------

		assign BrAddr26 	= instruction[25:0];
		assign CondAddr19 = instruction[23:5];
		assign Rd 				= (opcode==BL) ? 5'd30 : instruction[4:0];
		assign Rn 				= instruction[9:5];
		assign Rm 				= instruction[20:16];
		assign shamt 			= instruction [15:10];
		assign ALU_Imm12 	= instruction[21:10];
		assign DAddr9 		= instruction[20:12];

//------Flag Generate Logic-----------------------------------------------------
//      Use previous cycle's flags to determine
//		  the status of current instruction's dependencies.

		logic lessThan, greaterThan, LTorEQ, GTorEQ;

		xor #(DELAY) gteq	(GTorEQ, ~negative, overflow);
		and #(DELAY) gt		(greaterThan, GTorEQ, ~zero);
		xor #(DELAY) lt		(lessThan, negative, overflow);
		or	#(DELAY) lteq	(LTorEQ, lessThan, zero);



//------Set control signals based on format and opcode--------------------------

	assign Reg2Loc 	 = (format==R_TYPE&&opcode!=BR);
	assign RegWrite  = (opcode==BL||(format==R_TYPE&&opcode!=BR)||format==I_TYPE||opcode==LDUR||opcode==LDURB);
	assign MemWrite  = (opcode==STUR||opcode == STURB);
	assign MemRead   = (opcode==LDUR||opcode==LDURB);
	assign setFlags  = (opcode==ANDS||opcode==ANDIS||opcode==SUBS||opcode==SUBIS||opcode==ADDS||opcode==ADDIS);


//------Set ALUSrc------------------------------------------------------------
//      If I_Type, ALUSrc is 2 to accept the immediate value.
//      If D_Type, ALUSrc is 1 to accept the memory offset.
//			Otherwise, ALUSrc is 0 to accept the regfile output.

	always_comb begin
			if (reset)															ALUSrc = 2'b00;
			else if (format==I_TYPE) 								ALUSrc = 2'b10;
			else if (format==D_TYPE) 								ALUSrc = 2'b01;
			else										 								ALUSrc = 2'b00;
	end

//------Set MemToReg------------------------------------------------------------
//      If BL, MemToReg is 2 so it can store the next PC address.
//			If loading, MemToReg is 1 to read from memory.
//			Otherwise, MemToReg is 0 to read ALU Output.

	always_comb begin
			if (reset)															MemToReg = 2'b00;
			else if (opcode==BL)		 								MemToReg = 2'b10;
			else if ((opcode==LDUR||opcode==LDURB)&&FwdScB!=3'b100) MemToReg = 2'b01;
			else										 								MemToReg = 2'b00;
	end


	//------Set CondBrTaken-------------------------------------------------------------
	//      Only handles conditional branches
	//      that require the flags.

		always_comb begin
			if (opcode == Bcond)
						case(condcode)
							EQ: CondBrTaken = zero;
							NE:	CondBrTaken = ~zero;
							GE:	CondBrTaken = GTorEQ;
							LT:	CondBrTaken = lessThan;
							GT: CondBrTaken = greaterThan;
							LE: CondBrTaken = LTorEQ;
						endcase
			else CondBrTaken = 1'b0;
		end


//------Set ALUOp based on format and opcode------------------------------------

	always_comb begin
		if (reset)									ALUOp = 3'b000;
		else
		case(format)
			B_TYPE:		ALUOp = 3'b000;
			CB_TYPE:	ALUOp = 3'b000;
			D_TYPE:		ALUOp = 3'b010;
			R_TYPE:		case(opcode)
										AND:	ALUOp = 3'b100;
										ADD:	ALUOp = 3'b010;
										ORR:	ALUOp = 3'b101;
										ADDS:	ALUOp = 3'b010;
										EOR:	ALUOp = 3'b110;
										SUB:	ALUOp = 3'b011;
										BR:		ALUOp = 3'b000;
										ANDS:	ALUOp = 3'b100;
										SUBS:	ALUOp = 3'b011;

								endcase
			I_TYPE:		case(opcode)
										ADDI:	 ALUOp = 3'b010;
										ANDI:	 ALUOp = 3'b100;
										ADDIS: ALUOp = 3'b010;
										ORRI:	 ALUOp = 3'b101;
										SUBI:	 ALUOp = 3'b011;
										EORI:	 ALUOp = 3'b110;
										SUBIS: ALUOp = 3'b011;
										ANDIS: ALUOp = 3'b100;
								endcase
			endcase
		end


endmodule


module decodeInstruction_testbench();
`timescale 1ns/10ps
logic  [4:0]  Rd, Rm, Rn, RdP2, RmP2, RnP2;
logic  [5:0]  shamt;
logic  [11:0] ALU_Imm12;
logic  [18:0] CondAddr19;
logic  [25:0] BrAddr26;
logic  [8:0]  DAddr9;
logic  [1:0]  ALUSrc;
logic  [2:0]  ALUOp, ALUOpP2;
logic         MemWrite, MemRead;
logic  [1:0]  MemToReg;
logic         RegWrite;
logic         Reg2Loc;
logic  [1:0]  BrTaken, BrTakenP2;
logic         UncondBr,  UncondBrP2;
logic         setFlags;
logic  [31:0] instruction, instructionP1;
logic         negative, zero, currentzero, overflow, carry_out;
logic 				negativePrev, zeroPrev, overflowPrev, carry_outPrev;
logic					clk, reset;

parameter ClockDelay = 100;

decodeInstruction dut (.Rn, .Rm, .Rd, .shamt, .ALU_Imm12, .CondAddr19,
											 .BrAddr26, .DAddr9, .ALUSrc, .ALUOp, .MemWrite,
											 .MemRead, .MemToReg, .RegWrite, .Reg2Loc, .BrTaken,
											 .UncondBr, .setFlags, .instruction, .negative,
											 .zero, .currentzero, .overflow, .carry_out, .clk, .reset);



	// Force %t's to print in a nice format.
	//initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial begin
		instruction<=32'b1001000100_000000000000_11111_00000;
		{negative, zero, overflow, carry_out} <= 4'b0;
		reset<=1; @(posedge clk);
		reset<=0; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		{negative, zero, overflow, carry_out} <= 4'b0;
		instruction<=32'b1001000100_000000000100_00000_00100;//addi
		@(posedge clk);
		@(posedge clk);
		{negative, zero, overflow, carry_out} <= 4'b0;
		instruction<=32'b11101011000_00001_000000_00000_00010;//subs
		@(posedge clk);
		@(posedge clk);
		{negative, zero, overflow, carry_out} <= 4'b0;
		instruction<=32'b10101011000_00001_000000_00000_00110;//adds
		@(posedge clk);
		@(posedge clk);
		{negative, zero, overflow, carry_out} <= 4'b0;
		instruction<=32'b000101_00000000000000000000001100; //b
		@(posedge clk);
		@(posedge clk);
		{negative, zero, overflow, carry_out} <= 4'b0100;
		instruction<=32'b10110100_0000000000000010100_11111;//cbz
		@(posedge clk);
		@(posedge clk);
		{negative, zero, overflow, carry_out} <= 4'b0000;
		instruction<=32'b10110100_0000000000000010100_11111;//cbz
		@(posedge clk);
		@(posedge clk);
		{negative, zero, overflow, carry_out} <= 4'b0;
		instruction<=32'b11111000000_111111101_00_00100_00001;//stur
		@(posedge clk);
		@(posedge clk);
		instruction<=32'b11111000010_000000101_00_00100_00111;//ldur
		@(posedge clk);
		@(posedge clk);
		{negative, zero, overflow, carry_out} <= 4'b1000;
		instruction<=32'b01010100_0000000000000001000_01011;//b.lt
		@(posedge clk);
		@(posedge clk);
		{negative, zero, overflow, carry_out} <= 4'b0010;
		instruction<=32'b01010100_0000000000000001000_01011;//b.lt
		@(posedge clk);
		@(posedge clk);
		{negative, zero, overflow, carry_out} <= 4'b1010;
		instruction<=32'b01010100_0000000000000001000_01011;//b.lt
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);

		$stop;
	end

endmodule
