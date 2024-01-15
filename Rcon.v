module Rcon(inputNum,outputNum);
input [0:31] inputNum;
output reg [0:31] outputNum;

always @(*) begin
		case(inputNum)
			32'h00000001: outputNum = 32'h01000000;
			32'h00000002: outputNum = 32'h02000000;
			32'h00000003: outputNum = 32'h04000000;
			32'h00000004: outputNum = 32'h08000000;
			32'h00000005: outputNum = 32'h10000000;
			32'h00000006: outputNum = 32'h20000000;
			32'h00000007: outputNum = 32'h40000000;
			32'h00000008: outputNum = 32'h80000000;
			32'h00000009: outputNum = 32'h1b000000;
			32'h0000000a: outputNum = 32'h36000000;
			default: 
			outputNum = 32'h00000000;
		endcase
	end
endmodule 