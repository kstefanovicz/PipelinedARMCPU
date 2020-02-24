onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DFFen_testbench/reset
add wave -noupdate /DFFen_testbench/clk
add wave -noupdate -divider {q logic}
add wave -noupdate /DFFen_testbench/q
add wave -noupdate /DFFen_testbench/dut/notEn
add wave -noupdate /DFFen_testbench/dut/q1
add wave -noupdate -divider {d logic}
add wave -noupdate /DFFen_testbench/d
add wave -noupdate /DFFen_testbench/en
add wave -noupdate /DFFen_testbench/dut/d1
add wave -noupdate -divider output
add wave -noupdate /DFFen_testbench/dut/p
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
WaveRestoreZoom {0 ps} {1008 ps}
