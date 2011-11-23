module basis_adder_tb;

   logic [7:0] a,b,s,s_invert;
   logic [8:0] s_test;
   logic       p,c_in1,c_in2,c_out1,c_out2,c_out1_test,c_out2_test;
   
   	     basis_adder #(8) test_basis(.a(a),.b(b),.p(p),.c_in1(c_in1),.c_in2(c_in2),.s(s),.s_invert(s_invert),.c_out1(c_out1),.c_out2(c_out2));

   initial
     begin
	#5;
	repeat(10)
	  begin
	     #1;
	     a = $random();
	     b = $random();
	     c_in1 = $random();
	     assign p= a^b;
	     
	     
	     s_test = a+b+c_in1;
	     

	     assert(s == s_test[7:0])
	       $display("ERROR : s est incorect");
	     assert(s == ~s_test[7:0])
	       $display("ERROR : ~s est incorrect");
	     assert(c_out1 == s_test[8])
	       $display("ERROR : c_out1 est incorrect");
	     assert(c_out2 == s_test[8])
	       $display("ERROR : c_out2 est incorrect");
	  end // repeat (100)
	
	
     end
endmodule // basic_adder_tb
