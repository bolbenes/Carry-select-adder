module basis_adder # (parameter width = 8)
  (
   input [width-1:0] a,
   input [width-1:0] b,
   input [width-1:0] p,
   input c_in1,
   input c_in2,
   output logic [width-1:0] s,
   output logic [width-1:0] s_invert,
   output logic c_out1,
   output logic c_out2);

   // sorties internes au module
   logic [width-1:0] s_in0,s_invert_in0,s_in1,s_invert_in1;
   // c1 représente l'étape dans le calcul, out1/2 représente l'indice des retenues
   logic 	   c_out1_in0,c_out2_in0,c_out1_in1,c_out2_in1;

   sdb #(width) sdb_carry_in0(.c_in(0),.a(a),.b(b),.p(p),.s1(s_in0),.s2(s_invert_in0),.c_out1(c_out1_in0),.c_out2(c_out2_in0));
   sdb #(width) sdb_carry_in1(.c_in(1),.a(a),.b(b),.p(p),.s1(s_in1),.s2(s_invert_in1),.c_out1(c_out1_in1),.c_out2(c_out2_in1));

/********************************************************************************************************************
 *******************************************************************************************************************
				  Sélection des sorties correctent en fonction de la valeur des retenues
 ********************************************************************************************************************
 * ******************************************************************************************************************/
   always_comb
     begin
	if (c_in1 == 0)
	  begin
	     s <= s_in0;
	     c_out1 <= c_out1_in0;
	  end
	else
	  begin
	     s <= s_in1;
	     c_out1 <= c_out1_in1;
	  end
       	if (c_in2 == 0)
	  begin
	     s_invert <= s_invert_in0;
	     c_out2 <= c_out2_in0;
	  end
	else
	  begin
	     s_invert <= s_invert_in1;
	     c_out2 <= c_out2_in1;
	  end
     end
endmodule // duplicated_carry
