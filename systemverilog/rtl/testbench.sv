
`include "../rtl/struct.sv"  // Include the necessary files

module tb;

logic clk;
logic clk1;
logic rst;
logic flag;
logic [31:0] inst_out;
logic [15:0] arith_inst_cnt;
logic [15:0] logic_inst_cnt;
logic [15:0] mem_inst_cnt;
logic [15:0] ctrl_inst_cnt;
mem_t [31:0] registers_out;
logic [31:0] total_inst_cnt;
logic [(D_SIZE-1):0] mem_out [0:1023];
logic [31:0] pc_out;
logic [31:0] stall_wo_forewarding;
logic [31:0] stall_w_forewarding;
logic [31:0] total_clk_w_forwarding;
logic [31:0] total_clk_wo_forwarding;

assign total_inst_cnt = arith_inst_cnt + mem_inst_cnt + logic_inst_cnt + ctrl_inst_cnt;
assign total_clk_w_forwarding  = total_inst_cnt + 6 + stall_w_forewarding;  // 6 to account for the cycles front and back
assign total_clk_wo_forwarding = total_inst_cnt + 6 + stall_wo_forewarding; // 6 to account for the cycles front and back

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
	.pc_out 		   (pc_out 			  ),
	.stall_wo_forewarding (stall_wo_forewarding),
	.stall_w_forewarding  (stall_w_forewarding )
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
	        
	        $display ("\nProgram counter: %d", (pc_out + 4));
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

	        
	        $display ("\n\n..........Final memory state...........");
	        
		flag=0;
		for (int i=0 ; i< 1024 ; i=i+1)
		begin 
		if ( mem_out [i] == 32'h44000000) 
		flag=1
		
		if(flag)
		
	        $display ("\nAddress: %d, Contents: %d", i , mem_out[i]);

				
	        end
	        
	        $display ("\n\n..........Timing Simulator without forewarding..........");
	        $display ("\nTotal number of clock cycles: %d", total_clk_wo_forwarding);
	        $display ("\n\n..........Timing Simulator with forewarding..........");
	        $display ("\nTotal number of clock cycles: %d", total_clk_w_forwarding);
	        $display ("\nProgram Halted");

			$finish;
		end
		else
			#10;
	end

end

endmodule


