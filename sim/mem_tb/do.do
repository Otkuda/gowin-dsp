vlib work
vlog ./src/gowin_sp/gowin_sdpb.v
vlog ./sim/mem_tb/mem_tb.sv ./sim/mem_tb/mem_example.v
vsim -novopt work.mem_tb -L ./gw1n_lib


