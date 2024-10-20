module sample_test;

reg signal;
reg periodic;

initial begin
  // dump signal into "sample_test.vcd"
  $dumpfile("sample_test.vcd");
  // dump all signals
  $dumpvars; 
  signal = 1'b1;
  periodic = 1'b0;
  #10
  signal = 1'b0;
  #15
  signal = 1'b1;
  #100
  $finish;
end

always #10 periodic = ~periodic;

endmodule
