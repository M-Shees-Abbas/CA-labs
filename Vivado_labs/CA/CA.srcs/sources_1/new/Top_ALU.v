`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2026 02:23:33 PM
// Design Name: 
// Module Name: Top_ALU
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


module Top_ALU(
    input  [15:0] sw,
    input         btnC, btnU, btnL, btnR, btnD,
    output [15:0] led
);
    wire [31:0] result;
    wire        cout;

    alu_32bit alu(
        .a({24'b0, sw[7:0]}),      // a = low 8 switches
        .b({24'b0, sw[15:8]}),     // b = high 8 switches
        .cin(btnC),
        .ALU_op({btnU, btnL, btnR, btnD}),
        .cout(cout),
        .result(result)
    );

    assign led[7:0]  = result[7:0];  // low 8 bits of the result
    assign led[14:8] = 7'b0;
    assign led[15]   = cout;
endmodule
