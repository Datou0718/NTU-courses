`timescale 1ms/1us

module test;

reg rst;
reg clk;
output [3:0] out;

accumulator acc(rst, clk, out);

initial begin
  $dumpfile("test_accumulator.vcd");
  $dumpvars;

  rst = 1'b1;
  clk = 1'b0;
  #0.1
  rst = 1'b0;
  #0.1
  rst = 1'b1;
  #16
  $finish;
end

always #0.5 begin
  clk = ~clk;
  if (clk)
    $display("%d", out);
end

endmodule
