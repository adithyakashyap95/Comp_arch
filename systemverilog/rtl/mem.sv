// mem stage

`include "../rtl/struct.sv"
// Connect Outputs directly to ID stage as we have less logic in WB stage it is combined here
module mem (
	input  logic clk, 
	input  logic reset,
	input  logic mem_write,                                 // Only high for STW 
	input  logic mem_read,                                  // Only high for LDW 
	input  logic mem_to_reg,                                // when Rd/Rt is in use  
	input  logic [(ADDR_LINE_MEM-1):0] addr_in, 
	input  logic [(ADDR_LINE_REG-1):0] addr_reg_in,         // If mem_to_reg is high
	input  logic [(D_SIZE-1):0] write_data, 

	output logic mem_to_reg_2_wb,                           // when Rd/Rt is in use  
	output logic [(D_SIZE-1):0] alu_out_f_mem_2_wb,
	output logic [(ADDR_LINE_REG-1):0] alu_add_f_mem_2_wb,   // This is only for REGISTER WRITE
    output logic [(D_SIZE-1):0] mem_out [0:1023]
);

  logic [(D_SIZE-1):0] memory [0:1023];
  logic [(D_SIZE-1):0] mem_local [0:1023];
  logic [(D_SIZE-1):0] reg_w_data;
  logic [31:0] inst_mem [0:1023];

  string memory_image;
  initial
  begin 
        $value$plusargs("MEM_IMAGE=%s",memory_image);
  	$readmemh("memory_image.txt",inst_mem);  //reading the list of instructions from the instruction.txt file
  end

  always_ff@(posedge clk or negedge reset)
  begin
	if(reset==0)
	begin
		memory             <= inst_mem;   // Input from File
		alu_out_f_mem_2_wb <= '0;
		alu_add_f_mem_2_wb <= '0; 
		mem_to_reg_2_wb    <= '0;
	end
	else
	begin
		memory             <= mem_local;
		alu_out_f_mem_2_wb <= reg_w_data;
		alu_add_f_mem_2_wb <= addr_reg_in;
		mem_to_reg_2_wb    <= mem_to_reg;
	end
  end

  // Write back Included in this stage as it had only 2 lines
  
  always_comb
  begin
  	mem_local = memory;
	mem_local[addr_in] = (mem_write==1) ? write_data : memory[addr_in];
	reg_w_data = (mem_read==1) ? memory[addr_in]: write_data;           // If LDW only then read from memory 

	mem_out = memory;
  end

endmodule

