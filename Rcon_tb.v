module Rcon_tb;
reg [0:7] inputNum;
wire [0:31] outputNum;


Rcon r(inputNum,outputNum);

initial begin
$monitor("inputNum= %h , outputNum= %h",inputNum,outputNum);
inputNum=8'h0a;

end
endmodule
