module AddRoundKey(inputState,key,outputState);

input [0:127] inputState;
input [0:127] key;
output [0:127] outputState;

assign outputState= inputState ^ key;

endmodule 