module tb_alu;

logic  [5:0]op;
logic  [31:0]rs, rt;
logic  [31:0]imm;
logic [31:0]rd, A;
logic clk;

alu i1(.*);

always #5 clk = ~clk;

// Testbench stimulus
  initial begin 
   clk=0; 
    // Test case 1: Addition
    op = 6'b000000;
    rs = 32'h0000000A;
    rt = 32'h00000005;
    #10;
    $display("Addition result: %h", rd);
    
    // Test case 2: Subtraction Immediate
    op = 6'b000011;
    rs = 32'h0000000A;
    imm = 32'hFFFFFFF5;
    #10;
    $display("Subtraction Immediate result: %h", rd);
    
    // Test case 3: Bitwise XOR
    op = 6'b001010;
    rs = 32'h0000000A;
    rt = 32'h000000F0;
    #10;
    $display("Bitwise XOR result: %h", rd);
    
    // Test case 4: Load Word
    op = 6'b001100;
    rs = 32'h00000100;
    imm = 32'h00000008;
    #10;
    $display("Load Word result: %d", A);
    
  
    
    #10;
    $finish;
  end
endmodule 
