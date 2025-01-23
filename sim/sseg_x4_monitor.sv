`timescale 1ns / 1ps
/******************************************************************************
 * (C) Copyright 2023-2025 AGH UST All Rights Reserved
 *
 * MODULE:    sseg_x4_monitor
 * DEVICE:    general
 * PROJECT:   stopwatch
 * ABSTRACT:  This module monitors the 4-digit 7-segment display control signals
 *            and puts the result value on te 4-character (32-bit) output.
 *            The input values are sampled on the posedge of the clock.
 *
 * HISTORY:
 * 2 Jan 2016, RS - initial version
 * 18 Jan 2023, LK - ported to SystemVerilog
 *******************************************************************************/
module sseg_x4_monitor (
        input  wire         clk,     // main clock, posedge active
        // 7-segment display control (common anode)
        input  wire  [6:0]  sseg_ca, // segments (active LOW)
        input  wire  [3:0]  sseg_an, // anode enable (active LOW)
        output logic [15:0] sseg     // displayed string (4 characters)
    );

    // bits for segments  gfedcba
    localparam SSEG_0 = 7'b1000000;
    localparam SSEG_1 = 7'b1111001;
    localparam SSEG_2 = 7'b0100100;
    localparam SSEG_3 = 7'b0110000;
    localparam SSEG_4 = 7'b0011001;
    localparam SSEG_5 = 7'b0010010;
    localparam SSEG_6 = 7'b0000010;
    localparam SSEG_7 = 7'b1111000;
    localparam SSEG_8 = 7'b0000000;
    localparam SSEG_9 = 7'b0010000;

    logic [3:0]  char;     // decoded character
    logic [15:0] sseg_tmp; // displayed string (4 characters) - temporary storage

    initial begin
        sseg = 16'hxxxx;
    end

    always @(posedge clk) begin
        // decoding character
        case(sseg_ca)
            SSEG_0: char  = 4'h0;
            SSEG_1: char  = 4'h1;
            SSEG_2: char  = 4'h2;
            SSEG_3: char  = 4'h3;
            SSEG_4: char  = 4'h4;
            SSEG_5: char  = 4'h5;
            SSEG_6: char  = 4'h6;
            SSEG_7: char  = 4'h7;
            SSEG_8: char  = 4'h8;
            SSEG_9: char  = 4'h9;
            default: char = 4'hx;
        endcase

        if( sseg_an[0] === 1'b0 ) sseg_tmp[3:0]   = char;
        if( sseg_an[1] === 1'b0 ) sseg_tmp[7:4]   = char;
        if( sseg_an[2] === 1'b0 ) sseg_tmp[11:8]  = char;
        if( sseg_an[3] === 1'b0 ) sseg_tmp[15:12] = char;

        // on the last char display we set all the other - synced output
        if( sseg_an[3] === 1'b0 ) sseg            = sseg_tmp;
    end

endmodule
