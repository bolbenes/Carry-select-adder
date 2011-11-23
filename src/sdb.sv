module sdb # (parameter width = 8) (
				    input c_in,
				    input a[0:width-1],
				    input b[0:width-1],
				    input p[0:width-1],
				    output s1[0:width-1],
				    output s2[0:width-1],
				    output c_out1,
				    output c_out2);
   
logic [0:width-1] to_invert_sum;
   
sdb_inner #(width) i_sdb1 (.c_in(c_in), .a(a), .b(b), .p(p), .s(s1), .c_out(c_out1));
sdb_inner #(width) i_sdb2 (.c_in(c_in), .a(a), .b(b), .p(p), .s(to_invert_sum)m .c_out(c_out2));
   
assign s2 = ~to_invert_sum;

endmodule
