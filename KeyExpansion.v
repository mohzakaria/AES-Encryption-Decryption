module KeyExpansion #(parameter Nk=4,parameter Nr=10)(inputKey,w);

input [0:(8*4*Nk)-1] inputKey;     //at nk=4 -> [0:127]
output reg [0:(32*4*(Nr+1))-1] w;  //at nk=4,nr=10 -> [0:1407]

reg [0:31] temp;
reg [0:7] i_reg;
//reg [0:31] tempXor;

reg [0:31] tempRotWord;
reg [0:31] tempSubWord1;
reg [0:31] tempSubWord2;
reg [0:31] tempRcon;
reg [0:31] tempXor;

//RotWord  rot(temp,tempRotWord);
//SubWord	subword1(tempRotWord,tempSubWord1);
//Rcon  rcon(i_reg/Nk,tempRcon);	
//SubWord	subword2(temp,tempSubWord2);

integer i;

always@(*) begin
for (i = 0; i < Nk; i = i + 1) begin : loop_1
	i_reg=i;
	w[i*32 +: 32] = inputKey [32*i +: 32];	
end


for (i = Nk; i < 4*(Nr+1); i = i + 1) begin : loop_2
	//$display("w 1 isss= %h ",w);
	i_reg=i;
	temp=w[(i-1)*32 +: 32];
	//$display("temp 1 isss= %h ",temp);
	if((i % Nk) == 0) begin
		tempRotWord=RotWord(temp);
		tempSubWord1=SubWord(tempRotWord);
		tempRcon=Rcon(i_reg/Nk);
		temp=tempSubWord1^tempRcon;
		//$display("temp 2 isss= %h ",temp);
	end else if(Nk>6 && i % Nk == 4) begin
		tempSubWord2=SubWord(temp);
		temp=tempSubWord2;
		//$display("temp 3 isss= %h ",temp);
	end
	//$display("w[(i-Nk)*32 +: 32] 1 isss= %h ",w[(i-Nk)*32 +: 32]);
	//$display("temp 4 isss= %h ",temp);
	w[i*32 +: 32] = w[(i-Nk)*32 +: 32] ^ temp;
	//$display("w[i*32 +: 32] isss= %h ",w[i*32 +: 32]);
end
end
////////////////////////////////
function [0:31] RotWord;
input [0:31] inputNum;
begin

RotWord[0:23]=inputNum[8:31];
RotWord[24:31]=inputNum[0:7];
end

endfunction
//////////////////////////////
function [0:31] SubWord;
input [0:31] inputState;
begin
 SubWord[0:7]=sBox(inputState[0:7]);
 SubWord[8:15]=sBox(inputState[8:15]);
 SubWord[16:23]=sBox(inputState[16:23]);
 SubWord[24:31]=sBox(inputState[24:31]);

end
endfunction 

function [7:0] sBox;
input [7:0] inputByte;


