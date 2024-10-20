module Branch_Flush(
    clk_i,
    rst_i,
    predictWrong,
    branch_i,
    ID_pc_branch,
    EX_pc_4,
    EX_pc_branch,
    flush_o,
    IF_pc_branch,
    pcChoice,
    predict_i,
);

input clk_i;
input rst_i;
input branch_i;
input predictWrong;
input predict_i;
input [1:0] pcChoice;
input [31:0] ID_pc_branch;
input [31:0] EX_pc_4;
input [31:0] EX_pc_branch;

output flush_o;
output [31:0] IF_pc_branch;
assign flush_o = (predictWrong || (branch_i && predict_i))? 1: 0;
assign IF_pc_branch = (pcChoice == 2'd1)? (EX_pc_4+3'd4) : (pcChoice == 2'd2)? EX_pc_branch : ID_pc_branch;

endmodule