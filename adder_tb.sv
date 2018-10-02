module adder_tb;
logic [15:0]a,b;
logic [16:0]s;
adder a1(.*);
initial
begin
repeat(10)
begin
a=$urandom_range(100,20);
b=$urandom_range(201,300);
#5;
end
end
initial
$monitor($time,"a=%d, b=%d, s=%d",a,b,s);
endmodule