module SubByteReverse_tb;

reg [0:127] inputState;
wire [0:127] outputState;
SubByteReverse s(inputState,outputState);

initial begin
$monitor("inputState= %h , outputState= %h",inputState,outputState);
inputState=128'h7a9f102789d5f50b2beffd9f3dca4ea7;
//outputState= bd6e7c3df2b5779e0b61216e8b10b689

end
endmodule
