module sdb # (parameter width = 8) (
				    input c_in,
				    input [width-1:0] a,
				    input [width-1:0] b,
				    input [width-1:0] p,
				    output [width-1:0] s1,
					output [width-1:0] s2,
				    output c_out_1,
				    output c_out_2);
   
logic [width-1:0] to_invert_sum;
   
sdb_inner #(width) i_sdb1 (.c_in(c_in), .a(a), .b(b), .p(p), .s(s1), .c_out(c_out_1));
sdb_inner #(width) i_sdb2 (.c_in(c_in), .a(a), .b(b), .p(p), .s(to_invert_sum), .c_out(c_out_2));
   
assign s2 = ~to_invert_sum;

endmodule
