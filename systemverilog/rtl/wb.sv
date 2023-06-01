// wb stage

`include "../rtl/struct.sv"

module wb(
    input  logic memToReg,
    input  logic [31:0] alu_out,
    input  logic [31:0] memory_out,
    output logic [31:0] register_in
);

Mux2_1 mux_write_back (register_in, memToReg, alu_out, mem_out);


endmodule
