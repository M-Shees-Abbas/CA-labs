`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2026 01:45:48 PM
// Design Name: 
// Module Name: single
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


module RegisterFile_tb;

    // Inputs
    reg        clk;
    reg        rst;
    reg        WriteEnable;
    reg  [4:0] rs1;
    reg  [4:0] rs2;
    reg  [4:0] rd;
    reg [31:0] WriteData;

    // Outputs
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;

    // Instantiate the Unit Under Test (UUT)
    reg_file uut (
        .clk(clk),
        .rst(rst),
        .WriteEnable(WriteEnable),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    // Clock generation: 10ns period (100 MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        WriteEnable = 0;
        rs1 = 0;
        rs2 = 0;
        rd = 0;
        WriteData = 0;

        // Apply Reset
        #10;
        rst = 1;
        #10;
        rst = 0;
        #10;

        // -------------------------------------------------------------
        // Test Case (i): Write a value to a register (x5 = 0xDEADBEEF) 
        // with WriteEnable=1 and check on next clock that ReadData1/2 returns it.
        // -------------------------------------------------------------
        WriteEnable = 1;
        rd = 5'd5;
        WriteData = 32'hDEADBEEF;
        #10; // Wait for rising edge
        WriteEnable = 0;

        rs1 = 5'd5;
        rs2 = 5'd5;
        #2; // Small delay for combinational read

        // -------------------------------------------------------------
        // Test Case (ii): Attempt to write to x0 and verify it remains zero.
        // -------------------------------------------------------------
        WriteEnable = 1;
        rd = 5'd0;
        WriteData = 32'hCAFEF00D;
        #10; // Wait for rising edge
        WriteEnable = 0;

        rs1 = 5'd0;
        rs2 = 5'd0;
        #2;

        // -------------------------------------------------------------
        // Test Case (iii): Simultaneous two read ports: verify both return 
        // correct contents concurrently (x5 = 0xDEADBEEF, x10 = 0x12345678).
        // -------------------------------------------------------------

        // Write to x10 first
        WriteEnable = 1;
        rd = 5'd10;
        WriteData = 32'h12345678;
        #10;
        WriteEnable = 0;

        // Read x5 on Port 1 and x10 on Port 2 simultaneously
        rs1 = 5'd5;
        rs2 = 5'd10;
        #2;


        // -------------------------------------------------------------
        // Test Case (iv): Overwrite a register and verify old value is replaced.
        // -------------------------------------------------------------
        WriteEnable = 1;
        rd = 5'd5;
        WriteData = 32'h87654321;
        #10;
        WriteEnable = 0;

        rs1 = 5'd5;
        #2;
   

        // -------------------------------------------------------------
        // Test Case (v): Reset behavior: check registers clear appropriately.
        // -------------------------------------------------------------
     
        rst = 1;
        #10;
        rst = 0;
        #2;

        rs1 = 5'd5;
        rs2 = 5'd10;
        #2;
      
    end

endmodule