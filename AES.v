
module AES(LEDR,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
output [1:0] LEDR;
input [1:0]KEY;

output[6:0] HEX0;
output[6:0] HEX1;
output[6:0] HEX2;
output[6:0] HEX3;
output[6:0] HEX4;
output[6:0] HEX5;
//


wire [0:127] inputText = 128'h_23412233445566778899aabbccddeabc;
wire [0:127] inputKey =  128'h_00010203040506070888888888888888;
wire [0:127] encryptionCorrectOutput = 128'h_69c4e0d86a7b0430d8cdb78070b4c55a;
wire [0:127] decryptionCorrectOutput= 128'h_00112233445566778899aabbccddeeff;

wire [0:127] encryptionActualOutput;
wire [0:127] decryptionActualOutput;

wire [0:127] temp1;
wire [0:127] temp2;
wire [0:127] temp3;
wire [0:127] temp4;
wire [0:127] temp5;
wire [0:127] temp6;
wire [0:127] temp7;

reg [0:127] encryptionActualOutputREG;
reg [0:127] decryptionActualOutputREG;

wire [6:0] out1;
wire [6:0] out2;
wire [6:0] out3;
wire [0:6] out4;
wire [0:6] out5;
wire [0:6] out6;
wire [0:6] out7;
wire [0:6] out8;
wire [0:6] out9;

reg [6:0] out1reg;
reg [6:0] out2reg;
reg [6:0] out3reg;
reg [0:6] out4reg;
reg [0:6] out5reg;
reg [0:6] out6reg;
reg [6:0] out11reg;
reg [6:0] out21reg;
reg [6:0] out31reg;
reg [0:6] out41reg;
reg [0:6] out51reg;
reg [0:6] out61reg;

initial begin
encryptionActualOutputREG=0;
decryptionActualOutputREG=0;
out1reg=0;
out2reg=0;
out3reg=0;
out4reg=0;
out5reg=0;
out6reg=0;
out11reg=0;
out21reg=0;
out31reg=0;
out41reg=0;
out51reg=0;
out61reg=0;







end

Cipher cipher1(inputText,inputKey,encryptionActualOutput,out7,out8,out9,KEY);

BCD2HEX BH7(encryptionActualOutput[124:127], out4);
BCD2HEX BH6(encryptionActualOutput[120:123], out5);
BCD2HEX BH5(encryptionActualOutput[116:119], out6);

assign HEX0 = out4;
assign HEX1 = out5;
assign HEX2 = out6;


//// Extract the least significant bytes (LSBs) and convert to HEX


//assign HEX3 = out41reg;
//assign HEX4 = out51reg;
//assign HEX5 = out61reg;


DeCipher decipher1(encryptionActualOutput,inputKey,decryptionActualOutput);
BCD2HEX BH71(decryptionActualOutput[124:127], out1);
BCD2HEX BH61(decryptionActualOutput[120:123], out2);
BCD2HEX BH51(decryptionActualOutput[116:119], out3);




//// Extract the least significant bytes (LSBs) and convert to HEX

always@(posedge KEY[0]) begin
out1reg<=out1;
out2reg<=out2;
out3reg<=out3;

end




//assign HEX0 = out1reg;
//assign HEX1 = out2reg;
//assign HEX2 = out3reg;
assign HEX3 = out1reg;
assign HEX4 = out2reg;
assign HEX5 = out3reg;


always@(posedge KEY[0]) begin
encryptionActualOutputREG<=encryptionActualOutput;
decryptionActualOutputREG<=decryptionActualOutput;
end

assign temp1=encryptionActualOutputREG;
assign temp2=decryptionActualOutputREG;


//check encryption if correct on ledr[0]
assign LEDR[0] = (temp1 == encryptionCorrectOutput) ? 1'b1 : 1'b0;
//check decryption if correct on ledr[1]
assign LEDR[1] = (temp2 == decryptionCorrectOutput) ? 1'b1 : 1'b0;

//BCD2HEX BH1(encryptionCorrectOutput[0:3],out1);
//BCD2HEX BH2(encryptionCorrectOutput[4:7],out2);
//BCD2HEX BH3(encryptionCorrectOutput[8:11] ,out3);
//

//assign HEX2=out4;
//assign HEX1=out5;
//assign HEX0=out6;

endmodule
