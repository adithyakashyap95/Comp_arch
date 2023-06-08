
`include "../rtl/struct.sv"  // Include the necessary files

module tb;

logic clk;
logic clk1;
logic rst;
logic [31:0] inst_out;
logic [15:0] arith_inst_cnt;
logic [15:0] logic_inst_cnt;
logic [15:0] mem_inst_cnt;
logic [15:0] ctrl_inst_cnt;
mem_t [31:0] registers_out;
logic [31:0] total_inst_cnt;
logic [(D_SIZE-1):0] mem_out [0:1023];
logic [31:0] clk_counter;
logic [31:0] pc_out;

assign total_inst_cnt = arith_inst_cnt + mem_inst_cnt + logic_inst_cnt + ctrl_inst_cnt;
// While printing PC_OUT print with +4 value

//.........instantiation .......
main i_main (
	.clk		       (clk		 		  ), 
	.clk1		       (clk1			  ), 
	.reset		       (rst				  ),
	.valid 		       (1'b0			  ),
	.opr_finished 	   (1'b0			  ),
	.inst_out          (inst_out		  ),
    .arith_inst_cnt    (arith_inst_cnt    ),
    .logic_inst_cnt    (logic_inst_cnt    ),
    .mem_inst_cnt      (mem_inst_cnt      ),
    .ctrl_inst_cnt     (ctrl_inst_cnt     ),
    .registers_out     (registers_out     ),
	.mem_out		   (mem_out			  ),
	.pc_out 		   (pc_out 			  )
);

//..........clock generation .............
always #4 clk = ~clk;
always #1 clk1= ~clk1;

//... TB stimulus............

initial begin 

clk = 0;
clk1= 0;
rst = 0;


#10 rst = 1;

	for(int i=0;i<1000000;i=i+1)
	begin
		if(inst_out[31:26] == 6'b010001 )
		begin
			#60;
	        $display ("\n..............Instruction Counts...............");
	        
	        $display ("\nTotal number of instructions: %d", total_inst_cnt);
	        $display ("Arithmetic instructions: %d",arith_inst_cnt);
	        $display ("Logical instructions: %d",logic_inst_cnt);
	        $display ("Memory access instructions: %d",mem_inst_cnt);
	        $display ("Control transfer instructions: %d",ctrl_inst_cnt);
	        
	        $display ("\n\n..............Final Register State..............");
	        
	        $display ("\nProgram counter: %d", pc_out);
	        $display ("R1: %d", registers_out[1]);
	        $display ("R2: %d", registers_out[2]);
	        $display ("R3: %d", registers_out[3]);
	        $display ("R4: %d", registers_out[4]);
	        $display ("R5: %d", registers_out[5]);
	        $display ("R6: %d", registers_out[6]);
	        $display ("R7: %d", registers_out[7]);
	        $display ("R8: %d", registers_out[8]);
	        $display ("R9: %d", registers_out[9]);
	        $display ("R10: %d",registers_out[10]);
	        $display ("R11: %d",registers_out[11]);
	        $display ("R12: %d",registers_out[12]);
		$display ("R13: %d",registers_out[13]);
		$display ("R14: %d",registers_out[14]);
		$display ("R15: %d",registers_out[15]);
		$display ("R16: %d",registers_out[16]);
		$display ("R17: %d",registers_out[17]);
		$display ("R18: %d",registers_out[18]);
		$display ("R19: %d",registers_out[19]);
		$display ("R20: %d",registers_out[20]);
		$display ("R21: %d",registers_out[21]);
		$display ("R22: %d",registers_out[22]);
		$display ("R23: %d",registers_out[23]);
		$display ("R24: %d",registers_out[24]);
		$display ("R25: %d",registers_out[25]);
		$display ("R26: %d",registers_out[26]);
		$display ("R27: %d",registers_out[27]);
		$display ("R28: %d",registers_out[28]);
		$display ("R29: %d",registers_out[29]);	
		$display ("R30: %d",registers_out[30]);
		$display ("R31: %d",registers_out[31]);	
		$display ("R32: %d",registers_out[32]);

	        
	        $display ("\n\n..........Final memory state...........");
	        
		foreach (mem_out[i])
		begin 
		
		
	        $display ("\nAddress: %d, Contents: %d", i , mem_out[i]);
	        //$display ("Address: %d, Contents: %d",  1404,mem_out[351]);
	        //$display ("Address: %d, Contents: %d",  1408,mem_out[352]);
	        end
	        
	        $display ("\n\n..........Timing Simulator..........");
	        // FIXME
	        $display ("\nTotal number of clock cycles:To be corredccted: %d", 0);
	        $display ("\nProgram Halted");

			$finish;
		end
		else
			#10;
	end

end

// Do we need this ?
always_ff@(posedge clk or negedge rst)
begin
	if(rst==0)
		clk_counter <= '0;
	else
		clk_counter <= clk_counter + 32'b1;
end


endmodule


