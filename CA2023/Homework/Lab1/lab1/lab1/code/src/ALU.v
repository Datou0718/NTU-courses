module ALU
(
    ALU_i_1,
    ALU_i_2,
    sel,
    ALU_result,
);

input signed [31:0] ALU_i_1;
input signed [31:0] ALU_i_2;
input [2:0] sel;
output signed [31:0] ALU_result;

// for sel
/*
000: add 
001: and
010: xor
011: sll
100: sub
101: mul
110: srai
*/

wire [31:0] ALU_result;

assign ALU_result = (sel[2]? (sel[1]? ALU_i_1 >>> ALU_i_2[4:0] : 
                          (sel[0]? ALU_i_1 * ALU_i_2 : ALU_i_1 - ALU_i_2)) :
                      (sel[1]? (sel[0]? ALU_i_1 << ALU_i_2 : ALU_i_1 ^ ALU_i_2) :
                          (sel[0]? ALU_i_1 & ALU_i_2 : ALU_i_1 + ALU_i_2)));

endmodule