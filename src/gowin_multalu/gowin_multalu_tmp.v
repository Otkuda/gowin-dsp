//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.10.03 Education (64-bit)
//Part Number: GW1N-LV9LQ144C6/I5
//Device: GW1N-9
//Device Version: C
//Created Time: Sat Feb 15 16:35:47 2025

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    Gowin_MULTALU your_instance_name(
        .dout(dout), //output [53:0] dout
        .caso(caso), //output [54:0] caso
        .a(a), //input [17:0] a
        .b(b), //input [17:0] b
        .c(c), //input [53:0] c
        .ce(ce), //input ce
        .clk(clk), //input clk
        .reset(reset) //input reset
    );

//--------Copy end-------------------
