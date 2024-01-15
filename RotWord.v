module RotWord(inputNum,outputNum);
input [0:31] inputNum;
output [0:31] outputNum;

assign outputNum[0:23]=inputNum[8:31];
assign outputNum[24:31]=inputNum[0:7];

endmodule 