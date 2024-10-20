module ALU
(
    a,
    b,
    ALUCtrl,
    out,
);

input signed [31:0] a;
input signed [31:0] b;
input [2:0] ALUCtrl;
output signed [31:0] out;

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

reg signed [31:0] out;

initial
begin
    out <= 0;
end

always @(*)
begin
    case (ALUCtrl)
        3'b000: out <= a + b;
        3'b001: out <= a & b;
        3'b010: out <= a ^ b;
        3'b011: out <= a << b[4:0];
        3'b100: out <= a - b;
        3'b101: out <= a * b;
        3'b110: out <= a >>> b[4:0];
        default: out <= 0;
    endcase
end

endmodule