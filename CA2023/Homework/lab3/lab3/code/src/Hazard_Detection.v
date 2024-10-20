module Hazard_Detection(
    RS1addr_i,
    RS2addr_i,
    MemRead,
    RDaddr_i,
    PCWrite,
    Stall_o,
    NoOp,
);

input [4:0] RS1addr_i;
input [4:0] RS2addr_i;
input MemRead;
input [4:0] RDaddr_i;

output PCWrite;
output Stall_o;
output NoOp;

reg PCWrite;
reg Stall_o;
reg NoOp;

initial
begin
    PCWrite <= 0;
    Stall_o <= 0;
    NoOp <= 0;
end

always @(*)
begin
    if (MemRead && ((RS1addr_i == RDaddr_i) || (RS2addr_i == RDaddr_i)))
    begin
        PCWrite <= 0;
        Stall_o <= 1;
        NoOp <= 1;
    end
    else
    begin
        PCWrite <= 1;
        Stall_o <= 0;
        NoOp <= 0;
    end
end

endmodule