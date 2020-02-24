onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Input
add wave -noupdate -radix decimal /alu_testbench/A
add wave -noupdate -radix decimal /alu_testbench/B
add wave -noupdate /alu_testbench/dut/operation
add wave -noupdate -expand /alu_testbench/cntrl
add wave -noupdate -divider Output
add wave -noupdate -radix decimal /alu_testbench/result
add wave -noupdate /alu_testbench/negative
add wave -noupdate /alu_testbench/zero
add wave -noupdate /alu_testbench/overflow
add wave -noupdate /alu_testbench/carry_out
add wave -noupdate -divider InternalALU
add wave -noupdate /alu_testbench/dut/A
add wave -noupdate /alu_testbench/dut/B
add wave -noupdate /alu_testbench/dut/result
add wave -noupdate /alu_testbench/dut/carry
add wave -noupdate -childformat {{{/alu_testbench/dut/cntrl[2]} -radix binary} {{/alu_testbench/dut/cntrl[1]} -radix binary} {{/alu_testbench/dut/cntrl[0]} -radix binary}} -expand -subitemconfig {{/alu_testbench/dut/cntrl[2]} {-height 15 -radix binary} {/alu_testbench/dut/cntrl[1]} {-height 15 -radix binary} {/alu_testbench/dut/cntrl[0]} {-height 15 -radix binary}} /alu_testbench/dut/cntrl
add wave -noupdate /alu_testbench/dut/carry_out
add wave -noupdate /alu_testbench/dut/negative
add wave -noupdate /alu_testbench/dut/zero
add wave -noupdate /alu_testbench/dut/overflow
add wave -noupdate /alu_testbench/dut/Bnot
add wave -noupdate -divider ALU0
add wave -noupdate /alu_testbench/dut/alu0/A
add wave -noupdate /alu_testbench/dut/alu0/B
add wave -noupdate /alu_testbench/dut/alu0/C
add wave -noupdate /alu_testbench/dut/alu0/Bnot
add wave -noupdate -expand /alu_testbench/dut/alu0/cntrl
add wave -noupdate /alu_testbench/dut/alu0/carry_out
add wave -noupdate /alu_testbench/dut/alu0/result
add wave -noupdate /alu_testbench/dut/alu0/bIn
add wave -noupdate /alu_testbench/dut/alu0/adder
add wave -noupdate /alu_testbench/dut/alu0/andRes
add wave -noupdate /alu_testbench/dut/alu0/orRes
add wave -noupdate /alu_testbench/dut/alu0/xorRes
add wave -noupdate -divider mux2_1
add wave -noupdate /alu_testbench/dut/alu0/bInvert/out
add wave -noupdate -radix binary /alu_testbench/dut/alu0/bInvert/in0
add wave -noupdate -radix binary /alu_testbench/dut/alu0/bInvert/in1
add wave -noupdate -radix binary /alu_testbench/dut/alu0/bInvert/sel1
add wave -noupdate /alu_testbench/dut/alu0/bInvert/nsel1
add wave -noupdate /alu_testbench/dut/alu0/bInvert/a
add wave -noupdate /alu_testbench/dut/alu0/bInvert/b
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {235977154 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 459
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
WaveRestoreZoom {8711323973 ps} {9120456634 ps}
