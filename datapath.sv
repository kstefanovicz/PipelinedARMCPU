module datapath(
  output logic  [31:0] instruction,
  output logic  negative, zero, overflow, carry_out,
  input  logic  [4:0] Rd, Rm, Rn,
  input  logic  Reg2Loc, Reg3Loc, RegWrite, ImmOrAddr,
  input  logic  ALUSrc, MemWrite, MemRead,
  input  logic  [2:0] ALUOp,
  input  logic  [1:0] MemToReg,
  input  logic  [18:0] CondAddr19,
  input  logic  [25:0] BrAddr26,
  input  logic  [8:0] DAddr9,
  input  logic  [11:0] ALU_Imm12,
  input  logic  UncondBr, BrTaken, Branch, clk, reset
);
//B.L needs two bits on memtoreg because of branch link (almost same as b.cond)
//100101 (saves next inst into x30)

//-------Create the internal logic signals--------------------------------------


  logic [4:0]  Ab, Aw;
  logic [63:0] Da, Db, Dw, ALUResult, Dout, MuxedDout, MuxedUncondBr, MuxedALUSrc, MuxedDb, MuxedBranch;
  logic [63:0] PCOut, NextAddr, AddedInstNotBranch, AddedInstBranch, MuxedImmOrAddr;

//-------Instantiate all components of datapath---------------------------------

  //Instruction datapath
  pc          thepc           (.oldaddress(PCOut), .newaddress(MuxedBranch), .clk, .reset(reset));
  instructmem im              (.address(PCOut), .instruction, .clk);
  mux2_1x64   uncond          (.out(MuxedUncondBr), .in0({{45{CondAddr19[18]}},CondAddr19}), .in1({{38{BrAddr26[25]}},BrAddr26}), .sel1(UncondBr));
  adder_64    notBranchedIns  (.result(AddedInstNotBranch), .carry_out(), .A(PCOut), .B(64'd4));
  adder_64    branchedIns     (.result(AddedInstBranch), .carry_out(), .A(PCOut), .B({MuxedUncondBr[61:0],2'b00}));
  mux2_1x64   btak            (.out(NextAddr), .in0(AddedInstNotBranch), .in1(AddedInstBranch), .sel1(BrTaken));
  mux2_1x64   branch          (.out(MuxedBranch), .in0(NextAddr), .in1(Db), .sel1(Branch));

  //Register and Memory Datapath
  regfile reg32         (.ReadData1(Da), .ReadData2(Db), .WriteData(Dw), .ReadRegister1(Rn), .ReadRegister2(Ab), .WriteRegister(Aw), .RegWrite, .clk, .reset);
  alu         theALU    (.A(Da), .B(MuxedDb), .cntrl(ALUOp), .result(ALUResult), .negative, .zero, .overflow, .carry_out);
  datamem     mem       (.address(ALUResult), .write_enable(MemWrite), .read_enable(MemRead), .write_data(Db), .clk, .xfer_size(4'b1000), .read_data(Dout));
  mux2_1x64  #(5) rdOR30(.out(Aw), .in0(Rd), .in1(5'b11110), .sel1(Reg3Loc));
  mux2_1x64  #(5) rdORrm(.out(Ab), .in0(Rd), .in1(Rm), .sel1(Reg2Loc));
  mux2_1x64   ALUSourc  (.out(MuxedDb), .in0(Db), .in1(MuxedImmOrAddr), .sel1(ALUSrc));

  mux4_1x64   dataOut   (.out(Dw), .in0(ALUResult), .in1(Dout), .in2(AddedInstNotBranch), .in3(64'b0), .sel1(MemToReg));
  mux2_1x64   ImmORAddr1(.out(MuxedImmOrAddr), .in0({{52{ALU_Imm12[11]}},ALU_Imm12}), .in1({{55{DAddr9[8]}},DAddr9}), .sel1(ImmOrAddr));


endmodule

module datapath_testbench();
`timescale 1ns/10ps
logic  [31:0] instruction;
logic  negative, zero, overflow, carry_out;
logic  [4:0] Rd, Rm, Rn;
logic  Reg2Loc, Reg3Loc, RegWrite, ImmOrAddr;
logic  ALUSrc, MemWrite, MemRead;
logic  [2:0] ALUOp;
logic  [1:0] MemToReg;
logic  [18:0] CondAddr19;
logic  [25:0] BrAddr26;
logic  [8:0] DAddr9;
logic  [11:0] ALU_Imm12;
logic  UncondBr, BrTaken, Branch, clk, reset;

parameter ClockDelay = 100;

datapath dut (.instruction, .negative, .zero, .overflow, .carry_out,
						   .Rd, .Rm, .Rn, .Reg2Loc, .Reg3Loc, .RegWrite, .ImmOrAddr,
						   .ALUSrc, .ALUOp, .MemWrite, .MemRead, .MemToReg,
						   .CondAddr19, .BrAddr26, .DAddr9, .ALU_Imm12,
						   .UncondBr, .BrTaken, .Branch, .clk, .reset);

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
