module MUX32
(
    rs2_data,
    immediate,
    sel,
    ALU_i_2,
);

input [31:0] rs2_data;
input [31:0] immediate;
input sel;
output[31:0] ALU_i_2;

wire [31:0] ALU_i_2;

assign ALU_i_2 = (sel)? immediate : rs2_data;

endmodule