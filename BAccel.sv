//Accelerates all branches that do not require flags.

module BAccel(
  output logic [63:0] PCOutBranch_DEC,
  output logic        BrTakenAcc_DEC,
  input  logic [63:0] Db_DEC, PCOut_DEC,
  input  logic [31:0] instruction_DEC,
  input  logic [18:0] CondAddr19_DEC,
  input  logic [25:0] BrAddr26_DEC
);

logic [11:0] nextCondAddr;
logic [26:0] nextBrAddr;



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

//------Set BrTakenAcc and PCOutBranch------------------------------------------
//      Based on opcode (and condcode if applicable)

assign nextBrAddr = PCOut_DEC + {{36{BrAddr26_DEC[25]}},BrAddr26_DEC,2'b00};
assign nextCondAddr = PCOut_DEC + {{43{CondAddr19_DEC[18]}},CondAddr19_DEC,2'b00};

    always_comb begin
      case (opcode)
        B:    begin
                BrTakenAcc_DEC = 1'b1;
                PCOutBranch_DEC = nextBrAddr;
              end
        BR:   begin
                BrTakenAcc_DEC = 1'b1;
                PCOutBranch_DEC = Db_DEC;
              end
        BL:   begin
                BrTakenAcc_DEC = 1'b1;
                PCOutBranch_DEC = nextBrAddr;
              end
        CBZ:  begin
                if (Db_DEC==0) begin
                  BrTakenAcc_DEC = 1'b1;
                  PCOutBranch_DEC = nextCondAddr;
                end
                else
                  BrTakenAcc_DEC = 1'b0;
              end
        CBNZ: begin
                if (Db_DEC!=0) begin
                  BrTakenAcc_DEC = 1'b1;
                  PCOutBranch_DEC = nextCondAddr;
                end
                else
                  BrTakenAcc_DEC = 1'b0;
              end
        default:  begin BrTakenAcc_DEC = 1'b0; PCOutBranch_DEC = PCOutBranch_DEC; end
      endcase
    end

endmodule
