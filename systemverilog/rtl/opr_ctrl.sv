
module opr_ctrl (
	input  logic 	clk,
	input  logic 	rstb,
	input  logic 	valid,
	output logic 	opr_finished,

// Generated Pulses

	output logic 	opr_1,
	output logic 	opr_2,
	output logic 	opr_3,
	output logic 	opr_4,
	output logic 	opr_5
);

logic [10:0]			cntr_opr;  // Counter for checking 1024 lines instructions in memeory image

// Generating pulses so that the modules work in series fashion.

always_ff@(posedge clk or negedge rstb)
begin
	if(rstb==0)
	begin
		cntr_opr <= 0;
	end
	else if(cntr_opr==1023)
	begin
		cntr_opr <= 0;
	end	
	else if((valid)|(cntr_opr>0))
	begin
		cntr_opr <= cntr_opr + 1;
	end
	else
	begin
		cntr_opr <= cntr_opr;
	end
end

assign opr_finished = (cntr_opr==1023)? 1 : 0;

always_comb
begin
	if((cntr_opr%5)==0)
	begin
		opr_1 = 1;
		opr_2 = 0;
		opr_3 = 0;
		opr_4 = 0;
		opr_5 = 0;
	end
	else if((cntr_opr%5)==4)
	begin
		opr_1 = 1;
		opr_2 = 1;
		opr_3 = 1;
		opr_4 = 1;
		opr_5 = 1;
	end	
	else if((cntr_opr%5)==3)
	begin
		opr_1 = 1;
		opr_2 = 1;
		opr_3 = 1;
		opr_4 = 1;
		opr_5 = 0;
	end	
	else if((cntr_opr%5)==2)
	begin
		opr_1 = 1;
		opr_2 = 1;
		opr_3 = 1;
		opr_4 = 0;
		opr_5 = 0;
	end	
	else if((cntr_opr%5)==1)
	begin
		opr_1 = 1;
		opr_2 = 1;
		opr_3 = 0;
		opr_4 = 0;
		opr_5 = 0;
	end	
	else  // This will never execute
	begin
		opr_1 = 1;
		opr_2 = 1;
		opr_3 = 1;
		opr_4 = 1;
		opr_5 = 1;
	end	

end


endmodule
