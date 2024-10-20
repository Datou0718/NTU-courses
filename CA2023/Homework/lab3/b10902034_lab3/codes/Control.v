module Control
(
    Opcode,
    NoOp,
    ALUOp,
    ALUSrc,
    RegWrite,
    Branch_o,
    MemtoReg,
    MemRead,
    MemWrite
);

input [6:0] Opcode;
input NoOp;

output [1:0] ALUOp;
output ALUSrc;
output RegWrite;
output Branch_o;
output MemtoReg;
output MemRead;
output MemWrite;

reg [1:0] ALUOp;
reg ALUSrc;
reg RegWrite;
reg Branch_o;
reg MemtoReg;
reg MemRead;
reg MemWrite;

initial
begin
    ALUOp <= 0;
    ALUSrc <= 0;
    RegWrite <= 0;
    Branch_o <= 0;
    MemtoReg <= 0;
    MemRead <= 0;
    MemWrite <= 0;
end

// 00: and xor sll add sub mul srai
// 01: addi lw
// 10: sw
// 11: beq

always @(*)
begin
    if (NoOp)
    begin
        ALUOp <= 2'b00;
        ALUSrc <= 0;
        RegWrite <= 0;
        Branch_o <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0;
    end
    else
    case(Opcode)
        7'b0110011: // and xor sll add sub mul
        begin
            ALUOp <= 2'b00;
            ALUSrc <= 0;
            RegWrite <= 1;
            Branch_o <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
        end
        7'b0010011: // addi srai
        begin
            begin
                ALUOp <= 2'b01;
                ALUSrc <= 1;
                RegWrite <= 1;
                Branch_o <= 0;
                MemRead <= 0;
                MemWrite <= 0;
                MemtoReg <= 0;
            end
        end
        7'b0000011: // lw
        begin 
            ALUOp <= 2'b10;
            ALUSrc <= 1;
            RegWrite <= 1;
            Branch_o <= 0;
            MemRead <= 1;
            MemWrite <= 0;
            MemtoReg <= 1;
        end
        7'b0100011: // sw
        begin
            ALUOp <= 2'b11;
            ALUSrc <= 1;
            RegWrite <= 0;
            Branch_o <= 0;
            MemRead <= 0;
            MemWrite <= 1;
            MemtoReg <= 0;
        end
        7'b1100011: begin // beq
            ALUOp <= 2'b11;
            ALUSrc <= 0;
            RegWrite <= 0;
            Branch_o <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
        end
        default: 
        begin
            ALUOp <= 2'b00;
            ALUSrc <= 0;
            RegWrite <= 0;
            Branch_o <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
        end
    endcase
end 

endmodule