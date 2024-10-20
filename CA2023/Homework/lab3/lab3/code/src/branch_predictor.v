module branch_predictor(
    clk,
    rst,
    IF_ID_branch,
    ID_EX_branch,
    ALUResult,
    predictWrong,
    predictPC,
    predict_o,
);

input clk;
input rst;
input IF_ID_branch;
input ID_EX_branch;
input unsigned [31:0] ALUResult;

output predictWrong;
output [1:0] predictPC;
output predict_o;

wire predict_o;
reg [1:0] predictorState;
// 0: strongly taken
// 1: weakly taken
// 2: weakly non-taken
// 3: strongly non-taken


initial
begin
    predictorState <= 0;
end

assign predict_o = (predictorState == 0 || predictorState == 1);
assign predictWrong = ID_EX_branch && ((predictorState == 0 || predictorState == 1) && (ALUResult != 0) || (predictorState == 2 || predictorState == 3) && (ALUResult == 0));
assign predictPC = (predictWrong && ALUResult != 0)? 2'd1 : (predictWrong && ALUResult == 0)? 2'd2 : 2'd0;

always @(posedge clk, negedge rst)
begin
    if (!rst) // reset
    begin
        predictorState <= 0;
    end
    else // new cycle
    begin
        if(ID_EX_branch == 1) // verify
        begin
            if(predictorState == 0 || predictorState == 1) // taken
            begin
                if(ALUResult == 0) // indeed taken
                begin
                    predictorState <= 0;
                end
                else // verify wrong
                begin
                    predictorState <= predictorState + 1;
                end
            end
            else // non-taken
            begin
                if(ALUResult == 0) // verify wrong
                begin
                    predictorState <= predictorState - 1;
                end
                else // indeed non-taken
                begin
                    predictorState <= 3;
                end
            end
        end
    end
end

endmodule