`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/28 10:22:57
// Design Name: 
// Module Name: Controller
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


module Controller(
    input[31:0] inst,
    output reg Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,
    output reg [1:0]  ALUOp
    );
    always @* begin
        case (inst[6:0])
            7'b0110011: begin
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                MemWrite = 0; 
                ALUSrc = 0;
                RegWrite = 1;
                ALUOp = 2'b10;
            end 
            7'b0000011:begin
                Branch = 0;
                MemRead = 1;
                MemtoReg = 1;
                MemWrite = 0; 
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 2'b00;
            end
            7'b0100011:begin
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                MemWrite = 1; 
                ALUSrc = 1;
                RegWrite = 0;
                ALUOp = 2'b00;
            end
            7'b1100011:begin
                Branch = 1;
                MemRead = 0;
                MemtoReg = 0;
                MemWrite = 0; 
                ALUSrc = 0;
                RegWrite = 0;
                ALUOp = 2'b01;
            end
            default: begin
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                MemWrite = 0; 
                ALUSrc = 0;
                RegWrite = 0;
                ALUOp = 2'b11;
            end
        endcase
        
    end

endmodule
