onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /decodeInstruction_testbench/clk
add wave -noupdate /decodeInstruction_testbench/reset
add wave -noupdate -divider Input
add wave -noupdate /decodeInstruction_testbench/instruction
add wave -noupdate /decodeInstruction_testbench/negative
add wave -noupdate /decodeInstruction_testbench/zero
add wave -noupdate /decodeInstruction_testbench/overflow
add wave -noupdate /decodeInstruction_testbench/carry_out
add wave -noupdate -divider -height 20 Output
add wave -noupdate /decodeInstruction_testbench/setFlags
add wave -noupdate -divider <NULL>
add wave -noupdate /decodeInstruction_testbench/Rn
add wave -noupdate /decodeInstruction_testbench/Rm
add wave -noupdate /decodeInstruction_testbench/Rd
add wave -noupdate /decodeInstruction_testbench/shamt
add wave -noupdate -divider <NULL>
add wave -noupdate /decodeInstruction_testbench/Reg2Loc
add wave -noupdate /decodeInstruction_testbench/RegWrite
add wave -noupdate /decodeInstruction_testbench/ImmOrAddr
add wave -noupdate /decodeInstruction_testbench/MemWrite
add wave -noupdate /decodeInstruction_testbench/BrTaken
add wave -noupdate /decodeInstruction_testbench/UncondBr
add wave -noupdate /decodeInstruction_testbench/ALUSrc
add wave -noupdate /decodeInstruction_testbench/MemToReg
add wave -noupdate /decodeInstruction_testbench/ALUOp
add wave -noupdate -divider <NULL>
add wave -noupdate /decodeInstruction_testbench/ALU_Imm12
add wave -noupdate -divider <NULL>
add wave -noupdate /decodeInstruction_testbench/CondAddr19
add wave -noupdate /decodeInstruction_testbench/BrAddr26
add wave -noupdate /decodeInstruction_testbench/DAddr9
add wave -noupdate /decodeInstruction_testbench/Reg3Loc
add wave -noupdate -divider Internal
add wave -noupdate /decodeInstruction_testbench/dut/format
add wave -noupdate /decodeInstruction_testbench/dut/lessThan
add wave -noupdate /decodeInstruction_testbench/dut/greaterThan
add wave -noupdate /decodeInstruction_testbench/dut/LTorEQ
add wave -noupdate /decodeInstruction_testbench/dut/GTorEQ
add wave -noupdate -radix hexadecimal /decodeInstruction_testbench/dut/iMSB
add wave -noupdate -divider 63
add wave -noupdate -divider 0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {779833 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 194
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 300
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {684803 ps} {1519819 ps}
