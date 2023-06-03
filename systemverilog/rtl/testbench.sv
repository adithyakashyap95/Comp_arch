
`include "../rtl/struct.sv"  // Include the necessary files

module testbench;

logic clk;
logic rst;

//.........instantiation .......
main i_main (
	.clk		(clk	), 
	.reset		(rst	),
	.valid 		(1'b0	),
	.opr_finished 	(1'b0	)
);

//..........clock generation .............
always #5 clk = ~clk;

//... TB stimulus............

initial begin 

clk = 0;
rst = 0;


#10 rst = 1;


#300 $finish;

//...........Test cases..........

end

endmodule


