module InverseMixColumns (
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
  
  
  //////multiply by 4 is multiply by 2 2 times since 4=2*2
  function[7:0] MultiplyByFour(input [7:0]x);
	integer i;
	begin
		for(i=0;i<2;i=i+1)begin
			x= MultiplyByTwo(x);
		end
	MultiplyByFour=x;
	end
	endfunction

	
	///multiply by 8 is multiply by 2 3 times since 8=2*2*2
  function[7:0] MultiplyByEight(input [7:0]x);
	integer i;
	begin
		for(i=0;i<3;i=i+1)begin
			x= MultiplyByTwo(x);
		end
	MultiplyByEight=x;
	end
	endfunction
	
	//as 09 which is 9=8+1 so x*9 will be = x*(8+1)
	function[7:0] MultiplyByNine(input [7:0]x);
	begin
	MultiplyByNine=MultiplyByEight(x)^x;
	end
	endfunction
	
	
	//as 0b is 11 which is 11=8+2+1 so x*11 will be = x*(8+2+1)
	function[7:0] MultiplyBy0B(input [7:0]x);
	begin
	MultiplyBy0B=MultiplyByEight(x)^MultiplyByTwo(x)^x;
	end
	endfunction
	
	//as 0d is 13 which is 13=8+4+1 so x*13 will be = x*(8+4+1)
	function[7:0] MultiplyBy0D(input [7:0]x);
	begin
	MultiplyBy0D=MultiplyByEight(x)^MultiplyByFour(x)^x;
	end
	endfunction
	
	//as 0e is 14 which is 14=8+4+2 so x*14 will be = x*(8+4+2)
	
	function[7:0] MultiplyBy0E(input [7:0]x);
	begin
	MultiplyBy0E=MultiplyByEight(x)^MultiplyByFour(x)^MultiplyByTwo(x);
	end
	endfunction
	
	
	
	

  genvar i;
  generate
    for (i = 0; i < 4; i = i + 1) begin : colmixing
      assign out[(i*32 + 24)+:8]= MultiplyBy0E(in[(i*32 + 24)+:8]) ^ MultiplyBy0B(in[(i*32 + 16)+:8]) ^ MultiplyBy0D(in[(i*32 + 8)+:8]) ^ MultiplyByNine(in[i*32+:8]);
		assign out[(i*32 + 16)+:8]= MultiplyByNine(in[(i*32 + 24)+:8]) ^ MultiplyBy0E(in[(i*32 + 16)+:8]) ^ MultiplyBy0B(in[(i*32 + 8)+:8]) ^ MultiplyBy0D(in[i*32+:8]);
		assign out[(i*32 + 8)+:8]= MultiplyBy0D(in[(i*32 + 24)+:8]) ^ MultiplyByNine(in[(i*32 + 16)+:8]) ^ MultiplyBy0E(in[(i*32 + 8)+:8]) ^ MultiplyBy0B(in[i*32+:8]);
		assign out[i*32+:8]= MultiplyBy0B(in[(i*32 + 24)+:8]) ^ MultiplyBy0D(in[(i*32 + 16)+:8]) ^ MultiplyByNine(in[(i*32 + 8)+:8]) ^ MultiplyBy0E(in[i*32+:8]);
    end
  endgenerate

endmodule

