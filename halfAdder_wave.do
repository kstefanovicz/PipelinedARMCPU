onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /halfAdder_testbench/i
add wave -noupdate -divider Input
add wave -noupdate /halfAdder_testbench/A
add wave -noupdate /halfAdder_testbench/B
add wave -noupdate -divider Output
add wave -noupdate /halfAdder_testbench/result
add wave -noupdate /halfAdder_testbench/carry_out
add wave -noupdate -divider Internal
add wave -noupdate /halfAdder_testbench/dut/A
add wave -noupdate /halfAdder_testbench/dut/B
add wave -noupdate /halfAdder_testbench/dut/aXORb
add wave -noupdate /halfAdder_testbench/dut/aNANDb
add wave -noupdate /halfAdder_testbench/dut/x
add wave -noupdate /halfAdder_testbench/dut/y
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3 ps} 0}
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
WaveRestoreZoom {0 ps} {128 ps}
