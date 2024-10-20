module CPU
(
    clk_i, 
    rst_i,
);

// Ports
input               clk_i;
input               rst_i;

// Wires
wire [31:0]         IF_pc_r;
wire [31:0]         IF_pc_w;
wire [31:0]         IF_pc_4;
wire [31:0]         IF_pc_branch;
wire [31:0]         IF_instruction;

// Control Signals
wire                IF_pcWrite;
wire                ID_FlushIF;
wire                ID_Branch;

// IF
PC PC(
    .clk_i (clk_i),
    .rst_i (rst_i),
    .pc_i (IF_pc_w),
    .PCWrite_i (IF_pcWrite),
    .pc_o (IF_pc_r)
);

Adder PC_Adder(
    .a (IF_pc_r),
    .b (32'd4),
    .out (IF_pc_4)
);

MUX32 PC_MUX(
    .a (IF_pc_4),
    .b (IF_pc_branch),
    .sel (ID_FlushIF),
    .out (IF_pc_w)
);

Instruction_Memory Instruction_Memory(
    .addr_i (IF_pc_r), 
    .instr_o (IF_instruction)
);

// IF/ID Pipeline Register

// wires
wire [31:0] ID_instruction;
wire [31:0] ID_immediate;
wire [31:0] ID_RS1data;
wire [31:0] ID_RS2data;
wire [31:0] ID_pc;

// Control Signals
wire                ID_Stall;
wire                ID_NoOp;
wire [1:0]          ID_ALUOp;
wire                ID_ALUSrc;
wire                ID_RegWrite;
wire                ID_MemtoReg;
wire                ID_MemRead;
wire                ID_MemWrite;

IF_ID_Register IF_ID_Register(
    .clk_i (clk_i),
    .rst_i (rst_i),
    .pc_i (IF_pc_r),
    .pc_o (ID_pc),
    .Stall (ID_Stall),
    .Flush (ID_FlushIF),
    .instruction_i (IF_instruction),
    .instruction_o (ID_instruction)
);

Immediate_Gen Immediate_Gen(
    .instruction (ID_instruction),
    .immediate (ID_immediate)
);

Adder Branch_Adder(
    .a (ID_pc),
    .b (ID_immediate),
    .out (IF_pc_branch)
);

Registers Registers(
    .clk_i (clk_i),
    .rst_i (rst_i),
    .RS1addr_i (ID_instruction[19:15]),
    .RS2addr_i (ID_instruction[24:20]),
    .RDaddr_i (WB_RDaddr),
    .RDdata_i (WB_WriteData),
    .RegWrite_i (WB_RegWrite),
    .RS1data_o (ID_RS1data),
    .RS2data_o (ID_RS2data)
);

Control Control(
    .Opcode (ID_instruction[6:0]),
    .NoOp (ID_NoOp),
    .ALUOp (ID_ALUOp),
    .ALUSrc (ID_ALUSrc),
    .RegWrite (ID_RegWrite),
    .MemtoReg (ID_MemtoReg),
    .MemRead (ID_MemRead),
    .MemWrite (ID_MemWrite),
    .Branch_o (ID_Branch)
);

assign ID_FlushIF = ID_Branch & (ID_RS1data == ID_RS2data);

// wires
wire [31:0]         EX_RS1data;
wire [31:0]         EX_RS2data;
wire [31:0]         EX_immediate;
wire [6:0]          EX_funct7;
wire [2:0]          EX_funct3;
wire [4:0]          EX_RS1addr;
wire [4:0]          EX_RS2addr;
wire [4:0]          EX_RDaddr;
wire [31:0]         ForwardA_out;
wire [31:0]         ForwardB_out;
wire [31:0]         EX_ALU_A;
wire [31:0]         EX_ALU_B;
wire [31:0]         EX_ALUResult;

// Control Signals
wire                EX_RegWrite;
wire                EX_MemtoReg;
wire                EX_MemRead;
wire                EX_MemWrite;
wire [1:0]          EX_ALUOp;
wire                EX_ALUSrc;
wire [1:0]          ForwardA;
wire [1:0]          ForwardB;
wire [2:0]          ALUCtrl;

// ID/EX Pipeline Register
ID_EX_Register ID_EX_Register(
    .clk_i (clk_i),
    .rst_i (rst_i),
    .RegWrite_i (ID_RegWrite),
    .MemtoReg_i (ID_MemtoReg),
    .MemRead_i (ID_MemRead),
    .MemWrite_i (ID_MemWrite), 
    .ALUOp_i (ID_ALUOp),
    .ALUSrc_i (ID_ALUSrc),
    .RS1data_i (ID_RS1data),
    .RS2data_i (ID_RS2data),
    .immediate_i (ID_immediate),
    .funct7_i (ID_instruction[31:25]),
    .funct3_i (ID_instruction[14:12]),
    .RS1addr_i (ID_instruction[19:15]),
    .RS2addr_i (ID_instruction[24:20]),
    .RDaddr_i (ID_instruction[11:7]),
    .RegWrite_o (EX_RegWrite),
    .MemtoReg_o (EX_MemtoReg),
    .MemRead_o (EX_MemRead),
    .MemWrite_o (EX_MemWrite), 
    .ALUOp_o (EX_ALUOp),
    .ALUSrc_o (EX_ALUSrc),
    .RS1data_o (EX_RS1data),
    .RS2data_o (EX_RS2data),
    .immediate_o (EX_immediate),
    .funct7_o (EX_funct7),
    .funct3_o (EX_funct3),
    .RS1addr_o (EX_RS1addr),
    .RS2addr_o (EX_RS2addr),
    .RDaddr_o (EX_RDaddr)
);

Forward_Mux Forward_Mux_1(
    .a (EX_RS1data),
    .b (WB_WriteData),
    .c (MEM_ALUResult),
    .Forward (ForwardA),
    .out (ForwardA_out)
);

Forward_Mux Forward_Mux_2(
    .a (EX_RS2data),
    .b (WB_WriteData),
    .c (MEM_ALUResult),
    .Forward (ForwardB),
    .out (ForwardB_out)
);

MUX32 EX_ALU_MUX(
    .a (ForwardB_out),
    .b (EX_immediate),
    .sel (EX_ALUSrc),
    .out (EX_ALU_B)
);

ALU_Control ALU_Control(
    .funct7 (EX_funct7),
    .funct3 (EX_funct3),
    .ALUOp (EX_ALUOp),
    .ALUCtrl (ALUCtrl)
);

ALU ALU(
    .a (ForwardA_out),
    .b (EX_ALU_B),
    .ALUCtrl (ALUCtrl),
    .out (EX_ALUResult)
);

// wires
wire [31:0] MEM_ALUResult;
wire [31:0] MEM_RS2data;
wire [31:0] MEM_RS1data;
wire [31:0] MEM_WriteData;
wire [31:0] MEM_ReadData;
wire [4:0] MEM_RDaddr;



// Control Signals
wire                MEM_RegWrite;
wire                MEM_MemtoReg;
wire                MEM_MemRead;
wire                MEM_MemWrite;

// EX/MEM Pipeline Register
EX_MEM_Register EX_MEM_Register(
    .clk_i (clk_i),
    .rst_i (rst_i),
    .RegWrite_i (EX_RegWrite),
    .MemtoReg_i (EX_MemtoReg),
    .MemRead_i (EX_MemRead),
    .MemWrite_i (EX_MemWrite),
    .ALUResult_i (EX_ALUResult),
    .RS2data_i (ForwardB_out),
    .RDaddr_i (EX_RDaddr),
    .RegWrite_o (MEM_RegWrite),
    .MemtoReg_o (MEM_MemtoReg),
    .MemRead_o (MEM_MemRead),
    .MemWrite_o (MEM_MemWrite),
    .ALUResult_o (MEM_ALUResult),
    .RS2data_o (MEM_RS2data),
    .RDaddr_o (MEM_RDaddr)
);

Data_Memory Data_Memory(
    .clk_i (clk_i),
    .addr_i (MEM_ALUResult),
    .MemRead_i (MEM_MemRead),
    .MemWrite_i (MEM_MemWrite),
    .data_i (MEM_RS2data),
    .data_o (MEM_ReadData)
);

// wires
wire [31:0] WB_ALUresult;
wire [31:0] WB_ReadData;
wire [4:0] WB_RDaddr;
wire [31:0] WB_WriteData;

// Control Signals
wire                WB_RegWrite;
wire                WB_MemtoReg;

// MEM/WB Pipeline Register
MEM_WB_Register MEM_WB_Register(
    .clk_i (clk_i),
    .rst_i (rst_i),
    .RegWrite_i (MEM_RegWrite),
    .MemToReg_i (MEM_MemtoReg),
    .ALUResult_i (MEM_ALUResult),
    .ReadData_i (MEM_ReadData),
    .RDaddr_i (MEM_RDaddr),
    .RegWrite_o (WB_RegWrite),
    .MemToReg_o (WB_MemtoReg),
    .ALUResult_o (WB_ALUresult),
    .ReadData_o (WB_ReadData),
    .RDaddr_o (WB_RDaddr)
);

MUX32 WB_WriteData_MUX(
    .a (WB_ALUresult),
    .b (WB_ReadData),
    .sel (WB_MemtoReg),
    .out (WB_WriteData)
);

// hazard detection
Hazard_Detection Hazard_Detection(
    .RS1addr_i (ID_instruction[19:15]),
    .RS2addr_i (ID_instruction[24:20]),
    .MemRead (EX_MemRead),
    .RDaddr_i (EX_RDaddr),
    .PCWrite (IF_pcWrite),
    .Stall_o (ID_Stall),
    .NoOp (ID_NoOp)
);

// Forwarding Unit
Forwarding_Unit Forwarding_Unit(
    .MEM_RegWrite (MEM_RegWrite),
    .MEM_Rd (MEM_RDaddr),
    .Ex_Rs1 (EX_RS1addr),
    .Ex_Rs2 (EX_RS2addr),
    .WB_RegWrite (WB_RegWrite),
    .WB_Rd (WB_RDaddr),
    .Forward_A (ForwardA),
    .Forward_B (ForwardB)
);

endmodule