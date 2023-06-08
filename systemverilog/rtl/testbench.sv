
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
logic signed [31:0] registers_tmp1;
logic signed [31:0] registers_tmp2;
logic signed [31:0] registers_tmp3;
logic signed [31:0] registers_tmp4;
logic signed [31:0] registers_tmp5;
logic signed [31:0] registers_tmp6;
logic signed [31:0] registers_tmp7;
logic signed [31:0] registers_tmp8;
logic signed [31:0] registers_tmp9;
logic signed [31:0] registers_tmp10;
logic signed [31:0] registers_tmp11;
logic signed [31:0] registers_tmp12;
logic signed [31:0] registers_tmp13;
logic signed [31:0] registers_tmp14;
logic signed [31:0] registers_tmp15;
logic signed [31:0] registers_tmp16;
logic signed [31:0] registers_tmp17;
logic signed [31:0] registers_tmp18;
logic signed [31:0] registers_tmp19;
logic signed [31:0] registers_tmp20;
logic signed [31:0] registers_tmp21;
logic signed [31:0] registers_tmp22;
logic signed [31:0] registers_tmp23;
logic signed [31:0] registers_tmp24;
logic signed [31:0] registers_tmp25;
logic signed [31:0] registers_tmp26;
logic signed [31:0] registers_tmp27;
logic signed [31:0] registers_tmp28;
logic signed [31:0] registers_tmp29;
logic signed [31:0] registers_tmp30;
logic signed [31:0] registers_tmp31;
logic [31:0] total_inst_cnt;
logic [(D_SIZE-1):0] mem_out [0:1023];
logic [31:0] pc_out;
logic [31:0] stall_wo_forewarding;
logic [31:0] stall_w_forewarding;
logic [31:0] total_clk_w_forwarding;
logic [31:0] total_clk_wo_forwarding;
logic signed [31:0] mem_temp;
real a,b,c;

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
	        
	        $display ("\nTotal number of instructions:     %d", total_inst_cnt);
	        $display ("Arithmetic instructions:            %d",arith_inst_cnt);
	        $display ("Logical instructions:               %d",logic_inst_cnt);
	        $display ("Memory access instructions:         %d",mem_inst_cnt);
	        $display ("Control transfer instructions:      %d",ctrl_inst_cnt);
	        
	        $display ("\n\n..............Final Register State..............");

			registers_tmp1  = registers_out[1];
			registers_tmp2  = registers_out[2];
			registers_tmp3  = registers_out[3];
			registers_tmp4  = registers_out[4];
			registers_tmp5  = registers_out[5];
			registers_tmp6  = registers_out[6];
			registers_tmp7  = registers_out[7];
			registers_tmp8  = registers_out[8];
			registers_tmp9  = registers_out[9];
			registers_tmp10 = registers_out[10];
			registers_tmp11 = registers_out[11];
			registers_tmp12 = registers_out[12];
			registers_tmp13 = registers_out[13];
			registers_tmp14 = registers_out[14];
			registers_tmp15 = registers_out[15];
			registers_tmp16 = registers_out[16];
			registers_tmp17 = registers_out[17];
			registers_tmp18 = registers_out[18];
			registers_tmp19 = registers_out[19];
			registers_tmp20 = registers_out[20];
			registers_tmp21 = registers_out[21];
			registers_tmp22 = registers_out[22];
			registers_tmp23 = registers_out[23];
			registers_tmp24 = registers_out[24];
			registers_tmp25 = registers_out[25];
			registers_tmp26 = registers_out[26];
			registers_tmp27 = registers_out[27];
			registers_tmp28 = registers_out[28];
			registers_tmp29 = registers_out[29];
			registers_tmp30 = registers_out[30];
			registers_tmp31 = registers_out[31];
	        
	        $display ("\nProgram counter: %d", (pc_out));
	        $display ("R1: %d",registers_tmp1);
	        $display ("R2: %d",registers_tmp2);
	        $display ("R3: %d",registers_tmp3);
	        $display ("R4: %d",registers_tmp4);
	        $display ("R5: %d",registers_tmp5);
	        $display ("R6: %d",registers_tmp6);
	        $display ("R7: %d",registers_tmp7);
	        $display ("R8: %d",registers_tmp8);
	        $display ("R9: %d",registers_tmp9);
	        $display ("R10:%d",registers_tmp10);
	        $display ("R11:%d",registers_tmp11);
	        $display ("R12:%d",registers_tmp12);
		    $display ("R13:%d",registers_tmp13);
		    $display ("R14:%d",registers_tmp14);
		    $display ("R15:%d",registers_tmp15);
		    $display ("R16:%d",registers_tmp16);
		    $display ("R17:%d",registers_tmp17);
		    $display ("R18:%d",registers_tmp18);
		    $display ("R19:%d",registers_tmp19);
		    $display ("R20:%d",registers_tmp20);
		    $display ("R21:%d",registers_tmp21);
		    $display ("R22:%d",registers_tmp22);
		    $display ("R23:%d",registers_tmp23);
		    $display ("R24:%d",registers_tmp24);
		    $display ("R25:%d",registers_tmp25);
		    $display ("R26:%d",registers_tmp26);
		    $display ("R27:%d",registers_tmp27);
		    $display ("R28:%d",registers_tmp28);
		    $display ("R29:%d",registers_tmp29);	
		    $display ("R30:%d",registers_tmp30);
		    $display ("R31:%d",registers_tmp31);	

	        
	        $display ("\n\n..........Final memory state...........");
	        
			flag=0;
			for (int i=0 ; i< 1024 ; i=i+1)
			begin 
				if ( mem_out[i-1] == 32'h44000000) 
					flag=1;
				if(flag)
				begin
		        	if(mem_out[i]!='0) 
					begin
						mem_temp = mem_out[i];
						$display ("\nAddress: %d, Contents: %d", (i<<2) , mem_temp);
					end
				end
	        end
	        
	        $display ("\n\n..........Timing Simulator without forewarding..........");
	        $display ("\nTotal number of clock cycles: %d", total_clk_wo_forwarding);
	        $display ("\n\n..........Timing Simulator with forewarding..........");
	        $display ("\nTotal number of clock cycles: %d", total_clk_w_forwarding);

			a = real'(total_clk_wo_forwarding);
			b = real'(total_clk_w_forwarding);
			c = a/b;

	        $display ("\n\n..........Speedup overall..........");
			$display ("Speedup overall : %f",c);
	        $display ("\nProgram Halted");

			$finish;
		end
		else
			#10;
	end

end

endmodule


