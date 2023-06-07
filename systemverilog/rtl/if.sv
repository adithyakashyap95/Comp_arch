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
	output logic [31:0] pc_out
);

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

//assign hazard = ifid_memread & (idex_dest != 0) & ((idex_dest == ifid_rs) | (idex_dest == ifid_rt));
//assign hazard = (idex_dest != 0 && (idex_dest == ifid_rs | idex_dest == ifid_rt)) |
//                 (ifid_memread != 0 & (ifid_memread == ifid_rs | ifid_memread == ifid_rt));

always_comb 
begin
	if ( reg_write_f_id & (id_dest == rs || id_dest == rt || id_dest == rd))
		hazard = 1;
	else if (reg_write_f_ex & (ex_dest == rs || ex_dest == rt || ex_dest == rd))
		hazard = 1;
	else if (reg_write_f_mem & (mem_dest == rs || mem_dest == rt || mem_dest == rd))
	 	hazard = 1;
	else 
	 	hazard = 0;
end
  
endmodule
