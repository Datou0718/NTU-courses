module IF_ID_Register(
    clk_i, 
    rst_i,
    pc_i,
    pc_o,
    instruction_i,
    instruction_o,
    Stall,
    Flush,
);

input clk_i;
input rst_i;
input [31:0] pc_i;
input [31:0] instruction_i;
input Stall;
input Flush;

output [31:0] pc_o;
output [31:0] instruction_o;

reg [31:0] pc_o;
reg [31:0] instruction_o;

initial
begin
    pc_o <= 0;
    instruction_o <= 0;
end

always @(posedge clk_i, negedge rst_i)
begin
    if (!rst_i || Flush)
    begin
        pc_o <= 0;
        instruction_o <= 0;
    end
    else if (!Stall)
    begin
        pc_o <= pc_i;
        instruction_o <= instruction_i;
        
    end
end

endmodule