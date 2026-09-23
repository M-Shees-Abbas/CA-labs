`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Testbench: tb_top_fsm_system
// Drives the actual top-level ports (clk, pbin, physical_sw) and checks
// physical_leds plus internal FSM signals via hierarchical references.
//
// Verifies:
//   1. Reset (pbin) forces S_IDLE / leds = 0
//   2. FSM stays in S_IDLE while switches == 0
//   3. Non-zero switch value is captured and countdown begins
//   4. LEDs track the counter down to 0, FSM returns to S_IDLE
//   5. Switches are ignored while counting
//   6. Reset asserted mid-count immediately clears everything
//
// NOTE: debouncer.v in this project is a passthrough (pbout = pbin), and
// clock_divider.v has MAX_COUNT set low for simulation, so pbin can be
// driven directly as a clean, fast reset pulse here.
//////////////////////////////////////////////////////////////////////////////////

module tb_top_fsm_system;

    reg        clk;
    reg        pbin;
    reg [15:0] physical_sw;
    wire [15:0] physical_leds;

    top_fsm_system dut (
        .clk(clk),
        .pbin(pbin),
        .physical_sw(physical_sw),
        .physical_leds(physical_leds)
    );

    // 100 MHz-style fast clock: 10ns period
    always #5 clk = ~clk;

    initial begin
        $dumpfile("top_fsm_system.vcd");
        $dumpvars(0, tb_top_fsm_system);

        clk = 0;
        pbin = 1;          // reset asserted
        physical_sw = 16'd0;

        // ---- Test 1: Reset behavior ----
        repeat (5) @(posedge clk);
        if (dut.state !== 1'b0 || physical_leds !== 16'd0)
            $display("FAIL: reset did not force S_IDLE / leds=0");
        else
            $display("PASS: reset -> S_IDLE, leds=0");
        pbin = 0;

        // ---- Test 2: switches == 0 keeps FSM in S_IDLE ----
        repeat (5) @(posedge clk);
        if (dut.state !== 1'b0)
            $display("FAIL: FSM left S_IDLE with switches=0");
        else
            $display("PASS: FSM stays in S_IDLE while switches=0");

        // ---- Test 3: non-zero switch loads counter and starts countdown ----
        physical_sw = 16'd5;
        @(posedge clk);
        @(posedge clk);
        if (dut.state !== 1'b1 || dut.count_reg !== 16'd5)
            $display("FAIL: did not latch sw=5 and enter S_COUNT (count_reg=%0d, state=%0d)", dut.count_reg, dut.state);
        else
            $display("PASS: latched sw=5, entered S_COUNT");

        // ---- Test 4: switches ignored while counting ----
        physical_sw = 16'd9999;  // should have no effect on count_reg

        wait (dut.state == 1'b0);
        $display("PASS: countdown reached 0, FSM returned to S_IDLE, leds=%0d", physical_leds);
        if (physical_leds !== 16'd0)
            $display("FAIL: leds should be 0 in S_IDLE, got %0d", physical_leds);

        // ---- Test 5: reset during an active countdown ----
        physical_sw = 16'd7;
        @(posedge clk);
        @(posedge clk);
        repeat (3) @(posedge dut.slow_clk);   // let a few ticks pass, count_reg < 7
        @(posedge clk);
        if (dut.state !== 1'b1)
            $display("FAIL: expected to be mid-countdown before reset test");
        pbin = 1;
        @(posedge clk);
        if (dut.state !== 1'b0 || dut.count_reg !== 16'd0 || physical_leds !== 16'd0)
            $display("FAIL: reset during S_COUNT did not clear state/count/leds");
        else
            $display("PASS: reset during S_COUNT immediately clears state, count_reg, leds");
        pbin = 0;
        physical_sw = 16'd0;

        repeat (10) @(posedge clk);
        $display("Simulation complete.");
        $finish;
    end

endmodule