module register_4bit(in, out, clk);

input [3:0] in;
input clk;
output [3:0] out;
reg [3:0] register;

assign out = register;
always @ (posedge clk) begin
  register = in;
end

endmodule
