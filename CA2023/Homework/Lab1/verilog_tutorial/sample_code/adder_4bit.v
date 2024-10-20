module adder_4bit(a, b, cin, s, cout);

input [3:0] a, b;
input cin;
output cout;
output [3:0] s;

wire c0, c1, c2;

adder_1bit bit0(a[0], b[0], cin, s[0], c0);
adder_1bit bit1(a[1], b[1], c0, s[1], c1);
adder_1bit bit2(a[2], b[2], c1, s[2], c2);
adder_1bit bit3(a[3], b[3], c2, s[3], cout);

endmodule
