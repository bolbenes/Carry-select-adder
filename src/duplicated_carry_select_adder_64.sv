module duplicated_carry_select_adder_64
  (
   input [64-1:0] a,
   input [64-1:0] b,
   input  pa,
   input  pb,
   output logic [64-1:0] s,
   output logic [64-1:0] s_invert,
   output logic papb,
   output logic pab);

   logic [64-1:0] p;
   // les retenues c_out(numero de la sortie)[(numero de l'étage)]
   logic [64-1:0] c_out1;
   logic [64-1:0] c_out2;

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

   //////////// ETAGE 1 et 2 (taille 2) ////////////////
   sdb #(2) sdb_0(.c_in(1'b0),.a(a[1:0]),.b(b[1:0]),.p(p[1:0]),.s1(s[1:0]),.s2(s_invert[1:0]),.c_out_1(c_out1[0]),.c_out_2(c_out2[0]));
   basis_adder #(2) adder_1(.a(a[3:2]), .b(b[3:2]), .p(p[3:2]), .c_in1(c_out1[0]), .c_in2(c_out2[0]), .s(s[3:2]), .s_invert(s_invert[3:2]), .c_out1(c_out1[1]), .c_out2(c_out2[1]));
   //////////// ETAGE 2 et 3 (taille 4) ////////////////
   basis_adder #(4) adder_2(.a(a[7:4]), .b(b[7:4]), .p(p[7:4]), .c_in1(c_out1[1]), .c_in2(c_out2[1]), .s(s[7:4]), .s_invert(s_invert[7:4]), .c_out1(c_out1[2]), .c_out2(c_out2[2]));
   basis_adder #(4) adder_2(.a(a[11:8]), .b(b[11:8]), .p(p[11:8]), .c_in1(c_out1[2]), .c_in2(c_out2[2]), .s(s[11:8]), .s_invert(s_invert[11:8]), .c_out1(c_out1[3]), .c_out2(c_out2[3]));
   //////////// ETAGE 4 et 5 (taille 6) ////////////////
   basis_adder #(6) adder_4(.a(a[17:12]), .b(b[17:12]), .p(p[17:12]), .c_in1(c_out1[3]), .c_in2(c_out2[3]), .s(s[17:12]), .s_invert(s_invert[17:12]), .c_out1(c_out1[4]), .c_out2(c_out2[4]));
   basis_adder #(6) adder_4(.a(a[23:18]), .b(b[23:18]), .p(p[23:18]), .c_in1(c_out1[4]), .c_in2(c_out2[4]), .s(s[23:18]), .s_invert(s_invert[23:18]), .c_out1(c_out1[5]), .c_out2(c_out2[5]));
   //////////// ETAGE 6 et 7 (taille 8) ////////////////
   basis_adder #(8) adder_6(.a(a[31:24]), .b(b[31:24]), .p(p[31:24]), .c_in1(c_out1[5]), .c_in2(c_out2[5]), .s(s[31:24]), .s_invert(s_invert[31:24]), .c_out1(c_out1[6]), .c_out2(c_out2[6]));
   basis_adder #(8) adder_6(.a(a[39:32]), .b(b[39:32]), .p(p[39:32]), .c_in1(c_out1[6]), .c_in2(c_out2[6]), .s(s[39:32]), .s_invert(s_invert[39:32]), .c_out1(c_out1[7]), .c_out2(c_out2[7]));
   //////////// ETAGE 8 et 9 (taille 10) ////////////////
   basis_adder #(10) adder_8(.a(a[49:40]), .b(b[49:40]), .p(p[49:40]), .c_in1(c_out1[7]), .c_in2(c_out2[7]), .s(s[49:40]), .s_invert(s_invert[49:40]), .c_out1(c_out1[8]), .c_out2(c_out2[8]));
   basis_adder #(10) adder_8(.a(a[59:50]), .b(b[59:50]), .p(p[59:50]), .c_in1(c_out1[8]), .c_in2(c_out2[8]), .s(s[59:50]), .s_invert(s_invert[59:50]), .c_out1(c_out1[9]), .c_out2(c_out2[9]));
   //////////// ETAGE 10 (taille 4) ////////////////
   basis_adder #(4) adder_10(.a(a[63:60]), .b(b[63:60]), .p(p[63:60]), .c_in1(c_out1[9]), .c_in2(c_out2[9]), .s(s[63:60]), .s_invert(s_invert[63:60]), .c_out1(c_out1[10]), .c_out2(c_out2[10]));

endmodule
