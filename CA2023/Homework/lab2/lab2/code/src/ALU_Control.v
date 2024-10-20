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

reg [2:0] ALUCtrl;

initial
begin
    ALUCtrl <= 0;
end

/*
000: add 
001: and
010: xor
011: sll
100: sub
101: mul
110: srai
*/

always @(*)
begin
    case(ALUOp)
        2'b00: // and xor sll add sub mul
        begin
            case(funct7)
                7'b0000000: // and xor sll add 
                begin
                    case(funct3)
                        3'b111: ALUCtrl <= 3'b001; // and
                        3'b100: ALUCtrl <= 3'b010; // xor
                        3'b001: ALUCtrl <= 3'b011; // sll
                        3'b000: ALUCtrl <= 3'b000; // add
                    endcase
                end
                7'b0000001: // mul
                begin
                    ALUCtrl <= 3'b101; // mul
                end
                7'b0100000: // sub
                begin
                    ALUCtrl <= 3'b100; // sub
                end
            endcase
        end
        2'b01: // addi srai
        begin
            case(funct3)
                3'b000: ALUCtrl <= 3'b000; // addi
                3'b101: ALUCtrl <= 3'b110; // srai
            endcase
        end
        2'b10: // lw
        begin
            ALUCtrl <= 3'b000; // lw -> add
        end
        2'b11: // sw beq
        begin
            case(funct3)
                3'b010: ALUCtrl <= 3'b000; // sw -> add
                3'b000: ALUCtrl <= 3'b100; // beq
            endcase
        end
    endcase
end

endmodule