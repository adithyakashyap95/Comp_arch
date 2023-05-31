// mem stage

`include "../rtl/struct.sv"

module mem (
	input  logic clk, 
	input  logic reset,
	input  logic rw,                           // read = 0 and write = 1 
	input  logic [(ADDR_LINE-1):0] addr_in, 
	input  logic [(D_SIZE-1):0] write_data, 
	output logic [(D_SIZE-1):0] read_data
);

  mem_t [(D_MEM-1):0] memory;
  mem_t [(D_MEM-1):0] mem_local;

  always_ff@(posedge clk or negedge reset)
  begin
	if(reset==0)
		memory <= '0;
	else
		memory <= mem_local;
  end

  always_comb
  begin
        mem_local = memory;
	mem_local[addr_in] = (rw==1) ? write_data : mem_local[addr_in];
	read_data = (rw==0) ? mem_local[addr_in]: '0;
  end

endmodule

