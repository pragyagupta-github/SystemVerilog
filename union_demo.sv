module union_demo;
union
{
reg[3:0]a;
byte b;
logic [5:0]c;
logic [7:0]d;
}m;
initial
begin
m.a=4'b1101;
$display("%b",m.a);
m.b=8'b10101010;
$display("%b",m.b);
m.c=6'b010101;
$display("%b",m.c);
m.d=8'b11101011;
$display("%b",m.d);
end
endmodule