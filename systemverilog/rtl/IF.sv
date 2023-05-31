module instruction_fetch (

input logic clk, rst,
input logic hazard,
 

input logic [31:0] pc_out1,
input logic [31:0] address,
input logic [31:0] instruction,
input logic [31:0] ex_add,

output logic [31:0] pc_out,
output logic [31:0] pc4


);

logic [31:0] pc_in;
logic opcode;
logic [31:0] inst_mem [1023:0];
assign instruction = inst_mem [address [31:2]];


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

if(rst) 

  pc4 = 0;

else 

  pc4 = pc_out1 + 4;
  

always_comb

begin 


case (instruction[31:26])

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
      
  
  
endmodule
