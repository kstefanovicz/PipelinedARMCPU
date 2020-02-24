`timescale 1ns/10ps
module forward(
  output logic [2:0]  FwdScA, FwdScB,
  output logic [1:0]  FwdScC, FwdScD,
  input  logic [8:0]  DAddr9_DEC, DAddr9_EX,
  input  logic [31:0] instruction_DEC,
  input  logic [4:0] Rn_DEC, Rn_EX, Rm_DEC, Rd_DEC, Rd_EX, Rd_MEM, Rd_WR,
  input  logic [63:0] ALUResult_EX, ALUResult_MEM, Dw_WR,
  input  logic  RegWrite_EX, RegWrite_MEM, RegWrite_WR, MemRead_DEC, MemRead_EX, MemWrite_EX, MemWrite_MEM, clk, reset
);

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
assign iMSB = instruction_DEC[31:21];
OPCODE opcode;
CONDCODE condcode;
		always_comb begin
		     	 if (((iMSB>=11'h0A0)&&(iMSB<=11'h0BF)) || ((iMSB>=11'h4A0)&&(iMSB<=11'h4BF)))
					  	begin
								format = B_TYPE;
								opcode = OPCODE'(instruction_DEC[31:31-BTYPE]);
							end

			else if (((iMSB>=11'h2A0)&&(iMSB<=11'h2A7)) || ((iMSB>=11'h5A0)&&(iMSB<=11'h5AF)))
							begin
								format = CB_TYPE;
								opcode = OPCODE'(instruction_DEC[31:31-CBTYPE]);
								condcode = CONDCODE'(instruction_DEC[4:0]);
							end

	  	else if (((iMSB>=11'h450)&&(iMSB<=11'h458)) || ((iMSB>=11'h4D6)&&(iMSB<=11'h558)) ||
						   ((iMSB>=11'h650)&&(iMSB<=11'h658)) || ((iMSB>=11'h69A)&&(iMSB<=11'h758)))
							 begin
							 	format = R_TYPE;
							 	opcode = OPCODE'(instruction_DEC[31:31-RTYPE]);
							end

	  	else if (((iMSB>=11'h488)&&(iMSB<=11'h491)) || ((iMSB>=11'h588)&&(iMSB<=11'h591)) ||
							 ((iMSB>=11'h688)&&(iMSB<=11'h691)) || ((iMSB>=11'h788)&&(iMSB<=11'h791)) ||
								(iMSB == 11'h2c8))
								begin
									format = I_TYPE;
									opcode = OPCODE'(instruction_DEC[31:31-ITYPE]);
								end

	  	else if (((iMSB>=11'h1C0)&&(iMSB<=11'h1C2)) || ((iMSB>=11'h7C0)&&(iMSB<=11'h7C2)))
								begin
									format = D_TYPE;
									opcode = OPCODE'(instruction_DEC[31:31-DTYPE]);
								end

			else format = UNDEF; //undefined instruction
		end

//------Handle Reads in DEC after Writes in EX, MEM, or WR cycle----------------

    always_comb begin
      if(reset) FwdScA = 3'b00;
      else if  (Rn_DEC==Rd_EX && Rd_EX!=5'd31 && RegWrite_EX)  FwdScA = 3'b001;
      else if (Rn_DEC==Rd_MEM && Rd_MEM!=5'd31 && RegWrite_MEM) FwdScA = 3'b010;
      else if (Rn_DEC==Rd_WR && Rd_WR!=5'd31 && RegWrite_WR) FwdScA = 3'b011;
      else                     FwdScA = 3'b00;

    end

    always_comb begin
      if(reset) FwdScB = 3'b00;
      else if (Rm_DEC==Rd_EX && Rd_EX!=5'd31 && (format==R_TYPE||(opcode==STUR||opcode==STURB)))  FwdScB = 3'b001;
      else if (Rm_DEC==Rd_MEM && Rd_MEM!=5'd31 && format==R_TYPE) FwdScB = 3'b010;
      else if (Rm_DEC==Rd_WR && Rd_WR!=5'd31 && format==R_TYPE) FwdScB = 3'b011;
      else if ((Rd_DEC==Rd_EX)&&(opcode==CBZ||opcode==CBNZ||opcode==BR)) FwdScB=3'b001;
      else if ((Rd_DEC==Rd_MEM)&&(opcode==CBZ||opcode==CBNZ||opcode==BR)) FwdScB=3'b010;
      else if ((Rd_DEC==Rd_WR)&&(opcode==CBZ||opcode==CBNZ||opcode==BR)) FwdScB=3'b011;
      else                     FwdScB = 3'b00;
    end

//------Handle Stores after writes----------------------------------------------

    always_comb begin
      if (reset) FwdScC = 2'b0;
      else if (MemWrite_EX && Rd_EX==Rd_MEM) FwdScC = 2'b01;
      else if (MemWrite_EX && Rd_EX==Rd_WR) FwdScC = 2'b10;
      //else if (MemWrite_EX && Rn_EX==Rd_MEM) FwdScC = 2'b11;
      //else if (MemWrite_EX && Rn_EX==Rd_WR) FwdScC = 2'b11;
      else  FwdScC = 2'b0;
    end

endmodule

module forward_testbench();
`timescale 1ns/10ps
logic [1:0]  FwdScA, FwdScB;
logic [4:0]  Rn_DEC, Rm_DEC, Rd_EX, Rd_MEM;
logic clk, reset;

