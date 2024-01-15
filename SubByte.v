module SubByte(inputState,outputState);
input [127:0] inputState;
output [127:0] outputState;

//matrix 4x4 = 16 box
//kol box fehom byte
//yb2a total =8x16=128

  genvar i;
  generate
    for (i = 0; i < 128; i = i + 8) begin : outer_loop
          SBox s(inputState[7+i:i],outputState[7+i:i]);
    end
  endgenerate

endmodule 
