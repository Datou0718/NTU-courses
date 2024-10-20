module Control
(
    Opcode,
    ALUOp,
    ALUSrc,
    RegWrite,
);

input [6:0] Opcode;
output [1:0] ALUOp;
output ALUSrc;
output RegWrite;

wire [1:0] ALUOp;
wire ALUSrc;
wire RegWrite;

assign RegWrite = 1'b1;
assign ALUSrc = (Opcode[5])? 1'b0 : 1'b1;
assign ALUOp = (Opcode[5])? 2'b00 : 2'b01;

endmodule