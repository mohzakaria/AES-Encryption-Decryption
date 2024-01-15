module MixColumn (
  input [127:0] in,
  output [127:0] out
);

  function [7:0] MultiplyByTwo;
    input [7:0] x;
    begin
      if (x[7] == 1)//as according to the condition of the project
        MultiplyByTwo = ((x << 1) ^ 8'h1b);
      else
        MultiplyByTwo = x << 1; 
    end
  endfunction

  function [7:0] MultiplyByThree;
    input [7:0] x;
    begin//(x+1)
      MultiplyByThree = (MultiplyByTwo(x) ^ x);
    end
  endfunction

  genvar i;
  generate
    for (i = 0; i < 4; i = i + 1) begin : colmixing
   assign out[(i*32 + 24)+:8]= MultiplyByTwo(in[(i*32 + 24)+:8]) ^ MultiplyByThree(in[(i*32 + 16)+:8]) ^ in[(i*32 + 8)+:8] ^ in[i*32+:8];
	assign out[(i*32 + 16)+:8]= in[(i*32 + 24)+:8] ^ MultiplyByTwo(in[(i*32 + 16)+:8]) ^ MultiplyByThree(in[(i*32 + 8)+:8]) ^ in[i*32+:8];
	assign out[(i*32 + 8)+:8]= in[(i*32 + 24)+:8] ^ in[(i*32 + 16)+:8] ^ MultiplyByTwo(in[(i*32 + 8)+:8]) ^ MultiplyByThree(in[i*32+:8]);
   assign out[i*32+:8]= MultiplyByThree(in[(i*32 + 24)+:8]) ^ in[(i*32 + 16)+:8] ^ in[(i*32 + 8)+:8] ^ MultiplyByTwo(in[i*32+:8]);

    end
  endgenerate

endmodule

