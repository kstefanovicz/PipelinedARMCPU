onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /regArray_testbench/clk
add wave -noupdate /regArray_testbench/reset
add wave -noupdate -divider control
add wave -noupdate /regArray_testbench/en
add wave -noupdate -divider {q logic}
add wave -noupdate -radix decimal -childformat {{{/regArray_testbench/q[0]} -radix decimal} {{/regArray_testbench/q[1]} -radix decimal} {{/regArray_testbench/q[2]} -radix decimal} {{/regArray_testbench/q[3]} -radix decimal} {{/regArray_testbench/q[4]} -radix decimal} {{/regArray_testbench/q[5]} -radix decimal} {{/regArray_testbench/q[6]} -radix decimal} {{/regArray_testbench/q[7]} -radix decimal} {{/regArray_testbench/q[8]} -radix decimal} {{/regArray_testbench/q[9]} -radix decimal} {{/regArray_testbench/q[10]} -radix decimal} {{/regArray_testbench/q[11]} -radix decimal} {{/regArray_testbench/q[12]} -radix decimal} {{/regArray_testbench/q[13]} -radix decimal} {{/regArray_testbench/q[14]} -radix decimal} {{/regArray_testbench/q[15]} -radix decimal} {{/regArray_testbench/q[16]} -radix decimal} {{/regArray_testbench/q[17]} -radix decimal} {{/regArray_testbench/q[18]} -radix decimal} {{/regArray_testbench/q[19]} -radix decimal} {{/regArray_testbench/q[20]} -radix decimal} {{/regArray_testbench/q[21]} -radix decimal} {{/regArray_testbench/q[22]} -radix decimal} {{/regArray_testbench/q[23]} -radix decimal} {{/regArray_testbench/q[24]} -radix decimal} {{/regArray_testbench/q[25]} -radix decimal} {{/regArray_testbench/q[26]} -radix decimal} {{/regArray_testbench/q[27]} -radix decimal} {{/regArray_testbench/q[28]} -radix decimal} {{/regArray_testbench/q[29]} -radix decimal} {{/regArray_testbench/q[30]} -radix decimal} {{/regArray_testbench/q[31]} -radix decimal}} -expand -subitemconfig {{/regArray_testbench/q[0]} {-radix decimal} {/regArray_testbench/q[1]} {-radix decimal} {/regArray_testbench/q[2]} {-radix decimal} {/regArray_testbench/q[3]} {-radix decimal} {/regArray_testbench/q[4]} {-radix decimal} {/regArray_testbench/q[5]} {-radix decimal} {/regArray_testbench/q[6]} {-radix decimal} {/regArray_testbench/q[7]} {-radix decimal} {/regArray_testbench/q[8]} {-radix decimal} {/regArray_testbench/q[9]} {-radix decimal} {/regArray_testbench/q[10]} {-radix decimal} {/regArray_testbench/q[11]} {-radix decimal} {/regArray_testbench/q[12]} {-radix decimal} {/regArray_testbench/q[13]} {-radix decimal} {/regArray_testbench/q[14]} {-radix decimal} {/regArray_testbench/q[15]} {-radix decimal} {/regArray_testbench/q[16]} {-radix decimal} {/regArray_testbench/q[17]} {-radix decimal} {/regArray_testbench/q[18]} {-radix decimal} {/regArray_testbench/q[19]} {-radix decimal} {/regArray_testbench/q[20]} {-radix decimal} {/regArray_testbench/q[21]} {-radix decimal} {/regArray_testbench/q[22]} {-radix decimal} {/regArray_testbench/q[23]} {-radix decimal} {/regArray_testbench/q[24]} {-radix decimal} {/regArray_testbench/q[25]} {-radix decimal} {/regArray_testbench/q[26]} {-radix decimal} {/regArray_testbench/q[27]} {-radix decimal} {/regArray_testbench/q[28]} {-radix decimal} {/regArray_testbench/q[29]} {-radix decimal} {/regArray_testbench/q[30]} {-radix decimal} {/regArray_testbench/q[31]} {-radix decimal}} /regArray_testbench/q
add wave -noupdate -divider {d logic}
add wave -noupdate -radix decimal /regArray_testbench/d
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
