`timescale 1ns / 1ps
/******************************************************************************
 * (C) Copyright 2023-2025 AGH UST All Rights Reserved
 *
 * MODULE:    stopwatch_test
 * DEVICE:    NA
 * PROJECT:   stopwatch
 *
 * ABSTRACT:  Test bench for stopwatch.v
 *
 *
 * HISTORY:
 * 2 Jan 2016, RS - initial version
 * 18 Jan 2023, LK - ported to SystemVerilog
 *
 *******************************************************************************/
module stopwatch_test();

    logic          t_clk100MHz;
    logic          t_rst;
    logic          t_start;
    logic          t_stop;
    wire    [6:0]  t_sseg_ca;
    wire    [3:0]  t_sseg_an;
    wire    [15:0] t_sseg_display;
    event          t_monitor_start;

    localparam time MSEC = 1_000_000;
    localparam time SEC  = 1000 * MSEC;

    stopwatch u_stopwatch
    (
        .clk100MHz(t_clk100MHz),
        .rst (t_rst),
        .start (t_start),
        .stop (t_stop),
        //7-segment display control
        .sseg_ca (t_sseg_ca),
        .sseg_an (t_sseg_an)
    );

    sseg_x4_monitor u_sseg_x4_monitor
    (
        .clk(t_clk100MHz),
        .sseg_ca(t_sseg_ca),
        .sseg_an(t_sseg_an),
        .sseg(t_sseg_display)
    );

    // clock generation
    initial begin
        t_clk100MHz = 0;
        forever #5 t_clk100MHz = ~t_clk100MHz;
    end

    // MAIN
    initial begin
        @(negedge t_clk100MHz);
        t_start            = 0;
        t_stop             = 0;
        // reset
        t_rst              = 1;
        @(negedge t_clk100MHz);
        t_rst              = 0;
        @(negedge t_clk100MHz);

        -> t_monitor_start;

        // start stopwatch
        t_start            = 1;
        #(10*MSEC) t_start = 0;

        // wait
        repeat(500) #(MSEC);

        // stop stopwatch
        t_stop             = 1;
        #(10*MSEC); t_stop = 0;

        // finish simulation
        #(30*MSEC) $finish;
    end

    integer t_loop_counter;

    logic   t_display_clk;

    initial begin
        t_display_clk = 0;
        forever #(5*MSEC) t_display_clk = ~t_display_clk;
    end

    initial begin
        $timeformat (-3, 1, " ms", 8);
        $display("Staring 7-segment display monitoring.");
        forever begin
            #(10*MSEC) $strobe("%0t 7-SEG: %4h",$time, t_sseg_display);
        end
    end

endmodule
