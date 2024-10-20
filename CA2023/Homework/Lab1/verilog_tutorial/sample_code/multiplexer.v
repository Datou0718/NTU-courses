module multiplexer(a, b, sel, out);

input a, b, sel;
output out;

assign out = sel ? a : b;

/*
always @ (*) begin
  if (sel)
    out = a;
  else
    out = b;
end
*/

endmodule
