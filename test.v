module test;
reg [0:127] k1;
wire[1407:0] w;
reg [0:31] temp;
wire [0:31] tempRotWord;
wire [0:31] tempSubWord1;
wire [0:31] tempSubWord2;
wire [0:31] tempRcon;
wire [0:31] tempXor;

RotWord  rot(temp,tempRotWord);
SubWord	subword1(tempRotWord,tempSubWord1);
Rcon  rcon(4/4,tempRcon);

initial begin
k1=128'h_2b7e1516_28aed2a6_abf71588_09cf4f3c;
#100;
temp=32'h09cf4f3c;
#100;
$monitor("temp= %h , tempRotWord= %h",temp,tempRotWord);
#100;
$monitor("tempRotWord= %h , tempSubWord1= %h",tempRotWord,tempSubWord1);
#100;
$monitor("4/4= 1 , tempRcon= %h",tempRcon);
#100;
$monitor("tempSubWord1 ^tempRcon = %h",tempSubWord1 ^tempRcon);
#100;
$monitor("k1[0:31]= %h,temp;= %h,k1[0:31] ^ temp;= %h",k1[0:31],tempSubWord1 ^tempRcon,k1[0:31] ^tempSubWord1 ^tempRcon);
#100;
$monitor("k= %h , w= %h",k1,w);
#100;
end
endmodule



