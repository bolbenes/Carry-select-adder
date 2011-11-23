module fra_basic_bl_a (
		       input a,
		       input b,
		       input p,
		       input c1,
		       input c2,
		       output c3,
		       output c4,
		       output s);

	assign c4 = ~(a & b);
	assign c3 = ~(c1 & (c2 & p));
	assign s = p ^ (c1 & c2);

endmodule
