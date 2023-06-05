module tb;
  logic [31:0]inst;
  logic [31:0]add;
  logic [31:0]sub;
  
  
  initial
    begin
      inst={6'd12,5'd8,5'd1, 16'd65535};
      $display("%h",inst);
      inst={6'd12,5'd25,5'd2, 16'd14741};
      $display("%h",inst);
      inst={6'd12,5'd3,5'd2, 16'd5};
      $display("%h",inst);
      add={6'd0, 5'd3, 5'd1, 5'd2, 11'b0};
      $display("%h",add);
      sub={6'd2, 5'd2, 5'd1, 5'd4, 11'b0};
      $display("Sub instruction = = %h",sub);
      
    end
endmodule
