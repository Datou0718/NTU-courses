module accumulator(clk, out);
  input clk;
  output [3:0] out;
  reg [3:0] register;
  wire [4:0] added;

  assign out = register;
  adder_4bit adder(register, 4'b1, 1'b0, added[3:0], added[4]);

  always @ (posedge clk) begin
    register = added[3:0];
  end
endmodule
