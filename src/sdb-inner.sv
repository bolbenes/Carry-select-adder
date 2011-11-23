// parameter width has to be even and bigger than 2
module sdb_inner # (parameter width = 8) 
   (input c_in,
    input [width-1:0] a,
    input [width-1:0] b,
    input [width-1:0] p,
    output [width-1:0] s,
    output c_out);

   logic   [0:width-1] a_i;
   logic   [0:width-1] b_i;
   logic   [0:width-1] p_i;
   logic   [0:width-1] s_i;
   
   logic   [0:width/2+1] c1;
   logic   [0:width/2+1] c2;
   logic   [0:width/2] c3;
   logic   [0:width/2] c4;
   

    /*for(int i=0, i<width; i++);
		begin
			s[i]=s_i[i];
			a_i[i] = a[i];
			b_i[i] = b[i];
			p_i[i] = p[i];
		end*/
   
   assign c1[0] = c_in;
   assign c2[0] = c_in;

   genvar 	     i;
   
   generate
      for(i=0; i<width; i=i+2)
	begin
	   fra_basic_bl_a i_fra_basic_bl_a (.a(a[i]), .b(b[i]), .p(p[i]), .c1(c1[i/2]), .c2(c2[i/2]), .c3(c3[i/2]), .c4(c4[i/2]), .s(s[i]));
	   fra_basic_bl_b i_fra_basic_bl_b (.a(a[i+1]), .b(b[i+1]), .p(p[i+1]), .c1(c1[i/2+1]), .c2(c2[i/2+1]), .c3(c3[i/2]), .c4(c4[i/2]), .s(s[i+1]));
	end
   endgenerate
   assign c_out = c1[width/2] & c2[width/2];
   
endmodule