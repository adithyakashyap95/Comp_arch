// Instruction fetch stage

`include "../rtl/struct.sv"

module inst_f (
	input  logic clk,
	input  logic rst,
	input  logic [31:0] ex_add,
	input logic [4:0] id_dest,
	input logic [4:0] ex_dest,
	input logic [4:0] mem_dest,
	input logic [4:0] rs_f_id,
	input logic [4:0] rd_f_id,
	input logic [4:0] rt_f_id,
	input logic reg_write_f_id, 
	input logic reg_write_f_ex, 
	input logic reg_write_f_mem, 
	
	output logic [31:0] instruction,
	output logic [31:0] stall_wo_forewarding,
	output logic [31:0] stall_w_forewarding,
	output logic [31:0] pc_out
);
bit id_stall;
bit ex_stall;
bit mem_stall;
logic [4:0] id_dest_minus1;
logic [4:0] ex_dest_minus2;
logic [4:0] mem_dest_minus3;
logic opcode;
logic halt;
logic hazard;
logic [4:0] rs;
logic [4:0] rd;
logic [4:0] rt;
logic [31:0] pc_in;
logic [31:0] pc4;
logic [31:0] inst_mem [0:1023];
logic [31:0] inst_mem1 [0:1023];
assign instruction = inst_mem[pc_out[31:2]];
assign rs = rs_f_id; 
assign rd = rd_f_id; 
assign rt = rt_f_id; 

always_ff @(posedge clk or negedge rst) //porgram counter
begin
	if(rst==0)
    begin
		halt   <= 0;
		pc_out <= 0;	
    end
	else if (opcode==1'b1)
	begin
		halt   <= halt;
		pc_out <= pc_in;
   	end
   	else if (hazard)
    begin
		halt   <= halt;
      	pc_out <= pc_in; //pc_out;   // Need to be updated 
    end
	else if ((instruction[31:26] == 6'b010001) | (halt == 1'b1))
	begin
		halt   <= 1;
		pc_out <= pc_out;
   	end
	else 
    begin 
		halt   <= halt;
		pc_out <= pc_in;
    end
end

always_comb   // Add program counter
begin
	if(rst==0) 
		pc4 = 0;
	else 
		pc4 = pc_out + 4;
end

always_comb
begin 
	unique casez (instruction[31:26])
		6'b001110 : opcode = 1'b1; 
		6'b001111 : opcode = 1'b1;
		6'b010000 : opcode = 1'b1;
		default   : opcode = 1'b0; 
	endcase 
	pc_in = (opcode==0) ? pc4 : ex_add;
end


string memory_image;

initial
begin 
        $value$plusargs("MEM_IMAGE=%s",memory_image);
	$readmemh("memory_image.txt",inst_mem1);  //reading the list of instructions from the instruction.txt file
end

always_ff @(posedge clk or negedge rst)
begin 
	if(rst==0) begin 
		inst_mem <= inst_mem1;
		end
	else begin
		inst_mem <= inst_mem;
		end

end

logic reg_write_f_id_minus1;
logic reg_write_f_ex_minus2;

always_comb 
begin
	if ( reg_write_f_id_minus1 & (id_dest_minus1 == rs || id_dest_minus1 == rt || id_dest_minus1 == rd))
	begin
		hazard = 1;
		id_stall=1;
		ex_stall=0;
		mem_stall=0;
	end
	else if (reg_write_f_ex_minus2 & (ex_dest_minus2 == rs || ex_dest_minus2 == rt || ex_dest_minus2 == rd))
	begin
		hazard = 1;
		id_stall=0;
		ex_stall=1;
		mem_stall=0;
	end

//	else if (reg_write_f_mem & (mem_dest == rs || mem_dest == rt || mem_dest == rd))
//	 begin
//		hazard = 1;
//		id_stall=0;
//		ex_stall=0;
//		mem_stall=1;
//	end

	else 
	 begin
		hazard = 0;
		id_stall=0;
		ex_stall=0;
		mem_stall=0;
	end

end
logic [4:0] r_rd_minus1;
logic [4:0] i_rdt_minus1;
logic [29:0] pc_out_minus1;
assign pc_out_minus1 = pc_out[31:2] - 30'b1;
logic [31:0] inst_minus1;
assign inst_minus1 = inst_mem[pc_out_minus1];

// R -instruction
assign r_rd_minus1  = inst_minus1[15:11];

// I -instruction
assign i_rdt_minus1 = inst_minus1[20:16];

// instruction decode
always_comb
begin
	unique casez(inst_minus1[31:26])
		6'b000000:begin 		// add
			id_dest_minus1 = r_rd_minus1;	
			reg_write_f_id_minus1 = 1;
		end
		6'b000001:begin			// addi
			id_dest_minus1 = i_rdt_minus1;	
			reg_write_f_id_minus1 = 1;
		end
		6'b000010:begin 		// sub
			id_dest_minus1 = r_rd_minus1;	
			reg_write_f_id_minus1 = 1;
		end
		6'b000011:begin			// subi
			id_dest_minus1 = i_rdt_minus1;	
			reg_write_f_id_minus1 = 1;
		end	
		6'b000100:begin			// mul
			id_dest_minus1 = r_rd_minus1;	
			reg_write_f_id_minus1 = 1;
		end
		6'b000101:begin			// muli
			id_dest_minus1 = i_rdt_minus1;	
			reg_write_f_id_minus1 = 1;
		end
		6'b000110:begin			// OR
			id_dest_minus1 = r_rd_minus1;	
			reg_write_f_id_minus1 = 1;
		end
		6'b000111:begin			// ORI
			id_dest_minus1 = i_rdt_minus1;	
			reg_write_f_id_minus1 = 1;
		end
		6'b001000:begin			// AND
			id_dest_minus1 = r_rd_minus1;	
			reg_write_f_id_minus1 = 1;
		end
		6'b001001:begin			// ANDI
			id_dest_minus1 = i_rdt_minus1;	
			reg_write_f_id_minus1 = 1;
		end
		6'b001010:begin			// XOR
			id_dest_minus1 = r_rd_minus1;	
			reg_write_f_id_minus1 = 1;
		end
		6'b001011:begin			// XORI
			id_dest_minus1 = i_rdt_minus1;	
			reg_write_f_id_minus1 = 1;
		end
		6'b001100:begin			// LDW
			id_dest_minus1 = i_rdt_minus1;	
			reg_write_f_id_minus1 = 1;
		end
		6'b001101:begin			// STW
			id_dest_minus1 = i_rdt_minus1;	
			reg_write_f_id_minus1 = 0;
		end
		6'b001110:begin			// BZ
			id_dest_minus1 = '0;	
			reg_write_f_id_minus1 = 0;
		end
		6'b001111:begin			// BEQ
			id_dest_minus1 = '0;	
			reg_write_f_id_minus1 = 0;
		end
		6'b010000:begin			// JR
			id_dest_minus1 = '0;	
			reg_write_f_id_minus1 = 0;
		end
		6'b010001:begin			// HALT
			id_dest_minus1 = '0;	
			reg_write_f_id_minus1 = 0;
		end
		6'b111111:begin			// NOP 
			id_dest_minus1 = '0;	
			reg_write_f_id_minus1 = 0;
		end
		  default:begin
			id_dest_minus1 = '0;	
			reg_write_f_id_minus1 = 0;
		end
	endcase		
end

logic [4:0] r_rd_minus2;
logic [4:0] i_rdt_minus2;
logic [29:0] pc_out_minus2;
assign pc_out_minus2 = pc_out[31:2] - 30'h2;
logic [31:0] inst_minus2;
assign inst_minus2 = inst_mem[pc_out[31:2] - 2];

// R -instruction
assign r_rd_minus2  = inst_minus2[15:11];

// I -instruction
assign i_rdt_minus2 = inst_minus2[20:16];

// instruction decode
always_comb
begin
	unique casez(inst_minus2[31:26])
		6'b000000:begin 		// add
			ex_dest_minus2 = r_rd_minus2;	
			reg_write_f_ex_minus2 = 1;
		end
		6'b000001:begin			// addi
			ex_dest_minus2 = i_rdt_minus2;	
			reg_write_f_ex_minus2 = 1;
		end
		6'b000010:begin 		// sub
			ex_dest_minus2 = r_rd_minus2;	
			reg_write_f_ex_minus2 = 1;
		end
		6'b000011:begin			// subi
			ex_dest_minus2 = i_rdt_minus2;	
			reg_write_f_ex_minus2 = 1;
		end	
		6'b000100:begin			// mul
			ex_dest_minus2 = r_rd_minus2;	
			reg_write_f_ex_minus2 = 1;
		end
		6'b000101:begin			// muli
			ex_dest_minus2 = i_rdt_minus2;	
			reg_write_f_ex_minus2 = 1;
		end
		6'b000110:begin			// OR
			ex_dest_minus2 = r_rd_minus2;	
			reg_write_f_ex_minus2 = 1;
		end
		6'b000111:begin			// ORI
			ex_dest_minus2 = i_rdt_minus2;	
			reg_write_f_ex_minus2 = 1;
		end
		6'b001000:begin			// AND
			ex_dest_minus2 = r_rd_minus2;	
			reg_write_f_ex_minus2 = 1;
		end
		6'b001001:begin			// ANDI
			ex_dest_minus2 = i_rdt_minus2;	
			reg_write_f_ex_minus2 = 1;
		end
		6'b001010:begin			// XOR
			ex_dest_minus2 = r_rd_minus2;	
			reg_write_f_ex_minus2 = 1;
		end
		6'b001011:begin			// XORI
			ex_dest_minus2 = i_rdt_minus2;	
			reg_write_f_ex_minus2 = 1;
		end
		6'b001100:begin			// LDW
			ex_dest_minus2 = i_rdt_minus2;	
			reg_write_f_ex_minus2 = 1;
		end
		6'b001101:begin			// STW
			ex_dest_minus2 = i_rdt_minus2;	
			reg_write_f_ex_minus2 = 0;
		end
		6'b001110:begin			// BZ
			ex_dest_minus2 = '0;	
			reg_write_f_ex_minus2 = 0;
		end
		6'b001111:begin			// BEQ
			ex_dest_minus2 = '0;	
			reg_write_f_ex_minus2 = 0;
		end
		6'b010000:begin			// JR
			ex_dest_minus2 = '0;	
			reg_write_f_ex_minus2 = 0;
		end
		6'b010001:begin			// HALT
			ex_dest_minus2 = '0;	
			reg_write_f_ex_minus2 = 0;
		end
		6'b111111:begin			// NOP 
			ex_dest_minus2 = '0;	
			reg_write_f_ex_minus2 = 0;
		end
		  default:begin
			ex_dest_minus2 = '0;	
			reg_write_f_ex_minus2 = 0;
		end
	endcase		
end


always_ff @(posedge clk or negedge rst)
begin
if(rst==0)
	stall_wo_forewarding<=0;
else if(id_stall)
	stall_wo_forewarding<=stall_wo_forewarding+2;
else if(ex_stall)
	stall_wo_forewarding<=stall_wo_forewarding+1;
else if(opcode)
	stall_wo_forewarding<=stall_wo_forewarding+2;
else
	stall_wo_forewarding<=stall_wo_forewarding;
end

always_ff @(posedge clk or negedge rst)
begin
if(rst==0)
	stall_w_forewarding<=0;
else if(id_stall)
	stall_w_forewarding<=stall_w_forewarding+1;
else if(ex_stall)
	stall_w_forewarding<=stall_w_forewarding+0;
else if(opcode)
	stall_w_forewarding<=stall_w_forewarding+1;
else
	stall_w_forewarding<=stall_w_forewarding;
end
 
endmodule
