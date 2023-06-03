// Instruction fetch stage

`include "../rtl/struct.sv"

module inst_f (
	input  logic clk,
	input  logic rst,
	input  logic hazard,
	input  logic [31:0] ex_add,
	
	output logic [31:0] instruction,
	output logic [31:0] pc_out
);

logic opcode;
logic halt;
logic [1:0] delay;
logic [31:0] pc_in;
logic [31:0] pc4;
logic [31:0] inst_mem [0:1023];
logic [31:0] inst_mem1 [0:1023];
assign instruction = inst_mem[pc_out[31:2]];

always_ff @(posedge clk or negedge rst) //porgram counter
begin
	if(rst==0)
    	begin
		halt   <= 0;
		pc_out <= 0;	
    	end
   	else if (hazard)
    	begin
		halt   <= halt;
      		pc_out <= pc_out;   // Need to be updated 
    	end
	else if (opcode==1'b1)
	begin
		halt   <= halt;
		pc_out <= (delay==2) ? pc_in : pc_out;
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


always_ff@(posedge clk or negedge rst)
begin
	if(rst==0)
		delay <= '0;
	else if(delay == 2)
		delay <= '0;
	else if(delay>0)
		delay <= delay + 1;
	else if(opcode == 1)
		delay <= delay + 1;
	else
		delay <= delay;
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

  
endmodule
