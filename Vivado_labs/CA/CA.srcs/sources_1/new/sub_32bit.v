`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2026 04:42:45 PM
// Design Name: 
// Module Name: sub_32bit
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

module sub_32bit (
    input  [31:0] a,
    input  [31:0] b,
    output [31:0] diff,
    output        cout     // 1 means no borrow (a >= b, unsigned)
);
    adder_32bit add_inst (
        .a(a),
        .b(~b),            // flip every bit of b
        .cin(1'b1),        // the +1 for two's complement
        .sum(diff),
        .cout(cout)
    );
endmodule