vlib work
vlog ./src/gowin_multalu/gowin_multalu_comb.v ./src/top.sv
vlog ./sim/top_tb.sv
vsim -novopt work.top_tb -L ./gw1n_lib


