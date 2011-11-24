module  # (parameter width = 64) duplicated_carry_select_adder_parameter // minimum width = 4!
  (
   input [width-1:0] a,
   input [width-1:0] b,
   input  pa,
   input  pb,
   output logic [width-1:0] s,
   output logic [width-1:0] s_invert,
   output logic papb,
   output logic pab);

   logic [width-1:0] p;
   // les retenues c_out(numero de la sortie)[(numero de l'étage)]
   logic [width-1:0] c_out1;
   logic [width-1:0] c_out2;
   
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
   
   //////////// ETAGE 1 et 2 (toujours pareil) ////////////////

   sdb #(2) sdb_0(.c_in(1'b0),.a(a[1:0]),.b(b[1:0]),.p(p[1:0]),.s1(s[1:0]),.s2(s_invert[1:0]),.c_out_1(c_out1[0]),.c_out_2(c_out2[0]));
   
   basis_adder #(2) adder_1(.a(a[3:2]), .b(b[3:2]), .p(p[3:2]), .c_in1(c_out1[0]), .c_in2(c_out2[0]), .s(s[3:2]), .s_invert(s_invert[3:2]), .c_out1(c_out1[1]), .c_out2(c_out2[1]));

   
   // instancier les blocs qui restent (2, puis 4, 4, 6, 6, ... jusqu'on a assez de blocs
   
   logic bits_handled = 4;
   logic finished = 0;
   genvar i=2;
   current_block_size = 4;
	generate
	while(finished == 0)
		begin
			if(current_block_size <= width-bits_handled)
				begin
					int upperborder=bits_handled+current_block_size-1;
					int lowerborder=bits_handled;
					basis_adder #(current_block_size) adder_ia(.a(a[upperborder:lowerborder]), .b(b[upperborder:lowerborder]), .p(p[upperborder:lowerborder]), .c_in1(c_out1[i-1]), .c_in2(c_out2[i-1]), .s(s[upperborder:lowerborder]), .s_invert(s_invert[upperborder:lowerborder]), .c_out1(c_out1[i]), .c_out2(c_out2[i]));
				end
			else	
				finished = 1;
			if(current_block_size <= width-bits_handled-current_block_size)
				begin
					int upperborder=bits_handled+2*current_block_size-1;
					int lowerborder=bits_handled+current_block_size;
					basis_adder #(current_block_size) adder_ib(.a(a[upperborder:lowerborder]), .b(b[upperborder:lowerborder]), .p(p[upperborder:lowerborder]), .c_in1(c_out1[i]), .c_in2(c_out2[i]), .s(s[upperborder:lowerborder]), .s_invert(s_invert[upperborder:lowerborder]), .c_out1(c_out1[i+1]), .c_out2(c_out2[i+1]));
				end
			else
				finished = 1;
			current_block_size += 2;
			i+=2;
		end
	endgenerate
endmodule
      