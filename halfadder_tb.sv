module halfadder_tb;
logic a,b,s,c;
integer i;
halfadder f1(.a(a), .b(b), .s(s), .c(c));
initial
i= $fopen("fulladder.txt");
initial
begin
{a,b}=2'b00;
repeat(7)
#5 {a,b} = {a,b}+ 2'b01;
end
initial
$fmonitor(i,$time,"a=%b, b=%b,s=%b, c=%b",a,b,s,c);
endmodule