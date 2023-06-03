// Instruction fetch stage

`include "../rtl/struct.sv"

module inst_f (
	input  logic clk,
	input  logic rst,
	input  logic hazard,
	//input  logic [31:0] pc_out1,
	//input  logic [31:0] address,
	input  logic [31:0] ex_add,
	
	output logic [31:0] instruction,
	output logic [31:0] pc_out,
	//output logic [31:0] pc4_dc
);

logic opcode;
logic [31:0] pc_in;
logic [31:0] pc4;
logic [31:0] inst_mem [0:1023];
logic [31:0] inst_mem1 [0:1023];
assign instruction = inst_mem [pc[31:2]];

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
	else if (instruction [31:26] == 6'b010001 )
		pc_out <= '0;
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
		pc4 = pc_out + 4;
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

string memory_image;

initial
begin 
        $value$plusargs("MEM_IMAGE=%s",memory_image);
	$readmemh("memory_image.txt",inst_mem1);  //reading the list of instructions from the instruction.txt file
end

always_ff @(posedge clk)
begin 
	if(rst) begin 
		inst_mem <= inst_mem1;
		end
	else begin
		inst_mem <= inst_mem;
		end

end	

  
endmodule
