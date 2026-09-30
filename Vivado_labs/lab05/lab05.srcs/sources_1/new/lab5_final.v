`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// TOP-LEVEL FSM SYSTEM (CONFIGURED FOR FPGA HARDWARE)
//////////////////////////////////////////////////////////////////////////////////

module top_fsm_system #(
    // Hardware-scale limits: 100MHz clock -> 1Hz ticks (~1 second per count)
    parameter CLK_DIV_LIMIT = 26'd49_999_999, 
    parameter DEBOUNCE_LIMIT = 20'hFFFFF       // ~10.5ms debouncer delay
)(
    input wire clk,
    input wire pbin,
    input wire [15:0] physical_sw,
    output wire [15:0] physical_leds
);

    // Internal Signals
    wire rst_clean;
    wire [31:0] switch_data;           
    reg [31:0] led_write_data = 32'd0; 
    wire slow_clk;

    // Debouncer Instance (Filters button noise on pbin -> rst_clean)
    debouncer #(
        .WAIT_LIMIT(DEBOUNCE_LIMIT)
    ) rst_db_inst (
        .clk(clk),
        .pbin(pbin),
        .pbout(rst_clean)
    );

    // Switch Interface
    leds switch_reader (
        .clk(clk), 
        .rst(rst_clean),
        .btns(16'd0),        
        .writeData(32'd0),   
        .writeEnable(1'b0),  
        .readEnable(1'b1),   
        .memAddress(30'd0),
        .switches(physical_sw), 
        .readData(switch_data)
    );

    // LED Interface
    switches led_writer (
        .clk(clk), 
        .rst(rst_clean),
        .writeData(led_write_data),
        .writeEnable(1'b1),  
        .readEnable(1'b0),
        .memAddress(30'd0),
        .readData(),         
        .leds(physical_leds)
    );

    // Clock Divider (Divides 100MHz to 1Hz slow_clk)
    clock_divider #(
        .DIV_LIMIT(CLK_DIV_LIMIT)
    ) ticker (
        .clk_in(clk),       
        .rst(rst_clean),    
        .clk_out(slow_clk)  
    );

    // FSM Logic
    reg state = 1'b0; // 0: IDLE, 1: COUNTING

    always @(posedge slow_clk or posedge rst_clean) begin
        if (rst_clean == 1'b1) begin
            state <= 1'b0;          
            led_write_data <= 32'b0; 
        end else begin
            case (state)
                1'b0: begin // IDLE State
                    if (switch_data != 32'b0) begin
                        state <= 1'b1;
                        led_write_data <= switch_data;
                    end else begin
                        state <= 1'b0;
                        led_write_data <= 32'b0;
                    end
                end

                1'b1: begin // COUNTING State
                    if (led_write_data != 32'b0) begin
                        led_write_data <= led_write_data - 1'b1;
                        state <= 1'b1;
                    end else begin
                        state <= 1'b0; // Reached zero
                    end
                end

                default: begin
                    state <= 1'b0;
                    led_write_data <= 32'b0;
                end
            endcase
        end
    end

endmodule


//////////////////////////////////////////////////////////////////////////////////
// DEBOUNCE MODULE
//////////////////////////////////////////////////////////////////////////////////

module debouncer #(
    parameter WAIT_LIMIT = 20'hFFFFF
)(
    input wire clk,
    input wire pbin,
    output reg pbout
);

    reg [19:0] count = 20'd0;
    reg sync_0, sync_1;

    always @(posedge clk) begin
        sync_0 <= pbin;
        sync_1 <= sync_0;
    end

    always @(posedge clk) begin
        if (sync_1 == pbout) begin
            count <= 20'd0;
        end else begin
            count <= count + 1'b1;
            if (count >= WAIT_LIMIT) begin
                pbout <= sync_1;
                count <= 20'd0;
            end
        end
    end

endmodule


//////////////////////////////////////////////////////////////////////////////////
// CLOCK DIVIDER MODULE
//////////////////////////////////////////////////////////////////////////////////

module clock_divider #(
    parameter DIV_LIMIT = 26'd49_999_999
)(
    input wire clk_in,
    input wire rst,
    output reg clk_out
);

    reg [25:0] count = 26'd0;

    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            count <= 26'd0;
            clk_out <= 1'b0;
        end else begin
            if (count >= DIV_LIMIT) begin
                count <= 26'd0;
                clk_out <= ~clk_out;
            end else begin
                count <= count + 1'b1;
            end
        end
    end

endmodule


//////////////////////////////////////////////////////////////////////////////////
// SWITCHES MODULE
//////////////////////////////////////////////////////////////////////////////////

module switches (
    input wire clk,
    input wire rst,
    input wire [31:0] writeData,
    input wire writeEnable,
    input wire readEnable,
    input wire [29:0] memAddress,
    output reg [31:0] readData,
    output reg [15:0] leds
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            leds <= 16'd0;
            readData <= 32'd0;
        end else begin
            if (writeEnable) begin
                leds <= writeData[15:0];
            end
            if (readEnable) begin
                readData <= {16'd0, leds};
            end
        end
    end

endmodule


//////////////////////////////////////////////////////////////////////////////////
// LEDS MODULE
//////////////////////////////////////////////////////////////////////////////////

module leds (
    input wire clk,
    input wire rst,
    input wire [15:0] btns,
    input wire [31:0] writeData,
    input wire writeEnable,
    input wire readEnable,
    input wire [29:0] memAddress,
    input wire [15:0] switches,
    output reg [31:0] readData
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            readData <= 32'd0;
        end else begin
            if (readEnable) begin
                readData <= {16'd0, switches};
            end
        end
    end

endmodule