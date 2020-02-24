onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Input
add wave -noupdate -radix decimal /mux4_1x64_testbench/in0
add wave -noupdate -radix decimal /mux4_1x64_testbench/in1
add wave -noupdate -radix decimal /mux4_1x64_testbench/in2
add wave -noupdate -radix decimal /mux4_1x64_testbench/in3
add wave -noupdate -radix unsigned /mux4_1x64_testbench/sel1
add wave -noupdate -divider Output
add wave -noupdate -radix decimal /mux4_1x64_testbench/out
add wave -noupdate -divider Internal
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {74172 ps} 0}
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
WaveRestoreZoom {35482 ps} {166554 ps}
