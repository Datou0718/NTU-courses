module Forwarding_Unit(
    MEM_RegWrite,
    MEM_Rd,
    Ex_Rs1,
    Ex_Rs2,
    WB_RegWrite,
    WB_Rd,
    Forward_A,
    Forward_B,
);

input MEM_RegWrite;
input [4:0] MEM_Rd;
input [4:0] Ex_Rs1;
input [4:0] Ex_Rs2;
input WB_RegWrite;
input [4:0] WB_Rd;

output [1:0] Forward_A;
output [1:0] Forward_B;

reg [1:0] Forward_A;
reg [1:0] Forward_B;

initial
begin
    Forward_A <= 2'b00;
    Forward_B <= 2'b00;
end

always @(*)
begin
    if (MEM_RegWrite && (MEM_Rd != 0) && (MEM_Rd == Ex_Rs1))
        Forward_A <= 2'b10;
    else if (WB_RegWrite && (WB_Rd != 0) && (WB_Rd == Ex_Rs1))
        Forward_A <= 2'b01;
    else
        Forward_A <= 2'b00;
    
    if (MEM_RegWrite && (MEM_Rd != 0) && (MEM_Rd == Ex_Rs2))
        Forward_B <= 2'b10;
    else if (WB_RegWrite && (WB_Rd != 0) && (WB_Rd == Ex_Rs2))
        Forward_B <= 2'b01;
    else
        Forward_B <= 2'b00;
end

endmodule