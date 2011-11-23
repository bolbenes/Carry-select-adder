module SDB_inner_tb;
   
   localparam width = 8;
   logic [width-1:0] a;
   logic [width-1:0] b;
   logic [width-1:0] p;
   logic [width-1:0] s1, s2;
   logic c_in;
   logic c_out_1, c_out_2;
   
   logic [width-1:0] expected_sum;
   
   sdb_inner #(width) I_SDB_INNER_1 (.a(a),.b(b),.p(p),.c_in(c_in),.c_out(c_out_1),.s(s1));
   sdb_inner #(width) I_SDB_INNER_2 (.a(a),.b(b),.p(p),.c_in(c_in),.c_out(c_out_2),.s(s2));
	
	initial
		begin
			a=$random();
			b=$random();
			c_in = $random();
			p=a^b;
			
		   expected_sum = a+b+c_in;
			#1;
			
			assert(c_out_1 != c_out_2)
				$display("ERROR : les retenues c1 et c2 sont différentes\n");

			assert(c_out_1 != expected_sum[width])
				$display("ERROR : les retenues n'ont pas la bonne valeur\n");

			assert (s1 != ~s2)
				$display("ERROR : les sommes ne sont pas inversé\n");

			assert(s1 != expected_sum[width-1:0])
				$display("ERROR : les sommes n'ont pas la bonne valeur\n");
		end
   
endmodule