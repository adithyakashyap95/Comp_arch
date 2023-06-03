// data hazard

`include "../rtl/struct.sv"

module hazzo(

input logic ifid_memread,
input logic idex_dest,
input logic [4:0] ifid_rs,
input logic [4:0] ifid_rt,

output logic hazard
);



assign hazard = ifid_memread & (idex_dest != 0) & ((idex_dest == ifid_rs) | (idex_dest == ifid_rt));

endmodule

