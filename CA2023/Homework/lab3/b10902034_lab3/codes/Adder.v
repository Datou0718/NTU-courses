module Adder
(
    a,
    b,
    out,
);

input signed [31:0] a;
input signed [31:0] b;

output signed [31:0] out;

wire [31:0] out;

assign out = a + b;

endmodule