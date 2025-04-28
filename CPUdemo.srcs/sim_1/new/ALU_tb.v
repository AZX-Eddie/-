`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/21 15:48:57
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb;
reg [1:0] ALUOp;
reg [31:0] ReadData1, ReadData2, imm32;
reg [2:0] funct3;
reg [6:0] funct7;
reg ALUSrc;
wire [31:0] ALUResult;
wire zero;

ALU uut(
    .ALUOp(ALUOp),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .imm32(imm32),
    .funct3(funct3),
    .funct7(funct7),
    .ALUSrc(ALUSrc),
    .ALUResult(ALUResult),
    .zero(zero)
);

initial begin
    $display("Time\tALUOp\tfunct3\tfunct7\tALUSrc\tResult\t\tZero");

    // lw x1, 0(x1)  -> ADD
    ALUOp = 2'b00;  // load/store
    ReadData1 = 32'h10;
    imm32 = 32'h4;
    ALUSrc = 1;
    funct3 = 3'b010;
    funct7 = 7'b0000000;
    #10 $display("%g\t%0b\t%0b\t%0b\t%b\t%h\t%b", $time, ALUOp, funct3, funct7, ALUSrc, ALUResult, zero);

    // add x1, x1, x1
    ALUOp = 2'b10;
    ReadData1 = 32'h5;
    ReadData2 = 32'h6;
    ALUSrc = 0;
    funct3 = 3'b000;
    funct7 = 7'b0000000;
    #10 $display("%g\t%0b\t%0b\t%0b\t%b\t%h\t%b", $time, ALUOp, funct3, funct7, ALUSrc, ALUResult, zero);

    // sw x1, 0(x0)
    ALUOp = 2'b00;
    ReadData1 = 32'h100;
    imm32 = 32'h10;
    ALUSrc = 1;
    funct3 = 3'b010;
    funct7 = 7'b0000000;
    #10 $display("%g\t%0b\t%0b\t%0b\t%b\t%h\t%b", $time, ALUOp, funct3, funct7, ALUSrc, ALUResult, zero);

    // beq x1, x0, -16
    ALUOp = 2'b01;
    ReadData1 = 32'h10;
    ReadData2 = 32'h10;
    ALUSrc = 0;
    funct3 = 3'b000;
    funct7 = 7'b0000000;
    #10 $display("%g\t%0b\t%0b\t%0b\t%b\t%h\t%b", $time, ALUOp, funct3, funct7, ALUSrc, ALUResult, zero);

    // bne x0, x1, 4
    ALUOp = 2'b01;
    ReadData1 = 32'h5;
    ReadData2 = 32'h6;
    ALUSrc = 0;
    funct3 = 3'b001;
    funct7 = 7'b0000000;
    #10 $display("%g\t%0b\t%0b\t%0b\t%b\t%h\t%b", $time, ALUOp, funct3, funct7, ALUSrc, ALUResult, zero);

    // sub x1, x0, x3
    ALUOp = 2'b10;
    ReadData1 = 32'h20;
    ReadData2 = 32'h10;
    ALUSrc = 0;
    funct3 = 3'b000;
    funct7 = 7'b0100000;
    #10 $display("%g\t%0b\t%0b\t%0b\t%b\t%h\t%b", $time, ALUOp, funct3, funct7, ALUSrc, ALUResult, zero);

    // and x2, x3, x4
    ALUOp = 2'b10;
    ReadData1 = 32'hFF00FF00;
    ReadData2 = 32'h0F0F0F0F;
    ALUSrc = 0;
    funct3 = 3'b111;
    funct7 = 7'b0000000;
    #10 $display("%g\t%0b\t%0b\t%0b\t%b\t%h\t%b", $time, ALUOp, funct3, funct7, ALUSrc, ALUResult, zero);

    // or x3, x4, x5
    ALUOp = 2'b10;
    ReadData1 = 32'hF0F0F0F0;
    ReadData2 = 32'h0F0F0F0F;
    ALUSrc = 0;
    funct3 = 3'b110;
    funct7 = 7'b0000000;
    #10 $display("%g\t%0b\t%0b\t%0b\t%b\t%h\t%b", $time, ALUOp, funct3, funct7, ALUSrc, ALUResult, zero);

    $finish;
end
endmodule

