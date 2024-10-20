module CPU
(
    clk_i, 
    rst_i,
);

// Ports
input               clk_i;
input               rst_i;

// program counter
wire [31:0] pc_r; 
wire [31:0] pc_w;

wire [31:0] instruction;
// write back value
wire [31:0] WriteBack;
// sign extended value
wire [31:0] immediate;
wire [31:0] ALU_i_1;
wire [31:0] ALU_i_2;
wire [31:0] rs2_data;

// controls
wire [1:0] ALUOp;
wire ALUSrc;
wire RegWrite;
wire [2:0] ALUCtrl;

Control Control(
    .Opcode (instruction[6:0]),
    .ALUOp (ALUOp),
    .ALUSrc (ALUSrc),
    .RegWrite (RegWrite)
);

Adder Add_PC(
    .pc_i (pc_r),
    .value (32'd4),
    .pc_o (pc_w)
);

PC PC(
    .clk_i (clk_i),
    .rst_i (rst_i),
    .pc_i (pc_w),
    .pc_o (pc_r)
);

Instruction_Memory Instruction_Memory(
    .addr_i (pc_r),
    .instr_o (instruction)
);

Registers Registers(
    .rst_i (rst_i),
    .clk_i (clk_i),
    .RS1addr_i (instruction[19:15]),
    .RS2addr_i (instruction[24:20]),
    .RDaddr_i (instruction[11:7]),
    .RDdata_i (WriteBack),
    .RegWrite_i (RegWrite),
    .RS1data_o (ALU_i_1),   
    .RS2data_o (rs2_data)
);

MUX32 MUX_ALUSrc(
    .rs2_data (rs2_data),
    .immediate (immediate),
    .sel (ALUSrc),
    .ALU_i_2 (ALU_i_2)
);

Sign_Extend Sign_Extend(
    .to_extend (instruction[31:20]),
    .immediate (immediate)
);

ALU ALU(
    .ALU_i_1 (ALU_i_1),
    .ALU_i_2 (ALU_i_2),
    .sel (ALUCtrl),
    .ALU_result (WriteBack)
);

ALU_Control ALU_Control(
    .funct7 (instruction[31:25]),
    .funct3 (instruction[14:12]),
    .ALUOp (ALUOp),
    .ALUCtrl (ALUCtrl)
);

endmodule

