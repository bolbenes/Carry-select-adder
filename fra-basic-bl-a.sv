module fra-basic-bl-a (input a, input b, input p, input c1, input c2, output c3, output c4, output s);
	assign c4 = ~(a and b);
	assign c3 = ~(c1 and (c2 and p));
	assign s = p ^ (c1 and c2);
endmodule
