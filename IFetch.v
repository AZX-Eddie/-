`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/28 11:32:27
// Design Name: 
// Module Name: IFetch
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


module IFetch(
    input wire clk,
    input wire rst,
    input wire [31:0] imm32,
    input wire branch,
    input wire zero,
    output wire [31:0] inst
);

reg [31:0] pc;

prgrom urom(
    .clka(clk),
    .addra(pc[15:2]), 
    .douta(inst)
);

always @(negedge clk or negedge rst) begin
    if (!rst) begin
        pc <= 32'b0;
    end
    else begin
        if (branch && zero) begin
            pc <= pc + imm32;  
        end
        else begin
            pc <= pc + 4;      
        end
    end
end

endmodule
