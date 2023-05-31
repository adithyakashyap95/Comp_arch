// SV main.sv

`include "../rtl/struct.sv"

module main (
	input  logic 	clk,
	input  logic 	reset,
	input  logic 	valid,
	input  logic 	opr_finished
); 

// Do I need this ?
// Logic for opr_control Module to all pipeline module
//logic opr_1_to_f;	
//logic opr_2_to_d;	
//logic opr_3_to_ex;	
//logic opr_4_to_m;	
//logic opr_5_to_w;

// IF stage
logic hazard;
logic [31:0] add_f_ex_2_id;
logic [31:0] pc_f_ex_2_id;
logic [31:0] pc4_f_if_2_id;

// Input to ID state and Output from ID state
logic w_f_wb;                         // Write from WB stage 
logic [31:0] inst;                    // from Inst Fetch stage
logic [31:0] pc_in_f_if_2_id;         // from Inst Fetch stage
logic [(ADDR_LINE-1):0] addr_in_f_wb; // From WB stage
logic [(D_SIZE-1):0] write_data_f_wb; // From WB stage

logic [31:0] pc_in_f_id_2_ex;         // from Inst decode stage
logic [31:0] pc4_in_f_id_2_ex;         // from Inst decode stage
logic [5:0]  opcode_2_ex;
logic [31:0] rs_reg_value_2_ex;
logic [31:0] rt_reg_value_2_ex;
logic [31:0] rd_reg_value_2_ex;
logic [31:0] i_data_2_ex;


// Data from EX stage to Mem Stage if needed
logic rw_f_ex;                     
logic [(ADDR_LINE-1):0] addr_in_f_ex;
logic [(D_SIZE-1):0] write_data_f_ex;
logic [(D_SIZE-1):0] read_data_f_ex; 

// Operation control
// opr_ctrl i_opr (
// 	.clk		(clk		),
// 	.rstb		(reset		),
// 	.valid		(valid		),
// 	.opr_finished	(opr_finished	),
// 	.opr_1		(opr_1_to_f	),
// 	.opr_2		(opr_2_to_d	),
// 	.opr_3		(opr_3_to_ex	),
// 	.opr_4		(opr_4_to_m	),
// 	.opr_5		(opr_5_to_w	)
// );

// Fetch
inst_f i_inst_fetch (
	.clk         	 (clk         	), 
	.rst         	 (reset        	),
	.hazard      	 (hazard      	),   // Not connected
	.pc_out1     	 (pc_f_ex_2_id  ),
	.address     	 (address       ),   // Not required FIXME
	.instruction 	 (instruction   ),
	.ex_add      	 (add_f_ex_2_id ),
	.pc_out      	 (pc_in_f_if_2_id), 
	.pc4         	 (pc4_f_if_2_id)
);


// Decode
id i_decode(
	.clk               (clk               ), 
	.reset             (reset             ), 
	.w_f_wb            (w_f_wb            ),
	.pc_in_f_if        (pc_in_f_if_2_id   ),
	.inst              (inst              ),
	.addr_in_f_wb      (addr_in_f_wb      ), 
	.write_data_f_wb   (write_data_f_wb   ),
	.pc4_in_f_if	   (pc4_f_if_2_id     ),
	.pc4_out_2_ex      (pc4_in_f_id_2_ex  ),
	.pc_in_2_ex        (pc_in_f_id_2_ex   ),
	.opcode_2_ex       (opcode_2_ex       ),
	.rs_reg_value_2_ex (rs_reg_value_2_ex ),
	.rt_reg_value_2_ex (rt_reg_value_2_ex ),
	.rd_reg_value_2_ex (rd_reg_value_2_ex ),
	.i_data_2_ex       (i_data_2_ex       )
); 


// Execute E
	// GIVE PC4 to EX stage 


// Memory

mem i_memory
(
	.clk		(clk		), 
	.reset		(reset		),
	.rw		(rw_f_ex	), 
	.addr_in	(addr_in_f_ex	), 
	.write_data	(write_data_f_ex), 
	.read_data	(read_data_f_ex	)
);

// Writeback


endmodule
