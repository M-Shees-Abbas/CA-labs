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


module alu_1bit(
    input [31:0]a,
    input [31:0]b,
    input cin,
    input [3:0]ALU_op,
    output cout,
    output result
    
    );
    localparam AND_OP = 3'd0;
    localparam OR_OP  = 3'd1;
    localparam XOR_OP = 3'd2;
    localparam ADD_OP = 3'd3;
    localparam SUB_OP = 3'd4;
    localparam SLL_OP = 3'd5;
    localparam SRL_OP = 3'd6;
    
    wire AND, OR, XOR, ADD, SUB, sll, slr;
    assign AND = a & b;
    assign OR = a | b;
    assign XOR = a^b
    
    
    
endmodule
