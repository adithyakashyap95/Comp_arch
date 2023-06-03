//Testbench for Instruction Fetch stage

`include "../rtl/struct.sv"  // Include the necessary files

module inst_f_tb;

  // ............Declare testbench signals........
  logic clk;
  logic rst;
  logic hazard;
  logic [31:0] pc_out1;
  logic [31:0] address;
  logic [31:0] ex_add;
  logic [31:0] instruction;
  logic [31:0] pc_out;
  logic [31:0] pc4_dc;

  // ............Instantiate the IF module..........
  inst_f dut (
   .clk(clk),
    .rst(rst),
    .hazard(hazard),
    .pc_out1(pc_out1),
    .address(address),
    .ex_add(ex_add),
    .instruction(instruction),
    .pc_out(pc_out),
    .pc4_dc(pc4_dc)
  );

  // ............Clock generation.................
  always #5 clk = ~clk;

  // ...........Testbench stimulus........................
  initial begin
    clk = 0;
    rst = 1;
    hazard = 0;
    pc_out1 = 0;
    address = 0;
    ex_add = 0;
//.............................................................



    
    #10 rst = 0;

    // .............Testcase...........................
    address = 32'h0000;
    #10;
    $display("Instruction: %h", instruction);
    $display("PC Out: %h", pc_out);
    $display("PC4 DC: %h", pc4_dc);

    #10 $finish;

end


endmodule
