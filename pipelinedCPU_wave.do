onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pipelinedCPU_testbench/dut/thepc/clk
add wave -noupdate /pipelinedCPU_testbench/dut/thepc/reset
add wave -noupdate -divider IF
add wave -noupdate /pipelinedCPU_testbench/instruction
add wave -noupdate -divider Dec
add wave -noupdate -divider Exec
add wave -noupdate /pipelinedCPU_testbench/dut/branchedIns/A
add wave -noupdate -divider Mem
add wave -noupdate -divider RegWrite
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 3} {733331772 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 166
configure wave -valuecolwidth 233
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
WaveRestoreZoom {0 ps} {5685901 ps}
