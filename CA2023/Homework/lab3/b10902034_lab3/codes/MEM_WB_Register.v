module MEM_WB_Register(
    clk_i, 
    rst_i,
    RegWrite_i,
    MemToReg_i,
    ALUResult_i,
    ReadData_i,
    RDaddr_i,
    RegWrite_o,
    MemToReg_o,
    ALUResult_o,
    ReadData_o,
    RDaddr_o
);

input clk_i;
input rst_i;
input RegWrite_i;
input MemToReg_i;
input [31:0] ALUResult_i;
input [31:0] ReadData_i;
input [4:0] RDaddr_i;

output RegWrite_o;
output MemToReg_o;
output [31:0] ALUResult_o;
output [31:0] ReadData_o;
output [4:0] RDaddr_o;

reg RegWrite_o;
reg MemToReg_o;
reg [31:0] ALUResult_o;
reg [31:0] ReadData_o;
reg [4:0] RDaddr_o;

initial
begin
    RegWrite_o <= 0;
    MemToReg_o <= 0;
    ALUResult_o <= 0;
    ReadData_o <= 0;
    RDaddr_o <= 0;
end

always @(posedge clk_i, negedge rst_i)
begin
    RegWrite_o <= RegWrite_i;
    MemToReg_o <= MemToReg_i;
    ALUResult_o <= ALUResult_i;
    ReadData_o <= ReadData_i;
    RDaddr_o <= RDaddr_i;
end

endmodule