parameter ClockDelay = 100;

initial begin // Set up the clock
 clk <= 0;
 forever #(ClockDelay/2) clk <= ~clk;
end
initial begin
reset <=1;
@(posedge clk);
@(posedge clk);
reset <=0;
@(posedge clk);
Rm_DEC <= 5'd0; Rn_DEC <=5'd0; Rd_EX <= 5'd0; Rd_MEM <=5'd0;
@(posedge clk);
Rm_DEC <= 5'd0; Rn_DEC <=5'd0; Rd_EX <= 5'd1; Rd_MEM <=5'd0;
@(posedge clk);
Rm_DEC <= 5'd0; Rn_DEC <=5'd1; Rd_EX <= 5'd0; Rd_MEM <=5'd0;
@(posedge clk);
Rm_DEC <= 5'd0; Rn_DEC <=5'd1; Rd_EX <= 5'd1; Rd_MEM <=5'd0;
@(posedge clk);
Rm_DEC <= 5'd0; Rn_DEC <=5'd0; Rd_EX <= 5'd0; Rd_MEM <=5'd0;
@(posedge clk);
Rm_DEC <= 5'd0; Rn_DEC <=5'd0; Rd_EX <= 5'd1; Rd_MEM <=5'd0;
@(posedge clk);
Rm_DEC <= 5'd1; Rn_DEC <=5'd1; Rd_EX <= 5'd0; Rd_MEM <=5'd0;
@(posedge clk);
Rm_DEC <= 5'd1; Rn_DEC <=5'd1; Rd_EX <= 5'd1; Rd_MEM <=5'd0;
@(posedge clk);
Rm_DEC <= 5'd1; Rn_DEC <=5'd0; Rd_EX <= 5'd0; Rd_MEM <=5'd0;
@(posedge clk);
Rm_DEC <= 5'd1; Rn_DEC <=5'd0; Rd_EX <= 5'd1; Rd_MEM <=5'd0;
@(posedge clk);
Rm_DEC <= 5'd0; Rn_DEC <=5'd0; Rd_EX <= 5'd0; Rd_MEM <=5'd1;
@(posedge clk);
Rm_DEC <= 5'd0; Rn_DEC <=5'd0; Rd_EX <= 5'd1; Rd_MEM <=5'd1;
@(posedge clk);
Rm_DEC <= 5'd0; Rn_DEC <=5'd1; Rd_EX <= 5'd0; Rd_MEM <=5'd1;
@(posedge clk);
Rm_DEC <= 5'd0; Rn_DEC <=5'd1; Rd_EX <= 5'd1; Rd_MEM <=5'd1;
@(posedge clk);
Rm_DEC <= 5'd0; Rn_DEC <=5'd0; Rd_EX <= 5'd0; Rd_MEM <=5'd1;
@(posedge clk);
Rm_DEC <= 5'd0; Rn_DEC <=5'd0; Rd_EX <= 5'd1; Rd_MEM <=5'd1;
@(posedge clk);
Rm_DEC <= 5'd1; Rn_DEC <=5'd1; Rd_EX <= 5'd0; Rd_MEM <=5'd1;
@(posedge clk);
Rm_DEC <= 5'd1; Rn_DEC <=5'd1; Rd_EX <= 5'd1; Rd_MEM <=5'd1;
@(posedge clk);
Rm_DEC <= 5'd1; Rn_DEC <=5'd0; Rd_EX <= 5'd0; Rd_MEM <=5'd1;
@(posedge clk);
Rm_DEC <= 5'd1; Rn_DEC <=5'd0; Rd_EX <= 5'd1; Rd_MEM <=5'd1;
@(posedge clk);
$stop;
end

endmodule
