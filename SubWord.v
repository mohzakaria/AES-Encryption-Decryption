module SubWord(inputState,outputState);
input [0:31] inputState;
output [0:31] outputState;

//word = 4bytes= 32 bit

// Using a generate block for loop-like construct
  genvar i;
  generate
    for (i = 0; i < 32; i = i + 8) begin : outer_loop
          SBox s(inputState[i:7+i],outputState[i:7+i]);
    end
  endgenerate

endmodule 