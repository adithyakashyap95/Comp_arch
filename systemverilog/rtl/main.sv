// SV main.sv

`include "../rtl/struct.sv"

module main (
	input  logic 	clk,
	input  logic 	reset,
	input  logic 	valid,
	input  logic 	opr_finished
); 

// IF stage
logic hazard;
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

// Fetch
inst_f i_inst_fetch (
	.clk         	 (clk         	), 
	.rst         	 (reset        	),
	.hazard      	 (hazard      	),   // Not connected
	.instruction 	 (inst          ),
	.ex_add      	 (pc4_out_2_if  ),
	.pc_out      	 (pc4_f_if_2_id ) 
);

// Decode

id i_decode(
	.clk               (clk               ), 
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
	.mem_write_2_ex	   (mem_write_2_ex    ) 
); 

// Execute E

alu i_ex(
	.clk                (clk             ),  
	.reset              (reset           ),  
	.op                 (opcode_2_ex     ),    
	.rs                 (rs_reg_value_2_ex),   
	.rt                 (rt_reg_value_2_ex),    
	.imm                (i_data_2_ex     ),    
	.pc4_out_2_ex       (pc4_in_f_id_2_ex),  
	.i_data_2_ex        (i_data_2_ex     ), 
	.rd                 (write_data_f_ex ),   
	.A                  (addr_in_f_ex    ),   
	.pc4_out_2_ex_out   (pc4_out_2_if    )
);

// FIXME :  EX stage should foreward the destination register as well
// FIXME :  EX stage should foreward the ctrl registers mem_write, mem_red and mem_to_reg after pipelining 

// Memory

mem i_memory (
	.clk                	(clk                	),
	.reset              	(reset              	),
	.mem_write          	(mem_write          	),
	.mem_read           	(mem_read           	),
	.mem_to_reg         	(mem_to_reg         	), 
	.addr_in            	(addr_in_f_ex         	),  
	.addr_reg_in        	(addr_reg_in_f_ex      	),
	.write_data         	(write_data_f_ex       	),
	.mem_to_reg_2_wb    	(mem_to_reg_f_mem    	), 
	.alu_out_f_mem_2_wb 	(alu_out_f_mem_2_wb 	),
	.alu_add_f_mem_2_wb 	(alu_add_f_mem_2_wb 	)
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
