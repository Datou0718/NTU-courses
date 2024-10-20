module Forward_Mux(
    a,
    b,
    c,
    Forward,
    out,
);

input [31:0] a;
input [31:0] b;
input [31:0] c;
input [1:0] Forward;

output [31:0] out;

reg [31:0] out;

initial
begin
    out <= 0;
end

always @(*)
begin
    case(Forward)
        2'b00: out <= a;
        2'b01: out <= b;
        2'b10: out <= c;
        2'b11: out <= 32'b0;
        default: out <= 32'b0;
    endcase
end

endmodule