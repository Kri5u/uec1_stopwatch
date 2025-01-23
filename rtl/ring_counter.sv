`timescale 1ns/1ps
/******************************************************************************
 * (C) Copyright 2023-2025 AGH UST All Rights Reserved
 *
 * MODULE:    ring_counter
 * DEVICE:    general
 * PROJECT:   stopwatch
 * ABSTRACT:  This is a simple ring counter with parameterized size and initial
 *            value. The content of the ring counter is shifted left on each
 *            clock cycle
 *
 * HISTORY:
 * 1 Jan 2016, RS - initial version
 * 18 Jan 2023, LK - ported to SystemVerilog
 *
 *****************************************************************************/
module ring_counter
    # ( parameter
        SIZE     = 4, // number of bits in the ring counter
        INIT_VAL = 1  // initial value after reset
    )
    (
        input  wire             clk, // posedge clk
        input  wire             rst, // async reset active HIGH
        output logic [SIZE-1:0] ring // ring counter with one bit = 0
    );

    always_ff @(posedge clk, posedge rst)
        if(rst)
            ring <= INIT_VAL;                                   // reset counter
        else
            ring <= { ring[SIZE-2:0], ring[SIZE-1] }; // rotate counter

endmodule
