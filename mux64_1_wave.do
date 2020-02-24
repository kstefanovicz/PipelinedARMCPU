onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mux64_1_testbench/i
add wave -noupdate -divider {Test Cases}
add wave -noupdate {/mux64_1_testbench/in[63]}
add wave -noupdate {/mux64_1_testbench/in[58]}
add wave -noupdate {/mux64_1_testbench/in[53]}
add wave -noupdate {/mux64_1_testbench/in[44]}
add wave -noupdate {/mux64_1_testbench/in[37]}
add wave -noupdate {/mux64_1_testbench/in[30]}
add wave -noupdate {/mux64_1_testbench/in[18]}
add wave -noupdate {/mux64_1_testbench/in[14]}
add wave -noupdate {/mux64_1_testbench/in[2]}
add wave -noupdate {/mux64_1_testbench/in[0]}
add wave -noupdate -divider Input
add wave -noupdate -radix hexadecimal /mux64_1_testbench/in
add wave -noupdate -radix unsigned /mux64_1_testbench/sel
add wave -noupdate -divider Output
add wave -noupdate /mux64_1_testbench/out
add wave -noupdate -divider Internal
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {110 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 104
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
WaveRestoreZoom {0 ps} {1024 ps}
