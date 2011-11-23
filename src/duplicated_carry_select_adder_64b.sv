module duplicated_carry_select_adder_64b
  (
   input [63:0] a,
   input [63:0] b,
   input  pa,
   input  pb,
   output logic [63:0] s,
   output logic [63:0] s_invert,
   output logic papb,
   output logic pab);

   logic [63:0] p;
   // les retenues c(numero de l'étage)_out(numero de la sortie)
   logic 	c1_out1,c1_out2;
   logic 	c2_out1,c2_out2;
   logic 	c3_out1,c3_out2;
   logic 	c4_out1,c4_out2;
   logic 	c5_out1,c5_out2;
   
   assign papb = pa^pb;

   // calcul de p(a xor b)
   always_comb
     begin
	pab = p[0];
	for(int i=1; i<64; i++)
	  begin
	     pab = pab ^ p[i];
	  end
     end
      
   assign p = a^b;

//////////// ETAGE 1 ////////////////

   sdb #(8) sdb_1(.c_in(0),.a(a[7:0]),.b(b[7:0]),.p(p[7:0]),.s1(s[7:0]),.s2(s_invert[7:0]),.c_out1(c1_out1),.c_out2(c1_out2));

   //////// ETAGE 2 /////////////

   basis_adder #(8) adder_2(.a(a[15:8]), .b(b[15:8]), .p(p[15:8]), .c_in1(c1_out1), .c_in2(c1_out2), .s(s[15:8]), .s_invert(s_invert[15:8]), .c_out1(c2_out1), .c_out2(c2_out2));

   //////// ETAGE 3 /////////////

   basis_adder #(12) adder_3(.a(a[27:16]),.b(b[27:16]),.p(p[27:16]),.c_in1(c2_out1),.c_in2(c2_out2),.s(s[27:16]),.s_invert(s_invert[27:16]),.c_out1(c3_out1),.c_out2(c3_out2));

   //////// ETAGE 4 /////////////

   basis_adder #(12) adder_4(.a(a[39:28]),.b(b[39:28]),.p(p[39:28]),.c_in1(c3_out1),.c_in2(c3_out2),.s(s[39:28]),.s_invert(s_invert[39:28]),.c_out1(c4_out1),.c_out2(c4_out2));

    //////// ETAGE 5 /////////////

   basis_adder #(12) adder_5(.a(a[51:40]),.b(b[51:40]),.p(p[51:40]),.c_in1(c4_out1),.c_in2(c4_out2),.s(s[51:40]),.s_invert(s_invert[51:40]),.c_out1(c5_out1),.c_out2(c5_out2));

 //////// ETAGE 6 /////////////

   basis_adder #(12) adder_6(.a(a[63:52]),.b(b[63:52]),.p(p[63:52]),.c_in1(c5_out1),.c_in2(c5_out2),.s(s[63:52]),.s_invert(s_invert[63:52]),.c_out1(),.c_out2());
   
endmodule
      