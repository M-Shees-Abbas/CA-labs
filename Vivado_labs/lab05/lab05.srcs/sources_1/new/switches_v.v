`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2026 12:34:23 PM
// Design Name: 
// Module Name: switches_v
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