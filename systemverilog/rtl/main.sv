// SV main.sv

`include "../rtl/struct.sv"

module main (
	input  logic 	clk,
	input  logic 	clk1,
	input  logic 	reset,
	input  logic 	valid,
	input  logic 	opr_finished,
	output logic [31:0] inst_out,
    output logic [15:0] arith_inst_cnt,
    output logic [15:0] logic_inst_cnt,
    output logic [15:0] mem_inst_cnt,
    output logic [15:0] ctrl_inst_cnt,
    output mem_t [31:0] registers_out,
    output logic [31:0] pc_out, 
	output logic [31:0] stall_wo_forewarding,
	output logic [31:0] stall_w_forewarding,
    output logic [(D_SIZE-1):0] mem_out [0:1023]
 
); 

// IF stage
logic [31:0] add_f_ex_2_id;
logic [31:0] pc4_f_if_2_id;
logic [31:0] pc4_out_2_if;

// Input to ID state and Output from ID state
logic [31:0] inst;                    // from Inst Fetch stage

logic [31:0] pc4_in_f_id_2_ex;         // from Inst decode stage
logic [5:0]  opcode_2_ex;
logic [31:0] rs_reg_value_2_ex;
logic [31:0] rt_reg_value_2_ex;
logic [4:0]  rd_add_value_2_ex;
logic [31:0] i_data_2_ex;
logic [4:0] id_dest;
logic [4:0] ex_dest;
logic [4:0] mem_dest;

logic branch_2_ex;
logic mem_read_2_ex;
logic mem_to_reg_2_ex;	
logic mem_write_2_ex;

// Data from EX stage to Mem Stage if needed
logic [(ADDR_LINE_MEM-1):0] addr_in_f_ex;
logic [(ADDR_LINE_REG-1):0] addr_reg_in_f_ex;
logic [(D_SIZE-1):0] write_data_f_ex;

// WB stage
logic                       mem_to_reg_f_mem;
logic [(D_SIZE-1):0]        alu_out_f_mem_2_wb;
logic [(ADDR_LINE_REG-1):0] alu_add_f_mem_2_wb; 
logic                       mem_to_reg_f_wb_to_id;
logic [(D_SIZE-1):0]        reg_data_f_wb_id;
logic [(ADDR_LINE_REG-1):0] reg_addr_f_wb_id;

logic [4:0]  rs_add_value_2_if;
logic [4:0]  rd_add_value_2_if;
logic [4:0]  rt_add_value_2_if;

// Just assigning output to testbench
assign inst_out = inst;
assign pc_out = pc4_f_if_2_id + 4;

// Fetch
inst_f i_inst_fetch (
	.clk         	 (clk         	), 
	.rst         	 (reset        	),
	.ex_add      	 (pc4_out_2_if  ),
	.instruction 	 (inst          ),
	.pc_out      	 (pc4_f_if_2_id ),
    .reg_write_f_ex  (mem_to_reg    ),
    .reg_write_f_id  (mem_to_reg_2_ex),
    .reg_write_f_mem (mem_to_reg_f_mem), 
    .id_dest         (rd_add_value_2_ex),
    .ex_dest         (addr_reg_in_f_ex),
    .mem_dest        (alu_add_f_mem_2_wb),
	.rs_f_id	     (rs_add_value_2_if),
	.rd_f_id	     (rd_add_value_2_if),
	.rt_f_id	     (rt_add_value_2_if),
	.stall_wo_forewarding (stall_wo_forewarding),
	.stall_w_forewarding  (stall_w_forewarding)
);

// Decode

id i_decode(
	.clk               (clk1              ), 
	.clk1              (clk               ), 
	.reset             (reset             ), 
	.w_f_wb            (mem_to_reg_f_wb_to_id),
	.inst              (inst              ),
	.addr_in_f_wb      (reg_addr_f_wb_id  ), 
	.write_data_f_wb   (reg_data_f_wb_id  ),
	.pc4_in_f_if	   (pc4_f_if_2_id     ),
	.pc4_out_2_ex      (pc4_in_f_id_2_ex  ),
	.opcode_2_ex       (opcode_2_ex       ),
	.rs_reg_value_2_ex (rs_reg_value_2_ex ),
	.rt_reg_value_2_ex (rt_reg_value_2_ex ),
	.rd_add_value_2_ex (rd_add_value_2_ex ),
	.i_data_2_ex       (i_data_2_ex       ),
	.branch_2_ex	   (branch_2_ex	      ), 
	.mem_read_2_ex	   (mem_read_2_ex     ), 
	.mem_to_reg_2_ex   (mem_to_reg_2_ex   ), 
	.mem_write_2_ex	   (mem_write_2_ex    ), 
	.rs_add_value_2_if (rs_add_value_2_if ),
	.rd_add_value_2_if (rd_add_value_2_if ),
	.rt_add_value_2_if (rt_add_value_2_if ),
    .arith_inst_cnt    (arith_inst_cnt    ),
    .logic_inst_cnt    (logic_inst_cnt    ),
    .mem_inst_cnt      (mem_inst_cnt      ),
    .ctrl_inst_cnt     (ctrl_inst_cnt     ),
    .registers_out     (registers_out     ) 
); 

// Execute E

alu i_ex(
	.clk                (clk1            ),  
	.reset              (reset           ),  
	.op                 (opcode_2_ex     ),    
	.rs                 (rs_reg_value_2_ex),   
	.rt                 (rt_reg_value_2_ex),    
	.pc4_out_2_ex       (pc4_in_f_id_2_ex),  
	.i_data_2_ex        (i_data_2_ex     ), 
	.rd                 (write_data_f_ex ),   
	.A                  (addr_in_f_ex    ),   
	.pc4_out_2_ex_out   (pc4_out_2_if    ),
        .mem_read_2_ex      (mem_read_2_ex   ),    
        .mem_to_reg_2_ex    (mem_to_reg_2_ex ),       	
        .mem_write_2_ex     (mem_write_2_ex  ),  
        .rd_add_value_2_ex  (rd_add_value_2_ex),  

        .mem_read_2_mem     (mem_read        ),       
        .mem_to_reg_2_mem   (mem_to_reg      ),       
        .mem_write_2_mem    (mem_write       ),       
        .rd_add_value_2_mem (addr_reg_in_f_ex)
);

// Memory

mem i_memory (
	.clk                	(clk1               	),
	.reset              	(reset              	),
	.mem_write          	(mem_write          	),
	.mem_read           	(mem_read           	),
	.mem_to_reg         	(mem_to_reg         	), 
	.addr_in            	(addr_in_f_ex         	),  
	.addr_reg_in        	(addr_reg_in_f_ex      	),
	.write_data         	(write_data_f_ex       	),
	.mem_to_reg_2_wb    	(mem_to_reg_f_mem    	), 
	.alu_out_f_mem_2_wb 	(alu_out_f_mem_2_wb 	),
	.alu_add_f_mem_2_wb 	(alu_add_f_mem_2_wb 	),
	.mem_out                (mem_out 				)
);

// Writeback
wb i_writeback (
	.mem_to_reg_f_mem	(mem_to_reg_f_mem	), 
	.alu_out_f_mem_2_wb  	(alu_out_f_mem_2_wb  	), 
	.alu_add_f_mem_2_wb 	(alu_add_f_mem_2_wb 	), 
	.mem_to_reg_f_wb_to_id	(mem_to_reg_f_wb_to_id	), 
	.reg_data_f_wb_id	(reg_data_f_wb_id	), 
	.reg_addr_f_wb_id 	(reg_addr_f_wb_id 	)
);

endmodule
