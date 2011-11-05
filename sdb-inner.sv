// parameter width has to be even and bigger than 2
module sdb_inner # (parameter width = 8) (input c_in, input a[0:width-1], input b[0:width-1], input p[0:width-1], output s[0:width-1], output c_out);

logic [0:width/2+1] c1, c2;
logic [0:width/2] c3,c4;

assign c1[0] = c_in;
assign c2[0] = c_in;

for(int i=0; i<width; i=i+2)
begin
	fra-basic-bl-a i_fra-basic-bl-a[i] (.a(a[i]), .b(b[i]), .p(p[i]), .c1(c1[i/2]), .c2(c2[i/2]), .c3(c3[i/2]), .c4(c4[i/2]), .s(s[i]));
	fra-basic-bl-b i_fra-basic-bl-b[i] (.a(a[i+1], .b(b[i+1]), .p(p[i+1]), .c1(c1[i/2+1]), .c2(c2[i/2+1]), .c3(c3[i/2]), .c4(c4[i/2]), .s(s[i+1]));
end

assign c_out = c1[width/2+1] and c2[width/2+1];

endmodule