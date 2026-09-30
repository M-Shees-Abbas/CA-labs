`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2026 12:35:35 PM
// Design Name: 
// Module Name: leds
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
