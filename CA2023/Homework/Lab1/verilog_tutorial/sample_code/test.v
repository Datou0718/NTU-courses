`timescale 1s/100ms

module test;

reg reset, clock;
wire [3:0] out;

accumulator acc(reset, clock, out);

initial begin
  $dumpfile("test.vcd");
  $dumpvars;

  clock = 1'b0;
  reset = 1'b0;

  #0.1
  reset = 1'b1;

  #30
  $finish;
end

always #0.5 begin
  clock = ~clock;
  if (clock)
    $display("%d", out);
end

endmodule
