module adder_1bit(a, b, cin, s, cout);

input a, b;
input cin;

output s;
output cout;

wire half_sum, carry1, carry2;

assign half_sum = a ^ b;
assign carry1 = a & b;
assign carry2 = cin & half_sum;
assign s = half_sum ^ cin;
assign cout = carry1 | carry2;

endmodule
