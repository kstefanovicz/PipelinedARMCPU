onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Input
add wave -noupdate -radix decimal /adder_64_testbench/A
add wave -noupdate -radix decimal /adder_64_testbench/B
add wave -noupdate -divider Output
add wave -noupdate /adder_64_testbench/carry_out
add wave -noupdate -radix decimal /adder_64_testbench/result
add wave -noupdate -radix decimal /adder_64_testbench/S
add wave -noupdate -divider Internal
add wave -noupdate /adder_64_testbench/dut/carries
add wave -noupdate -divider 63
add wave -noupdate /adder_64_testbench/dut/add63/result
add wave -noupdate /adder_64_testbench/dut/add63/carry_out
add wave -noupdate /adder_64_testbench/dut/add63/A
add wave -noupdate /adder_64_testbench/dut/add63/B
add wave -noupdate /adder_64_testbench/dut/add63/C
add wave -noupdate /adder_64_testbench/dut/add63/haCX
add wave -noupdate /adder_64_testbench/dut/add63/haCY
add wave -noupdate /adder_64_testbench/dut/add63/haSX
add wave -noupdate -divider 0
add wave -noupdate /adder_64_testbench/dut/add0/result
add wave -noupdate /adder_64_testbench/dut/add0/carry_out
add wave -noupdate /adder_64_testbench/dut/add0/A
add wave -noupdate /adder_64_testbench/dut/add0/B
add wave -noupdate /adder_64_testbench/dut/add0/C
add wave -noupdate /adder_64_testbench/dut/add0/haCX
add wave -noupdate /adder_64_testbench/dut/add0/haCY
add wave -noupdate /adder_64_testbench/dut/add0/haSX
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {100003000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 108
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
WaveRestoreZoom {33039666 ps} {1050892649 ps}
