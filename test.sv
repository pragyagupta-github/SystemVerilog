module test;
/*logic a;
endmodule
input logic a,b,
output logic y);
/*assign y=a&b;
xor g1(y, a,b);
always @(a,b)
y=a&b;
always_comb
y=a&b;
always_comb
y=a|b;
integer x=10, y=10, z=10;
initial
begin
y-=x--;
z-=--x;
x-=--x-x--;
//z=i---111;
//z=i/++i;*/
reg [1:0]a,b,c;
initial
begin
a=2'b00;
b=2'b01;
c=2'b11;
#5 a=2'b11;
#5 b=2'b10;
#5 c=2'b00;
#5 c=2'b11;
end
initial
$monitor($time,"a=%b,b=%b,c=%b", a,b,c);
final
begin
$display($time,"a=%b, b=%b, c=%b",a,b,c);
$display("final block:no delay allowed");
end
endmodule