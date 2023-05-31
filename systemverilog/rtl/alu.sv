//Inputs :  OPCODE-6bit [5:0]
//Source registers rs and rt --> 5bit [4:0]
//Immediate value -- how many bits? 5? 
//Output : Destination register --> rd -->5bit [4:0]

module alu( 
	input logic  [5:0]op,
	input logic  [31:0]rs, rt,
	input logic  [31:0]imm,
	output logic [31:0]rd, A
		   );
logic [31:0]opr1, opr2;
logic [31:0]IMM;

assign opr1 = rs[31] ? (~rs+1):rs;
assign opr2 = rt[31] ? (~rt+1):rt;
assign IMM = imm[31]? (~imm+1):imm;

always_comb begin
case(op)

000000: rd= opr1 + opr2; // op:000000- Add
000001: rd= opr1 + IMM; //op: 000001 - ADDI
//op : 000010 - Sub
000010:
//op : 000011 - SubI
000011:

000100: rd = rs*rt; //op:000100 - MUL
000101:rd = rs*imm; //op:000101 - MULI
000110:rd = rs | rt ; //op -000110 - OR
000111:rd = rs | imm; //op - 000111 - ORi
001000:rd = rs & rt; //op - 001000 - AND
001001:rd = rs & imm; //op - 001001 - ANDi
001010:rd = rs ^ rt; //op - 001010 - XOR
001011:rd = rs ^ imm; //op - 001011 - XORI
001100:A= rs+imm;  //LDW
001101:A=rs+imm;   //STW


endcase
end

