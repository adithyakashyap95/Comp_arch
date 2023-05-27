// SV main.sv

`include "../rtl/struct.sv"

module main (
	input  logic 	clk,
	input  logic 	reset,
	input  logic 	valid,
	input  logic 	opr_finished
); 

// Logic for opr_control Module to all pipeline module
logic opr_1_to_f;	
logic opr_2_to_d;	
logic opr_3_to_ex;	
logic opr_4_to_m;	
logic opr_5_to_w;

// Data from EX stage to Mem Stage if needed
logic rw_f_ex;                     
logic [(ADDR_LINE-1):0] addr_in_f_ex;
logic [(D_SIZE-1):0] write_data_f_ex;
logic [(D_SIZE-1):0] read_data_f_ex; 

// Operation control
opr_ctrl i_opr (
	.clk		(clk		),
	.rstb		(reset		),
	.valid		(valid		),
	.opr_finished	(opr_finished	),
	.opr_1		(opr_1_to_f	),
	.opr_2		(opr_2_to_d	),
	.opr_3		(opr_3_to_ex	),
	.opr_4		(opr_4_to_m	),
	.opr_5		(opr_5_to_w	)
);

// Fetch

// Decode

// Execute E


// Memory

mem i_memory
(
	.clk		(clk		), 
	.reset		(reset		),
	.update		(opr_3_to_m	),
	.rw		(rw_f_ex	), 
	.addr_in	(addr_in_f_ex	), 
	.write_data	(write_data_f_ex), 
	.read_data	(read_data_f_ex	)
);

// Writeback


endmodule
