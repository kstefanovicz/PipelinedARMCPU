onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /forward_testbench/clk
add wave -noupdate /forward_testbench/ClockDelay
add wave -noupdate /forward_testbench/reset
add wave -noupdate -radix unsigned /forward_testbench/FwdScA
add wave -noupdate -radix unsigned /forward_testbench/FwdScB
add wave -noupdate -radix unsigned /forward_testbench/Rd_EX
add wave -noupdate -radix unsigned /forward_testbench/Rd_MEM
add wave -noupdate -radix unsigned /forward_testbench/Rm_DEC
add wave -noupdate -radix unsigned /forward_testbench/Rn_DEC
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2249150 ps} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {1024 ns} {3072 ns}
