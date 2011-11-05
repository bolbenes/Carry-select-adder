module fra-basic-bl-a (input a, input b, input c3, input c4, output c1, output c2, output s);
	assign c1 = ~(c3 and (p and c4));
	assign c2 = a or b;
	assign s = p ^ ~(c3 and c4);
endmodule