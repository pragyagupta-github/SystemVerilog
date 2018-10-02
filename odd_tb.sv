module odd_tb;
logic [7:0]a;
reg [7:0]s;
odd a1(.a(a), .s(s));
initial
begin
repeat(10)
begin
#5 a=$urandom_range(1,100);
end
end
initial
$monitor($time,"a=%d, s=%d",a,s);
endmodule