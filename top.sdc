set_time_format -unit ns -decimal_places 3

#                имя для sdc       период                                  имя порта в top файле
create_clock -name {clk50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {clk}]

derive_clock_uncertainty

set_clock_uncertainty -rise_from [get_clocks {clk50}] -rise_to [get_clocks {clk50}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {clk50}] -fall_to [get_clocks {clk50}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {clk50}] -rise_to [get_clocks {clk50}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {clk50}] -fall_to [get_clocks {clk50}]  0.030 


# команды, чтобы он не анализировал входы/выходы
# входы
set_false_path -from [get_ports rst] -to * 
set_false_path -from [get_ports {user_pb[*]}] -to *
set_false_path -from [get_ports {user_dip[*]}] -to *
# выходы
set_false_path -from * -to [get_ports {user_led[*]}]

