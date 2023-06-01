//Inputs :  OPCODE-6bit [5:0]
//Source registers rs and rt --> 5bit [4:0]
//Immediate value -- how many bits? 5? 
//Output : Destination register --> rd -->5bit [4:0]

module alu(
  input logic [5:0] op,
  input logic [31:0] rs,
  input logic [31:0] rt,
  input logic [31:0] imm,
  output logic [31:0] rd,
  output logic [31:0] A,
  input logic clk
);
  
  logic [31:0] opr1, opr2;
  logic [31:0] IMM;
  logic [32:0] tmp;
assign opr1 = (~rs + 1);
assign opr2 = (~rt + 1);
assign IMM = (~imm + 1);

  
  always_ff @(posedge clk) begin
        
    case (op)
      6'b000000: rd <= rs + rt; // Add
      6'b000001: rd <= rs + IMM;  // Add Immediate
      6'b000010: subtraction(rs, opr1, rd); // Subtract
      6'b000011: subtraction(rs, IMM, rd);  // Subtract Immedia
      6'b000100: rd <= opr1 * opr2; // Multiply
      6'b000101: rd <= opr1 * IMM;  // Multiply Immediate
      6'b000110: rd <= rs | rt;     // Bitwise OR
      6'b000111: rd <= rs | imm;    // Bitwise OR Immediate
      6'b001000: rd <= rs & rt;     // Bitwise AND
      6'b001001: rd <= rs & imm;    // Bitwise AND Immediate
      6'b001010: rd <= rs ^ rt;     // Bitwise XOR
      6'b001011: rd <= rs ^ imm;    // Bitwise XOR Immediate
      6'b001100: A <= rs + imm;     // Load Word
      6'b001101: A <= rs + imm;     // Store Word
      default: begin
        rd <= 32'b0; // Default output
        A <= 32'b0;  // Default output
      end
    endcase
  end
endmodule

task subtraction(
input logic [31:0] A, B,
output logic [31:0] S);
logic [32:0] tmp;
tmp = A+B;
if(tmp[32] !==0)
	S=tmp[31:0];
else 
	S= (~tmp[31:0]+1);
endtask









/*module alu( 
	input logic  [5:0]op,
	input logic  [31:0]rs, rt,
	input logic  [31:0]imm,
	output logic [31:0]rd, A
		   );
logic [31:0]opr1, opr2;
logic [31:0]IMM;

/*assign opr1 = rs[31] ? (~rs+1):rs;
assign opr2 = rt[31] ? (~rt+1):rt;
assign IMM = imm[31]? (~imm+1):imm;*/

/*assign opr1 = (~rs+1);
assign opr2 = (~rt+1);
assign IMM =  (~imm+1);

always_comb begin
case(op)

000000:rd = opr1 + opr2; // op:000000- Add
000001:rd = opr1 + IMM; //op: 000001 - ADDI
000010:rd = opr1 + opr2;//op : 000010 - Sub
000011:rd = opr1 + IMM; //op : 000011 - SubI
000100:rd = opr1 * opr2; //op:000100 - MUL
000101:rd = opr1 * IMM; //op:000101 - MULI
000110:rd = rs | rt ; //op -000110 - OR
000111:rd = rs | imm; //op - 000111 - ORi
001000:rd = rs & rt; //op - 001000 - AND
001001:rd = rs & imm; //op - 001001 - ANDi
001010:rd = rs ^ rt; //op - 001010 - XOR
001011:rd = rs ^ imm; //op - 001011 - XORI
001100:A  = rs + imm;  //LDW
001101:A  = rs + imm;   //STW


endcase
end
endmodule */

