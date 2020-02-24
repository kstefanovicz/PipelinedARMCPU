onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /decoder_testbench/clk
add wave -noupdate -divider control
add wave -noupdate /decoder_testbench/RegWrite
add wave -noupdate -divider input
add wave -noupdate -radix binary /decoder_testbench/WriteRegister
add wave -noupdate -divider output
add wave -noupdate -radix binary -radixshowbase 0 /decoder_testbench/en
add wave -noupdate -divider dcdr4
add wave -noupdate /decoder_testbench/dut/dcdr4/en
add wave -noupdate /decoder_testbench/dut/dcdr4/WriteRegister
add wave -noupdate -radix binary /decoder_testbench/dut/dcdr4/RegWrite
add wave -noupdate -divider dcdr3
add wave -noupdate /decoder_testbench/dut/dcdr3/en
add wave -noupdate /decoder_testbench/dut/dcdr3/WriteRegister
add wave -noupdate -radix binary /decoder_testbench/dut/dcdr3/RegWrite
add wave -noupdate -divider dcdr2
add wave -noupdate /decoder_testbench/dut/dcdr2/en
add wave -noupdate /decoder_testbench/dut/dcdr2/WriteRegister
add wave -noupdate -radix binary /decoder_testbench/dut/dcdr2/RegWrite
add wave -noupdate -divider dcdr1
add wave -noupdate /decoder_testbench/dut/dcdr1/en
add wave -noupdate /decoder_testbench/dut/dcdr1/WriteRegister
add wave -noupdate -radix binary /decoder_testbench/dut/dcdr1/RegWrite
add wave -noupdate -divider dcdr0
add wave -noupdate /decoder_testbench/dut/dcdr0/en
add wave -noupdate /decoder_testbench/dut/dcdr0/WriteRegister
add wave -noupdate -radix decimal /decoder_testbench/dut/dcdr0/RegWrite
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {919 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 204
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
WaveRestoreZoom {1059 ps} {1155 ps}
