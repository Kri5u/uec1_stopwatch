`timescale 1ns / 1ps
/******************************************************************************
 * (C) Copyright 2023-2025 AGH UST All Rights Reserved
 *
 * MODULE:    bin2bcd
 * DEVICE:    general
 * PROJECT:   stopwatch
 *
 * ABSTRACT:  binary to BCD converter, three 8421 BCD digits
 *            Algorithm description:
 *            http://www.eng.utah.edu/~nmcdonal/Tutorials/BCDTutorial/BCDConversion.html
 *
 * HISTORY:
 * 1 Jan 2016, RS - initial version
 * 18 Jan 2023, LK - ported to SystemVerilog
 * 24 Jan 2025, KB - added 4'th digit to 7-seg display 
 * 30 Jan 2025, KB - changed max displayed value to one minute
 *
 *******************************************************************************/
module bin2bcd (
        input  wire  [15:0] bin,  // input binary number
        output logic [3:0]  bcd0, // LSB
        output logic [3:0]  bcd1,
        output logic [3:0]  bcd2,
        output logic [3:0]  bcd3  // MSB
    );

    integer i;
    logic [15:0] bin_mod;

    always_comb begin
        bin_mod = bin % 6000;
        bcd0 = 0;
        bcd1 = 0;
        bcd2 = 0;
        bcd3 = 0;
        for ( i = 15; i >= 0; i = i - 1 ) begin
            if( bcd0 > 4 ) bcd0 = bcd0 + 3;
            if( bcd1 > 4 ) bcd1 = bcd1 + 3;
            if( bcd2 > 4 ) bcd2 = bcd2 + 3;
            if( bcd3 > 4 ) bcd3 = bcd3 + 3;
            { bcd3[3:0], bcd2[3:0], bcd1[3:0], bcd0[3:0] } =
            { bcd3[2:0], bcd2[3:0], bcd1[3:0], bcd0[3:0], bin_mod[i] };    
        end
    end

endmodule
