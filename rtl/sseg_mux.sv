`timescale 1ns/1ps
/******************************************************************************
 * (C) Copyright 2023-2025 AGH UST All Rights Reserved
 *
 * MODULE:    sseg_mux
 * DEVICE:    general
 * PROJECT:   stopwatch
 *
 * ABSTRACT:  Multiplexer of four 4-bit input numbers into one 4-bit bus
 *
 * HISTORY:
 * 4 Jan 2016, RS - initial version
 * 18 Jan 2023, LK - ported to SystemVerilog
 *
 *******************************************************************************/
module sseg_mux (
        input  wire  [3:0] sel,         // single zero will select the input
        input  wire  [3:0] bcd0,
        input  wire  [3:0] bcd1,
        input  wire  [3:0] bcd2,
        input  wire  [3:0] bcd3,
        output logic [3:0] bcd_selected
    );

    always_comb
        case(sel)
            4'b1110: bcd_selected = bcd0;
            4'b1101: bcd_selected = bcd1;
            4'b1011: bcd_selected = bcd2;
            4'b0111: bcd_selected = bcd3;
            default: bcd_selected = 4'bxxxx;
        endcase

endmodule
