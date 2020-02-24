onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Input
add wave -noupdate /one_bit_alu_testbench/A
add wave -noupdate /one_bit_alu_testbench/B
add wave -noupdate /one_bit_alu_testbench/C
add wave -noupdate /one_bit_alu_testbench/cntrl
add wave -noupdate -divider Output
add wave -noupdate /one_bit_alu_testbench/carry_out
add wave -noupdate /one_bit_alu_testbench/result
add wave -noupdate -divider Internal
add wave -noupdate /one_bit_alu_testbench/i
add wave -noupdate /one_bit_alu_testbench/j
add wave -noupdate -divider cntrlMux
add wave -noupdate /one_bit_alu_testbench/dut/cntrlMux/out
add wave -noupdate -expand /one_bit_alu_testbench/dut/cntrlMux/in
add wave -noupdate /one_bit_alu_testbench/dut/cntrlMux/sel
add wave -noupdate /one_bit_alu_testbench/dut/cntrlMux/w
add wave -noupdate -divider AdderSubtractor
add wave -noupdate /one_bit_alu_testbench/dut/addSub/result
add wave -noupdate /one_bit_alu_testbench/dut/addSub/carry_out
add wave -noupdate /one_bit_alu_testbench/dut/addSub/A
add wave -noupdate /one_bit_alu_testbench/dut/addSub/B
add wave -noupdate /one_bit_alu_testbench/dut/addSub/C
add wave -noupdate /one_bit_alu_testbench/dut/addSub/haCX
add wave -noupdate /one_bit_alu_testbench/dut/addSub/haCY
add wave -noupdate /one_bit_alu_testbench/dut/addSub/haSX
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {232320 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
configure wave -timelineunits ps
update
WaveRestoreZoom {141926 ps} {666214 ps}
