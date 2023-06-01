// Write Back Stage

`include "../rtl/struct.sv"

module write_back(
    input logic memToReg,
    //input logic [31:0] alu_out,
    //input logic [31:0] memory_out,
    input  logic [(ADDR_LINE-1):0] addr_in,
    input logic [(D_SIZE-1):0] read_data,
    input logic [31:0] alu_out_f_mem_2_wb,
    input logic [31:0] alu_add_f_mem_2_wb, 
    output logic [31:0] register_in,
    output logic [31:0] register_in_addr
);

//Mux2_1 mux_write_back_data (register_in, memToReg, alu_add_f_mem_2_wb, mem_out);
//Mux2_1 mux_write_back_addr (register_in_addr, memToReg, alu_out_f_mem_2_wb, mem_out);

assign register = memToReg ? read_data : alu_out_f_mem_2_wb;
assign register_in_addr = memToReg ? addr_in : alu_add_f_mem_2_wb;


endmodule
