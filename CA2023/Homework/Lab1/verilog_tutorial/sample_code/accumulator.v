module accumulator(rst, clk, out);
  input rst;
  input clk;
  output [3:0] out;
  reg [3:0] register;
  wire [4:0] added;

  assign out = register;
  adder_4bit adder(register, 4'b0001, 1'b0, added[3:0], added[4]);

  always @ (posedge clk or negedge rst) begin
    if (rst)
      register = added[3:0];
    else
      register = 4'b0;
  end
endmodule
