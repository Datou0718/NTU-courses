module ALU_Control
(
    funct7,
    funct3,
    ALUOp,
    ALUCtrl,
);

input [6:0] funct7;
input [2:0] funct3;
input [1:0] ALUOp;
output [2:0] ALUCtrl;

wire [2:0] ALUCtrl;

/*
000: add 
001: and
010: xor
011: sll
100: sub
101: mul
110: srai
*/

assign ALUCtrl = (
            ALUOp[0]?
                (funct3[0]? 3'b110 : 3'b000) : (funct7[5]? 3'b100 : (funct7[0]?  3'b101 : 
                (funct3[2]? (funct3[1]? 3'b001 : 3'b010) : (funct3[0]? 3'b011 : 3'b000))))
);

endmodule