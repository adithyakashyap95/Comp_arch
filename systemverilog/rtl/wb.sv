// Write Back Stage

`include "../rtl/struct.sv"

module wb (
    input  logic                       mem_to_reg_f_mem,
    input  logic [(D_SIZE-1):0]        alu_out_f_mem_2_wb,
    input  logic [(ADDR_LINE_REG-1):0] alu_add_f_mem_2_wb, 

    output logic                       mem_to_reg_f_wb_to_id,
    output logic [(D_SIZE-1):0]        reg_data_f_wb_id,
    output logic [(ADDR_LINE_REG-1):0] reg_addr_f_wb_id
);

assign reg_data_f_wb_id = alu_out_f_mem_2_wb;
assign reg_addr_f_wb_id = alu_add_f_mem_2_wb;
assign mem_to_reg_f_wb_to_id = mem_to_reg_f_mem;

endmodule
