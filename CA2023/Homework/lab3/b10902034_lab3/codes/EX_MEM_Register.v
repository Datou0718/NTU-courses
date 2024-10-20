module EX_MEM_Register(
    clk_i,
    rst_i,
    RegWrite_i,
    MemtoReg_i,
    MemRead_i,
    MemWrite_i, 
    ALUResult_i,
    RS2data_i,
    RDaddr_i,
    RegWrite_o,
    MemtoReg_o,
    MemRead_o,
    MemWrite_o,
    ALUResult_o,
    RS2data_o,
    RDaddr_o,
);

input clk_i;
input rst_i;
input RegWrite_i;
input MemtoReg_i;
input MemRead_i;
input MemWrite_i;
input [31:0] ALUResult_i;
input [31:0] RS2data_i;
input [4:0] RDaddr_i;

output RegWrite_o;
output MemtoReg_o;
output MemRead_o;
output MemWrite_o;
output [31:0] ALUResult_o;
output [31:0] RS2data_o;
output [4:0] RDaddr_o;

reg RegWrite_o;
reg MemtoReg_o;
reg MemRead_o;
reg MemWrite_o;
reg [31:0] ALUResult_o;
reg [31:0] RS2data_o;
reg [4:0] RDaddr_o;

initial 
begin
    RegWrite_o <= 0;
    MemtoReg_o <= 0;
    MemRead_o <= 0;
    MemWrite_o <= 0;
    ALUResult_o <= 0;
    RS2data_o <= 0;
    RDaddr_o <= 0;
end

always @(posedge clk_i, negedge rst_i)
begin
    RegWrite_o <= RegWrite_i;
    MemtoReg_o <= MemtoReg_i;
    MemRead_o <= MemRead_i;
    MemWrite_o <= MemWrite_i;
    ALUResult_o <= ALUResult_i;
    RS2data_o <= RS2data_i;
    RDaddr_o <= RDaddr_i;
end

endmodule