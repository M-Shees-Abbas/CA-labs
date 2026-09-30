`timescale 1ns / 1ps

module lab5_tb();

    reg clk;
    reg pbin;
    reg [15:0] physical_sw;
    wire [15:0] physical_leds;

    // Fast simulation parameter overrides
    top_fsm_system #(
        .CLK_DIV_LIMIT(26'd4),  // Rapid clock ticks for fast simulation
        .DEBOUNCE_LIMIT(20'd4)  // Fast debouncer for button press
    ) uut (
        .clk(clk),
        .pbin(pbin),
        .physical_sw(physical_sw),
        .physical_leds(physical_leds)
    );

    always #5 clk = ~clk; // 100MHz clock (10ns period)

    initial begin
        // 1. Initial State
        clk = 0;
        pbin = 0;
        physical_sw = 16'd0;

        // 2. Power-on Reset
        #20 pbin = 1;
        #100 pbin = 0;
        #100;

        // 3. Start Countdown from 5
        physical_sw = 16'd5;
        
        // Wait long enough for counter to load 0005 -> 0004 -> 0003
        #350; 

        // 4. TRIGGER MID-COUNTDOWN RESET
        pbin = 1;            // Press reset button while leds = 0003
        #100;                // Hold long enough to clear debouncer
        pbin = 0; 
        physical_sw = 16'd0; // Clear switches so FSM returns to IDLE

        #400; // Observe physical_leds instantly drop to 0000 from 0003

        $finish;
    end

endmodule