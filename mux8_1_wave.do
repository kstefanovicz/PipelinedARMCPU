onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mux8_1_testbench/i
add wave -noupdate -divider Input
add wave -noupdate -radix binary -childformat {{{/mux8_1_testbench/in[7]} -radix binary} {{/mux8_1_testbench/in[6]} -radix binary} {{/mux8_1_testbench/in[5]} -radix binary} {{/mux8_1_testbench/in[4]} -radix binary} {{/mux8_1_testbench/in[3]} -radix binary} {{/mux8_1_testbench/in[2]} -radix binary} {{/mux8_1_testbench/in[1]} -radix binary} {{/mux8_1_testbench/in[0]} -radix binary}} -expand -subitemconfig {{/mux8_1_testbench/in[7]} {-radix binary} {/mux8_1_testbench/in[6]} {-radix binary} {/mux8_1_testbench/in[5]} {-radix binary} {/mux8_1_testbench/in[4]} {-radix binary} {/mux8_1_testbench/in[3]} {-radix binary} {/mux8_1_testbench/in[2]} {-radix binary} {/mux8_1_testbench/in[1]} {-radix binary} {/mux8_1_testbench/in[0]} {-radix binary}} /mux8_1_testbench/in
add wave -noupdate /mux8_1_testbench/sel
add wave -noupdate -divider Output
add wave -noupdate /mux8_1_testbench/out
add wave -noupdate -divider Internal
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
WaveRestoreZoom {0 ps} {2048 ps}
