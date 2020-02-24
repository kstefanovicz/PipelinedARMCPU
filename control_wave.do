onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /control_testbench/clk
add wave -noupdate /control_testbench/reset
add wave -noupdate -divider Input
add wave -noupdate /control_testbench/instruction
add wave -noupdate /control_testbench/negative
add wave -noupdate /control_testbench/zero
add wave -noupdate /control_testbench/overflow
add wave -noupdate /control_testbench/carry_out
add wave -noupdate -divider -height 20 Output
add wave -noupdate /control_testbench/setFlags
add wave -noupdate -divider <NULL>
add wave -noupdate -radix unsigned /control_testbench/Rn
add wave -noupdate -radix unsigned /control_testbench/Rm
add wave -noupdate -radix unsigned /control_testbench/Rd
add wave -noupdate -radix decimal /control_testbench/shamt
add wave -noupdate -divider <NULL>
add wave -noupdate /control_testbench/Reg2Loc
add wave -noupdate /control_testbench/RegWrite
add wave -noupdate /control_testbench/ImmOrAddr
add wave -noupdate /control_testbench/MemWrite
add wave -noupdate /control_testbench/BrTaken
add wave -noupdate /control_testbench/UncondBr
add wave -noupdate /control_testbench/ALUSrc
add wave -noupdate /control_testbench/MemToReg
add wave -noupdate /control_testbench/ALUOp
add wave -noupdate -divider <NULL>
add wave -noupdate -radix hexadecimal /control_testbench/ALU_Imm12
add wave -noupdate -divider <NULL>
add wave -noupdate -radix hexadecimal /control_testbench/CondAddr19
add wave -noupdate -radix hexadecimal /control_testbench/BrAddr26
add wave -noupdate -radix hexadecimal /control_testbench/DAddr9
add wave -noupdate -radix hexadecimal /control_testbench/PCSrc
add wave -noupdate -radix hexadecimal /control_testbench/Reg3Loc
add wave -noupdate -divider Internal
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
WaveRestoreZoom {0 ps} {835016 ps}
