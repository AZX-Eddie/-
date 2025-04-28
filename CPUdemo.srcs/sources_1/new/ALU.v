`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/21 14:45:29
// Design Name: 
// Module Name: ALU
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


module ALU(
    input[1:0] ALUOp,
    input[31:0] ReadData1,ReadData2,imm32,
    input[2:0] funct3,
    input[6:0] funct7,
    input ALUSrc,
    output reg [31:0] ALUResult,
    output wire zero
    );
    reg [3:0] ALUControl;
    always @ (*) begin
        case(ALUOp)
            2'b00: ALUControl = { ALUOp, 2'b10}; //l/s
            2'b01: ALUControl = { ALUOp, 2'b10}; //beq
            2'b10: ALUControl = { 1'b0,funct7[5],~funct3[2],funct3[1]^funct3[0]};//Rtype
            default : ALUControl = 1'b0;
        endcase
    end
    wire[31:0] operand1 = ReadData1;
    wire[31:0] operand2;
    assign operand2 = (ALUSrc == 0)? ReadData2 : imm32;
    assign zero = (ALUResult == 0) ? 1'b1 : 1'b0;
    always @(*) begin
        case (ALUControl)
            4'b0010: ALUResult = operand1 + operand2;
            4'b0110: ALUResult = operand1 - operand2;
            4'b0000: ALUResult = operand1 & operand2;
            4'b0001: ALUResult = operand1 | operand2;
            default: ALUResult = 1'b0;
        endcase
    end
    
endmodule
