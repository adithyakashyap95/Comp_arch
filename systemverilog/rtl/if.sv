// Instruction fetch stage

`include "../rtl/struct.sv"

module inst_f (
	input  logic clk,
	input  logic rst,
	input  logic hazard,
	input  logic [31:0] pc_out1,
	input  logic [31:0] address,
	input  logic [31:0] ex_add,
	
	output logic [31:0] instruction,
	output logic [31:0] pc_out,
	output logic [31:0] pc4_dc
);

logic opcode;
logic [31:0] pc_in;
<<<<<<< HEAD
logic [31:0] pc4;
logic [31:0] inst_mem [1023:0];
assign instruction = inst_mem [address[31:2]];
=======
inst_t [1023:0] inst_mem;
assign instruction = inst_mem[address[31:2]];
>>>>>>> 3e12e6a5fd1a439f923048cab0c6474756bad6b1

always_ff @(posedge clk) //porgram counter
begin
	if(rst)
    	begin
		pc_out <= 0;	
    	end
   	else if (hazard)
    	begin
      		pc_out <= pc_out; 
    	end
   	else 
     	begin 
		pc_out <= pc_in;
      	end
end

always_comb   // Add program counter
begin
	if(rst) 
		pc4 = 0;
	else 
		pc4 = pc_out1 + 4;
end

always_comb
begin 
	unique casez (instruction[31:26])
		6'b001110 : opcode = 1'b1; 
		6'b001111 : opcode = 1'b1;
		6'b010001 : opcode = 1'b1;
		default   : opcode = 1'b0; 
	endcase 
	pc_in = opcode ? pc4 : ex_add;
end

always_ff @(posedge clk)  // intruction memory
begin 
	if(rst) 
		$readmemb("instruction.txt",inst_mem);  //reading the list of instructions from the instruction.txt file
end

always_ff @(posedge clk)
begin 
	if(rst) begin 
		inst_mem <= '0;
<<<<<<< HEAD
		pc4_dc <= '0;
=======
		//pc4 <= '0;
>>>>>>> 3e12e6a5fd1a439f923048cab0c6474756bad6b1
		end

	else begin
		inst_mem <= inst_mem;
<<<<<<< HEAD
		pc4_dc <= pc4;
=======
		//pc4 <= pc_out;
>>>>>>> 3e12e6a5fd1a439f923048cab0c6474756bad6b1
	     end
end	

  
endmodule
