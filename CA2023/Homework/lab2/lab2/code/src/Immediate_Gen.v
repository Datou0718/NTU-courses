module Immediate_Gen(
    instruction,
    immediate
);

input [31:0] instruction;
output signed [31:0] immediate;

reg [31:0] immediate;

initial
begin
    immediate <= 0;
end

always @(*)
begin
    if(instruction[6:0] == 7'b0010011)
    begin
        if(instruction[14:12] == 3'b000)
        begin
            immediate <={{20{instruction[31]}}, instruction[31:20]};
        end
        else if(instruction[14:12] == 3'b101)
        begin
            immediate <= {{27{instruction[24]}}, instruction[24:20]};
        end
    end 
    if(instruction[6:0] == 7'b0000011)
    begin
        immediate <= {{20{instruction[31]}}, instruction[31:20]};
    end
    if(instruction[6:0] == 7'b0100011)
    begin
        immediate <= {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
    end
    if(instruction[6:0] == 7'b1100011)
    begin
        immediate <= {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
    end
end

endmodule