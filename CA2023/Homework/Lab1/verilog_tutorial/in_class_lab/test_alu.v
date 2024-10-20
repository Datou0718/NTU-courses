`timescale 1ms/1us
`define AND_OP 2'b00
`define ADD_OP 2'b01
`define SUB_OP 2'b10
`define SRAI_OP 2'b11

module test;

reg [7:0] in0, in1;
reg [1:0] alu_op;
wire [7:0] out;

baby_alu alu(in0, in1, alu_op, out);

initial begin
  $dumpfile("alu.vcd");
  $dumpvars;
  in0 = 8'b0;
  in1 = 8'b0;
  alu_op = `AND_OP;

  #10
  in0 = 8'b10;
  in1 = 8'b10;
  alu_op = `AND_OP;

  #10
  in0 = 8'hF0;
  in1 = 8'hAA;
  alu_op = `ADD_OP;

  #10
  in0 = 8'hF0;
  in1 = 8'hAA;
  alu_op = `SUB_OP;

  #10
  in0 = 8'h1F;
  in1 = 8'h04;
  alu_op = `SRAI_OP;

  #10
  $finish;
end

always @ (out) $display("%x", out);

endmodule
