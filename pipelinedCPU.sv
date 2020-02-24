`timescale 1ns/10ps
module pipelinedCPU(
 input logic clk, reset
);


//------Create the internal logic signals---------------------------------------
  logic  [31:0] instruction;
  logic         negative, zero, overflow, carry_out;
  logic  [4:0]  Rd, Rm, Rn;
  logic  [5:0]  shamt;
  logic         Reg2Loc, Reg3Loc, RegWrite, ImmOrAddr;
  logic         ALUSrc, MemWrite, MemRead;
  logic  [2:0]  ALUOp;
  logic  [1:0]  MemToReg;
  logic  [18:0] CondAddr19;
  logic  [25:0] BrAddr26;
  logic  [8:0]  DAddr9;
  logic  [11:0] ALU_Imm12;
  logic         UncondBr, BrTaken, Branch;
  logic  [4:0]  Ab, Aw;
  logic  [63:0] Da, Db, Dw, ALUResult, Dout, MuxedDout, MuxedUncondBr, MuxedALUSrc, MuxedDb, MuxedBranch;
  logic  [63:0] PCOut, pipelinedPCOut, NextAddr, AddedInstNotBranch, AddedInstBranch, MuxedImmOrAddr;
	logic 				negativePrev, zeroPrev, overflowPrev, carry_outPrev, setFlags;

//------Instantiate all components of datapath----------------------------------

//------Pipeline Stage 1--------------------------------------------------------
//      Instruction Fetch



  pc          thepc          (.oldaddress(PCOut), .newaddress(MuxedBranch), .clk, .reset(reset));
  instructmem im             (.address(PCOut), .instruction, .clk);

  register64  #(32) p1       (.q(pipelinedPCOut), .d(PCOut), .en(), .reset, .clk); //reg64 is parameterized

//------Pipeline Stage 2--------------------------------------------------------
//      Instruction decode and register fetch



  mux2_1x64   uncond         (.out(MuxedUncondBr), .in0({{45{CondAddr19[18]}},CondAddr19}), .in1({{38{BrAddr26[25]}},BrAddr26}), .sel1(UncondBr));
  adder_64    notBranchedIns (.result(AddedInstNotBranch), .carry_out(), .A(pipelinedPCOut), .B(64'd4));
  adder_64    branchedIns    (.result(AddedInstBranch), .carry_out(), .A(pipelinedPCOut), .B({MuxedUncondBr[61:0],2'b00}));
  mux2_1x64   btak           (.out(NextAddr), .in0(AddedInstNotBranch), .in1(AddedInstBranch), .sel1(BrTaken));
  mux2_1x64   branch         (.out(MuxedBranch), .in0(NextAddr), .in1(Db), .sel1(Branch));
  regfile     reg32          (.ReadData1(Da), .ReadData2(Db), .WriteData(Dw), .ReadRegister1(Rn), .ReadRegister2(Ab), .WriteRegister(Aw), .RegWrite, .clk, .reset);

	decodeInstruction decodeI  (.Rn, .Rm, .Rd, .shamt,
  										         .Reg2Loc, .Reg3Loc, .RegWrite, .ImmOrAddr,
  										         .MemWrite, .MemRead, .BrTaken, .Branch, .UncondBr,
  										         .ALUSrc, .MemToReg,	.ALU_Imm12,	.ALUOp,
  										         .CondAddr19, .BrAddr26, .DAddr9, .instruction,
  										         .negative(negativePrev), .zero(zeroPrev), .currentzero(zero),
  										         .overflow(overflowPrev), .carry_out(carry_outPrev), .clk,
  										         .reset, .setFlags);

  register64 #(4) flags       (.q({negativePrev, zeroPrev, overflowPrev, carry_outPrev}),
                                .d({negative, zero, overflow, carry_out}), .en(setFlags), .reset, .clk);


  register64  #(32) p2        (.q(pipelinedPCOut), .d(PCOut), .en(), .reset(1'b1), .clk); //reg64 is parameterized


  //------Pipeline Stage 3--------------------------------------------------------
  //      Execute
  alu         theALU          (.A(Da), .B(MuxedDb), .cntrl(ALUOp), .result(ALUResult), .negative, .zero, .overflow, .carry_out);

  mux2_1x64  #(5) rdOR30      (.out(Aw), .in0(Rd), .in1(5'b11110), .sel1(Reg3Loc));
  mux2_1x64  #(5) rdORrm      (.out(Ab), .in0(Rd), .in1(Rm), .sel1(Reg2Loc));
  mux2_1x64   ALUSourc        (.out(MuxedDb), .in0(Db), .in1(MuxedImmOrAddr), .sel1(ALUSrc));
  mux2_1x64   ImmORAddr1      (.out(MuxedImmOrAddr), .in0({{52{ALU_Imm12[11]}},ALU_Imm12}), .in1({{55{DAddr9[8]}},DAddr9}), .sel1(ImmOrAddr));

  register64  #(32) p3        (.q(pipelinedPCOut), .d(PCOut), .en(), .reset(1'b1), .clk); //reg64 is parameterized

  //------Pipeline Stage 4--------------------------------------------------------
  //      Memory access
  datamem     mem             (.address(ALUResult), .write_enable(MemWrite), .read_enable(MemRead), .write_data(Db), .clk, .xfer_size(4'b1000), .read_data(Dout));
  mux4_1x64   dataOut         (.out(Dw), .in0(ALUResult), .in1(Dout), .in2(AddedInstNotBranch), .in3(64'b0), .sel1(MemToReg));


endmodule

module pipelinedCPU_testbench();
`timescale 1ns/10ps
logic  [31:0] instruction;
logic         negative, zero, overflow, carry_out;
logic  [4:0]  Rd, Rm, Rn;
logic  [5:0]  shamt;
logic         Reg2Loc, Reg3Loc, RegWrite, ImmOrAddr;
logic         ALUSrc, MemWrite, MemRead;
logic  [2:0]  ALUOp;
logic  [1:0]  MemToReg;
logic  [18:0] CondAddr19;
logic  [25:0] BrAddr26;
logic  [8:0]  DAddr9;
logic  [11:0] ALU_Imm12;
logic         UncondBr, BrTaken, Branch;
logic  [4:0]  Ab, Aw;
logic  [63:0] Da, Db, Dw, ALUResult, Dout, MuxedDout, MuxedUncondBr, MuxedALUSrc, MuxedDb, MuxedBranch;
logic  [63:0] PCOut, NextAddr, AddedInstNotBranch, AddedInstBranch, MuxedImmOrAddr;
logic 				negativePrev, zeroPrev, overflowPrev, carry_outPrev, setFlags;
logic         clk, reset;

