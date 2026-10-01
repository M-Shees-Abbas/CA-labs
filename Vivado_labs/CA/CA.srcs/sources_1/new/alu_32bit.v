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


module alu_32bit(
    input [31:0]a,
    input [31:0]b,
    input cin,
    input [3:0]ALU_op,
    output reg cout,
    output reg result
    
    );
    localparam AND_OP = 3'd0;
    localparam OR_OP  = 3'd1;
    localparam XOR_OP = 3'd2;
    localparam ADD_OP = 3'd3;
    localparam SUB_OP = 3'd4;
    localparam SLL_OP = 3'd5;
    localparam SRL_OP = 3'd6;
    
    wire [31:0]a_prev = {a[30:0], 1'b0};
    wire [31:0]a_next = {1'b0, a[30:0]};
    
    wire [31:0]add_out, sub_out;
    wire add_cout, sub_cout;
    
    wire [31:0]AND, OR, XOR;
    assign AND = a & b;
    assign OR = a | b;
    assign XOR = a^b;
    
    adder_32bit adder(
        .a(a),
        .b(b),
        .cin(cin),
        .sum(add_out),
        .cout(add_cout)
    );
    
    sub_32bit sub(
        .a(a),
        .b(b),
        .sum(sub_out),
        .cout(sub_cout)
    );
    
    
    always @(*) begin
        cout = 1'b0;
        case(ALU_op)
            AND_OP: result = AND;
            OR_OP: result = OR;
            XOR_OP: result = XOR;
            ADD_OP: 
            begin
                result = add_out;
                cout = add_cout;
            end
            SUB_OP: 
            begin
                result = sub_out;
                cout = sub_cout;
            end
            SLL_OP: result = a_prev;
            SRL_OP: result = a_next;
            default: result = 32'b0;
        endcase
    end  
endmodule
