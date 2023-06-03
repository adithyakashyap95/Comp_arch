// ID stage

`include "../rtl/struct.sv"

// USE STRUCTURES as in struct.sv

module id (
	input  logic 	clk,
	input  logic 	reset,
	input  logic    w_f_wb,                      // Write from WB stage 
	input  logic [31:0] inst,                    // from Inst Fetch stage
	input  logic [(ADDR_LINE_REG-1):0] addr_in_f_wb, // From WB stage
	input  logic [(D_SIZE-1):0] write_data_f_wb, // From WB stage
	input  logic [31:0] pc4_in_f_if,             // PC Value In from IF

	output logic [31:0] pc4_out_2_ex,
	output logic [5:0]  opcode_2_ex,
	output logic [31:0] rs_reg_value_2_ex,
	output logic [31:0] rt_reg_value_2_ex,
	output logic [4:0]  rd_add_value_2_ex,
	output logic [31:0] i_data_2_ex,

 	output logic branch_2_ex,
	output logic mem_read_2_ex,
	output logic mem_to_reg_2_ex,	
	output logic mem_write_2_ex
); 

mem_t [31:0] registers; // Defininig the set of registers used as variables, temporary ...
mem_t [31:0] registers_nxt; 
logic [5:0]  opcode;
logic [31:0] r_rs;
logic [31:0] r_rt;
logic [4:0] r_rd;
logic [31:0] i_rs;
logic [31:0] i_rt;
logic [15:0] i_imm;
logic [31:0] rs_reg_value;
logic [31:0] rt_reg_value;
logic [4:0]  rd_add_value;
logic [31:0] i_data;
logic branch;
logic mem_read;
logic mem_to_reg;
logic mem_write;

assign opcode = inst[31:26];

// R -instruction
assign r_rs  = registers[inst[25:21]];
assign r_rt  = registers[inst[20:16]];
assign r_rd  = inst[15:11];
assign r_rdt = inst[20:16];

// I -instruction
assign i_rs  = registers[inst[25:21]];
assign i_rt  = registers[inst[20:16]];

// Needs special attention as we get only 16 bit data which shoulf be prefixed to data
assign i_imm = (inst[15]==1'b1) ? {16'hFFFF,inst[15:0]} : {16'b0,inst[15:0]};

// instruction decode
always_comb
begin
	unique casez(opcode)
		6'b000000:begin 		// add
			rs_reg_value = r_rs;	
			rt_reg_value = r_rt;	
			rd_add_value = r_rd;	
			i_data       = '0;
			branch       = 0;
			mem_read     = 0;
			mem_to_reg   = 1; 	
			mem_write    = 0; 	
		end
		6'b000001:begin			// addi
			rs_reg_value = i_rs;	
			rt_reg_value = '0;	
			rd_add_value = r_rdt;	
			i_data 	     = i_imm;
			branch       = 0;
			mem_read     = 0;
			mem_to_reg   = 1; 	
			mem_write    = 0; 	
		end
		6'b000010:begin 		// sub
			rs_reg_value = r_rs;	
			rt_reg_value = r_rt;	
			rd_add_value = r_rd;	
			i_data 	     = '0;
			branch       = 0;
			mem_read     = 0;
			mem_to_reg   = 1; 	
			mem_write    = 0; 	
		end
		6'b000011:begin			// subi
			rs_reg_value = i_rs;	
			rt_reg_value = '0;	
			rd_add_value = r_rdt;	
			i_data 	     = i_imm;
			branch       = 0;
			mem_read     = 0;
			mem_to_reg   = 1; 	
			mem_write    = 0; 	
		end	
		6'b000100:begin			// mul
			rs_reg_value = r_rs;	
			rt_reg_value = r_rt;	
			rd_add_value = r_rd;	
			i_data 	     = '0;
			branch       = 0;
			mem_read     = 0;
			mem_to_reg   = 1; 	
			mem_write    = 0; 	
		end
		6'b000101:begin			// muli
			rs_reg_value = i_rs;	
			rt_reg_value = '0;	
			rd_add_value = r_rdt;	
			i_data 	     = i_imm;
			branch       = 0;
			mem_read     = 0;
			mem_to_reg   = 1; 	
			mem_write    = 0; 	
		end
		6'b000110:begin			// OR
			rs_reg_value = r_rs;	
			rt_reg_value = r_rt;	
			rd_add_value = r_rd;	
			i_data 	     = '0;
			branch       = 0;
			mem_read     = 0;
			mem_to_reg   = 1; 	
			mem_write    = 0; 	
		end
		6'b000111:begin			// ORI
			rs_reg_value = i_rs;	
			rt_reg_value = '0;	
			rd_add_value = r_rdt;	
			i_data 	     = i_imm;
			branch       = 0;
			mem_read     = 0;
			mem_to_reg   = 1; 	
			mem_write    = 0; 	
		end
		6'b001000:begin			// AND
			rs_reg_value = r_rs;	
			rt_reg_value = r_rt;	
			rd_add_value = r_rd;	
			i_data 	     = '0;
			branch       = 0;
			mem_read     = 0;
			mem_to_reg   = 1; 	
			mem_write    = 0; 	
		end
		6'b001001:begin			// ANDI
			rs_reg_value = i_rs;	
			rt_reg_value = '0;	
			rd_add_value = r_rdt;	
			i_data 	     = i_imm;
			branch       = 0;
			mem_read     = 0;
			mem_to_reg   = 1; 	
			mem_write    = 0; 	
		end
		6'b001010:begin			// XOR
			rs_reg_value = r_rs;	
			rt_reg_value = r_rt;	
			rd_add_value = r_rd;	
			i_data 	     = '0;
			branch       = 0;
			mem_read     = 0;
			mem_to_reg   = 1; 	
			mem_write    = 0; 	
		end
		6'b001011:begin			// XORI
			rs_reg_value = i_rs;	
			rt_reg_value = '0;	
			rd_add_value = r_rdt;	
			i_data 	     = i_imm;
			branch       = 0;
			mem_read     = 0;
			mem_to_reg   = 1; 	
			mem_write    = 0; 	
		end
		6'b001100:begin			// LDW
			rs_reg_value = i_rs;	
			rt_reg_value = '0;	
			rd_add_value = r_rdt;	
			i_data 	     = i_imm;
			branch       = 0;
			mem_read     = 1;
			mem_to_reg   = 1; 	
			mem_write    = 0; 	
		end
		6'b001101:begin			// STW
			rs_reg_value = i_rs;	
			rt_reg_value = '0;	
			rd_add_value = r_rdt;	
			i_data 	     = i_imm;
			branch       = 0;
			mem_read     = 0;
			mem_to_reg   = 0; 	
			mem_write    = 1; 	
		end
		6'b001110:begin			// BZ
			rs_reg_value = i_rs;	
			rt_reg_value = '0;	
			rd_add_value = '0;	
			i_data 	     = i_imm;
			branch       = 1;
			mem_read     = 0;
			mem_to_reg   = 0; 	
			mem_write    = 0; 	
		end
		6'b001111:begin			// BEQ
			rs_reg_value = i_rs;	
			rt_reg_value = i_rt;	
			rd_add_value = '0;	
			i_data 	     = i_imm;
			branch       = 1;
			mem_read     = 0;
			mem_to_reg   = 0; 	
			mem_write    = 0; 	
		end
		6'b010000:begin			// JR
			rs_reg_value = i_rs;	
			rt_reg_value = '0;	
			rd_add_value = '0;	
			i_data 	     = i_imm;
			branch       = 1;
			mem_read     = 0;
			mem_to_reg   = 0; 	
			mem_write    = 0; 	
		end
		6'b010001:begin			// HALT
			rs_reg_value = '0;	
			rt_reg_value = '0;	
			rd_add_value = '0;	
			i_data 	     = '0;
			branch       = 0;
			mem_read     = 0;
			mem_to_reg   = 0; 	
			mem_write    = 0; 	
		end
		  default:begin
			rs_reg_value = '0;	
			rt_reg_value = '0;	
			rd_add_value = '0;	
			i_data 	     = '0;
			branch       = 0;
			mem_read     = 0;
			mem_to_reg   = 0; 	
			mem_write    = 0; 	
		end
	endcase		
end

// Registers

always_ff@(posedge clk or negedge reset)
begin
	if(reset==0)
		registers <= '0;
	else
		registers <= registers_nxt;
end

always_comb
begin
	registers_nxt    = registers;
	registers_nxt[0] = 32'b0; // always Constant zero
	registers_nxt[addr_in_f_wb] = (w_f_wb == 1'b1) ? write_data_f_wb : registers_nxt[addr_in_f_wb]; 
end

// pipeline

always_ff@(posedge clk or negedge reset)
begin
	if(reset==0)
	begin
        	opcode_2_ex       <= '0; 
        	rs_reg_value_2_ex <= '0; 
        	rt_reg_value_2_ex <= '0; 
        	rd_add_value_2_ex <= '0; 
        	i_data_2_ex       <= '0; 
		pc4_out_2_ex	  <= '0;
		branch_2_ex  	  <= '0;
		mem_read_2_ex 	  <= '0;
		mem_to_reg_2_ex   <= '0;
		mem_write_2_ex 	  <= '0;
	end
	else
	begin
        	opcode_2_ex       <= opcode; 
        	rs_reg_value_2_ex <= rs_reg_value; 
        	rt_reg_value_2_ex <= rt_reg_value; 
        	rd_add_value_2_ex <= rd_add_value; 
        	i_data_2_ex       <= i_data; 
		pc4_out_2_ex	  <= pc4_in_f_if;
		branch_2_ex  	  <= branch;
		mem_read_2_ex 	  <= mem_read;
		mem_to_reg_2_ex   <= mem_to_reg;
		mem_write_2_ex 	  <= mem_write;
	end
end

endmodule

