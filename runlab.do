# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./DFFen.sv"
vlog "./dFF.sv"
vlog "./register64.sv"
vlog "./register.sv"
vlog "./regArray.sv"
vlog "./dec3_8.sv"
vlog "./decoder.sv"
vlog "./mux32_1.sv"
vlog "./mux8_1.sv"
vlog "./mux8_1x64.sv"
vlog "./mux4_1.sv"
vlog "./mux2_1.sv"
vlog "./mux2_1x64.sv"
vlog "./mux4_1x64.sv"
vlog "./regfile.sv"
vlog "./halfAdder.sv"
vlog "./fullAdder.sv"
vlog "./one_bit_alu.sv"
vlog "./alu.sv"
vlog "./adder_64.sv"
vlog "./pc.sv"
vlog "./control.sv"
vlog "./decodeInstruction.sv"
vlog "./instructmem.sv"
vlog "./datamem.sv"
vlog "./cpu.sv"
vlog "./forward.sv"
vlog "./BAccel.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work cpu_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do cpu_wave.do

# Set the window types
view wave
view structure
view signals
noview source
onbreak view wave


# Run the simulation
run -all

# End
