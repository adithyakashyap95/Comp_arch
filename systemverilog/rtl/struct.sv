
localparam INST_LINES = 'h400;             // 1024 lines in memeory image
localparam INST_BYTE  = 'h4;               // 4 Bytes instruction size
localparam INST_BIT   = INST_BYTE * 8;     // 32 bits of imstructions size
localparam ADDR_LINE  = 'd32;              // 32 bits address lines
localparam D_MEM      = 'h400;             // usually 2**ADDR_LINE , now limiting to 1024
localparam D_SIZE     = 'd32;              // Data size bits to 5 bits 

typedef struct packed {
	logic [(INST_BIT-1):0] inst;
} inst_t;

typedef struct packed {
	logic [(D_SIZE-1):0] mem;
} mem_t;

typedef struct packed {
	logic [5:0] opcode;
	logic [4:0] rs;
	logic [4:0] rt;
	logic [4:0] rd;
	logic [10:0] unused;
} r_type;

typedef struct packed {
	logic [5:0] opcode;
	logic [4:0] rs;
	logic [4:0] rt;
	logic [15:0] imm;
} i_type;

//typedef enum logic [(INST_BIT-1):0] {  
//	S0 = 2'b00,
//	S1 = 2'b01,
//	S2 = 2'b10,
//	S3 = 2'b11
//} enum_states;


