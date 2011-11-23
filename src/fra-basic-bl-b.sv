module fra_basic_bl_b (
		       input a,
		       input b,
		       input p,
		       input c3,
		       input c4,
		       output c1,
		       output c2,
		       output s);
 
	assign c1 = ~(c3 & (p & c4));
	assign c2 = a | b;
	assign s = p ^ ~(c3 & c4);

endmodule