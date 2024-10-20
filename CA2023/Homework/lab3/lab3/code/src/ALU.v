module ALU
(
    a,
    b,
    ALUCtrl,
    data_o,
);

input signed [31:0] a;
input signed [31:0] b;
input [2:0] ALUCtrl;
output unsigned [31:0] data_o;

// for ALUCtrl
/*
000: add 
001: and
010: xor
011: sll
100: sub
101: mul
110: srai
*/

reg unsigned [31:0] data_o;

initial
begin
    data_o <= 0;
end

always @(*)
begin
    case (ALUCtrl)
        3'b000: data_o <= a + b;
        3'b001: data_o <= a & b;
        3'b010: data_o <= a ^ b;
        3'b011: data_o <= a << b[4:0];
        3'b100: data_o <= a - b;
        3'b101: data_o <= a * b;
        3'b110: data_o <= a >>> b[4:0];
        default: data_o <= 0;
    endcase
end

endmodule