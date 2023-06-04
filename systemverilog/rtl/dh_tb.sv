module hazzo_tb;

  logic ifid_memread;
  logic idex_dest;
  logic [4:0] ifid_rs;
  logic [4:0] ifid_rt;
  logic hazard;
  logic clk;

  
  hazzo dut (
    .ifid_memread(ifid_memread),
    .idex_dest(idex_dest),
    .ifid_rs(ifid_rs),
    .ifid_rt(ifid_rt),
    .hazard(hazard)
  );

    initial begin
    // Testcase ......................
    ifid_memread = 1'b0;
    idex_dest = 1'b0;
    ifid_rs = 5'b00100;
    ifid_rt = 5'b01000;
    
    #10;     
        $finish;
  end

  // Monitor...................
  always @(posedge clk) begin
    $display("ifid_memread=%b, idex_dest=%b, ifid_rs=%b, ifid_rt=%b, hazard=%b", ifid_memread, idex_dest, ifid_rs, ifid_rt, hazard);
  end

endmodule

