module Adder
(
    pc_i,
    value,
    pc_o,
);

input [31:0] pc_i;
input [31:0] value;
output [31:0] pc_o;

wire [31:0] pc_o;

assign pc_o = pc_i + value;

endmodule