module test_assoc;
int a[int]='{20:100, 100:2001, 121:2002, 183:2003};
initial
begin
foreach(a[i])
$display("%d %d",i, a[i]);
end
endmodule