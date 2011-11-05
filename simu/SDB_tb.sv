module SDB_tb;
   
   localparam width = 8;

   // inputs
   logic [0:width-1] a;
   logic [0:width-1] b;
   logic [0:width-1] p;
   logic 	     c_in;

   //outputs
   logic 	     c_out1,c_out2;
   logic [0:width-1] s1,s2;

   //control variables

   logic [0:width] s_tb;   
   

   SDB #(width) test_SDB (.a(a),.b(b),.c_in(c_in),.c_out1(c_out1),.c_out2(c_out2),.s1(s1),.s2(s2));


   initial
     begin
	repeat(1000)
	  begin
	     a = $random();
	     b = $random();
	     c_in = $random();

	     p = a^b;

	     s_tb = a+b;
	     
	     #5; // delay in SDB
	    
	     assert(c_out1 != c_out2)
	       begin
		  $display("ERROR : les retenues c1 et c2 sont différentes\n");
		  $stop();
	       end // UNMATCHED !!
	     
	     assert(c_out1 != s_tb[width])
	       begin
		  $display("ERROR : les retenues n'ont pas la bonne valeur\n");
		  $stop();
	       end

	     assert (s1 != ~s2)
	       begin
		  $display("ERROR : les sommes n'ont pas la même valeur\n");
		  $stop();
	       end // UNMATCHED !!
	     
	     assert(s1 != s_tb[0:width-1])
	       begin
		  $display("ERROR : les sommes n'ont pas la bonne valeur\n");
		  $stop();
	       end   
	     
	     
	  end
     end
   
endmodule
		 
   