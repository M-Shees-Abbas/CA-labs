`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2026 12:52:16 PM
// Design Name: 
// Module Name: alu_32bit_tb
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


module alu_32bit_tb();

reg [31:0] a_t,b_t;
reg cin_t;
reg [3:0] ALU_op_t;
wire cout_t;
wire [31:0] result_t;
wire zero_t;

alu_32bit dut(
    .a(a_t),
    .b(b_t),
    .cin(cin_t),
    .ALU_op(ALU_op_t),
    .cout(cout_t),
    .result(result_t),
    .zero(zero_t)
);


initial begin
    a_t = 32'b10101010101010101010101010101010;
    b_t = 32'b01010101010101010101010101010101;
    cin_t = 1'b0;
    #100;
    ALU_op_t = 4'b0000;
    
    #100;
    ALU_op_t = 4'b0001;
    
    #100;
    ALU_op_t = 4'b0010;
    
    #100;
    ALU_op_t = 4'b0011;
    
    #100;
    ALU_op_t = 4'b0100;
    
    #100;
    ALU_op_t = 4'b0101;
    
    #100;
    ALU_op_t = 4'b0110;
    
    #100;
    
end


endmodule
