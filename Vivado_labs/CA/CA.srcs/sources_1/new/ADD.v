`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2026 12:20:38 PM
// Design Name: 
// Module Name: ADD
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


module ADD(
    input a,
    input b,
    input cin,
    input sub,
    output sum,
    output cout
    );
    wire b_in = b^sub;
    assign sum = a^b_in ^cin;
    assign cout = (a&b_in)|(cin & (a^b_in));
endmodule
