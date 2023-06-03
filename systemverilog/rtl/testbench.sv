
`include "../rtl/struct.sv"  // Include the necessary files

module tb;

logic clk;
logic rst;
logic [31:0] inst_out;

//.........instantiation .......
main i_main (
	.clk		(clk		), 
	.reset		(rst		),
	.valid 		(1'b0		),
	.opr_finished 	(1'b0		),
	.inst_out       (inst_out	)
);

//..........clock generation .............
always #5 clk = ~clk;

//... TB stimulus............

initial begin 

clk = 0;
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

endmodule


