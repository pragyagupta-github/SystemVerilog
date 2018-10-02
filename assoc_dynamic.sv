module assoc_dynamic;
int a[*];
// '{10:100, 15:200, 20:300, 25:400, 30:500, 35:600, 40:700, 45:800, 50:900, 55:850};
int b[];
initial
begin
for(int i=0; i<10; i++)
//a[i]=$urandom_range(100,1);
a[$urandom_range(100,0)]=b[i];
$display("%p", a);
$display("%p", b);
end
endmodule