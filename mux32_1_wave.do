onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mux32_1_testbench/j
add wave -noupdate /mux32_1_testbench/i
add wave -noupdate -divider Input
add wave -noupdate /mux32_1_testbench/in
add wave -noupdate -radix unsigned /mux32_1_testbench/sel
add wave -noupdate -divider Output
add wave -noupdate /mux32_1_testbench/out
add wave -noupdate -divider Internal
add wave -noupdate /mux32_1_testbench/dut/mux6/in
add wave -noupdate /mux32_1_testbench/dut/mux6/out
add wave -noupdate /mux32_1_testbench/dut/mux6/sel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1180 ps} 0}
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
WaveRestoreZoom {615 ps} {2663 ps}
