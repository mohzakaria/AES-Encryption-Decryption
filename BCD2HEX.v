module BCD2HEX(in,out);
input [3:0] in;     
output [6:0] out;     

assign out=
		(in == 4'b0000)? 7'b1000000: 
		(in == 4'b0001)? 7'b1111001:
		(in == 4'b0010)? 7'b0100100:
		(in == 4'b0011)? 7'b0110000:
		(in == 4'b0100)? 7'b0011001:
		(in == 4'b0101)? 7'b0010010:
		(in == 4'b0110)? 7'b0000010:
		(in == 4'b0111)? 7'b1110000:
		(in == 4'b1000)? 7'b0000000:
		(in == 4'b1001)? 7'b0010000:

		(in == 4'b1010)? 7'b0001000:
		(in == 4'b1011)? 7'b0000011:
		(in == 4'b1100)? 7'b1000110:
		(in == 4'b1101)? 7'b0100001:
		(in == 4'b1110)? 7'b0000110:
		(in == 4'b1111)? 7'b0001110:
		 8'b00000000; 
endmodule