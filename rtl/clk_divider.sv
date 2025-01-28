`timescale 1ns / 1ns
/******************************************************************************
 * (C) Copyright 2023-2025 AGH UST All Rights Reserved
 *
 * MODULE:    clk_divider
 * DEVICE:    general
 * PROJECT:   stopwatch
 *
 * ABSTRACT:  The clock divider module. Assuming 100MHz input clock
 *
 * HISTORY:
 * 1 Jan 2016, RS - initial version
 * 18 Jan 2023, LK - ported to SystemVerilog
 * 24 Jan 2025, KB - added FREQ parameter, modified LOOP_COUNTER
 *
 *******************************************************************************/
module clk_divider
    #( parameter
        FREQ = 100     //Frequency divider parameter 
     )
    (
        input  wire  clk100MHz, // input clock 100 MHz
        input  wire  rst,       // async reset active high
        output logic clk_div    // output clock
    );

    // when the counter should restart from zero
    localparam LOOP_COUNTER_AT = 100_000_000 / (FREQ * 2) ;

    logic [clog2(LOOP_COUNTER_AT)-1:0] count;

    always_ff @(posedge clk100MHz, posedge rst) begin
        if(rst) begin : counter_reset
            count   <= '0;
            clk_div <= 1'b0;
        end
        else begin : counter_operate
            if (count == (LOOP_COUNTER_AT - 1)) begin : counter_loop
                count   <= '0;
                clk_div <= ~clk_div;
            end
            else begin : counter_increment
                count   <= count + 1;
                clk_div <= clk_div;
            end
        end
    end

    // function to calculate number of bits necessary to store the number
    // (ceiling of base 2 logarithm)
    function integer clog2(integer number);
        clog2 = 0;
        while (number) begin
            clog2  = clog2 + 1;
            number = number >> 1;
        end
    endfunction

endmodule
