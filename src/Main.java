import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;

public class Main {

	/**
	 * @param args
	 *            first argument: number of bits for the adder (at least 4,
	 *            default 64, maximum 128)
	 */
	public static void main(String[] args) {
		int numberOfBits;
		if (args.length==0) {
			numberOfBits = 64;
		} else {
			numberOfBits = Integer.parseInt(args[0]);
		}
		String fileName = "duplicated_carry_select_adder_" + numberOfBits
				+ ".sv";
		Writer fw = null;

		try {
			fw = new FileWriter(fileName);
			writeLine(fw, "module duplicated_carry_select_adder_"
					+ numberOfBits);
			writeLine(fw, "  (");
			writeLine(fw, "   input [" + numberOfBits + "-1:0] a,");
			writeLine(fw, "   input [" + numberOfBits + "-1:0] b,");
			writeLine(fw, "   input  pa,");
			writeLine(fw, "   input  pb,");
			writeLine(fw, "   output logic [" + numberOfBits + "-1:0] s,");
			writeLine(fw, "   output logic [" + numberOfBits + "-1:0] s_invert,");
			writeLine(fw, "   output logic papb,");
			writeLine(fw, "   output logic pab);");
			writeLine(fw, "");
			writeLine(fw, "   logic [" + numberOfBits + "-1:0] p;");
			writeLine(fw,
					"   // les retenues c_out(numero de la sortie)[(numero de l'étage)]");
			writeLine(fw, "   logic [" + numberOfBits + "-1:0] c_out1;");
			writeLine(fw, "   logic [" + numberOfBits + "-1:0] c_out2;");
			writeLine(fw, "");
			writeLine(fw, "   assign papb = pa^pb;");
			writeLine(fw, "");
			writeLine(fw, "   // calcul de p(a xor b)");
			writeLine(fw, "   always_comb");
			writeLine(fw, "     begin");
			writeLine(fw, "	pab = p[0];");
			writeLine(fw, "	for(int i=1; i<" + numberOfBits + "; i++)");
			writeLine(fw, "	  begin");
			writeLine(fw, "	     pab = pab ^ p[i];");
			writeLine(fw, "	  end");
			writeLine(fw, "     end");
			writeLine(fw, "");
			writeLine(fw, "   assign p = a^b;");
			writeLine(fw, "");
			writeLine(fw, "   //////////// ETAGE 1 et 2 (taille 2) ////////////////");
			writeLine(
					fw,
					"   sdb #(2) sdb_0(.c_in(1'b0),.a(a[1:0]),.b(b[1:0]),.p(p[1:0]),.s1(s[1:0]),.s2(s_invert[1:0]),.c_out_1(c_out1[0]),.c_out_2(c_out2[0]));");
			writeLine(
					fw,
					"   basis_adder #(2) adder_1(.a(a[3:2]), .b(b[3:2]), .p(p[3:2]), .c_in1(c_out1[0]), .c_in2(c_out2[0]), .s(s[3:2]), .s_invert(s_invert[3:2]), .c_out1(c_out1[1]), .c_out2(c_out2[1]));");
			int bits_handled = 4;
			int current_block_size = 4;
			for (int i = 2; i < numberOfBits; i+=2) {
				if(current_block_size*2 <= numberOfBits-bits_handled){
					writeLine(fw, "   //////////// ETAGE "+i+" et "+(i+1)+" (taille "+current_block_size+") ////////////////");
				} else if(current_block_size < numberOfBits-bits_handled) {
					int width=numberOfBits-bits_handled-current_block_size;
					writeLine(fw, "   //////////// ETAGE "+i+" et "+(i+1)+" (taille "+current_block_size+" et "+width+") ////////////////");
				} else {
					if(numberOfBits > bits_handled){
						int width=numberOfBits-bits_handled-current_block_size;
						width=numberOfBits-bits_handled;
						writeLine(fw, "   //////////// ETAGE "+i+" (taille "+width+") ////////////////");						
					}
				}
				if(current_block_size <= numberOfBits-bits_handled){
					int upperborder=bits_handled+current_block_size-1;
					int lowerborder=bits_handled;
					int j = i-1;
					writeLine(fw, "   basis_adder #(" + current_block_size + ") adder_"+i+"(.a(a["+upperborder+":"+lowerborder+"]), .b(b["+upperborder+":"+lowerborder+"]), .p(p["+upperborder+":"+lowerborder+"]), .c_in1(c_out1["+ j +"]), .c_in2(c_out2["+ j +"]), .s(s["+upperborder+":"+lowerborder+"]), .s_invert(s_invert["+upperborder+":"+lowerborder+"]), .c_out1(c_out1["+i+"]), .c_out2(c_out2["+i+"]));");
				} else if (numberOfBits-bits_handled > 0)
				{
					int upperborder=numberOfBits-1;
					int lowerborder=bits_handled;
					int j = i-1;
					int width = numberOfBits-bits_handled;
					writeLine(fw, "   basis_adder #(" + width + ") adder_"+i+"(.a(a["+upperborder+":"+lowerborder+"]), .b(b["+upperborder+":"+lowerborder+"]), .p(p["+upperborder+":"+lowerborder+"]), .c_in1(c_out1["+ j +"]), .c_in2(c_out2["+ j +"]), .s(s["+upperborder+":"+lowerborder+"]), .s_invert(s_invert["+upperborder+":"+lowerborder+"]), .c_out1(c_out1["+i+"]), .c_out2(c_out2["+i+"]));");
					break;
				}
				else{
					break;
				}
				if(current_block_size <= numberOfBits-bits_handled-current_block_size){
					int upperborder=bits_handled+2*current_block_size-1;
					int lowerborder=bits_handled+current_block_size;
					int k = i+1;
					writeLine(fw, "   basis_adder #(" + current_block_size + ") adder_"+k+"(.a(a["+upperborder+":"+lowerborder+"]), .b(b["+upperborder+":"+lowerborder+"]), .p(p["+upperborder+":"+lowerborder+"]), .c_in1(c_out1["+ i +"]), .c_in2(c_out2["+ i +"]), .s(s["+upperborder+":"+lowerborder+"]), .s_invert(s_invert["+upperborder+":"+lowerborder+"]), .c_out1(c_out1["+k+"]), .c_out2(c_out2["+k+"]));");
				} else if(numberOfBits-bits_handled > 0){
					int upperborder=numberOfBits-1;
					int lowerborder=bits_handled+current_block_size;
					int k = i+1;
					int width = numberOfBits-bits_handled-current_block_size;
					writeLine(fw, "   basis_adder #(" + width + ") adder_"+k+"(.a(a["+upperborder+":"+lowerborder+"]), .b(b["+upperborder+":"+lowerborder+"]), .p(p["+upperborder+":"+lowerborder+"]), .c_in1(c_out1["+ i +"]), .c_in2(c_out2["+ i +"]), .s(s["+upperborder+":"+lowerborder+"]), .s_invert(s_invert["+upperborder+":"+lowerborder+"]), .c_out1(c_out1["+k+"]), .c_out2(c_out2["+k+"]));");
					break;
				}
				else{
					break;
				}
				bits_handled+=2*current_block_size;
				current_block_size+=2;
			}
			writeLine(fw, "");
			writeLine(fw, "endmodule");
		} catch (IOException e) {
			System.err.println("Couldn't write / create file");
		} finally {
			if (fw != null)
				try {
					fw.close();
				} catch (IOException e) {
				}
		}
		
		fileName = "adder" + numberOfBits
				+ "_tb.sv";
		
		// Génération du testbench
		
		try {
			fw = new FileWriter(fileName);
			writeLine(fw, "module adder"+numberOfBits+"_tb;");
			writeLine(fw, "   localparam width = "+numberOfBits+";");
			writeLine(fw, "   logic [width-1:0] a,b;");
			writeLine(fw, "   logic 	     pa,pb;");
			writeLine(fw, "   logic [width-1:0] s1, s2;");
			writeLine(fw, "   logic 	     papb,pab;");
			writeLine(fw, "   logic [width:0] expected_sum;");
			writeLine(fw, "");
			writeLine(fw, "   duplicated_carry_select_adder_"+numberOfBits+" I_duplicated_carry_select_adder_"+numberOfBits+" (.a(a), .b(b), .pa(pa), .pb(pb), .s(s1), .s_invert(s2), .papb(papb), .pab(pab));");
			writeLine(fw, "	initial");
			writeLine(fw, "	  begin");
			writeLine(fw, "	     for(int i=0; i<1000; i++)");
			writeLine(fw, "	       begin");
			writeLine(fw, "		  a=$random();");
			writeLine(fw, "		  b=$random();");
			writeLine(fw, "		  pa=a[0];");
			writeLine(fw, "		  pb=b[0];");
			writeLine(fw, "		  for(int i=1; i<width; i++)");
			writeLine(fw, "			begin");
			writeLine(fw, "				pa=pa^a[i];");
			writeLine(fw, "				pb=pb^b[i];");
			writeLine(fw, "			end");
			writeLine(fw, "		  expected_sum = a+b;");
			writeLine(fw, "		  #1;");
			writeLine(fw, "");
			writeLine(fw, "		  assert (s1 == ~s2)");
			writeLine(fw, "		    else $display(\"ERROR : les sommes ne sont pas inversé\\n\");");
			writeLine(fw, "		  assert(s1 == expected_sum[width-1:0])");
			writeLine(fw, "		    else $display(\"ERROR : les sommes n'ont pas la bonne valeur\\n\");");
			writeLine(fw, "	       end // for (int i=0; i<1000; i++)");
			writeLine(fw, "	  end");
			writeLine(fw, "");
			writeLine(fw, "endmodule");
		} catch (IOException e) {
			System.err.println("Couldn't write / create file");
		} finally {
			if (fw != null)
				try {
					fw.close();
				} catch (IOException e) {
				}
		}
	}

	private static void writeLine(Writer fw, String text) throws IOException {
		fw.write(text);
		fw.append(System.getProperty("line.separator")); // e.g. "\n"
	}

}
