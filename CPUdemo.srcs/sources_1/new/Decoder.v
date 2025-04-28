`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/28 11:57:17
// Design Name: 
// Module Name: Decoder
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


module Decoder(
    input clk,rst,regWrite,
    input[31:0] inst,writeData,
    output [31:0] imm32,rs1Data,rs2Data
    );
    reg [31:0] registers [0:31];
    wire [4:0] rs1, rs2, rd;
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    assign opcode = inst[6:0];
    assign rd     = inst[11:7];
    assign funct3 = inst[14:12];
    assign rs1    = inst[19:15];
    assign rs2    = inst[24:20];
    assign funct7 = inst[31:25];
    assign rs1Data = registers[rs1];
    assign rs2Data = registers[rs2];

    reg [31:0] imm_reg;
    assign imm32 = imm_reg;
    always @(*) begin
        case (opcode)
        7'b1100111,
        7'b1110011,
        7'b0010011,
        7'b0000011: begin // I-type
            imm_reg = {{20{inst[31]}}, inst[31:20]};
        end
        7'b0100011: begin //  S-type
            imm_reg = {{20{inst[31]}}, inst[31:25], inst[11:7]};
        end
        7'b1100011: begin //  B-type
            imm_reg = {{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
        end
        7'b0110011: begin // R-type
            imm_reg = 32'b0;
        end
        7'b0010111,
        7'b0110111: begin // U-type
            imm_reg = {inst[31:12],12'b0};
        end
        7'b1101111: begin // J-type
            imm_reg = {{11{inst[31]}},inst[31],inst[19:12],inst[20],inst[30:21],1'b0};
        end
        default: begin
            imm_reg = 32'b0;
        end
    endcase
    end
    integer i;
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end
        else if (regWrite && (rd != 0)) begin
            registers[rd] <= writeData;
        end
    end
endmodule
