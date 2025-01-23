`timescale 1ns / 1ps
/******************************************************************************
 * (C) Copyright 2023-2025 AGH UST All Rights Reserved
 *
 * MODULE:    counter
 * DEVICE:    general
 * PROJECT:   stopwatch
 *
 * ABSTRACT:  This counter is the core of the stopwatch.
 *
 * HISTORY:
 * 1 Jan 2016, RS - initial version
 * 1 Jan 2023, RS - ported to SystemVerilog
 *
 *******************************************************************************/
module counter
    #(parameter N = 16)
    (
        input  wire          clk,    // posedge active clock
        input  wire          rst,    // async reset active HIGH
        input  wire          start,  // when 1 counter starts counting
        input  wire          stop,   // when 1 counter stops counting
        output logic [N-1:0] counter_value
    ) ;

    typedef enum bit { STATE_IDLE, STATE_COUNT } STATE_T;

    STATE_T state;
    STATE_T state_nxt;

    always_ff @(posedge clk, posedge rst) begin : state_blk
        if(rst) begin
            state <= STATE_IDLE;
        end
        else begin
            state <= state_nxt;
        end
    end

    always_comb begin : state_nxt_blk
        case({start,stop})
            2'b00: state_nxt   = state;
            2'b10: state_nxt   = STATE_COUNT;
            2'b01: state_nxt   = STATE_IDLE;
            default: state_nxt = state; // do nothing when two buttons pressed
        endcase
    end

    logic [N-1:0] counter_value_nxt;

    always_ff @(posedge clk, posedge rst) begin : counter_blk
        if(rst) begin
            counter_value <= '0;
        end
        else begin
            counter_value <= counter_value_nxt;
        end
    end

    always_comb begin : counter_value_nxt_blk
        case(state_nxt) // the counter should react immediately
            STATE_IDLE:  counter_value_nxt = counter_value;
            STATE_COUNT: counter_value_nxt = N'(counter_value + 1);
        endcase
    end

endmodule
