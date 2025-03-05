onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/clk
add wave -noupdate /top_tb/rst
add wave -noupdate /top_tb/ena
add wave -noupdate /top_tb/x_in
add wave -noupdate -format Analog-Step -height 74 -max 400000.0 /top_tb/dout
add wave -noupdate -divider {1 step}
add wave -noupdate {/top_tb/dut/for_loop[0]/genblk1/filter_inst0/x_in}
add wave -noupdate -radix unsigned {/top_tb/dut/for_loop[0]/genblk1/filter_inst0/b_in}
add wave -noupdate {/top_tb/dut/for_loop[0]/genblk1/filter_inst0/y_in}
add wave -noupdate {/top_tb/dut/for_loop[0]/genblk1/filter_inst0/x_out}
add wave -noupdate {/top_tb/dut/for_loop[0]/genblk1/filter_inst0/y_out}
add wave -noupdate -divider {2 step}
add wave -noupdate {/top_tb/dut/for_loop[1]/genblk1/filter_inst1/x_in}
add wave -noupdate -radix unsigned {/top_tb/dut/for_loop[1]/genblk1/filter_inst1/b_in}
add wave -noupdate {/top_tb/dut/for_loop[1]/genblk1/filter_inst1/y_in}
add wave -noupdate {/top_tb/dut/for_loop[1]/genblk1/filter_inst1/x_out}
add wave -noupdate {/top_tb/dut/for_loop[1]/genblk1/filter_inst1/y_out}
add wave -noupdate -divider {3 step}
add wave -noupdate {/top_tb/dut/for_loop[2]/genblk1/filter_inst1/x_in}
add wave -noupdate -radix unsigned {/top_tb/dut/for_loop[2]/genblk1/filter_inst1/b_in}
add wave -noupdate {/top_tb/dut/for_loop[2]/genblk1/filter_inst1/y_in}
add wave -noupdate {/top_tb/dut/for_loop[2]/genblk1/filter_inst1/x_out}
add wave -noupdate {/top_tb/dut/for_loop[2]/genblk1/filter_inst1/y_out}
add wave -noupdate -divider {4 step}
add wave -noupdate {/top_tb/dut/for_loop[3]/genblk1/filter_inst1/x_in}
add wave -noupdate {/top_tb/dut/for_loop[3]/genblk1/filter_inst1/b_in}
add wave -noupdate {/top_tb/dut/for_loop[3]/genblk1/filter_inst1/y_in}
add wave -noupdate {/top_tb/dut/for_loop[3]/genblk1/filter_inst1/x_out}
add wave -noupdate {/top_tb/dut/for_loop[3]/genblk1/filter_inst1/y_out}
add wave -noupdate -divider sync_reg
add wave -noupdate /top_tb/dut/sync_reg_inst/clk
add wave -noupdate /top_tb/dut/sync_reg_inst/c_ena
add wave -noupdate /top_tb/dut/sync_reg_inst/rst
add wave -noupdate /top_tb/dut/sync_reg_inst/d
add wave -noupdate /top_tb/dut/sync_reg_inst/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {84436 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 326
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {619500 ps}
