
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

assign total_inst_cnt = arith_inst_cnt + mem_inst_cnt + logic_inst_cnt + ctrl_inst_cnt;

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
	.mem_out		   (mem_out			  )
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
			$finish;
		end
		else
			#10;
	end
end

//...........Test cases..........


// While printing PC_OUT print with +4 value

endmodule


