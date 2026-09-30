`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2026 12:29:13 PM
// Design Name: 
// Module Name: rst_db
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module debouncer (
    input wire clk,
    input wire pbin,
    output reg pbout
);

    reg [19:0] count = 20'd0;
    reg sync_0, sync_1;

    // Double-flop synchronizer to prevent metastability
    always @(posedge clk) begin
        sync_0 <= pbin;
        sync_1 <= sync_0;
    end

    // Counter-based debounce filtering
    always @(posedge clk) begin
        if (sync_1 == pbout) begin
            count <= 20'd0;
        end else begin
            count <= count + 1'b1;
            if (count == 20'hFFFFF) begin
                pbout <= sync_1;
                count <= 20'd0;
            end
        end
    end

endmodule