begin
		case(inputByte)
			8'h00: sBox=8'h63;
			8'h01: sBox=8'h7c;
			8'h02: sBox=8'h77;
			8'h03: sBox=8'h7b;
			8'h04: sBox=8'hf2;
			8'h05: sBox=8'h6b;
			8'h06: sBox=8'h6f;
			8'h07: sBox=8'hc5;
			8'h08: sBox=8'h30;
			8'h09: sBox=8'h01;
			8'h0a: sBox=8'h67;
			8'h0b: sBox=8'h2b;
			8'h0c: sBox=8'hfe;
			8'h0d: sBox=8'hd7;
			8'h0e: sBox=8'hab;
			8'h0f: sBox=8'h76;
			8'h10: sBox=8'hca;
			8'h11: sBox=8'h82;
			8'h12: sBox=8'hc9;
			8'h13: sBox=8'h7d;
			8'h14: sBox=8'hfa;
			8'h15: sBox=8'h59;
			8'h16: sBox=8'h47;
			8'h17: sBox=8'hf0;
			8'h18: sBox=8'had;
			8'h19: sBox=8'hd4;
			8'h1a: sBox=8'ha2;
			8'h1b: sBox=8'haf;
			8'h1c: sBox=8'h9c;
			8'h1d: sBox=8'ha4;
			8'h1e: sBox=8'h72;
			8'h1f: sBox=8'hc0;
			8'h20: sBox=8'hb7;
			8'h21: sBox=8'hfd;
			8'h22: sBox=8'h93;
			8'h23: sBox=8'h26;
			8'h24: sBox=8'h36;
			8'h25: sBox=8'h3f;
			8'h26: sBox=8'hf7;
			8'h27: sBox=8'hcc;
			8'h28: sBox=8'h34;
			8'h29: sBox=8'ha5;
			8'h2a: sBox=8'he5;
			8'h2b: sBox=8'hf1;
			8'h2c: sBox=8'h71;
			8'h2d: sBox=8'hd8;
			8'h2e: sBox=8'h31;
			8'h2f: sBox=8'h15;
			8'h30: sBox=8'h04;
			8'h31: sBox=8'hc7;
			8'h32: sBox=8'h23;
			8'h33: sBox=8'hc3;
			8'h34: sBox=8'h18;
			8'h35: sBox=8'h96;
			8'h36: sBox=8'h05;
			8'h37: sBox=8'h9a;
			8'h38: sBox=8'h07;
			8'h39: sBox=8'h12;
			8'h3a: sBox=8'h80;
			8'h3b: sBox=8'he2;
			8'h3c: sBox=8'heb;
			8'h3d: sBox=8'h27;
			8'h3e: sBox=8'hb2;
			8'h3f: sBox=8'h75;
			8'h40: sBox=8'h09;
			8'h41: sBox=8'h83;
			8'h42: sBox=8'h2c;
			8'h43: sBox=8'h1a;
			8'h44: sBox=8'h1b;
			8'h45: sBox=8'h6e;
			8'h46: sBox=8'h5a;
			8'h47: sBox=8'ha0;
			8'h48: sBox=8'h52;
			8'h49: sBox=8'h3b;
			8'h4a: sBox=8'hd6;
			8'h4b: sBox=8'hb3;
			8'h4c: sBox=8'h29;
			8'h4d: sBox=8'he3;
			8'h4e: sBox=8'h2f;
			8'h4f: sBox=8'h84;
			8'h50: sBox=8'h53;
			8'h51: sBox=8'hd1;
			8'h52: sBox=8'h00;
			8'h53: sBox=8'hed;
			8'h54: sBox=8'h20;
			8'h55: sBox=8'hfc;
			8'h56: sBox=8'hb1;
			8'h57: sBox=8'h5b;
			8'h58: sBox=8'h6a;
			8'h59: sBox=8'hcb;
			8'h5a: sBox=8'hbe;
			8'h5b: sBox=8'h39;
			8'h5c: sBox=8'h4a;
			8'h5d: sBox=8'h4c;
			8'h5e: sBox=8'h58;
			8'h5f: sBox=8'hcf;
			8'h60: sBox=8'hd0;
			8'h61: sBox=8'hef;
			8'h62: sBox=8'haa;
			8'h63: sBox=8'hfb;
			8'h64: sBox=8'h43;
			8'h65: sBox=8'h4d;
			8'h66: sBox=8'h33;
			8'h67: sBox=8'h85;
			8'h68: sBox=8'h45;
			8'h69: sBox=8'hf9;
			8'h6a: sBox=8'h02;
			8'h6b: sBox=8'h7f;
			8'h6c: sBox=8'h50;
			8'h6d: sBox=8'h3c;
			8'h6e: sBox=8'h9f;
			8'h6f: sBox=8'ha8;
			8'h70: sBox=8'h51;
			8'h71: sBox=8'ha3;
			8'h72: sBox=8'h40;
			8'h73: sBox=8'h8f;
			8'h74: sBox=8'h92;
			8'h75: sBox=8'h9d;
			8'h76: sBox=8'h38;
			8'h77: sBox=8'hf5;
			8'h78: sBox=8'hbc;
			8'h79: sBox=8'hb6;
			8'h7a: sBox=8'hda;
			8'h7b: sBox=8'h21;
			8'h7c: sBox=8'h10;
			8'h7d: sBox=8'hff;
			8'h7e: sBox=8'hf3;
			8'h7f: sBox=8'hd2;
			8'h80: sBox=8'hcd;
			8'h81: sBox=8'h0c;
			8'h82: sBox=8'h13;
			8'h83: sBox=8'hec;
			8'h84: sBox=8'h5f;
			8'h85: sBox=8'h97;
			8'h86: sBox=8'h44;
			8'h87: sBox=8'h17;
			8'h88: sBox=8'hc4;
			8'h89: sBox=8'ha7;
			8'h8a: sBox=8'h7e;
			8'h8b: sBox=8'h3d;
			8'h8c: sBox=8'h64;
			8'h8d: sBox=8'h5d;
			8'h8e: sBox=8'h19;
			8'h8f: sBox=8'h73;
			8'h90: sBox=8'h60;
			8'h91: sBox=8'h81;
			8'h92: sBox=8'h4f;
			8'h93: sBox=8'hdc;
			8'h94: sBox=8'h22;
			8'h95: sBox=8'h2a;
			8'h96: sBox=8'h90;
			8'h97: sBox=8'h88;
			8'h98: sBox=8'h46;
			8'h99: sBox=8'hee;
			8'h9a: sBox=8'hb8;
			8'h9b: sBox=8'h14;
			8'h9c: sBox=8'hde;
			8'h9d: sBox=8'h5e;
			8'h9e: sBox=8'h0b;
			8'h9f: sBox=8'hdb;
			8'ha0: sBox=8'he0;
			8'ha1: sBox=8'h32;
			8'ha2: sBox=8'h3a;
			8'ha3: sBox=8'h0a;
			8'ha4: sBox=8'h49;
			8'ha5: sBox=8'h06;
			8'ha6: sBox=8'h24;
			8'ha7: sBox=8'h5c;
			8'ha8: sBox=8'hc2;
			8'ha9: sBox=8'hd3;
			8'haa: sBox=8'hac;
			8'hab: sBox=8'h62;
			8'hac: sBox=8'h91;
			8'had: sBox=8'h95;
			8'hae: sBox=8'he4;
			8'haf: sBox=8'h79;
			8'hb0: sBox=8'he7;
			8'hb1: sBox=8'hc8;
			8'hb2: sBox=8'h37;
			8'hb3: sBox=8'h6d;
			8'hb4: sBox=8'h8d;
			8'hb5: sBox=8'hd5;
			8'hb6: sBox=8'h4e;
			8'hb7: sBox=8'ha9;
			8'hb8: sBox=8'h6c;
			8'hb9: sBox=8'h56;
			8'hba: sBox=8'hf4;
			8'hbb: sBox=8'hea;
			8'hbc: sBox=8'h65;
			8'hbd: sBox=8'h7a;
			8'hbe: sBox=8'hae;
			8'hbf: sBox=8'h08;
			8'hc0: sBox=8'hba;
			8'hc1: sBox=8'h78;
			8'hc2: sBox=8'h25;
			8'hc3: sBox=8'h2e;
			8'hc4: sBox=8'h1c;
			8'hc5: sBox=8'ha6;
			8'hc6: sBox=8'hb4;
			8'hc7: sBox=8'hc6;
			8'hc8: sBox=8'he8;
			8'hc9: sBox=8'hdd;
			8'hca: sBox=8'h74;
			8'hcb: sBox=8'h1f;
			8'hcc: sBox=8'h4b;
			8'hcd: sBox=8'hbd;
			8'hce: sBox=8'h8b;
			8'hcf: sBox=8'h8a;
			8'hd0: sBox=8'h70;
			8'hd1: sBox=8'h3e;
			8'hd2: sBox=8'hb5;
			8'hd3: sBox=8'h66;
			8'hd4: sBox=8'h48;
			8'hd5: sBox=8'h03;
			8'hd6: sBox=8'hf6;
			8'hd7: sBox=8'h0e;
			8'hd8: sBox=8'h61;
			8'hd9: sBox=8'h35;
			8'hda: sBox=8'h57;
			8'hdb: sBox=8'hb9;
			8'hdc: sBox=8'h86;
			8'hdd: sBox=8'hc1;
			8'hde: sBox=8'h1d;
			8'hdf: sBox=8'h9e;
			8'he0: sBox=8'he1;
			8'he1: sBox=8'hf8;
			8'he2: sBox=8'h98;
			8'he3: sBox=8'h11;
			8'he4: sBox=8'h69;
			8'he5: sBox=8'hd9;
			8'he6: sBox=8'h8e;
			8'he7: sBox=8'h94;
			8'he8: sBox=8'h9b;
			8'he9: sBox=8'h1e;
			8'hea: sBox=8'h87;
			8'heb: sBox=8'he9;
			8'hec: sBox=8'hce;
			8'hed: sBox=8'h55;
			8'hee: sBox=8'h28;
			8'hef: sBox=8'hdf;
			8'hf0: sBox=8'h8c;
			8'hf1: sBox=8'ha1;
			8'hf2: sBox=8'h89;
			8'hf3: sBox=8'h0d;
			8'hf4: sBox=8'hbf;
			8'hf5: sBox=8'he6;
			8'hf6: sBox=8'h42;
			8'hf7: sBox=8'h68;
			8'hf8: sBox=8'h41;
			8'hf9: sBox=8'h99;
			8'hfa: sBox=8'h2d;
			8'hfb: sBox=8'h0f;
			8'hfc: sBox=8'hb0;
			8'hfd: sBox=8'h54;
			8'hfe: sBox=8'hbb;
			8'hff: sBox=8'h16;
			default: 
			sBox = 8'h00;
		endcase
	


end
endfunction

function[0:31] Rcon;
input [0:31] inputNum;

 begin
		case(inputNum)
			32'h00000001: Rcon = 32'h01000000;
			32'h00000002: Rcon = 32'h02000000;
			32'h00000003: Rcon = 32'h04000000;
			32'h00000004: Rcon = 32'h08000000;
			32'h00000005: Rcon = 32'h10000000;
			32'h00000006: Rcon = 32'h20000000;
			32'h00000007: Rcon = 32'h40000000;
			32'h00000008: Rcon = 32'h80000000;
			32'h00000009: Rcon = 32'h1b000000;
			32'h0000000a: Rcon = 32'h36000000;
			default: 
			Rcon = 32'h00000000;
		endcase
	end
endfunction
endmodule 
