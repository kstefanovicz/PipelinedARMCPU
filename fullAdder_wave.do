onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fullAdder_testbench/i
add wave -noupdate -divider Input
add wave -noupdate /fullAdder_testbench/A
add wave -noupdate /fullAdder_testbench/B
add wave -noupdate /fullAdder_testbench/C
add wave -noupdate -divider Output
add wave -noupdate /fullAdder_testbench/result
add wave -noupdate /fullAdder_testbench/carry_out
add wave -noupdate -divider Internal
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {25 ps} 0}
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
