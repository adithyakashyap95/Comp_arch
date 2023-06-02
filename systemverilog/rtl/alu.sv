//Inputs :  OPCODE-6bit [5:0]
//Source registers rs and rt --> 5bit [4:0]
//Immediate value -- how many bits? 5? 
//Output : Destination register --> rd -->5bit [4:0]

module alu(
  input logic [5:0] op,
  input logic [31:0] rs,
  input logic [31:0] rt,
  input logic [31:0] imm,
  input logic [31:0] pc_out_2_ex,
  input logic [31:0] i_data_2_ex,

  output logic [31:0] rd,
  output logic [31:0] A,
  output logic [31:0] pc_out_2_ex_out,
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
      6'b000000: addition(rs,rt,rd);  //rd <= rs + rt; // Add
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
      6'b001100: addition(rs,imm,A);  //A <= rs + imm;     // Load Word
      6'b001101: addition(rs,imm,A); //A <= rs + imm;     // Store Word
      6'b001110: if(rs==0) pc_out_2_ex_out=pc_out_2_ex+i_data_2_ex;
		 else pc_out_2_ex_out=pc_out_2_ex; //BZ Rs x 
      6'b001111: if(rs==rt) pc_out_2_ex_out=pc_out_2_ex+i_data_2_ex;
		 else pc_out_2_ex_out=pc_out_2_ex;  //BEQ Rs Rt x
      6'b010000: pc_out_2_ex_out<=rs; // JR Rs (Load the PC [program counter] with the cont regi Rs.Jump to the new PC).	
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


task addition(
input logic [31:0]A, B,
output logic [31:0] S);

logic [32:0] tmp, tmp1,tmp2;
logic [31:0] a, b; 
 
assign a = (~A+1);    //2's compliment of A
assign b = (~B+1);    //2's compliment of B

if(A[31]==0 && B[31]==0)
	S = A+B;
else if(A[31]==0 && B[31]==1) 
				begin
					if(A>b)  begin  //Addition of the positive number with a negative number when the positive number has a greater magnitude.
							tmp = A+b;
							S = tmp[31:0];
						end
					else if(A<b)  //Adding of the positive value with a negative value when the negative number has a higher magnitude
						begin
							tmp = A+b;
							tmp1 =(~tmp+1);
							S = tmp1[31:0];
						end
				end
else if(A[31]==1 && B[31]==1)   // Addition when both are negative
	begin
		tmp=a+b;
		tmp1= tmp[31:0]+tmp[32];
		tmp2 = (~tmp1+1);
		S = tmp2[31:0];
	end
else
	begin
					if(a<B)  begin  //Addition of the positive number with a negative number when the positive number has a greater magnitude.
							tmp = a+B;
							S = tmp[31:0];
						end
					else if(a>B)  //Adding of the positive value with a negative value when the negative number has a higher magnitude
						begin
							tmp = a+B;
							tmp1 =(~tmp+1);
							S = tmp1[31:0];
						end
	end

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

