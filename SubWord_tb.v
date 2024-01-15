module SubWord_tb;

reg [0:31] inputState;
wire[0:31] outputState;
SubWord s(inputState,outputState);

initial begin
$monitor("inputState= %h , outputState= %h",inputState,outputState);
inputState=32'h12345678;
//outputState= c918b1bc

end
endmodule
