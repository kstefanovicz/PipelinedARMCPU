onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /register64_testbench/clk
add wave -noupdate /register64_testbench/reset
add wave -noupdate -divider control
add wave -noupdate /register64_testbench/en
add wave -noupdate -divider {q logic}
add wave -noupdate -radix decimal /register64_testbench/q
add wave -noupdate -divider {d logic}
add wave -noupdate -radix decimal /register64_testbench/d
add wave -noupdate -divider output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {200 ps} 0}
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
WaveRestoreZoom {0 ps} {1764 ps}
