
`include "../rtl/struct.sv"  // Include the necessary files

module testbench;

logic clk;
logic rst;

//.........instantiation .......
i_main main (.clk(clk), .rst(rst));


//..........clock generation .............
always #5 clk = ~clk;

//... TB stimulus............

initial begin 

clk = 0;
rst = 1;


#10 rst = 0;

//...........Test cases..........




