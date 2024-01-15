
module SubByteReverse(inputState,outputState);
input [127:0] inputState;
output [127:0] outputState;

  genvar i;
  generate
    for (i = 0; i < 128; i = i + 8) begin : outer_loop
          SBoxReverse s(inputState[7+i:i],outputState[7+i:i]);
    end
  endgenerate

endmodule 