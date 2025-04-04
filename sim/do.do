vlib work
vlog ./src/gowin_multalu/gowin_multalu_comb.v ./src/top.v ./src/dff.v ./src/filter_step_block.v ./src/gowin_sdpb/gowin_sdpb.v
vlog ./sim/top_tb.sv
vsim -coverage -novopt work.top_tb -L ./gw1n_lib


