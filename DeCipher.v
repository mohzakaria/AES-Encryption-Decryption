
module DeCipher #(parameter Nk=4,parameter Nr=10)(inputText,inputKey,outputText);
input  [0:127] inputText;
output[0:127] outputText;
input [0:(8*4*Nk)-1] inputKey;
wire [0:(32*4*(Nr+1))-1] w; 
wire[0:127] state[1000:0];
wire [0:127] afterSubBytes[0:1000];
wire [0:127] afterShiftRows[0:1000];
wire [0:127] afterMixColumns[0:1000];
wire [0:127] afterAddroundKey[0:1000];

wire[0:127]tempsubbytes;
wire[0:127]tempshiftrows;




KeyExpansion #(Nk,Nr) KE(inputKey,w);

initial begin
$display("Initial inputText: %h", inputText);
$display("Initial inputKey: %h", inputKey);
end
//1279 1407     1150 1279
AddRoundKey ARK(inputText,w[((128*(Nr+1))-1)-:128],state[1]);

initial begin
$display("key test: %h", w[0:127]);
end

genvar i;
generate
    for(i=1;i<Nr;i=i+1)  begin : LOOP

    InverseShiftRow ISR(state[i], afterShiftRows[i]);
    SubByteReverse SBR(afterShiftRows[i],afterSubBytes[i]);
    AddRoundKey ARK1(afterSubBytes[i],w[(((128*(Nr+1))-1)-128*i)-:128],afterAddroundKey[i]);
    InverseMixColumns IMIX(afterAddroundKey[i],state[i+1]);

    initial begin
    $display("STEPPP: %h", state[i+1]);
    end
   
end
   InverseShiftRow ISR1(state[Nr],tempshiftrows);
   SubByteReverse ISB1(tempshiftrows,tempsubbytes);
   AddRoundKey ARK2(tempsubbytes,w[0:(32*Nk)-1],state[200]);

assign outputText=state[200];
endgenerate


endmodule
