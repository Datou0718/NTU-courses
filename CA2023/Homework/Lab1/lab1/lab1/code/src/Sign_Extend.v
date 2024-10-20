module Sign_Extend
(
    to_extend,
    immediate,
);

input [11:0] to_extend;
output [31:0] immediate;

wire [31:0] immediate;

assign immediate = {{20{to_extend[11]}}, to_extend};

endmodule