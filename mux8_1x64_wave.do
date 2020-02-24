onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mux8_1x64_testbench/i
add wave -noupdate -radix decimal /mux8_1x64_testbench/in0
add wave -noupdate -radix decimal /mux8_1x64_testbench/in1
add wave -noupdate -radix decimal /mux8_1x64_testbench/in2
add wave -noupdate -radix decimal /mux8_1x64_testbench/in3
add wave -noupdate -radix decimal /mux8_1x64_testbench/in4
add wave -noupdate -radix decimal /mux8_1x64_testbench/in5
add wave -noupdate -radix decimal /mux8_1x64_testbench/in6
add wave -noupdate -radix decimal /mux8_1x64_testbench/in7
add wave -noupdate -radix unsigned /mux8_1x64_testbench/sel
add wave -noupdate -radix decimal /mux8_1x64_testbench/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4927 ps} 0}
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
configure wave -gridperiod 500
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {221184 ps}