parameter ClockDelay = 100;

datapath dut (.instruction, .negative, .zero, .overflow, .carry_out,
						   .Rd, .Rm, .Rn, .Reg2Loc, .Reg3Loc, .RegWrite, .ImmOrAddr,
						   .ALUSrc, .ALUOp, .MemWrite, .MemRead, .MemToReg,
						   .CondAddr19, .BrAddr26, .DAddr9, .ALU_Imm12,
						   .UncondBr, .BrTaken, .Branch, .clk, .reset);

//[4:0] Rd, Rm, Rn,
//input  logic  Reg2Loc, RegWrite, ImmOrAddr,
//input  logic  ALUSrc, MemWrite, MemRead,
//input  logic  [2:0] ALUOp,
//input  logic  [1:0] MemToReg,
//input  logic  [18:0] CondAddr19,
//input  logic  [25:0] BrAddr26,
//input  logic  [8:0] DAddr9,
//input  logic  [11:0] ALU_Imm12,
//input  logic  UncondBr, BrTaken, clk, reset

initial begin // Set up the clock
 clk <= 0;
 forever #(ClockDelay/2) clk <= ~clk;
end
initial begin
reset <=1;
@(posedge clk);
reset <=0;
@(posedge clk);
//Load in 0 to X0
{Rd, Rm, Rn} <= {15'b_00000_11111_11111};
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);

@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);

$stop;
end
endmodule
