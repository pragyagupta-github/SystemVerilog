module struct_demo;
struct packed
{
reg[3:0]a;
byte b;
logic [5:0]c;
logic [7:0]d;
real e;
shortreal f;
}m;
initial
begin
m.a=4'b1101;
m.b=8'b10101010;
m.c=6'b010101;
m.d=8'b11101011;
m.e=32.12;
m.f=42.74;
$display("%b",m.a);
$display("%b",m.b);
$display("%b",m.c);
$display("%b",m.d);
$display("%b",m[17:9]);
$display("%p",m[11:3]);
$display("%p",m);
end
endmodule
