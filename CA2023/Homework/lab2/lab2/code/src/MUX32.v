module MUX32
(
    a,
    b,
    sel,
    out,
);

input [31:0] a;
input [31:0] b;
input sel;
output[31:0] out;

wire [31:0] out;

assign out = (sel)? b : a;

endmodule