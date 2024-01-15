module Cipher #(parameter Nk=4,parameter Nr=10)(inputText,inputKey,outputText,HEX0,HEX1,HEX2,KEY);
input  [0:127] inputText;
output[0:127] outputText;
input [0:(8*4*Nk)-1] inputKey;
wire [0:(32*4*(Nr+1))-1] w; 
wire[0:127] state[100:0];
wire [127:0] afterSubBytes[100:0];
wire [127:0] afterShiftRows[100:0];
wire [127:0] afterMixColumns[100:0];
wire [127:0] afterAddroundKey[100:0];

wire[0:127]tempsubbytes;
wire[0:127]tempshiftrows;

//7Segment
input [1:0]KEY;
wire [6:0] out1;
wire [6:0] out2;
wire [6:0] out3;
output[6:0] HEX0;
output[6:0] HEX1;
output[6:0] HEX2;

initial begin
$display("Initial test: %h", state[0]);
end

KeyExpansion #(Nk,Nr) KE(inputKey,w);

AddRoundKey ARK(inputText,w[0:(32*Nk)-1],state[1]);

genvar i;
generate
    for(i=1;i<Nr;i=i+1)  begin : LOOP
    SubByte SB(state[i],afterSubBytes[i]);
    ShiftRow SR(afterSubBytes[i], afterShiftRows[i]);
    MixColumn MIX(afterShiftRows[i],afterMixColumns[i]);
    AddRoundKey ARK1(afterMixColumns[i],w[(32*i*Nk) +:128],state[i+1]);
	 

//		initial begin
//		#100;
//		end


end
   SubByte SB1(state[Nr],tempsubbytes);
   ShiftRow SR1(tempsubbytes,tempshiftrows);
   AddRoundKey ARK2(tempshiftrows,w[(32*4*(Nr+1))-32*Nk:(32*4*(Nr+1))-1],state[99]);
assign outputText=state[99];

	   BCD2HEX BH1(state[99][0:3],out1);
		BCD2HEX BH2(state[99][4:7],out2);
		BCD2HEX BH3(state[99][8:11],out3);

		assign HEX0=out1;
		assign HEX1=out2;
		assign HEX2=out3;
endgenerate

endmodule
