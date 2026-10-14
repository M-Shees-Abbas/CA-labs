`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2026 01:34:35 PM
// Design Name: 
// Module Name: single_cycle
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


module reg_file (
    input  wire        clk,
    input  wire        rst,          // Synchronous/Asynchronous active-high reset
    input  wire        WriteEnable,  // RegWrite signal
    input  wire [4:0]  rs1,          // Read register 1 address
    input  wire [4:0]  rs2,          // Read register 2 address
    input  wire [4:0]  rd,           // Write register address
    input  wire [31:0] WriteData,    // Data to write into rd
    output wire [31:0] ReadData1,    // Asynchronous read data 1
    output wire [31:0] ReadData2     // Asynchronous read data 2
);

    // 32 registers, each 32 bits wide
    reg [31:0] regs [31:0];
    
    integer i;

    // Asynchronous read logic with hardwired x0 = 0
    assign ReadData1 = (rs1 == 5'd0) ? 32'b0 : regs[rs1];
    assign ReadData2 = (rs2 == 5'd0) ? 32'b0 : regs[rs2];

    // Synchronous write logic (and reset handling)
    always @(posedge clk) begin
        if (rst) begin
            // Clear all registers to zero on reset
            for (i = 0; i < 32; i = i + 1) begin
                regs[i] <= 32'b0;
            end
        end else if (WriteEnable) begin
            // Prevent writing to x0 (address 0)
            if (rd != 5'd0) begin
                regs[rd] <= WriteData;
            end
        end
    end

endmodule