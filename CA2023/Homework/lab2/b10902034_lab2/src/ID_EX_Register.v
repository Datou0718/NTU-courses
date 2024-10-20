module ID_EX_Register(
    clk_i, 
    rst_i,
    RegWrite_i,
    MemtoReg_i,
    MemRead_i,
    MemWrite_i, 
    ALUOp_i,
    ALUSrc_i,
    RS1data_i,
    RS2data_i,
    immediate_i,
    funct7_i,
    funct3_i,
    RS1addr_i,
    RS2addr_i,
    RDaddr_i,
    RegWrite_o,
    MemtoReg_o,
    MemRead_o,
    MemWrite_o,
    ALUOp_o,
    ALUSrc_o,
    RS1data_o,
    RS2data_o,
    immediate_o,
    funct7_o,
    funct3_o,
    RS1addr_o,
    RS2addr_o,
    RDaddr_o,   
);

input clk_i;
input rst_i;
input RegWrite_i;
input MemtoReg_i;
input MemRead_i;
input MemWrite_i;
input [1:0] ALUOp_i;
input ALUSrc_i;
input [31:0] RS1data_i;
input [31:0] RS2data_i;
input [31:0] immediate_i;
input [6:0] funct7_i;
input [2:0] funct3_i;
input [4:0] RS1addr_i;
input [4:0] RS2addr_i;
input [4:0] RDaddr_i;

output RegWrite_o;
output MemtoReg_o;
output MemRead_o;
output MemWrite_o;
output [1:0] ALUOp_o;
output ALUSrc_o;
output [31:0] RS1data_o;
output [31:0] RS2data_o;
output [31:0] immediate_o;
output [6:0] funct7_o;
output [2:0] funct3_o;
output [4:0] RS1addr_o;
output [4:0] RS2addr_o;
output [4:0] RDaddr_o;

reg RegWrite_o;
reg MemtoReg_o;
reg MemRead_o;
reg MemWrite_o;
reg [1:0] ALUOp_o;
reg ALUSrc_o;
reg [31:0] RS1data_o;
reg [31:0] RS2data_o;
reg [31:0] immediate_o;
reg [6:0] funct7_o;
reg [2:0] funct3_o;
reg [4:0] RS1addr_o;
reg [4:0] RS2addr_o;
reg [4:0] RDaddr_o;

initial
begin
    RegWrite_o <= 0;
    MemtoReg_o <= 0;
    MemRead_o <= 0;
    MemWrite_o <= 0;
    ALUOp_o <= 0;
    ALUSrc_o <= 0;
    RS1data_o <= 0;
    RS2data_o <= 0;
    immediate_o <= 0;
    funct7_o <= 0;
    funct3_o <= 0;
    RS1addr_o <= 0;
    RS2addr_o <= 0;
    RDaddr_o <= 0;
end

always @(posedge clk_i, negedge rst_i)
begin
    RegWrite_o <= RegWrite_i;
    MemtoReg_o <= MemtoReg_i;
    MemRead_o <= MemRead_i;
    MemWrite_o <= MemWrite_i;
    ALUOp_o <= ALUOp_i;
    ALUSrc_o <= ALUSrc_i;
    RS1data_o <= RS1data_i;
    RS2data_o <= RS2data_i;
    immediate_o <= immediate_i;
    funct7_o <= funct7_i;
    funct3_o <= funct3_i;
    RS1addr_o <= RS1addr_i;
    RS2addr_o <= RS2addr_i;
    RDaddr_o <= RDaddr_i;
end

endmodule