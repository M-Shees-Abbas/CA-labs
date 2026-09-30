`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2026 12:32:30 PM
// Design Name: 
// Module Name: clock_div
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

module clock_divider (
    input wire clk_in,
    input wire rst,
    output reg clk_out
);

    // 100MHz / (2 * 50_000_000) = 1Hz
    reg [25:0] count = 26'd0;

    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            count <= 26'd0;
            clk_out <= 1'b0;
        end else begin
            if (count == 26'd49_999_999) begin
                count <= 26'd0;
                clk_out <= ~clk_out;
            end else begin
                count <= count + 1'b1;
            end
        end
    end

endmodule
