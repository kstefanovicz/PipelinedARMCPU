`timescale 1ns/10ps

//------CONTROL MODULE receives instructions from the instruction----------------
//      memory, sends them to the instruction decoder
//			and sets flags.

module control (
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
	output logic 				RegWrite,
	output logic 				Reg2Loc,
	output logic 				CondBrTaken,
	input  logic [31:0] instruction,
	input  logic [2:0]	FwdScB,
	input  logic 				negative, zero, overflow, carry_out,
	input  logic 				clk, reset
	);

	logic negativePrev, zeroPrev, overflowPrev, carry_outPrev, negativeFlag, zeroFlag, overflowFlag, carry_outFlag, setFlags, setFlagsPrev;

//------Initialize instruction decoder------------------------------------------
//      and create internal logic support signals

	decodeInstruction decodeI (.Rn, .Rm, .Rd, .shamt, .ALU_Imm12, .CondAddr19,
															.BrAddr26, .DAddr9, .ALUSrc, .ALUOp, .MemWrite,
															.MemRead, .MemToReg, .RegWrite, .Reg2Loc,
															.CondBrTaken,	.setFlags, .instruction, .FwdScB,
															.negative(negativeFlag), .zero(zeroFlag),
															.currentzero(zero),	.overflow(overflowFlag),
															.carry_out(carry_outFlag), .clk, .reset);


//------Set flags for decode . one cycle later-----------------------------------
//      In a pipelined CPU, they already are one cycle later
	always_comb begin
		if (setFlagsPrev) begin
			negativeFlag=negative;
			zeroFlag=zero;
			overflowFlag=overflow;
			carry_outFlag=carry_out;
		end

		else begin
			negativeFlag=negativePrev;
			zeroFlag=zeroPrev;
			overflowFlag=overflowPrev;
			carry_outFlag=carry_outPrev;
		end
	end

	dFF F (.q(setFlagsPrev), 	.d(setFlags), 	.reset, .clk);
	DFFen N (.q(negativePrev), 	.d(negative), 	.en(setFlagsPrev), .reset, .clk);
	DFFen Z (.q(zeroPrev), 			.d(zero), 			.en(setFlagsPrev), .reset, .clk);
	DFFen V (.q(overflowPrev), 	.d(overflow), 	.en(setFlagsPrev), .reset, .clk);
	DFFen C (.q(carry_outPrev), .d(carry_out), 	.en(setFlagsPrev), .reset, .clk);

	//DFFen N (.q(negativePrev), 	.d(negative), 	.en(setFlags), .reset, .clk);
	//DFFen Z (.q(zeroPrev), 			.d(zero), 			.en(setFlags), .reset, .clk);
	//DFFen V (.q(overflowPrev), 	.d(overflow), 	.en(setFlags), .reset, .clk);
	//DFFen C (.q(carry_outPrev), .d(carry_out), 	.en(setFlags), .reset, .clk);

endmodule


module control_testbench();

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
logic  [1:0]  CondBrTaken, BrTakenP2;
logic  [31:0] instruction, instructionP1;
logic         negative, zero, overflow, carry_out;
logic 				negativePrev, zeroPrev, overflowPrev, carry_outPrev;
logic 				clk, reset;

parameter ClockDelay = 100;

	control dut (.Rn, .Rm, .Rd, .shamt, .ALU_Imm12, .CondAddr19,
							 .BrAddr26, .DAddr9, .ALUSrc, .ALUOp, .MemWrite,
							 .MemRead, .MemToReg, .RegWrite, .Reg2Loc, .CondBrTaken,
							 .instruction, .negative,
							 .zero, .overflow, .carry_out, .clk, .reset);

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




///*
//ADDI Rd, Rn, Imm12: Reg[Rd] = Reg[Rn] + ZeroExtend(Imm12).
//ADDS Rd, Rn, Rm: Reg[Rd] = Reg[Rn] + Reg[Rm]. Set flags.
//B Imm26: PC = PC + SignExtend(Imm26 << 2).
// For lab #4 (only) this instr. has a delay slot.
//B.LT Imm19: If (flags.negative != flags.overflow) PC = PC + SignExtend(Imm19<<2).
// For lab #4 (only) this instr. has a delay slot.
//BL Imm26: X30 = PC + 4 (instruction after this one), PC = PC + SignExtend(Imm26<<2).
// For lab #4 (only) this instr. has a delay slot.
//BR Rd: PC = Reg[Rd].
// For lab #4 (only) this instr. has a delay slot.
//CBZ Rd, Imm19: If (Reg[Rd] == 0) PC = PC + SignExtend(Imm19<<2).
// For lab #4 (only) this instr. has a delay slot.
//LDUR Rd, [Rn, #Imm9]: Reg[Rd] = Mem[Reg[Rn] + SignExtend(Imm9)].
//For lab #4 (only) the value in rd cannot be used in the next cycle.
//STUR Rd, [Rn, #Imm9]: Mem[Reg[Rn] + SignExtend(Imm9)] = Reg[Rd].
//SUBS Rd, Rn, Rm: Reg[Rd] = Reg[Rn] - Reg[Rm]. Set flags.
//*/
