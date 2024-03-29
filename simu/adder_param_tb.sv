module adder_param_tb;
   
   localparam width = 64;
   logic [width-1:0] a,b;
   
   logic 	     pa,pb;
   logic [width-1:0] s1, s2;
   logic 	     papb,pab;
   
   //logic c_in;
   //logic c_out_1, c_out_2;
   
   logic [width:0] expected_sum;
   
   duplicated_carry_select_adder_parameter #(width) I_duplicated_carry_select_adder_parameter (.a(a), .b(b), .pa(pa), .pb(pb), .s(s1), .s_invert(s2), .papb(papb), .pab(pab));
	initial
	  begin
	     for(int i=0; i<1000; i++)
	       begin
		  a=$random();
		  b=$random();
		  pa=a[0];
		  pb=b[0];
		  for(int i=1; i<width; i++)
			begin
				pa=pa^a[i];
				pb=pb^b[i];
			end
		  
		  
		  
		  expected_sum = a+b;
		  #1;
		  
		  /*assert(c_out_1 == c_out_2)
		    else $display("ERROR : les retenues c1 et c2 sont diff�rentes\n");
		  
		  assert(c_out_1 == expected_sum[width])
		    else $display("ERROR : les retenues n'ont pas la bonne valeur\n");
		  */
		  assert (s1 == ~s2)
		    else $display("ERROR : les sommes ne sont pas invers�\n");
		  
		  assert(s1 == expected_sum[width-1:0])
		    else $display("ERROR : les sommes n'ont pas la bonne valeur\n");
	       end // for (int i=0; i<1000; i++)
	     
	  end
   
endmodule