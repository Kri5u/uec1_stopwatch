`timescale 1ns / 1ps
/******************************************************************************
 * (C) Copyright 2023-2025 AGH UST All Rights Reserved
 *
 * MODULE:    bin2diode
 * DEVICE:    general
 * PROJECT:   stopwatch
 *
 * ABSTRACT:  binary to BCD converter - minute BCD display
 *
 * HISTORY:
 * 30 Jan 2025, KB - initial version
 *
 *******************************************************************************/
module bin2diode(
    input  wire  [15:0] bin,  // 16-bit binary input
    output logic [3:0] diode  // 4-bit diode output
);

    logic [3:0] bin_mod;  // Store result of division

    always_comb begin
        bin_mod = bin / 6000;  // Compute how many full 6000s fit in bin
        diode = bin_mod;       // Assign to diode output
    end

endmodule